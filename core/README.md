# Intel AI for Enterprise Inference 

### AI Inference Deployment Suite 

Unleash the Power of AI Inference

   The Intel AI for Enterprise Inference suite is your ultimate companion for harnessing the full potential of AI Inference capabilities. 
   
   Imagine a world where deploying and managing AI Inference services is as effortless as a few keystrokes. With AI Inference Deployment Suite, you can bid farewell to the complexities of manual provisioning and embrace a future where agility and operational excellence are the norms.
   
   Powered by Kubernetes Infrastructure. AI Inference Deployment suite empowers Enterprises to seamlessly provision, deploy, configure, and evolve their AI Inference Infrastructure with unparalleled agility.

   AI Inference Deployment suite is designed for versatility, supporting model deployment for Inference across a diverse range of Intel hardware platforms, including   
   Intel Xeon, Intel Gaudi, and Intel CPUs, ensuring maximum flexibility for your AI Inference Infrastructure requirements

#### Key Components:
   - **Kubernetes**: A powerful container orchestration platform that automates the deployment, scaling, and management of containerized applications, ensuring high availability and efficient resource utilization.
   - **Habana AI Operator**: A specialized operator that manages the lifecycle of Habana AI resources within the Kubernetes cluster, enabling efficient utilization of Intel Gaudi hardware for AI workloads.
   - **Ingress NGINX Controller**: A high-performance reverse proxy and load balancer for traffic, responsible for routing incoming requests to the appropriate services within the Kubernetes cluster, ensuring seamless access to deployed AI models.
   - **Keycloak**: An open-source identity and access management solution that provides robust authentication and authorization capabilities, ensuring secure access to AI services and resources within the cluster.
   - **APISIX**: A cloud-native API gateway, handling API traffic and providing advanced features caching, and authentication, enabling efficient and secure access to deployed AI models.
   - **Observability**: An open-source monitoring solution designed to operate natively within Kubernetes clusters, providing comprehensive visibility into the performance, health, and resource utilization of deployed applications and cluster components through metrics, visualization, and alerting capabilities.
   - **Model Deployments**: Automated deployment and management of AI LLM Models within the Kubernetes Inference cluster, enabling scalable and reliable AI Inference capabilities.
   
