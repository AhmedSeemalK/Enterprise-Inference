# Inference as a Service Deployment Automation
   This automates the setup, reset, and update of a Inference as Service kubernetes cluster using playbooks. It includes functions for setting up   
environment, deploying various components 
   - Kubernetes 
   - Habana AI Operator
   - Ingress NGINX Controller
   - Keycloak
   - APISIX
   - Model Deployments

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
1. [**llama-8b**](https://huggingface.co/meta-llama/Llama-3.1-8B-Instruct)
2. [**llama-70b**](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct)
3. [**codellama-34b**](https://huggingface.co/codellama/CodeLlama-34b-Instruct-hf)
4. [**mixtral-8x7b**](https://huggingface.co/mistralai/Mixtral-8x7B-Instruct-v0.1)
5. [**mistral-7b**](https://huggingface.co/mistralai/Mistral-7B-Instruct-v0.3)
6. [**tei**](https://github.com/huggingface/tei-gaudi/pkgs/container/tei-gaudi)
7. [**tei-rerank**](https://github.com/huggingface/text-embeddings-inference/pkgs/container/text-embeddings-inference)
8. [**falcon3-7b**](https://huggingface.co/tiiuae/Falcon3-7B-Instruct)   
9. [**cpu-llama-8b**](https://github.com/huggingface/text-generation-inference/pkgs/container/text-generation-inference)
   
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

### Add LLM Model
This option allows you to deploy a new LLM model on the Kubernetes cluster.

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

For inferencing with Llama-3-8b-CPU
curl -k ${KEYCLOAK_ADDR}/Meta-Llama-3.1-8B-Instruct-vllmcpu/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"
`````
#### Accessing the model from Inference Cluster deployed without APISIX and Keycloak
`````
When deploying models for inference without Keycloak and APISIX,
you can directly invoke the model inference API without the need for additional bearer token header.

Here's an example of how you can make the request:

For inferencing with Llama-3-8b:
curl -k ${KEYCLOAK_ADDR}/Meta-Llama-3.1-8B-Instruct/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json'

`````



Example Run:
[Inference-As-Service-Deployment-Automation](https://intel-my.sharepoint.com/:v:/r/personal/ahmed_seemal_intel_com/Documents/Videos/Clipchamp/Video%20Project%203/Exports/one-click-modularization.mp4?csf=1&web=1&e=k3mc0V&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D)
