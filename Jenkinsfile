// # ©2024 Intel Corporation
// # Permission is granted for recipient to internally use and modify this software for purposes of benchmarking and testing on Intel architectures. 
// # This software is provided "AS IS" possibly with faults, bugs or errors; it is not intended for production use, and recipient uses this design at their own risk with no liability to Intel.
// # Intel disclaims all warranties, express or implied, including warranties of merchantability, fitness for a particular purpose, and non-infringement. 
// # Recipient agrees that any feedback it provides to Intel about this software is licensed to Intel for any purpose worldwide. No permission is granted to use Intel’s trademarks.
// # The above copyright notice and this permission notice shall be included in all copies or substantial portions of the code.

def getEnvFromBranch(branch) {
    if (branch ==~ /main/) {
        return 'protex'
    }
    else {
        return 'virus,trivy'
       
    }
}

pipeline {
    agent {
        docker {
            label 'docker'
            image 'amr-registry.caas.intel.com/one-intel-edge/rrp-devops/oie_ci_testing:latest'
            alwaysPull true
        }
    }
    environment {
        GIT_SHORT_URL=env.GIT_URL.split('/')[4].toString().replaceAll('.git','')
        PROJECT_NAME = "${GIT_SHORT_URL}"
        authorEmail = sh (script: 'git --no-pager show -s --format=\'%ae\'',returnStdout: true).trim()
        SDLE_UPLOAD_PROJECT_ID = ' ' //add your SDL project
    }
    stages {
        stage('Scan Sources'){
            environment {
                SCANNERS            = getEnvFromBranch(env.BRANCH_NAME)
                PROTEX_PROJECT_NAME = "${GIT_SHORT_URL}"
            }
            when {
                anyOf {
                    branch 'main';
                    changeRequest();
                }
            }
            steps {
                rbheStaticCodeScan()
            }
        }
        // This stage is required for service/agent repos only
        // Please remove it for chart repos
        stage('Version Check') {
            steps {
                echo "Check if its a valid code version"
                sh '''
                /opt/ci/version-check.sh
                '''
            }        
        }
        stage('Build') {
            steps {
                echo "Hi, I'm a pipeline, doing build step"
                sh '''
                make build
                '''
            }
        }
        stage('License Check') {
            steps {
                sh '''
                echo "License checking the code"
                make license
                '''
            }
        }
        stage('Lint') {
            steps {
                echo "Hi, I'm a pipeline, doing lint step"
                sh '''
                make lint
                '''
            }
        }
        stage('Test') {
            when {
                changeRequest()
            }
            steps {
                echo "Hi, I'm a pipeline, doing test step"
                sh '''
                make test
                make coverage
                '''
                 post {
                    success {
                        coverageReport('cobertura-coverage.xml')
                    }
                } 
            }
        }
        // This stage is required for service/agent repos only
        // Please remove it for chart repos
        stage('Version Tag') {
            when {
                anyOf { branch 'main'; branch 'feature*'; branch 'release*' }
            }
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'sys_oie_devops_github_api',usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']])
                    {
                        netrcPatch()
                        echo "Generate tag if SemVer"
                        sh '''
                        # Tag the version
                        /opt/ci/version-tag.sh
                        '''
                }
            }
        }
        stage('Version dev') {
            when {
                anyOf { branch 'main'; branch 'iaas-*-*'; branch 'release-*'; }
            }
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'sys_oie_devops_github_api',usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']])
                {
                    versionDev()
                }
            }
        }
        stage('Auto approve') {
            when {
                changeRequest()
            }
            steps {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'sys_devops_approve_github_api', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                    script {
                        autoApproveAndMergePR()
                    }
                }
            }
        }
        stage('Artifact') {
            steps {
                artifactUpload()
            }
        }
    }
    post {
        always {
            jcpSummaryReport()
            intelLogstashSend failBuild: false, verbose: true
            cleanWs()
        }
        failure {
            script {
                emailFailure()
            }
        }
    }
}