# Table of Contents
- [Intel AI for Enterprise Inference Deployment Suite](#intel-ai-for-enterprise-inference)
- [Models for Inference Cluster](#models-for-inference-cluster)
- [Prerequisites for Setting Up Intel AI for Enterprise Inference Cluster](#prerequisites-for-setting-up-intel-ai-for-enterprise-inference-cluster)
   - [System Requirement](#system-requirement)
   - [Gaudi Node Requirement](#gaudi-node-requirements-and-setup-guide)
   - [SSH Key Setup](#ssh-key-setup)
   - [Network and Storage Requirement](#network-and-storage-requirement)
   - [DNS and SSL/TLS Setup](#dns-and-ssltls-setup)
     - [Production Environment](#production-environment)
     - [Development Environment](#development-environment)
  - [Hugging Face Token Generation](#hugging-face-token-generation)
- [Designing Inventory for Inference Cluster Deployment](#designing-inventory-for-inference-cluster-deployment)
   - [Control Plane Node Sizing](#control-plane-node-sizing)
   - [Workload Node Sizing](#workload-node-sizing)
   - [CPU-based Workloads (Intel Xeon)](#cpu-based-workloads-intel-xeon)
   - [HPU-based Workloads (Intel Gaudi)](#hpu-based-workloads-intel-gaudi)
   - [Infrastructure Node Sizing](#infrastructure-node-sizing)
   - [Setting Dedicated Infra Nodes](#setting-dedicated-inference-infra-nodes)
   - [Setting Dedicated Intel Xeon Nodes](#setting-dedicated-inference-xeon-nodes)
   - [Setting Dedicated Intel Gaudi Nodes](#setting-dedicated-gaudi-nodes)
   - [Setting Dedicated Intel CPU Nodes](#setting-dedicated-cpu-nodes)
   - [Node Sizing Guide](#node-sizing-guide)
   - [Single Node Deployment](#single-node-deployment)
   - [Single Master Multiple Workload Node Deployment](#single-master-multiple-workload-node-deployment)
   - [Multi Master Multi Workload Node Deployment](#multi-master-multi-workload-node-deployment)
   - [Multi Master Node with Dedicated Intel Xeon, Gaudi and CPU nodes Deployment](#multi-master-multi-workload-node-with-dedicated-intel-xeon-gaudi-and-cpu-nodes-deployment)

- [Running the AI Inference Deployment Suite](#usage)
   - [Component Based Deployment](#component-based-deployment)   
   - [Using the inference-config.cfg global configuration file](#running-the-ai-inference-deployment-suite-with-inference-configcfg)
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
- [Inferencing with Deployed Models](#accessing-deployed-ai-models-from-inference-cluster)
   - [Model Access Clients](#access-clients)
      - [Accessing Models from Postman Client](#accessing-models-from-postman-client)
      - [Accessing Models from OpenAI based Client](#accessing-models-from-curl-client)
      - [Accessing Models from curl Client](#accessing-models-from-curl-client)
   - [Accessing Models Deployed with Keycloak and APISIX](#accessing-models-deployed-with-keycloak-and-apisix)
   - [Accessing Models Deployed without Keycloak and APISIX](#accessing-the-model-from-inference-cluster-deployed-without-apisix-and-keycloak)

## Models for Inference Cluster
The following table lists the pre-validated models for the Intel AI for Enterprise Inference.      
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
| 11. [**llama3-405b**](https://huggingface.co/meta-llama/Llama-3.1-405B-Instruct) | Large Language Model (LLM) with 405 billion parameters, suitable for a wide range of natural language processing tasks.. |
| 21. [**cpu-llama-8b**](https://github.com/huggingface/text-generation-inference/pkgs/container/text-generation-inference) | CPU-optimized version of the LLama-8B model for efficient inference on CPUs. |
| 22. [**cpu-deepseek-r1-distill-qwen-32b**](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Qwen-32B) | CPU-optimized version of the Distilled Qwen-32B model for efficient inference on CPUs. |
| 23. [**cpu-deepseek-r1-distill-llama8b**](https://huggingface.co/deepseek-ai/DeepSeek-R1-Distill-Llama-8B) | CPU-optimized version of the Distilled LLama-8B model for efficient inference on CPUs. |

##### Notice:
   > Please note that this list is subject to change, and additional models may be added or removed based on business requirements and model performance evaluations.

For deploying models that are not part of the prevalidated models list from Hugging Face [please refer to the this steps](deploy-llm-model-from-hugging-face)
##### Notice:
   > Deploying models that is not part of above prevalidated models list by our team. Additional validation and optimization may be required to ensure seamless deployment in an Enterprise environment.


Both Prevalidated and Non-validated Models can be deployed, enabling a range of Inference capabilities to support diverse Enterprise needs and applications.


## Prerequisites for Setting Up Intel AI for Enterprise Inference Cluster


#### System Requirement:

| Category            | Details                                                                                                           |
|---------------------|-------------------------------------------------------------------------------------------------------------------|
| Operating System    | 22.04                                                                                                |
| Hardware Platforms  | 4th Gen Intel® Xeon® Scalable processors<br>5th Gen Intel® Xeon® Scalable processors<br>6th Gen Intel® Xeon® Scalable processors<br>3rd Gen Intel® Xeon® Scalable processors and Intel® Gaudi® 2 AI Accelerator<br>4th Gen Intel® Xeon® Scalable processors and Intel® Gaudi® 2 AI Accelerator <br>6th Gen Intel® Xeon® Scalable processors and Intel® Gaudi® 3 AI Accelerator|
| Gaudi Firmware Version | 1.20.0



#### Gaudi Node Requirements and Setup Guide:
This guide helps you verify and install the required firmware and driver version **1.20.0** for **Habana Gaudi** nodes in your Kubernetes or Standalone Environment.
   
#### Step 1: Verify Current Firmware Version
Use the following commands to check the firmware version installed on your Gaudi nodes:

```bash
hl-smi -L | grep SPI
```
Look for output similar to:
```
Firmware [SPI] Version : Preboot version hl-gaudi2-1.20.0-fw-58.0.0-sec-9 (Jan 16 2025 - 17:51:04)
```
###### For visual assistance, refer to the following snapshot for Firmware version:

<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/docs/pictures/AI-Inference-as-Service-Gaudi-Firmware-version.png" alt="AI Inference Firmware Snapshot" width="800" height="120"/>   
   

#### Step 2: Verify Current Driver Version
Use the following commands to check the required driver version installed on your Gaudi nodes:

```bash
hl-smi 
```
Look for output similar to:
```
+-----------------------------------------------------------------------------+
| HL-SMI Version:                              hl-1.20.0-fw-58.1.1.1          |
| Driver Version:                                     1.20.0-bd87f71          |
| Nic Driver Version:                                 1.20.0-e4fe12d          |
|-------------------------------+----------------------+----------------------+
```
###### For visual assistance, refer to the following snapshot for Driver version:

<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/docs/pictures/AI-Inference-as-Service-Gaudi-Driver-version.png" alt="AI Inference Driver Snapshot" width="800" height="120"/>    
   
#### Step 3: Verify Current Habana Runtime Version
Use the following commands to check the required Habana runtime version installed on your Gaudi nodes:

```bash
dpkg -l | grep habanalabs-container-runtime
```
Look for output similar to:
```
ii  habanalabs-container-runtime  1.20.0-543  HABANA container runtime
```

>  **If the Firmware, Driver, and Habana Runtime are all at version 1.20.0**, no further installation steps are required. You may proceed to the next section of your setup.  

>  **If any of the components are at a different version**, follow the steps below to uninstall and reinstall the correct version.

#### Installing Intel Gaudi Firmware Driver Runtime Software

#### Step 1: Unload Existing Drivers
```
echo "Unloading Habana drivers..."
sudo modprobe -r habanalabs && sudo modprobe -r habanalabs_cn
sudo modprobe -r habanalabs_ib && sudo modprobe -r habanalabs_en
```

#### Step 2: Clean Previous Installations (Optional)
```
echo "Removing old Habana runtime packages..."
sudo apt remove --purge -y habanalabs-container-runtime
sudo apt clean
```

#### Step 3: Install Required Packages
```
sudo apt update
echo "Installing Habana firmware and container runtime..."
sudo apt install -y habanalabs-firmware-odm
sudo apt install -y habanalabs-container-runtime
```

#### Step 4: Install or Upgrade Habana Base Installer
```
echo "Downloading Habana installer..."
wget -nv https://vault.habana.ai/artifactory/gaudi-installer/1.20.0/habanalabs-installer.sh
chmod +x habanalabs-installer.sh

# For Fresh Installation
./habanalabs-installer.sh install --type base

# For Upgrade Installation
./habanalabs-installer.sh upgrade --type base
```

#### Step 5: Update Firmware
```
echo "Updating firmware..."
sudo hl-fw-loader
```

#### Step 6: Load Habana Drivers
```
echo "loading habana drivers..."
sudo modprobe  habanalabs && sudo modprobe  habanalabs_cn
sudo modprobe  habanalabs_ib && sudo modprobe  habanalabs_en
```

Please follow above steps for verifying the installed firmware, driver and runtime versions.

> **For detailed documentation, refer to the official guide:** [Intel Gaudi Software Installation Documentation](https://docs.habana.ai/en/v1.20.1/Installation_Guide/Driver_Installation.html)

   
---   
   ##### SSH Key Setup
   - Generate an SSH key pair (if you don't have one already) using the `ssh-keygen` command.
   - Copy the public key (`id_rsa.pub`) to all the control plane and workload nodes that will be part of the cluster.
   - On each node, add the public key to the `authorized_keys` file in the `.ssh` directory of the user account you'll be using to connect to the nodes.
      ```
           echo "<YOUR_PUBLIC_KEY_CONTENTS>" >> ~/.ssh/authorized_keys
      ```
   - Ensure that the SSH service is running and enabled on all the nodes.
   - Verify that you can connect to all the nodes using the SSH key or password-based authentication from the Ansible control machine.
   - If you are using a bastion host for secure access to the cluster nodes, configure the bastion host with the necessary SSH keys or authentication methods, and ensure that the Ansible control machine can connect to the cluster nodes through the bastion host.

   #### Network and Storage Requirement
   ##### Network Requirement
   - Configure a network topology that allows communication between the control plane nodes and workload nodes.
   - Ensure that the nodes have internet access to pull the required Docker images and other dependencies during the deployment process.
   - Ensure that the necessary ports are open for communication (e.g., ports for Kubernetes API server, etcd, etc.).
   ##### Storage Requirement
   When planning for storage, it is important to consider both the needs of your cluster and the applications you intend to deploy:
   - Attach sufficient storage to your nodes based on the specific requirements and design of your cluster:
  - For model deployment, allocate storage based on the size of the models you plan to deploy. Larger models may require more storage space.
  - If deploying observability tools, it is recommended to allocate at least 30GB of storage for optimal performance.   

   #### DNS and SSL/TLS Setup
   
   #### Production Environment
   ###### DNS Setup
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
   ###### DNS Setup
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

   
   #### Hugging Face Token Generation
   1. Go to the [Hugging Face website](https://huggingface.co/) and sign in to your account (or create a new account if you don't have one).
   2. Once signed in, click on your profile picture in the top-right corner, and select "Settings" from the dropdown menu.
   3. In the "Settings" page, navigate to the "Access Tokens" section.
   4. Click on the "New Token" button to generate a new access token.
   5. In the "New Token" modal, you can optionally provide a description for the token (e.g., "My Development Token").
   6. Click on the "Generate" button to create the new token.
   7. Configure the token in the inference-config.cfg file under core/ directory 



## Designing Inventory for Inference Cluster Deployment
   
   Design your inventory file located at `core/inventory/hosts.yaml` according to your enterprise deployment requirements for the inference cluster.    


   ##### Control Plane Node Sizing
   For an inference model deployment cluster in Kubernetes (K8s), the control plane nodes should have sufficient resources to handle the management and orchestration of the cluster. It's recommended to have at least 8 vCPUs and 32 GB of RAM per control plane node.    
   For larger clusters or clusters with high workloads, you may need to increase the resources further.
   
   ##### Workload Node Sizing
   The workload node sizing will depend on the specific requirements of the inference models and the workloads they need to handle. Here are some recommendations:
      
   ##### CPU-based Workloads (Intel Xeon)
   For CPU-based inference workloads, the workload nodes should have a sufficient number of vCPUs based on the number of models and the expected concurrency. A general guideline is to allocate 32 vCPUs per model instance, depending on the model complexity and resource requirements.

   ##### HPU-based Workloads (Intel Gaudi)
   For HPU-based inference workloads using Intel Gaudi HPUs, the workload nodes should be equipped with the appropriate number of Gaudi HPUs based on the number of models and the expected concurrency.
   Each Gaudi HPU can handle multiple model instances, depending on the model size and resource requirements.
   
   Additionally, the workload nodes should have sufficient RAM and storage capacity to accommodate the inference models and any associated data.


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
   > It is recommended to keep the host names in the `inventory/hosts.yml` file similar to the actual machine hostnames. This ensures compatibility and maintain consistency across different systems and processes. Additionally, this AI Inference Deployment Suite will update the hostnames of the machines to match the ones specified in the `inventory/hosts.yml` file.
   
   ### Setting Dedicated Inference Infra Nodes:   
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

   ### Setting Dedicated Inference Xeon Nodes:   
   To configure a dedicated Xeon nodes for deploying models, edit the file `inventory/hosts.yml` and add the label `inference-xeon` to the nodes.
   This group will be used to schedule the workloads dedicated to run on Xeon nodes.
   
   follow these steps:
   1. Open the `inventory/hosts.yml` file in a text editor.
   2. Locate the section where you define your nodes. This is typically under the `all` group or any other group you've defined for your nodes.
   3. For each node that you want to label as an `inference-xeon`, add the following line under the node's IP or hostname:
   ```yaml
   node_labels:
     node-role.kubernetes.io/inference-xeon: "true"
   ```
   4.After labeling the desired nodes, list the nodes under the group kube_inference_xeon to include in this group. 

   Please find the template for the inventory configuration with 2 dedicated xeon nodes for inference cluster
   ```yaml
      all:
        hosts:
          inference-control-plane-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-xeon-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-xeon: "true"         
          inference-xeon-node-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-xeon: "true"
          inference-infra-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key          
        children:
          kube_control_plane:
            hosts:
              inference-control-plane-01:       
          kube_node:
            hosts:
              inference-xeon-node-01:
              inference-xeon-node-02:
              inference-infra-node-01:
          kube_inference_xeon:
              inference-xeon-node-01:
              inference-xeon-node-02:
        etcd:
          hosts:
            inference-control-plane-01:       
        k8s_cluster:
          children:
            kube_control_plane:
            kube_node:
            kube_inference_xeon: 
   ```


   ### Setting Dedicated Gaudi Nodes:   
   To configure a dedicated Gaudi nodes for deploying models, edit the file `inventory/hosts.yml` and add the label `inference-gaudi` to the nodes.
   This group will be used to schedule the workloads dedicated to run on nodes with Intel Gaudi attached.
   
   follow these steps:
   1. Open the `inventory/hosts.yml` file in a text editor.
   2. Locate the section where you define your nodes. This is typically under the `all` group or any other group you've defined for your nodes.
   3. For each node that you want to label as an `inference-gaudi`, add the following line under the node's IP or hostname:
   ```yaml
   node_labels:
     node-role.kubernetes.io/inference-gaudi: "true"
   ```
   4.After labeling the desired nodes, list the nodes under the group kube_inference_gaudi to include in this group. 

   Please find the template for the inventory configuration with 2 dedicated Gaudi nodes for inference cluster
   ```yaml
      all:
        hosts:
          inference-control-plane-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-gaudi-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-gaudi: "true"         
          inference-gaudi-node-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-xeon: "true"
          inference-infra-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key          
        children:
          kube_control_plane:
            hosts:
              inference-control-plane-01:       
          kube_node:
            hosts:
              inference-gaudi-node-01:
              inference-gaudi-node-02:
              inference-infra-node-01:
          kube_inference_gaudi:
              inference-gaudi-node-01:
              inference-gaudi-node-02:
        etcd:
          hosts:
            inference-control-plane-01:       
        k8s_cluster:
          children:
            kube_control_plane:
            kube_node:
            kube_inference_gaudi: 
   ```

   ### Setting Dedicated CPU Nodes:   
   To configure a dedicated CPU nodes for deploying models, edit the file `inventory/hosts.yml` and add the label `inference-cpu` to the nodes.
   This group will be used to schedule the workloads dedicated to run on nodes with Intel CPUs.
   
   follow these steps:
   1. Open the `inventory/hosts.yml` file in a text editor.
   2. Locate the section where you define your nodes. This is typically under the `all` group or any other group you've defined for your nodes.
   3. For each node that you want to label as an `inference-cpu`, add the following line under the node's IP or hostname:
   ```yaml
   node_labels:
     node-role.kubernetes.io/inference-cpu: "true"
   ```
   4.After labeling the desired nodes, list the nodes under the group kube_inference_cpu to include in this group. 

   Please find the template for the inventory configuration with 2 dedicated CPU nodes for inference cluster
   ```yaml
      all:
        hosts:
          inference-control-plane-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-cpu-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-cpu: "true"         
          inference-cpu-node-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-cpu: "true"
          inference-infra-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key          
        children:
          kube_control_plane:
            hosts:
              inference-control-plane-01:       
          kube_node:
            hosts:
              inference-cpu-node-01:
              inference-cpu-node-02:
              inference-infra-node-01:
          kube_inference_cpu:
              inference-cpu-node-01:
              inference-cpu-node-02:
        etcd:
          hosts:
            inference-control-plane-01:       
        k8s_cluster:
          children:
            kube_control_plane:
            kube_node:
            kube_inference_cpu: 
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

 ### Single Master Multiple Workload Node Deployment:   
   
   For deployment with a single control plane node and multiple workload nodes.   
   Replace the placeholders in the following code with the appropriate values:
   
   ```yaml
      all:
        hosts:
          inference-control-plane-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-workload-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-workload-node-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
        children:
          kube_control_plane:
            hosts:
              inference-control-plane-01:
          kube_node:
            hosts:
              inference-workload-node-01:
              inference-workload-node-02:
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

 ### Multi Master Multi Workload Node Deployment:   
   For an enterprise-grade deployment with multiple control plane nodes and multiple workload nodes, it is recommended to follow these guidelines:
   
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
          inference-workload-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-workload-node-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-workload-node-03:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
          inference-workload-node-04:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key         
          inference-workload-node-05:
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
              inference-workload-node-01:
              inference-workload-node-02:
              inference-workload-node-03:
              inference-workload-node-04:
              inference-workload-node-05:
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

   ### Multi Master Multi Workload Node with Dedicated Intel Xeon, Gaudi and CPU nodes Deployment:   
   For an enterprise-grade deployment with multiple control plane nodes and multiple workload nodes,
   This setup uses workload nodes to be mix of Intel Xeon, Intel Gaudi and Intel CPU nodes for deploying models.
   
   it is recommended to follow these guidelines:
   
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
         inference-infra-node-03:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-infra: "true"
         inference-workload-xeon-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-xeon: "true"
         inference-workload-xeon-node-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-xeon: "true"         
         inference-workload-gaudi-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-gaudi: "true"
         inference-workload-gaudi-node-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-gaudi: "true"
         inference-workload-cpu-node-01:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-cpu: "true"
         inference-workload-cpu-node-02:
            ansible_host: "{{ private_ip }}"
            ansible_user: "{{ ansible_user }}"
            ansible_ssh_private_key_file: /path/to/your/ssh/key
            node_labels:
              node-role.kubernetes.io/inference-cpu: "true"          
        children:
          kube_control_plane:
            hosts:
              inference-control-plane-01:
              inference-control-plane-02:
              inference-control-plane-03:
          kube_node:
            hosts:
              inference-infra-node-01:
              inference-infra-node-02:
              inference-infra-node-03:
              inference-workload-xeon-node-01:
              inference-workload-xeon-node-02:
              inference-workload-gaudi-node-01:
              inference-workload-gaudi-node-02:
              inference-workload-cpu-node-01:
              inference-workload-cpu-node-02:
          etcd:
            hosts:              
              inference-control-plane-01:
              inference-control-plane-02:
              inference-control-plane-03:
         kube_inference_infra:
              inference-infra-node-01:
              inference-infra-node-02:
              inference-infra-node-03:
         kube_inference_xeon:
              inference-workload-xeon-node-01:
		        inference-workload-xeon-node-02:
         kube_inference_gaudi:
              inference-workload-gaudi-node-01:
		        inference-workload-gaudi-node-02:
         kube_inference_cpu:
              inference-workload-cpu-node-01:
		        inference-workload-cpu-node-02:
          k8s_cluster:
            children:
              kube_control_plane:
              kube_node:
              kube_inference_infra:
              kube_inference_xeon:
              kube_inference_gaudi:
              kube_inference_cpu:
          calico_rr:
            hosts: {}

   ```

##### Authentication Formats for Deployed AI Models:   
   - **With Keycloak and APISIX**:      
      -  In this flow, Keycloak and APISIX are deployed to provide authentication, authorization, and API gateway functionality, ensuring secure and controlled access to the deployed AI models.
   - **Without Keycloak and APISIX**:
      - In this flow, the AI models are deployed directly within the Kubernetes cluster, without the additional security and API gateway layers provided by Keycloak and APISIX. This deployment option is suitable for scenarios where these components are not required or are handled separately.

--- 

## Component Based Deployment

### Usage
#### Running the AI Inference Deployment Suite with inference-config.cfg

If you don't want to be prompted for the required parameters, you can use the `ida\inference-config.cfg` file to provide the necessary values. The AI Inference Deployment Suite will read the values from this file.
Here's an example of the `inference-config.cfg` file:
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
Make sure to update the values in the inference-config.cfg file according to your requirements before running the AI Inference Deployment Suite.

##### Notice:
   This AI Inference Deployment Suite is designed for deployments which allows you to selectively deploy or skip various components based on your requirements.

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
updated the `core/inventory/hosts.yml` file with your desired requirement as documented, you are ready to proceed with the deployment. 

#### Alternative Deployment Method

bash inference-as-auto-deploy.sh [OPTIONS]
##### Options
`````
The AI Inference Deployment Suite accepts the following command-line options:
--cluster-url <URL>: The cluster URL (FQDN).
--cert-file <path>: The full path to the certificate file.
--key-file <path>: The full path to the key file.
--keycloak-client-id <id>: The Keycloak client ID.
--keycloak-admin-user <username>: The Keycloak admin username.
--keycloak-admin-password <password>: The Keycloak admin password.
--hugging-face-token <token>: The token for Huggingface.
--models <models>: The models to deploy (comma-separated list of model numbers or names).
--cpu-or-gpu <c/g>: Specify whether to run on CPU or HPU.
`````

Execute the following command to initiate the AI Inference Deployment Suite:
```
   bash inference-as-auto-deploy.sh
```
## Main Menu
When you run the AI Inference Deployment Suite  you will be presented with a main menu with the following options:
```
----------------------------------------------------------
|  Intel AI for Enterprise Inference                      |
|---------------------------------------------------------|
| 1) Provision AI for Inference Cluster                   |
| 2) Decommission Existing Cluster                        |
| 3) Update Deployed Inference Cluster                    |
|---------------------------------------------------------|
Please choose an option (1, 2, or 3):
```

### Fresh Installation:

##### Installation Precautions:
Ensure that the nodes do not contain existing workloads. If necessary, please purge any previous cluster configurations before initiating a fresh installation to avoid an inappropriate cluster state. Proceeding without this precaution could lead to service disruptions or data loss.

If you choose to perform a fresh installation, the AI Inference Deployment Suite will prompt you for the necessary inputs and proceed with the following steps:
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

If you choose to reset the cluster, the AI Inference Deployment Suite will:
1. Prompt for Confirmation: Asks for confirmation before proceeding with the reset.
2. Setup Initial Environment: Sets up the virtual environment and installs necessary dependencies.
3. Run Reset Playbook: Executes the Ansible playbook to reset the cluster.

##### Example Reset Cluster Screen
`````
Run:
----------------------------------------------------------
|  Intel AI for Enterprise Inference                      |
|---------------------------------------------------------|
| 1) Provision AI for Inference Cluster                   |
| 2) Decommission Existing Cluster                        |
| 3) Update Deployed Inference Cluster                    |
|---------------------------------------------------------|
Please choose an option (1, 2, or 3):
> 2
You are about to reset the existing AI Inference cluster.
This will remove all the current configurations and data.
Are you sure you want to proceed? (yes/no): 
Acknowledge it with "yes".
`````

### Update Existing Cluster:
If you choose to update the existing cluster, the AI Inference Deployment Suite will present you with the following options:
1. Manage Worker Nodes: Add or remove worker nodes.
2. Manage Models: Add or remove models.

##### Example Update Existing Cluster Screen
`````
Run:
bash inference-as-auto-deploy.sh

----------------------------------------------------------
|  Intel AI for Enterprise Inference                      |
|---------------------------------------------------------|
| 1) Provision AI for Inference Cluster                   |
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
|  Intel AI for Enterprise Inference                      |
|---------------------------------------------------------|
| 1) Provision AI for Inference Cluster                   |
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
If model is set in inference-config.cfg AI Inference Deployment Suite will proceed to deploy the model.
`````

### Deploy LLM Model from Hugging Face
This option allows you to deploy a new LLM model using model id from Hugging Face on the Inference Cluster.

##### Example Deploy Model from Hugging Face Screen:
`````
Run:
bash inference-as-auto-deploy.sh 
----------------------------------------------------------
|  Intel AI for Enterprise Inference                      |
|---------------------------------------------------------|
| 1) Provision AI for Inference Cluster                   |
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
|  Intel AI for Enterprise Inference                      |
|---------------------------------------------------------|
| 1) Provision AI for Inference Cluster                   |
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
If model is set in inference-config.cfg AI Inference Deployment Suite will proceed to remove the model.
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

###### For visual assistance, refer to the following Cluster observability dashboard 

<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/docs/pictures/AI-Inference-as-Service-Observability-dashboard.png" alt="AI Inference Model Observability dashboard" width="800" height="220"/>

<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/docs/pictures/AI-Inference-as-Service-Observability-dashboard-two.png" alt="AI Inference Model Observability dashboard" width="800" height="220"/>

###### For visual assistance, refer to the following for Habana observability dashboard 

<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/docs/pictures/AI-Inference-as-Service-Gaudi-Observability.png" alt="AI Inference Model Observability dashboard" width="800" height="220"/>

###### For visual assistance, refer to the following for Models observability dashboard 

<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/docs/pictures/AI-Inference-as-Service-Model-Observability.png" alt="AI Inference Model Observability dashboard" width="800" height="220"/>

###### For visual assistance, refer to the following for Cluster wide observability dashboard 

<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/docs/pictures/AI-Inference-as-Service-Gaudi-Utilization-Cluster-Observability.png" alt="AI Inference Model Observability dashboard" width="800" height="220"/>

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




## Accessing Deployed AI Models from Inference Cluster

This documentation outlines various methods through which deployed Inference Models APIs can be accessed.   
While `curl` is the standard access method, you have the flexibility to utilize Postman with its collections and environment configurations. Additionally, the APIs are compatible with OpenAPI-style clients, such as Swagger UI, Open WebUI or any client that supports OpenAPI specifications, allowing you to choose the platform that best fits your preferences.

#### Access Clients
- **cURL**: A command-line tool that uses URL syntax to transfer data to and from servers. It is widely supported and considered a go-to method for quick API interactions.
- **Postman**: An API platform for building and using APIs. Postman simplifies each step of the API lifecycle and streamlines collaboration so you can create better APIs faster. It offers a graphical interface and allows for easy management of API requests and responses.
- **OpenAPI based Clients**: These clients, such as Swagger UI or Open WebUI, are designed to work with APIs that adhere to the OpenAPI Specification (OAS). They provide interactive documentation, automatic code generation, and more, which can be particularly useful.
Choose the client or platform that aligns with your preferences and requirements.

### Accessing Models from Postman Client
#### Prerequisites
- Ensure that you have installed Postman on your workstation.
- Obtain the Postman collection and environment files associated with your deployment.
#### Setting Up Postman Environment
To interact with the inference model APIs through Postman, perform the following steps to configure your environment:
1. Launch Postman on your system.
2. Navigate to the 'Environment' tab located at the top right corner of the Postman interface.
3. Locate the Environment file located at `core/catalog/AI-Inference-as-Service-Environment.postman-environment.json`
4. Click on the 'import' button to import environment.
5. Populate the values for each variable according to the details provided in your `inference-config.cfg` file.
#### Importing Postman Collection
Follow these instructions to import the Postman collection for your deployed models:
1. Select the 'Import' button within Postman.
2. Locate the collection file located at `core/catalog/AI-Inference-as-Service-postman-collection.json`.
3. Confirm the import to add the collection to your Postman workspace.

For visual assistance, refer to the following example image of a Postman request setup:
###### Imported Intel AI for Enterprise Inference Collection Request and Response
<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/docs/pictures/AI-Inference-as-Service-Postman-Collection.png" alt="AI Inference Model API Example" width="800" height="200"/>

###### Imported Intel AI for Enterprise Inference Service Environment
<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/docs/pictures/AI-Inference-as-Service-Postman-Environment.png" alt="AI Inference Model Environment Example" width="800" height="200"/>

### Accessing Models from OpenAI based Client
For interacting with deployed models you can utilize any client that supports OpenAPI specification, such as Swagger UI or Open WebUI. 
These tools facilitate seamless integration by offering interactive documentation and many other features.  
As an example, we will demonstrate how to use Open WebUI to connect with these models, allowing you to execute API calls and effectively manage your interactions with the models.

###### For visual assistance, refer to the following example image of a OpenAPI based client request and response:
<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/docs/pictures/AI-Inference-as-Service-openapi-based-client.png" alt="AI Inference Model API openAPI request" width="800" height="220"/>


Please reference to this instruction to deploy the OpenAPI based client   
[openapi-client-deployment](https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/openapi-client-deployment.md)



### Accessing Models from curl Client
To configure your environment with the necessary variables for connecting to Keycloak, you will need to set the following environment variables.  
Please replace the placeholder values with your actual configuration details, which has been configured in `inference-config.cfg` file under the `core/` directory during deployment.


#### Accessing Models Deployed with Keycloak and APISIX
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

###### For visual assistance, refer to the following example image of a curl request and response:

<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/main/core/catalog/docs/pictures/AI-Inference-as-Service-curl-request.png" alt="AI Inference Model API curl request" width="900" height="100"/>


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
