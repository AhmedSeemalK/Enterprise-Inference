# AI Inference as a Service Deployment Automation
Unleash the Power of AI Inference

   The Inference as a Service Deployment Automation suite is your ultimate companion for harnessing the full potential of AI inference capabilities. 
   
   Imagine a world where deploying and managing AI inference services is as effortless as a few keystrokes. With this automation suite, you can bid farewell to the complexities of manual configurations and embrace a future where agility and operational excellence are the norms.
   
   Powered by Kubernetes infrastructure.This automation suite empowers enterprises to seamlessly provision, reconfigure, and evolve their AI inference infrastructure with unparalleled agility.

#### Key Components:
   - **Kubernetes**: A powerful container orchestration platform that automates the deployment, scaling, and management of containerized applications, ensuring high availability and efficient resource utilization.
   - **Habana AI Operator**: A specialized operator that manages the lifecycle of Habana AI resources within the Kubernetes cluster, enabling efficient utilization of hardware for AI workloads.
   - **Ingress NGINX Controller**: A high-performance reverse proxy and load balancer for traffic, responsible for routing incoming requests to the appropriate services within the Kubernetes cluster, ensuring seamless access to deployed AI models.
   - **Keycloak**: An open-source identity and access management solution that provides robust authentication and authorization capabilities, ensuring secure access to AI services and resources within the cluster.
   - **APISIX**: A cloud-native API gateway, handling API traffic and providing advanced features caching, and authentication, enabling efficient and secure access to deployed AI models.
   - **Observability**: An open-source monitoring solution designed to operate natively within Kubernetes clusters, providing comprehensive visibility into the performance, health, and resource utilization of deployed applications and cluster components through metrics, visualization, and alerting capabilities.
   - **Model Deployments**: Automated deployment and management of llm models within the Kubernetes cluster, enabling scalable and reliable AI inference capabilities.
   
