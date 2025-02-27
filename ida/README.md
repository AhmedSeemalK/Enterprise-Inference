# AI Inference as a Service Deployment Automation
Unleash the Power of AI Inference:

   The Inference as a Service Deployment Automation suite is your ultimate companion for harnessing the full potential of AI inference capabilities. 
   
   Imagine a world where deploying and managing AI inference services is as effortless as a few keystrokes. With this automation suite, you can bid farewell to the complexities of manual configurations and embrace a future where agility and operational excellence are the norms.
   
   Powered by Kubernetes infrastructure.This automation suite empowers enterprises to seamlessly provision, reconfigure, and evolve their AI inference infrastructure with unparalleled agility.

#### Key Components:
   - **Kubernetes**: A powerful container orchestration platform that automates the deployment, scaling, and management of containerized applications, ensuring high availability and efficient resource utilization.
   - **Habana AI Operator**: A specialized operator that manages the lifecycle of Habana AI resources within the Kubernetes cluster, enabling efficient utilization of hardware for AI workloads.
   - **Ingress NGINX Controller**: A high-performance reverse proxy and load balancer for traffic, responsible for routing incoming requests to the appropriate services within the Kubernetes cluster, ensuring seamless access to deployed AI models.
   - **Keycloak**: An open-source identity and access management solution that provides robust authentication and authorization capabilities, ensuring secure access to AI services and resources within the cluster.
   - **APISIX**: A cloud-native API gateway, handling API traffic and providing advanced features caching, and authentication, enabling efficient and secure access to deployed AI models.
   - **Model Deployments**: Automated deployment and management of llm models within the Kubernetes cluster, enabling scalable and reliable AI inference capabilities.
   
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
      - [Add Models](#deploy-llm-model)
         - [Workflow Steps](#example-2)
      - [Remove Models](#remove-llm-model)
         - [Workflow Steps](#example-3)
      - [List Models](#list-llm-model)
         - [Workflow Steps](#example-4)
11. [Inferencing with Deployed Model](#accessing-deployed-models-from-inference-cluster)



## Supported Models
List of Prevalidated Models for the Inference as a Service Automation:
1. [**llama-8b**](https://huggingface.co/meta-llama/Llama-3.1-8B-Instruct)
2. [**llama-70b**](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct)
3. [**codellama-34b**](https://huggingface.co/codellama/CodeLlama-34b-Instruct-hf)
4. [**mixtral-8x7b**](https://huggingface.co/mistralai/Mixtral-8x7B-Instruct-v0.1)
5. [**mistral-7b**](https://huggingface.co/mistralai/Mistral-7B-Instruct-v0.3)
6. [**tei**](https://github.com/huggingface/tei-gaudi/pkgs/container/tei-gaudi)
7. [**tei-rerank**](https://github.com/huggingface/text-embeddings-inference/pkgs/container/text-embeddings-inference)
8. [**falcon3-7b**](https://huggingface.co/tiiuae/Falcon3-7B-Instruct)   
9. [**deepseek-r1-distill-qwen-32b**](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B)
10. [**deepseek-r1-distill-llama8b**](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-8B)
11. [**cpu-llama-8b**](https://github.com/huggingface/text-generation-inference/pkgs/container/text-generation-inference)
12. [**cpu-deepseek-r1-distill-qwen-32b**](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B)
13. [**cpu-deepseek-r1-distill-llama8b**](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-8B)
   
These models can be deployed, providing a range of inference capabilities to suit various needs and applications.



## Prerequisites for Setting Up Inference as a Service Cluster
1. **Gaudi VM should be available with firmware version 1.18 or later.**
      Verify the firmware version by running the below command:
    ```commandline
    hl-smi
    ```
2. Fetch the private IPs and ssh keys file path for all nodes in cluster and update the host.yml file located at below path
    ```text
    ida/inventory/hosts.yaml
    ```
      ##### Please find below sample of hosts.yml file
   ```yaml
      all:
        hosts:
          master:
            ansible_host: "{{ private_ip }}"
            ansible_user: ubuntu
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          worker1:
            ansible_host: "{{ private_ip }}"
            ansible_user: ubuntu
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          worker2:
            ansible_host: "{{ private_ip }}"
            ansible_user: ubuntu
            ansible_ssh_private_key_file: /path/to/your/ssh/key
        children:
          kube_control_plane:
            hosts:
              master:
          kube_node:
            hosts:
              worker1:
              worker2:
          etcd:
            hosts:
              master:
          k8s_cluster:
            children:
              kube_control_plane:
              kube_node:
          calico_rr:
            hosts: {}
   ```

   2. **In Kubernetes cluster setup, perform below steps for master node to communicate with other nodes without ssh key.**
         1. On master node, open termnial and copy the output of id_rsa.pub file
       ```commandline
       cat ~/.ssh/id_rsa.pub
       ```
       2. On each worker node, perform below action:
       ```commandline
        echo "TOKEN_FROM_ABOVE_COMAMAND" >> ~/.ssh/authorized_keys
       ```

4. **Setup the DNS to access the service:**
      1. DNS name should be created for the master node IP (e.g., example.com resolves to 127.0.0.1).
      2. Certificate files should be created, including the full chain file and key file (Certfile).
5. **User needs to have huggingface token generated.**
     Please refer to the [Hugging Face documentation](https://huggingface.co/docs/hub/security-tokens) for more assistance.


## Usage
### Running the Automation
To run the automation, execute the following command in your terminal:
bash inference-as-auto-deploy.sh [OPTIONS]
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

### Using the inference-config.cfg File
If you don't want to be prompted for the required parameters, you can use the inference-config.cfg file to provide the necessary values. The automation will read the values from this file.
Here's an example of the inference-config.cfg file:
`````
cluster_url=example.com
cert_file=/path/to/cert/file.pem
key_file=/path/to/key/file.pem
keycloak_client_id=my-client-id
keycloak_admin_user=your-keycloak-admin-user
keycloak_admin_password=changeme
hugging_face_token=your_hugging_face_token
models=1,3,5
cpu_or_gpu=g
deploy_kubernetes_fresh=no
deploy_habana_ai_operator=no
deploy_ingress_controller=no
deploy_keycloak_apisix=no
deploy_llm_models=yes
`````
Make sure to update the values in the inference-config.cfg file according to your requirements before running the automation.

#### Deployment Authentication:   
   - **With Keycloak and APISIX**:      
      -  In this flow, Keycloak and APISIX are deployed to provide authentication, authorization, and API gateway functionality, ensuring secure and controlled access to the deployed AI models.
   - **Without Keycloak and APISIX**:
      - In this flow, the AI models are deployed directly within the Kubernetes cluster, without the additional security and API gateway layers provided by Keycloak and APISIX. This deployment option is suitable for scenarios where these components are not required or are handled separately.


And then execute the script.
```commandline
bash inference-as-auto-deploy.sh
```


## Main Menu
When you run the automation, you will be presented with a main menu with the following options:
```
----------------------------------------------------------
|  AI Inference as Service Deployment Automation          |
|---------------------------------------------------------|
| 1) Provision Inference as Service Cluster               |
| 2) Decommission Existing Cluster                        |
| 3) Update Deployed Inference Cluster                    |
|---------------------------------------------------------|
Please choose an option (1, 2, or 3):
```

### Fresh Installation:

#### Installation Precautions:
Ensure that the nodes do not contain existing workloads. If necessary, please purge any previous cluster configurations before initiating a fresh installation to avoid an inappropriate cluster state. Proceeding without this precaution could lead to service disruptions or data loss.

If you choose to perform a fresh installation, the automation will prompt you for the necessary inputs and proceed with the following steps:
1. Prompt for Input: Collects the required inputs from the user.
2. Setup Initial Environment: Sets up the virtual environment and installs necessary dependencies.
3. Install Kubernetes: Installs Kubernetes and sets up the kubeconfig for the user.
4. Deploy Components: Deploys the selected components (Habana AI Operator, Ingress NGINX Controller, Keycloak, and models).
#### Example
`````
To perform a fresh installation with specific parameters, you can run:
bash inference-as-auto-deploy.sh --cluster-url "https://example.com" --cert-file "/path/to/cert.pem" --key-file "/path/to/key.pem" --keycloak-client-id "my-client-id" --keycloak-admin-user "user" --keycloak-admin-password "password" --hugging-face-token "token" --models "1,3,5" --cpu-or-gpu "g"

or

with inference-config.cfg file configured, run
bash inference-as-auto-deploy.sh
`````
### Example Fresh Installation Screen:
```
Configuration file found, setting vars!
---------------------------------------
deploy_apisix and deploy_keycloak are set to 'yes'
Proceeding with the setup of Fresh Kubernetes cluster: yes
Proceeding with the setup of Habana AI Operator: yes
Proceeding with the setup of Ingress Controller: yes
Proceeding with the setup of Keycloak : yes
Proceeding with the setup of Apisix: yes
Proceeding with the setup of Large Language Model (LLM): yes
----- Input -----
Using provided CLUSTER URL: example.com
Using provided certificate file: /path/to/cert/file.pem
Using provided key file: /path/to/key/file.pem
Using provided keycloak client id: my-client-id
Using provided Keycloak admin username: your-keycloak-admin-user
Using provided Keycloak admin password
cpu_or_gpu is already set to c
Using provided Huggingface token
Using provided models: 6,7
Deploying/removing GPU models: llama-8b codellama-34b mistral-7b
Proceed with the inference cluster setup using the provided configurations? (yes/no)
```

### Reset Cluster:

##### Cluster Reset Precautions:
Performing a cluster reset is a significant action that will permanently erase all current configurations, services, and resources associated with the cluster. This operation is irreversible and may result in service interruptions and data loss. It is essential to be certain of your decision to reset the cluster. Please ensure that you have backed up any important data before confirming that you wish to proceed with the reset.

If you choose to reset the cluster, the automation will:
1. Prompt for Confirmation: Asks for confirmation before proceeding with the reset.
2. Setup Initial Environment: Sets up the virtual environment and installs necessary dependencies.
3. Run Reset Playbook: Executes the Ansible playbook to reset the cluster.
#### Example
`````
Run:
----------------------------------------------------------
|  AI Inference as Service Deployment Automation          |
|---------------------------------------------------------|
| 1) Provision Inference as Service Cluster               |
| 2) Decommission Existing Cluster                        |
| 3) Update Deployed Inference Cluster                    |
|---------------------------------------------------------|
Please choose an option (1, 2, or 3):
> 2
You are about to reset the existing Inference as service cluster.
This will remove all the current configurations and data.
Are you sure you want to proceed? (yes/no): 
Acknowledge it with "yes".
`````

### Update Existing Cluster:
If you choose to update the existing cluster, the automation will present you with the following options:
1. Manage Worker Nodes: Add or remove worker nodes.
2. Manage Models: Add or remove models.
`````
Run:
bash inference-as-auto-deploy.sh

----------------------------------------------------------
|  AI Inference as Service Deployment Automation          |
|---------------------------------------------------------|
| 1) Provision Inference as Service Cluster               |
| 2) Decommission Existing Cluster                        |
| 3) Update Deployed Inference Cluster                    |
|---------------------------------------------------------|
Please choose an option (1, 2, or 3):
> 3
-------------------------------------------------
|             Update Existing Cluster            |
|------------------------------------------------|
| 1) Manage Worker Nodes                         |
| 2) Manage LLM Models                           |
|------------------------------------------------|
Please choose an option (1 or 2):
`````


## Manage Models: Add or remove models.
### Deploy LLM Model
This option allows you to deploy a new LLM model on the Inference Cluster.

#### Example:
`````
Run:
bash inference-as-auto-deploy.sh
----------------------------------------------------------
|  AI Inference as Service Deployment Automation          |
|---------------------------------------------------------|
| 1) Provision Inference as Service Cluster               |
| 2) Decommission Existing Cluster                        |
| 3) Update Deployed Inference Cluster                    |
|---------------------------------------------------------|
Please choose an option (1, 2, or 3):
> 3
-------------------------------------------------
|             Update Existing Cluster            |
|------------------------------------------------|
| 1) Manage Worker Nodes                         |
| 2) Manage LLM Models                           |
| 3) Update Driver and Firmware                  |
|------------------------------------------------|
Please choose an option (1 or 2):
> 2
-------------------------------------------------
| Manage LLM Models                                  |
|------------------------------------------------|
| 1) Deploy Model                                |
| 2) Undeploy Model                              |
| 3) List Installed Models                       |
|------------------------------------------------|
Please choose an option (1, 2, or 3):
> 1
Follow the prompts to provide the necessary information for deploying the model if model is not set in inference-config.cfg.
If model is set in inference-config.cfg automation will proceed to deploy the model.
`````

### Deploy LLM Model from Hugging Face
This option allows you to deploy a new LLM model using model id from Hugging Face on the Inference Cluster.

#### Example:
`````
Run:
bash inference-as-auto-deploy.sh 
----------------------------------------------------------
|  AI Inference as Service Deployment Automation          |
|---------------------------------------------------------|
| 1) Provision Inference as Service Cluster               |
| 2) Decommission Existing Cluster                        |
| 3) Update Deployed Inference Cluster                    |
|---------------------------------------------------------|
Please choose an option (1, 2, or 3):
> 3
-------------------------------------------------
|             Update Existing Cluster            |
|------------------------------------------------|
| 1) Manage Worker Nodes                         |
| 2) Manage LLM Models                           |
|------------------------------------------------|
Please choose an option (1 or 2):
> 2
-------------------------------------------------
| Manage LLM Models                               
|------------------------------------------------|
| 1) Deploy Model                                |
| 2) Undeploy Model                              |
| 3) List Installed Models                       |
| 4) Deploy Model from Hugging Face              |
| 5) Remove Model using deployment name          |
|------------------------------------------------|
Please choose an option (1, 2, 3, or 4):
> 4
-------------------------------------------------
|         Deploy Model from Huggingface          |
|------------------------------------------------|
cpu_or_gpu is already set to g
Enter the Huggingface Model ID: meta-llama/Meta-Llama-3-8B
Enter the name of the model deployment name: metallama-8b
NOTICE: Ensure the Tensor Parallel size value corresponds to the number of available Gaudi cards. Providing an incorrect value may result in the model being in a not ready state. 
Enter the Tensor Parallel size:2
NOTICE: You are about to deploy a model directly from Hugging Face, which has not been pre-validated by our team. Do you wish to continue? (y/n) y
`````


### Remove LLM Model
This option allows you to remove deployed LLM model on the Kubernetes cluster.

#### Example:
`````
Run:
bash inference-as-auto-deploy.sh
----------------------------------------------------------
|  AI Inference as Service Deployment Automation          |
|---------------------------------------------------------|
| 1) Provision Inference as Service Cluster               |
| 2) Decommission Existing Cluster                        |
| 3) Update Deployed Inference Cluster                    |
|---------------------------------------------------------|
Please choose an option (1, 2, or 3):
> 3
-------------------------------------------------
|             Update Existing Cluster            |
|------------------------------------------------|
| 1) Manage Worker Nodes                         |
| 2) Manage LLM Models                           |
| 3) Update Driver and Firmware                  |
|------------------------------------------------|
Please choose an option (1 or 2):
> 2
-------------------------------------------------
| Manage LLM Models                                  |
|------------------------------------------------|
| 1) Deploy Model                                |
| 2) Undeploy Model                              |
| 3) List Installed Models                       |
|------------------------------------------------|
Please choose an option (1, 2, or 3):
> 2
Follow the prompts to select the model you want to undeploy if model is not set in inference-config.cfg.
If model is set in inference-config.cfg automation will proceed to remove the model.
`````


### List LLM Model
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

## Manage Nodes: Add or remove Nodes.

#### Add Worker Node:
##### Precautions:
WARNING: Adding a node that is already managed by another Kubernetes cluster or has been manually configured using kubeadm, kubelet, or other tools can cause severe disruptions to your existing cluster. This may lead to issues such as pod restarts, service interruptions, and potential data loss. 

#### Remove Worker Node:
##### Precautions:
CAUTION: Removing the Inference LLM Model will also remove its associated services and resources, which may cause service downtime and potential data loss. This action is irreversible. 


## Accessing Deployed Models from Inference Cluster

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

For inferencing with Llama-3-8b:
curl -k ${KEYCLOAK_ADDR}/Meta-Llama-3.1-8B-Instruct/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Llama-3-70b:
curl -k ${KEYCLOAK_ADDR}/Meta-Llama-3.1-70B-Instruct/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-70B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Codellama-34b:
curl -k ${KEYCLOAK_ADDR}/CodeLlama-34b-Instruct-hf/v1/completions -X POST -d '{"model": "codellama/CodeLlama-34b-Instruct-hf", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Mistral-7b:
curl -k ${KEYCLOAK_ADDR}/Mistral-7B-Instruct-v0.3/v1/completions -X POST -d '{"model": "mistralai/Mistral-7B-Instruct-v0.3", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Mixtral-8x-7b:
curl -k ${KEYCLOAK_ADDR}/Mixtral-8x7B-Instruct-v0.1/v1/completions -X POST -d '{"model": "mistralai/Mixtral-8x7B-Instruct-v0.1", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Falcon3-7b:
curl -k ${KEYCLOAK_ADDR}/Falcon3-7B-Instruct/v1/completions -X POST -d '{"model": "tiiuae/Falcon3-7B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Tei:
curl -k ${KEYCLOAK_ADDR}/bge-base-en-v1.5/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Tei-reranking:
curl -k ${KEYCLOAK_ADDR}/bge-reranker-base/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Deepseek R1 Distill Qwen 32b:
curl -k ${KEYCLOAK_ADDR}/DeepSeek-R1-Distill-Qwen-32B/v1/completions -X POST -d '{"model": "deepseek-ai/DeepSeek-R1-Distill-Qwen-32B", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Deepseek R1 Distill Llama 8b:
curl -k ${KEYCLOAK_ADDR}/DeepSeek-R1-Distill-Llama-8B/v1/completions -X POST -d '{"model": "deepseek-ai/DeepSeek-R1-Distill-Llama-8B", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Llama-3-8b-CPU
curl -k ${KEYCLOAK_ADDR}/Meta-Llama-3.1-8B-Instruct-vllmcpu/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Deepseek R1 Distill Qwen 32b CPU:
curl -k ${KEYCLOAK_ADDR}/DeepSeek-R1-Distill-Qwen-32B-vllmcpu/v1/completions -X POST -d '{"model": "deepseek-ai/DeepSeek-R1-Distill-Qwen-32B", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For inferencing with Deepseek R1 Distill Llama 8b CPU:
curl -k ${KEYCLOAK_ADDR}/DeepSeek-R1-Distill-Llama-8B-vllmcpu/v1/completions -X POST -d '{"model": "deepseek-ai/DeepSeek-R1-Distill-Llama-8B", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

`````
#### Accessing the model from Inference Cluster deployed without APISIX and Keycloak
`````
When deploying models for inference without Keycloak and APISIX,
you can directly invoke the model inference API without the need for additional bearer token header.

Here's an example of how you can make the request:

For inferencing with Llama-3-8b:
curl -k ${KEYCLOAK_ADDR}/Meta-Llama-3.1-8B-Instruct/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json'

`````


### Accessing Cluster Dashboard

To log in, use a **bearer token**. Generate it using the following command:
```sh
   kubectl -n kube-system create token dashboard-user
```

Open your browser and navigate to:
```
   https://<cluster-url>/dashboard/#/login
   Replace `<cluster-url>` with your domain name.
```






Example Run:
[Inference-As-Service-Deployment-Automation](https://intel-my.sharepoint.com/:v:/r/personal/ahmed_seemal_intel_com/Documents/Videos/Clipchamp/Video%20Project%203/Exports/one-click-modularization.mp4?csf=1&web=1&e=k3mc0V&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D)
