# Inference as a Service Deployment Automation
This automates the setup, reset, and update of a Kubernetes cluster with Inference as a Service using Ansible playbooks. It includes functions for setting up   environment, installing Kubernetes, deploying various components (e.g., Habana AI Operator, Ingress NGINX Controller, Keycloak, APISIX), and managing models and worker nodes.

# Table of Contents
1. [Inference as a Service Deployment Automation](#inference-as-a-service-deployment-automation)
2. [Supported Models](#supported-models)
3. [Prerequisites for Setting Up Inference as a Service Cluster](#prerequisites-for-setting-up-inference-as-a-service-cluster)
4. [Usage](#usage)
5. [Running the Automation](#running-the-automation)
   - [Prameter Options](#options)
6. [Inference Config File](#using-the-inference-configcfg-file)
7. [Main User Menu](#main-menu)
8. [Fresh Installation](#fresh-installation)
     - [Workflow Steps](#example)
9. [Reset Cluster](#reset-cluster)
     - [Workflow Steps](#example-1)
10. [Update Existing Cluster](#update-existing-cluster)
      - [Add Models](#add-llm-model)
         - [Workflow Steps](#example-2)
      - [Remove Models](#remove-llm-model)
         - [Workflow Steps](#example-3)
      - [List Models](#list-llm-model)
         - [Workflow Steps](#example-4)
11. [Inferencing with Deployed Model](#accessing-deployed-models-for-inference)



## Supported Models
The following models are supported by this Inference as a Service automation:
1. **llama-8b**
2. **llama-70b**
3. **codellama-34b**
4. **mixtral-8x7b**
5. **mistral-7b**
6. **tei**
7. **tei-rerank**
   
These models can be deployed, providing a range of inference capabilities to suit various needs and applications.

## Prerequisites for Setting Up Inference as a Service Cluster
1. **Gaudi Driver update, Firmware update, and Reboot.**
2. **Update the `ida/inventory/hosts.yaml` file with the private IP addresses of the nodes.**
3. **This automation needs to be invoked from a linux bastion host with keyless SSH access.**
4. **DNS entry for the master node IP (e.g., example.com resolves to 127.0.0.1).**
5. **Certificate file, including the full chain file and key file (Certfile).**
6. **Hugging Face token. For instructions on generating the Hugging Face token, please refer to the [Hugging Face documentation](https://huggingface.co/docs/hub/security-tokens).**



## Usage
### Running the Automation
To run the automation, execute the following command in your terminal:
./inference-as-auto-deploy.sh [OPTIONS]
### Options
`````
The automation accepts the following command-line options:
--cluster-url <URL>: The cluster URL (FQDN).
--cert-file <path>: The full path to the certificate file.
--key-file <path>: The full path to the key file.
--keycloak-client-id <id>: The Keycloak client ID.
--keycloak-admin-user <username>: The Keycloak admin username.
--keycloak-admin-password <password>: The Keycloak admin password.
--hugging-face-token <token>: The token for Huggingface.
--models <models>: The models to deploy (comma-separated list of model numbers or names).
--cpu-or-gpu <c/g>: Specify whether to run on CPU or GPU.
`````

### Main Menu
When you run the automation, you will be presented with a main menu with the following options:
1. Setup k8s Cluster with Inference as Service: Perform a fresh installation of the Kubernetes cluster with Inference as a Service.
2. K8sPurgeCluster: Reset the existing Kubernetes cluster.
3. Update Existing Cluster: Update the existing Kubernetes cluster.

### Fresh Installation
If you choose to perform a fresh installation, the automation will prompt you for the necessary inputs and proceed with the following steps:
1. Prompt for Input: Collects the required inputs from the user.
2. Setup Initial Environment: Sets up the virtual environment and installs necessary dependencies.
3. Install Kubernetes: Installs Kubernetes and sets up the kubeconfig for the user.
4. Deploy Components: Deploys the selected components (Habana AI Operator, Ingress NGINX Controller, Keycloak, and models).
### Example
`````
To perform a fresh installation with specific parameters, you can run:
bash inference-as-auto-deploy.sh --cluster-url "https://example.com" --cert-file "/path/to/cert.pem" --key-file "/path/to/key.pem" --keycloak-client-id "my-client-id" --keycloak-admin-user "user" --keycloak-admin-password "password" --hugging-face-token "token" --models "1,3,5" --cpu-or-gpu "g"

or

with inference-config.cfg file configured, run
bash inference-as-auto-deploy.sh
`````

#### Reset Cluster
If you choose to reset the cluster, the automation will:
1. Prompt for Confirmation: Asks for confirmation before proceeding with the reset.
2. Setup Initial Environment: Sets up the virtual environment and installs necessary dependencies.
3. Run Reset Playbook: Executes the Ansible playbook to reset the cluster.
### Example
`````
Run:
bash inference-as-auto-deploy.sh

Please select the following option:
   2) K8sPurgeCluster
Acknowledge it with "yes".
`````

#### Update Existing Cluster
If you choose to update the existing cluster, the automation will present you with the following options:
1. Manage Worker Nodes: Add or remove worker nodes.
2. Manage Models: Add or remove models.
`````
Run:
bash inference-as-auto-deploy.sh

Please select the following option:
   3) Update Existing Cluster

`````


#### Manage Models: Add or remove models.

#### Add LLM Model
This option allows you to deploy a new LLM model on the Kubernetes cluster.

#### Example:
`````
Run:
bash inference-as-auto-deploy.sh
Please select the following options:
   3) Update Existing Cluster
   then select,
   2) Manage LLM Models
   then select,
   1) Deploy Model
Follow the prompts to provide the necessary information for deploying the model.
`````

#### Remove LLM Model
This option allows you to remove deployed LLM model on the Kubernetes cluster.

#### Example:
`````
Run:
bash inference-as-auto-deploy.sh
Please select the following options:
   3) Update Existing Cluster
   then select,
   2) Manage LLM Models
   then select,
   2) Undeploy Model
Follow the prompts to select the model you want to undeploy.
`````


#### List LLM Model
This option allows you to list deployed LLM model on the Kubernetes cluster.

#### Example:
`````
Run:
bash inference-as-auto-deploy.sh
Please select the following options:
   3) Update Existing Cluster
   then select,
   2) Manage LLM Models
   then select,
   3) List Installed Models
The script will display a list of all the installed LLM models on the cluster.
`````


### Using the inference-config.cfg File
If you don't want to be prompted for the required parameters, you can use the inference-config.cfg file to provide the necessary values. The automation will read the values from this file if it exists.
Here's an example of the inference-config.cfg file:
`````
cluster_url=example.com
cert_file=/path/to/cert/file.pem
key_file=/path/to/key/file.pem
keycloak_client_id=my-client-id
keycloak_admin_user=your-keycloak-admin-user
keycloak_admin_password=changeme
hugging_face_token=your_hugging_face_token
models=6,7
cpu_or_gpu=gpu
deploy_kubernetes_fresh=no
deploy_habana_ai_operator=no
deploy_ingress_controller=no
deploy_keycloak_and_apisix=no
deploy_llm_models=yes
`````
Make sure to update the values in the inference-config.cfg file according to your requirements before running the automation.

## Accessing Deployed Models for Inference

### Export user credentials
`````
export USER=<your_username>
export PASSWORD=<your_password>
export KEYCLOAK_ADDR=https://example.com
export KEYCLOAK_REALM=<your_keycloak_realm>
export KEYCLOAK_CLIENT_ID=<your_keycloak_client_id>
export KEYCLOAK_CLIENT_SECRET=<your_keycloak_client_secret>
# Obtain access token
export TOKEN=$(curl -k -X POST $KEYCLOAK_ADDR/token  -H 'Content-Type: application/x-www-form-urlencoded' -d "grant_type=password&client_id=${KEYCLOAK_CLIENT_ID}&client_secret=${KEYCLOAK_CLIENT_SECRET}&username=${USER}&password=${PASSWORD}" | jq -r .access_token)

`````



Example Run:
[Inference-As-Service-Deployment-Automation](https://intel-my.sharepoint.com/:v:/r/personal/ahmed_seemal_intel_com/Documents/Videos/Clipchamp/Video%20Project%203/Exports/one-click-modularization.mp4?csf=1&web=1&e=k3mc0V&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D)