# Table of Contents
- [Inference as a Service Deployment Automation](#ai-inference-as-a-service-deployment-automation)
- [Models for Inference as a Service](#models-for-inference-as-a-service)
- [Prerequisites for Setting Up Inference as a Service Cluster](#prerequisites-for-setting-up-inference-as-a-service-cluster)
   - [Gaudi Node Requirement](#gaudi-node-requirements)
   - [SSH Key Setup](#ssh-key-setup)
   - [Supported Linux Distributions](#supported-linux-distributions)
   - [Network and Storage Requirement](#network-and-storage-requirement)
   - [DNS and SSL/TLS Setup](#dns-and-ssltls-setup)
     - [Production Environment](#production-environment)
     - [Development Environment](#development-environment)
  - [Hugging Face Token Generation](#hugging-face-token-generation)
- [Designing Inventory for Inference Cluster Deployment](#designing-inventory-for-inference-cluster-deployment)
   - [Control Plane Node Sizing](#control-plane-node-sizing)
   - [Worker Node Sizing](#worker-node-sizing)
   - [CPU-based Workloads](#cpu-based-workloads)
   - [HPU-based Workloads (Intel Gaudi)](#gpu-based-workloads-intel-gaudi)
   - [Infrastructure Node Sizing](#infrastructure-node-sizing)
   - [Setting Dedicated Infra Node](#setting-dedicated-inference-infra-node)
   - [Node Sizing Guide](#node-sizing-guide)
   - [Single Node Deployment](#single-node-deployment)
   - [Single Master Multiple Worker Node Deployment](#single-master-multiple-worker-node-deployment)
   - [Multi Master Multi Worker Node Deployment](#multi-master-multi-worker-node-deployment)
- [Running the Inference Deployment Automation](#running-the-inference-deployment-automation)   
   - [Using the inference-config.cfg global configuration file](#using-the-inference-configcfg-configuration-file)
   - [Deploying the cluster](#deploying-the-cluster)
   - [Alternative Deployment Method](#alternative-deployment-method)
   - [Access Formats for Deployed AI Models](#alternative-deployment-method)
- [Installation User Menu](#main-menu)
   - [Fresh Installation Workflow](#fresh-installation)
      - [Interactive Installation Screen](#example-fresh-installation-screen)
- [Reset Cluster User Menu](#reset-cluster)
   - [Interactive Reset Cluster Screen](#example-reset-cluster-screen)
- [Update Existing Cluster User Menu](#update-existing-cluster)         
   - [Manage Models: Add or Remove models](#manage-models-add-or-remove-models)
      - [Deploy LLM Model](#deploy-llm-model)
      - [Deploy LLM Model from Hugging Face](#deploy-llm-model-from-hugging-face)
      - [Remove LLM Model](#remove-llm-model)
      - [List LLM Model](#list-llm-model)
- [Obervability for Inference cluster](#observability)
   - [Components](#it-consists-of-the-following-key-components)
   - [Accessing the observability dashboard](#to-access-the-observability-dashboard-follow-these-steps)
- [Inferencing with Deployed Models](#accessing-deployed-models-from-inference-cluster)
   - [Accessing Inference Model APIs](#accessing-inference-model-apis)
   - [Accessing Models Deployed with Keycloak and APISIX](#export-user-credentials)
   - [Accessing Models Deployed without Keycloak and APISIX](#accessing-the-model-from-inference-cluster-deployed-without-apisix-and-keycloak)

## Models for Inference as a Service
The following table lists the pre-validated models for the Inference as a Service Automation.      
These models can be selectively deployed based on the configuration settings of models in the `inference-config.cfg` file, allowing organizations to choose the appropriate models that meet their specific business needs and applications.
| Model                                  | Description                                                  |
|----------------------------------------|---------------------------------------------------------------|
| 1. [**llama-8b**](https://huggingface.co/meta-llama/Llama-3.1-8B-Instruct) | Large Language Model (LLM) with 8 billion parameters, suitable for a wide range of natural language processing tasks. |
| 2. [**llama-70b**](https://huggingface.co/meta-llama/Llama-3.1-70B-Instruct) | LLM with 70 billion parameters, offering enhanced performance for complex language tasks. |
| 3. [**codellama-34b**](https://huggingface.co/codellama/CodeLlama-34b-Instruct-hf) | Specialized LLM with 34 billion parameters, designed for code generation and understanding. |
| 4. [**mixtral-8x7b**](https://huggingface.co/mistralai/Mixtral-8x7B-Instruct-v0.1) | Multimodal LLM with 8x7 billion parameters, optimized for efficient inference and knowledge retrieval. |
| 5. [**mistral-7b**](https://huggingface.co/mistralai/Mistral-7B-Instruct-v0.3) | General-purpose LLM with 7 billion parameters, capable of handling various natural language tasks. |
| 6. [**tei**](https://github.com/huggingface/tei-gaudi/pkgs/container/tei-gaudi) | Text Embedding Inference model for efficient text representation and similarity search. |
| 7. [**tei-rerank**](https://github.com/huggingface/text-embeddings-inference/pkgs/container/text-embeddings-inference) | Text Embedding Inference model with re-ranking capabilities for improved search relevance. |
| 8. [**falcon3-7b**](https://huggingface.co/tiiuae/Falcon3-7B-Instruct) | Instruction-following LLM with 7 billion parameters, designed for task-oriented language understanding and generation. |
| 9. [**deepseek-r1-distill-qwen-32b**](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B) | Distilled version of the Qwen-32B model, optimized for efficient inference and knowledge retrieval. |
| 10. [**deepseek-r1-distill-llama8b**](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-8B) | Distilled version of the LLama-8B model, optimized for efficient inference and knowledge retrieval. |
| 11. [**cpu-llama-8b**](https://github.com/huggingface/text-generation-inference/pkgs/container/text-generation-inference) | CPU-optimized version of the LLama-8B model for efficient inference on CPUs. |
| 12. [**cpu-deepseek-r1-distill-qwen-32b**](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B) | CPU-optimized version of the Distilled Qwen-32B model for efficient inference on CPUs. |
| 13. [**cpu-deepseek-r1-distill-llama8b**](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-8B) | CPU-optimized version of the Distilled LLama-8B model for efficient inference on CPUs. |


These models can be deployed, providing a range of inference capabilities to suit various needs and applications.

Notice:   
Please note that this list is subject to change, and additional models may be added or removed based on business requirements and model performance evaluations.    


## Prerequisites for Setting Up Inference as a Service Cluster

   ##### Gaudi Node Requirements        
   Ensure that the Gaudi Node(s) in your cluster have firmware and driver versions 1.20 installed
   Verify the firmware version by running the below command
   ```
      hl-smi

      and      

      hl-smi -L | grep SPI
   ```
    
   ##### SSH Key Setup
   - Generate an SSH key pair (if you don't have one already) using the `ssh-keygen` command.
   - Copy the public key (`id_rsa.pub`) to all the control plane and worker nodes that will be part of the cluster.
   - On each node, add the public key to the `authorized_keys` file in the `.ssh` directory of the user account you'll be using to connect to the nodes.
      ```
           echo "<YOUR_PUBLIC_KEY_CONTENTS>" >> ~/.ssh/authorized_keys
      ```
   - Ensure that the SSH service is running and enabled on all the nodes.
   - Verify that you can connect to all the nodes using the SSH key or password-based authentication from the Ansible control machine.
   - If you are using a bastion host for secure access to the cluster nodes, configure the bastion host with the necessary SSH keys or authentication methods, and ensure that the Ansible control machine can connect to the cluster nodes through the bastion host.

   #### Network and Storage Requirement
   ##### Network Requirement
   - Configure a network topology that allows communication between the control plane nodes and worker nodes.
   - Ensure that the nodes have internet access to pull the required Docker images and other dependencies during the deployment process.
   - Ensure that the necessary ports are open for communication (e.g., ports for Kubernetes API server, etcd, etc.).
   ##### Storage Requirement
   When planning for storage, it is important to consider both the needs of your cluster and the applications you intend to deploy:
   - Attach sufficient storage to your nodes based on the specific requirements and design of your cluster:
  - For model deployment, allocate storage based on the size of the models you plan to deploy. Larger models may require more storage space.
  - If deploying observability tools, it is recommended to allocate at least 30GB of storage for optimal performance.   

   #### DNS and SSL/TLS Setup
   
   #### Production Environment
   ##### DNS Setup
   1. Purchase a domain name from a reputable domain registrar (e.g., GoDaddy, Namecheap, Google Domains).
   2. Configure the domain's DNS records to point to your production server or load balancer IP address.
   ##### SSL/TLS Setup with a Trusted Certificate Authority (CA)
   1. Obtain an SSL/TLS certificate from a trusted Certificate Authority (CA) like Let's Encrypt, DigiCert, Comodo, or GoDaddy.
   2. Follow the CA's instructions to generate a Certificate Signing Request (CSR) and submit it for validation.
   3. Once the CA validates your domain ownership and organizational details, they will issue the SSL/TLS certificate.
   4. Install the issued certificate on your production server or load balancer, following the CA's instructions.
   ##### Renewal and Automation
   1. SSL/TLS certificates from trusted CAs typically have a validity period of 1-3 years.
   2. Set up a reminder or automated process to renew the certificate before it expires.
   3. Follow the CA's instructions for renewing the certificate, which may involve generating a new CSR and submitting it for validation.
   4. After successful renewal, update the certificate on your production server or load balancer.
   ##### Additional Considerations
   - For production environments, it's recommended to use a dedicated DNS provider and a trusted Certificate Authority (CA) for SSL/TLS certificates.
   - Let's Encrypt is a free and open CA, suitable for development and testing purposes.
   - Ensure that your firewall rules allow incoming HTTP traffic on port 80 for the domain validation process (if using HTTP-based validation).
   - If you're using a reverse proxy or load balancer, configure it to terminate SSL/TLS connections and forward the traffic to the backend servers.
      
   #### Development Environment
   ##### DNS Setup
   1. Set up a subdomain (e.g., `dev.example.com`) or a separate domain (e.g., `mydevdomain.com`) for your development environment.
   2. Point the subdomain or domain to the IP address of your development server or cluster.
   3. Alternatively, if you don't have a DNS server, you can modify the `/etc/hosts` file on your local machine to map the domain or subdomain to the IP address of your development server or cluster.
   For example:
   ```
      127.0.0.1   dev.example.com
   ```
   ##### SSL/TLS Setup with Let's Encrypt
   1. Install the Certbot client on your development server or a machine that can access the server over HTTP.
   2. Run the following command to obtain a certificate for your domain:
   ```
      sudo apt update
      sudo apt install software-properties-common
      sudo add-apt-repository universe
      sudo add-apt-repository ppa:certbot/certbot
      sudo apt update
      sudo apt install certbot
      certbot --version
      certbot certonly --manual --preferred-challenges=dns -d dev.example.com      
   ```
   3. Follow the instructions provided by Certbot to create the required DNS TXT record.
   4. Once the DNS TXT record is created, Certbot will validate the domain ownership and issue the certificate.
   5. The issued certificate files (fullchain.pem and privkey.pem) will be located in `/etc/letsencrypt/live/dev.example.com/`.

   
   ##### Supported Linux Distributions
   - ubuntu 22.04
   

   #### Hugging Face Token Generation
   1. Go to the [Hugging Face website](https://huggingface.co/) and sign in to your account (or create a new account if you don't have one).
   2. Once signed in, click on your profile picture in the top-right corner, and select "Settings" from the dropdown menu.
   3. In the "Settings" page, navigate to the "Access Tokens" section.
   4. Click on the "New Token" button to generate a new access token.
   5. In the "New Token" modal, you can optionally provide a description for the token (e.g., "My Development Token").
   6. Click on the "Generate" button to create the new token.
   7. Configure the token in the inference-config.cfg file under ida/ directory 



## Designing Inventory for Inference Cluster Deployment
   
   Design your inventory file located at `ida/inventory/hosts.yaml` according to your enterprise deployment requirements for the inference cluster.    


   ##### Control Plane Node Sizing
   For an inference model deployment cluster in Kubernetes (K8s), the control plane nodes should have sufficient resources to handle the management and orchestration of the cluster. It's recommended to have at least 8 vCPUs and 32 GB of RAM per control plane node.    
   For larger clusters or clusters with high workloads, you may need to increase the resources further.
   
   ##### Worker Node Sizing
   The worker node sizing will depend on the specific requirements of the inference models and the workloads they need to handle. Here are some recommendations:
      
   ##### CPU-based Workloads
   For CPU-based inference workloads, the worker nodes should have a sufficient number of vCPUs based on the number of models and the expected concurrency. A general guideline is to allocate 32 vCPUs per model instance, depending on the model complexity and resource requirements.

   ##### GPU-based Workloads (Intel Gaudi)
   For GPU-based inference workloads using Intel Gaudi GPUs, the worker nodes should be equipped with the appropriate number of Gaudi GPUs based on the number of models and the expected concurrency.
   Each Gaudi GPU can handle multiple model instances, depending on the model size and resource requirements.
   
   Additionally, the worker nodes should have sufficient RAM and storage capacity to accommodate the inference models and any associated data.


   ##### Infrastructure Node Sizing
   Infrastructure nodes used for deploying and managing services like Keycloak and APISIX. The number of nodes required depends on the presence of nodes labeled as    `inference-infra`. If no nodes have this label, a single-node deployment on the control plane node will be used.       
   Ensure that sufficient compute resources (CPU, memory, and storage) are provisioned for the infrastructure nodes to handle the expected workloads
   ###### Single-Node Deployment (Fallback)
   If no nodes are labeled as `inference-infra` in the `inventory/hosts.yml` file, single replicas of Keycloak and APISIX will be provisioned as a fallback to          support single-node deployment types.
   
   ##### Node Sizing Guide
   For more infromation on node sizing please refer to building large clusters guide
   ```   
   https://kubernetes.io/docs/setup/best-practices/cluster-large/#size-of-master-and-master-components
   ```

   Notice:
   It's important to note that these are general recommendations, and the actual sizing may vary based on the specific requirements of your inference models, workloads, and performance expectations.

   
   ## Configuring inventory/hosts.yml 

   ##### Note:
   > It is recommended to keep the host names in the `inventory/hosts.yml` file similar to the actual machine hostnames. This ensures compatibility and maintain consistency across different systems and processes. Additionally, this automation will update the hostnames of the machines to match the ones specified in the `inventory/hosts.yml` file.
   
   ### Setting Dedicated Inference Infra Node:   
   To configure dedicated infra node edit the file `inventory/hosts.yml` and add the label `inference-infra` to the nodes.   
   This group will be used to schedule the Keycloak and APISIX workloads.
   
   follow these steps:
   1. Open the `inventory/hosts.yml` file in a text editor.
   2. Locate the section where you define your nodes. This is typically under the `all` group or any other group you've defined for your nodes.
   3. For each node that you want to label as an `inference-infra` node, add the following line under the node's IP or hostname:
   ```yaml
   node_labels:
     node-role.kubernetes.io/inference-infra: "true"
   ```
   4.After labeling the desired nodes, list the nodes under the group kube_inference_infra to include in this group. 

   Please find the template for the inventory configuration with 2 dedicated infra nodes for inference cluster
   ```yaml
      all:
        hosts:
          inference-control-plane-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-infra-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-infra: "true"         
          inference-infra-node-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-infra: "true"
          inference-infra-workload-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key          
        children:
          kube_control_plane:
            hosts:
              inference-control-plane-01:       
          kube_node:
            hosts:
              inference-infra-node-01:
              inference-infra-node-02:
              inference-infra-workload-node-01:    
          kube_inference_infra:
              inference-infra-node-01:
              inference-infra-node-02:
        etcd:
          hosts:
            inference-control-plane-01:       
        k8s_cluster:
          children:
            kube_control_plane:
            kube_node:
            kube_inference_infra: 
   ```

   
   ### Single Node Deployment:   
   
   For an single node deployment, ensure that the public SSH key (`id_rsa.pub`) is added to the `authorized_keys` file on the node.  
   This step is necessary to enable the node to establish an SSH connection with itself.   
   Replace the placeholders in the following code with the appropriate values:

   ```yaml
      all:
        hosts:
          inference-control-plane-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key          
        children:
          kube_control_plane:
            hosts:
              inference-control-plane-01:
          kube_node:
            hosts:
              inference-control-plane-01:
          etcd:
            hosts:
              inference-control-plane-01:
          k8s_cluster:
            children:
              kube_control_plane:
              kube_node:
          calico_rr:
            hosts: {}
   ```

 ### Single Master Multiple Worker Node Deployment:   
   
   For deployment with a single control plane node and multiple worker nodes.   
   Replace the placeholders in the following code with the appropriate values:
   
   ```yaml
      all:
        hosts:
          inference-control-plane-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-worker-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-worker-node-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
        children:
          kube_control_plane:
            hosts:
              inference-control-plane-01:
          kube_node:
            hosts:
              inference-worker-node-01:
              inference-worker-node-02:
          etcd:
            hosts:
              inference-control-plane-01:
          k8s_cluster:
            children:
              kube_control_plane:
              kube_node:
          calico_rr:
            hosts: {}
   ```

 ### Multi Master Multi Worker Node Deployment:   
   For an enterprise-grade deployment with multiple control plane nodes and multiple worker nodes, it is recommended to follow these guidelines:
   
   ##### Control Plane Node Count
   It's recommended to have an odd number of control plane nodes (e.g., 3, 5, 7) to ensure high availability and fault tolerance. If one control plane node fails, the remaining nodes can continue to operate and maintain a quorum, ensuring the cluster remains operational.
      
   Replace the placeholders in the following code with the appropriate values:
   
   ```yaml
      all:
        hosts:
          inference-control-plane-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-control-plane-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key         
          inference-control-plane-03:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-worker-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-worker-node-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-worker-node-03:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-worker-node-04:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key         
          inference-worker-node-05:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
        children:
          kube_control_plane:
            hosts:
              inference-control-plane-01:
              inference-control-plane-02:
              inference-control-plane-03:
          kube_node:
            hosts:
              inference-worker-node-01:
              inference-worker-node-02:
              inference-worker-node-03:
              inference-worker-node-04:
              inference-worker-node-05:
          etcd:
            hosts:              
              inference-control-plane-01:
              inference-control-plane-02:
              inference-control-plane-03:
          k8s_cluster:
            children:
              kube_control_plane:
              kube_node:
          calico_rr:
            hosts: {}
   ```


 

## Usage
#### Running the Inference Deployment Automation

##### Authentication Formats for Deployed AI Models:   
   - **With Keycloak and APISIX**:      
      -  In this flow, Keycloak and APISIX are deployed to provide authentication, authorization, and API gateway functionality, ensuring secure and controlled access to the deployed AI models.
   - **Without Keycloak and APISIX**:
      - In this flow, the AI models are deployed directly within the Kubernetes cluster, without the additional security and API gateway layers provided by Keycloak and APISIX. This deployment option is suitable for scenarios where these components are not required or are handled separately.

#### Using the inference-config.cfg configuration file
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
deploy_kubernetes_fresh=on
deploy_ingress_controller=on
deploy_keycloak_apisix=off
deploy_observability=off
deploy_llm_models=on

`````
Make sure to update the values in the inference-config.cfg file according to your requirements before running the automation.

##### Notice:
   This automation is designed for deployments which allows you to selectively deploy or skip various components based on your requirements.

>
> - If `deploy_kubernetes_fresh` is set to `on`, a fresh Kubernetes cluster will be initialized as per the deployment configuration.
> - If `deploy_ingress_controller` is set to `on`, ingress controller will be configured to route external traffic to the cluster
> - If `deploy_keycloak_apisix` is set to `on`, Keycloak and APISIX will be deployed for Model API Authentication
> - If `deploy_observability` is set to `on`, the observability stack will be deployed for monitoring.
> - If `deploy_llm_models` is set to `on`, the selected models will be deployed for inferencing
> - The `cert_file` and `key_file` paths should be set according to the instructions for generating certificates for development and production environments, as documented.
> - The `models` value corresponds to the pre-validated LLM models listed in the documentation.

> - The `keycloak_client_id` is the client ID used for accessing APIs through Keycloak.
> - The `keycloak_admin_user` is the administrator username for Keycloak.
> - The `keycloak_admin_password` is the administrator password for Keycloak.
> - If `deploy_keycloak_apisix` is set to `off`, the `keycloak_client_id`, `keycloak_admin_user`, and `keycloak_admin_password` values will have no effect.
> - The `hugging_face_token` is the token used for pulling LLM models from Hugging Face. 
> - If `deploy_llm_models` is set to `off`, the `hugging_face_token` value will be ignored.
> - The `cpu_or_gpu` value specifies whether to deploy models for CPU or Intel Gaudi.


### Deploying the cluster

Once you have configured the `inference-config.cfg` file and selected the components to be deployed, as well as   
updated the `ida/inventory/hosts.yml` file with your desired requirement as documented, you are ready to proceed with the deployment. 

Execute the following command to initiate the automation:
```
   bash inference-as-auto-deploy.sh
```
#### Alternative Deployment Method

bash inference-as-auto-deploy.sh [OPTIONS]
##### Options
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

##### Installation Precautions:
Ensure that the nodes do not contain existing workloads. If necessary, please purge any previous cluster configurations before initiating a fresh installation to avoid an inappropriate cluster state. Proceeding without this precaution could lead to service disruptions or data loss.

If you choose to perform a fresh installation, the automation will prompt you for the necessary inputs and proceed with the following steps:
1. Prompt for Input: Collects the required inputs from the user.
2. Setup Initial Environment: Sets up the virtual environment and installs necessary dependencies.
3. Install Kubernetes: Installs Kubernetes and sets up the kubeconfig for the user.
4. Deploy Components: Deploys the selected components (Habana AI Operator, Ingress NGINX Controller, Keycloak, and models).
##### Example
`````
To perform a fresh installation with specific parameters, you can run:
bash inference-as-auto-deploy.sh --cluster-url "https://example.com" --cert-file "/path/to/cert.pem" --key-file "/path/to/key.pem" --keycloak-client-id "my-client-id" --keycloak-admin-user "user" --keycloak-admin-password "password" --hugging-face-token "token" --models "1,3,5" --cpu-or-gpu "g"

or

with inference-config.cfg file configured, run
bash inference-as-auto-deploy.sh
`````
##### Example Fresh Installation Screen:
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

##### Example Reset Cluster Screen
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

##### Example Update Existing Cluster Screen
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


## Manage Models: Add or Remove Models
### Deploy LLM Model
This option allows you to deploy a new LLM model on the Inference Cluster.

##### Example Manage Model Screen:
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

##### Example Deploy Model from Hugging Face Screen:
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

##### Example Remove Deployed LLM Model Screen
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

##### Example Listing Deployed LLM Model Screen 
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

## Manage Nodes: Add or Remove Nodes.

##### Add Worker Node:
###### Precautions:
WARNING: Adding a node that is already managed by another Kubernetes cluster or has been manually configured using kubeadm, kubelet, or other tools can cause severe disruptions to your existing cluster. This may lead to issues such as pod restarts, service interruptions, and potential data loss. 

##### Remove Worker Node:
###### Precautions:
CAUTION: Removing the Inference LLM Model will also remove its associated services and resources, which may cause service downtime and potential data loss. This action is irreversible. 


## Observability

The observability stack offers monitoring solution designed to operate natively within Kubernetes clusters. 
###### It consists of the following key components:
- **Prometheus**: A time-series database and monitoring system that stores metrics from various sources, including Kubernetes components, applications, and custom exporters.
- **Alertmanager**: A component responsible for handling alerts generated by Prometheus based on predefined rules, enabling notifications and other procedures.
- **Grafana**: A powerful data visualization and dashboarding tool that integrates seamlessly with Prometheus, allowing users to create customized dashboards and visualizations for monitoring AI services and resources.

#### To access the observability dashboard, follow these steps:
Initiate your web browser and proceed to navigate to the specified URL:
```
   https://<cluster-url>/observability/login
   #The cluster URL was configured during deployment in the cluster_url field  in inference-config.cfg file)
   # Please use the default code "prom-operator" and kindly change it upon your first login.

```

---

#### Accessing Inference cluster Admin Dashboard

**Note:** This dashboard is intended for administrators only. As it is a Kubernetes dashboard, please use it with caution as actions taken here can alter the state of the cluster.
To log in, use a **bearer token**. Generate it using the following command:
```sh
   kubectl -n kube-system create token dashboard-user
```

Initiate your web browser and proceed to navigate to the specified URL:
```
   https://<cluster-url>/dashboard/#/login
   #The cluster URL was configured during deployment in the cluster_url field  in inference-config.cfg file
```




## Accessing Deployed Models from Inference Cluster

##### Export user credentials

#### Accessing Inference Model APIs
To configure your environment with the necessary variables for connecting to Keycloak, you will need to set the following environment variables.  
Please replace the placeholder values with your actual configuration details, which has been configured in `inference-config.cfg` file under the `ida/` directory during deployment.

`````
#The Keycloak admin username was configured during deployment in the keycloak_admin_user field
export USER=<your_username>

#The Keycloak admin password was configured during deployment in the keycloak_admin_password field
export PASSWORD=<your_password>                     

#The Keycloak cluster URL was configured during deployment in the cluster_url field
export KEYCLOAK_ADDR=https://example.com            

#Default is 'master' if not changed
export KEYCLOAK_REALM=<your_keycloak_realm>         

#The client ID can be found in the Keycloak console and was configured during deployment in the keycloak_client_id field
export KEYCLOAK_CLIENT_ID=<your_keycloak_client_id> 

#The client secret can be obtained from the Keycloak console under the 'Authorization' tab of the client ID
export KEYCLOAK_CLIENT_SECRET=<your_keycloak_client_secret> 

# Obtaining the access token
export TOKEN=$(curl -k -X POST $KEYCLOAK_ADDR/token  -H 'Content-Type: application/x-www-form-urlencoded' -d "grant_type=password&client_id=${KEYCLOAK_CLIENT_ID}&client_secret=${KEYCLOAK_CLIENT_SECRET}&username=${USER}&password=${PASSWORD}" | jq -r .access_token)

With the obtained access token, we can proceed to make an Inference API call to the deployed Models.

For Inferencing with Llama-3-8b:
curl -k ${KEYCLOAK_ADDR}/Meta-Llama-3.1-8B-Instruct/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Llama-3-70b:
curl -k ${KEYCLOAK_ADDR}/Meta-Llama-3.1-70B-Instruct/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-70B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Codellama-34b:
curl -k ${KEYCLOAK_ADDR}/CodeLlama-34b-Instruct-hf/v1/completions -X POST -d '{"model": "codellama/CodeLlama-34b-Instruct-hf", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Mistral-7b:
curl -k ${KEYCLOAK_ADDR}/Mistral-7B-Instruct-v0.3/v1/completions -X POST -d '{"model": "mistralai/Mistral-7B-Instruct-v0.3", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Mixtral-8x-7b:
curl -k ${KEYCLOAK_ADDR}/Mixtral-8x7B-Instruct-v0.1/v1/completions -X POST -d '{"model": "mistralai/Mixtral-8x7B-Instruct-v0.1", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Falcon3-7b:
curl -k ${KEYCLOAK_ADDR}/Falcon3-7B-Instruct/v1/completions -X POST -d '{"model": "tiiuae/Falcon3-7B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Tei:
curl -k ${KEYCLOAK_ADDR}/bge-base-en-v1.5/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Tei-reranking:
curl -k ${KEYCLOAK_ADDR}/bge-reranker-base/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Deepseek R1 Distill Qwen 32b:
curl -k ${KEYCLOAK_ADDR}/DeepSeek-R1-Distill-Qwen-32B/v1/completions -X POST -d '{"model": "deepseek-ai/DeepSeek-R1-Distill-Qwen-32B", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Deepseek R1 Distill Llama 8b:
curl -k ${KEYCLOAK_ADDR}/DeepSeek-R1-Distill-Llama-8B/v1/completions -X POST -d '{"model": "deepseek-ai/DeepSeek-R1-Distill-Llama-8B", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Llama-3-8b-CPU
curl -k ${KEYCLOAK_ADDR}/Meta-Llama-3.1-8B-Instruct-vllmcpu/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Deepseek R1 Distill Qwen 32b CPU:
curl -k ${KEYCLOAK_ADDR}/DeepSeek-R1-Distill-Qwen-32B-vllmcpu/v1/completions -X POST -d '{"model": "deepseek-ai/DeepSeek-R1-Distill-Qwen-32B", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

For Inferencing with Deepseek R1 Distill Llama 8b CPU:
curl -k ${KEYCLOAK_ADDR}/DeepSeek-R1-Distill-Llama-8B-vllmcpu/v1/completions -X POST -d '{"model": "deepseek-ai/DeepSeek-R1-Distill-Llama-8B", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN"

`````

#### Accessing the model from Inference Cluster deployed without APISIX and Keycloak
`````
When deploying models for inference without Keycloak and APISIX,
The model inference API can be invoked directly without the necessity of including an additional bearer token header in the request.

An exemplary structure for making a request to the inference API is as follows:

#The Keycloak cluster URL was configured during deployment in the cluster_url field
export KEYCLOAK_ADDR=https://example.com

For Inferencing with Llama-3-8b:
curl -k ${KEYCLOAK_ADDR}/Meta-Llama-3.1-8B-Instruct/v1/completions -X POST -d '{"model": "meta-llama/Meta-Llama-3.1-8B-Instruct", "prompt": "What is Deep Learning?", "max_tokens": 5, "temperature": 0}' -H 'Content-Type: application/json'

`````

Example Run:
[Inference-As-Service-Deployment-Automation](https://intel-my.sharepoint.com/:v:/r/personal/ahmed_seemal_intel_com/Documents/Videos/Clipchamp/Video%20Project%203/Exports/one-click-modularization.mp4?csf=1&web=1&e=k3mc0V&nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D)
