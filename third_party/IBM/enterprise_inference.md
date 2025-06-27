# Intel AI for Enterprise Inference as a Deployable Architecture on IBM Cloud

The enterprise AI landscape demands solutions that can scale efficiently while maintaining operational simplicity and cost-effectiveness. Intel AI for Enterprise Inference, powered by the Open Platform for Enterprise AI (OPEA), addresses these challenges by providing a comprehensive platform that automates the deployment of OpenAI-compatible LLM inference endpoints. With IBM Cloud now offering Gaudi 3 accelerators, the result is scalable, high-performance inference servers that integrate seamlessly with existing applications while leveraging Intel's optimized hardware for superior economics and performance. When combined with IBM Cloud's deployable architecture approach, organizations gain access to a powerful, streamlined pathway for implementing production-ready AI inference capabilities.

## Understanding Enterprise Inference in the Modern Cloud Context

Enterprise Inference addresses a fundamental challenge facing organizations today: deploying AI inference services at scale while maintaining operational efficiency and cost control. Built on Intel's Open Platform for Enterprise AI (OPEA), Enterprise Inference automates the deployment of OpenAI-compatible LLM inference endpoints, eliminating the manual configuration work that typically slows enterprise AI adoption.

The platform's architecture centers on Kubernetes orchestration with specialized operators for Intel hardware detection and management. This approach streamlines complex tasks including model deployment, compute resource provisioning, and optimal configuration settings, reducing what traditionally requires weeks of manual setup to automated, repeatable deployments.

### Multi-Hardware Optimization Strategy

Different AI workloads require different hardware strategies for optimal performance and economics. The platform supports both Intel Gaudi accelerators and Xeon processors to match workload requirements with the most efficient hardware:

**Gaudi 3 for Large Model Performance**: For demanding inference workloads, Gaudi 3 accelerators deliver measurable advantages. [Independent benchmarking](https://signal65.com/research/ai/signal65-lab-insight-intel-gaudi-3-accelerates-ai-at-scale-on-ibm-cloud/) shows up to 43% more tokens per second than comparable GPU solutions for small AI workloads, with up to 335% better price-performance ratios for large models like Llama-3.1-405B. These improvements translate directly to operational benefits—processing more requests with lower infrastructure costs.

**Xeon for Small Model Efficiency**: For applications using smaller, specialized models, Xeon processors provide compelling advantages. As HuggingFace CEO Clement Delangue notes, "More companies would be better served focusing on smaller, specific models that are cheaper to train and run." Xeon-based deployments offer cost efficiency, deployment simplicity, and energy sustainability while delivering throughput well beyond typical human reading speeds for chat applications and productivity tools.

### OpenAI-Compatible API: Zero-Friction Integration

Enterprise Inference's complete OpenAI API compatibility eliminates integration friction, enabling organizations to leverage dedicated inference infrastructure without application rewrites. Existing applications using OpenAI's cloud services can migrate by simply changing the base URL and authentication token—the identical API surface means existing code, SDKs, and integration patterns continue to work without modification. This plug-and-play approach allows organizations to deploy Enterprise Inference as a strategic infrastructure upgrade rather than a disruptive technology change, preserving existing investments while gaining the performance and cost advantages of optimized Intel infrastructure.

## Core Components and Architecture

![Architecture](https://raw.githubusercontent.com/opea-project/Enterprise-Inference/d9a309e5763a35889761bddcaf11c38aa807a8f1/docs/pictures/Enterprise-Inference-Architecture.png)

The Enterprise Inference platform consists of several integrated components that work together to provide a complete AI inference solution. Kubernetes serves as the foundational orchestration layer, managing container lifecycles and resource allocation across the infrastructure. The Intel Gaudi Base Operator extends Kubernetes with AI-specific capabilities, handling the complexities of Gaudi resource management and optimizing workload placement for inference performance.

At the core of the inference capabilities, vLLM serves as the high-performance inference server, optimized for Intel hardware and designed to deliver efficient LLM serving with OpenAI-compatible APIs. Identity management through Keycloak ensures that AI services integrate seamlessly with existing enterprise authentication systems. This component becomes particularly important in regulated industries where access control and audit trails are mandatory requirements. The APISIX cloud-native API gateway provides the external interface for AI services, handling request routing, rate limiting, and protocol translation between client applications and inference endpoints.

Observability components provide the monitoring and metrics collection necessary for production AI workloads. Unlike traditional application monitoring, AI inference monitoring must account for model-specific metrics such as token throughput, latency distributions, and resource utilization patterns that are unique to language model workloads.

The platform's modular design allows organizations to customize deployments based on their specific requirements. Some enterprises may require additional security components, while others might need integration with existing monitoring systems. The deployable architecture approach accommodates these variations through parameterized configurations that maintain consistency while allowing necessary customization.


## Simplifying Enterprise AI with Deployable Architectures

Enterprise AI deployments traditionally involve complex coordination between multiple teams, extensive manual configuration, and weeks of integration work to assemble components like Kubernetes clusters, identity management, API gateways, and monitoring systems. Each deployment becomes a custom project requiring specialized expertise and careful orchestration.

IBM Cloud's deployable architecture approach transforms this complexity into automated, repeatable patterns. Instead of assembling infrastructure components from scratch, deployable architectures provide pre-validated templates that combine multiple cloud resources into cohesive, ready-to-deploy solutions. Think of it as moving from building enterprise infrastructure piece by piece to deploying proven architectural blueprints.

For Enterprise Inference, this means the entire AI infrastructure stack—Kubernetes orchestration, Intel Gaudi Base Operator, vLLM inference servers, ingress controllers, Keycloak identity management, APISIX API gateway, and observability tools—comes packaged as a single, automated deployment. Teams can provision production-ready AI inference capabilities in hours rather than weeks, with confidence that security configurations, networking policies, and resource allocations follow established enterprise best practices.

This approach shifts the complexity from deployment time to design time. Rather than coordinating between platform teams, data science teams, and operations teams during each deployment, that coordination happens once during the architectural design phase. The result is consistent, governance-compliant deployments that maintain enterprise control while dramatically reducing operational overhead.

## Seeing It in Action

Enterprise Inference deployments follow IBM Cloud's deployable architecture pattern, offering two primary consumption methods that suit different team preferences and operational requirements.
Teams can deploy through the IBM Cloud catalog's visual interface or directly via Terraform CLI, both approaches leveraging the same flexible configuration system.

### Deployment Configuration Options
The deployable architecture for Enterprise Inference provides two configuration approaches to accommodate different infrastructure readiness levels and deployment timelines.

**Before you begin**
Before proceeding, make sure you have the following details ready:
```
1)SSH Key Name and Private Key File
The name of your SSH key and its corresponding private key file created in IBM Cloud. These will be required as inputs during the setup.

2)IBM Cloud API Key
Ensure you have your IBM Cloud API Key available for authentication and provisioning of resources.

3)DNS Configuration
A valid and externally accessible domain name that will serve as the cluster URL/ API endpoint.

4)TLS Certificate Files
Provide the TLS certificate files for the specified DNS:
fullchain.pem: The full certificate chain.
key.pem: The private key corresponding to the certificate.
```

**Quickstart Configuration** assumes existing IBM Cloud infrastructure components are already in place. This approach significantly reduces deployment time by leveraging pre-configured VPCs, subnets, security groups, and resource groups. The quickstart requires only these essential variables:

```hcl
# Authentication and region
ibmcloud_api_key = "<your-api-key>"
ibmcloud_region = "<region-name>"

# Instance configuration
instance_name = "<instance-name>"
instance_zone = "<availability-zone>"
instance_profile = "<instance-profile>"

# Existing infrastructure references
vpc = "<vpc-name-or-id>"
subnet = "<subnet-name-or-id>"
security_group = "<security-group-name-or-id>"
public_gateway = "<public-gateway-id>"
resource_group = "<resource-group-name>"

# SSH access
ssh_key = "<ssh-key-name>"
ssh_private_key = "<path-to-private-key>"

#TLS Certificate details 
user_cert = "<TLS-certificate-fullchain>"
user_key ="<TLS-certificate-key>"

# Processing and model configuration
cpu_or_gpu = "gpu"
image = "<image-name>"
models = 1
```
**Standard Configuration** provisions all infrastructure components from scratch, including VPC creation, subnet configuration, security group setup, and resource group management. While this approach requires additional deployment time, it provides complete infrastructure automation and is ideal for new environments or teams that prefer full infrastructure-as-code control.

### Deployment via IBM Cloud Catalog UI

<img width="397" alt="image" src="https://gist.github.com/user-attachments/assets/807379b8-c327-4bf7-aa3f-154f8f3024c7" />

The IBM Cloud catalog provides a guided deployment experience that simplifies the configuration process while maintaining full control over deployment parameters. Teams access the Enterprise Inference deployable architecture through the IBM Cloud console, where they configure deployment settings through a structured form interface.

The catalog presents configuration options organized into logical groups, making it straightforward to specify essential parameters like instance profiles, networking settings, and component selections. Key configuration choices include selecting between CPU and Gaudi processing modes, enabling or disabling specific components like Keycloak authentication or observability tools, and setting up model deployment preferences.

Users specify infrastructure details such as VPC configuration, subnet assignments, and security group settings through dropdown menus and input fields. The interface validates configurations in real-time, preventing common deployment errors before they reach the infrastructure provisioning phase. Once configured, the deployment proceeds automatically, with progress tracking and status updates available through the IBM Cloud console.

The catalog approach particularly benefits teams who prefer visual interfaces or need to coordinate deployments across multiple stakeholders. The guided configuration process ensures that all required parameters are addressed while providing helpful descriptions and validation for each setting.

### Terraform CLI Deployment

For teams that prefer infrastructure-as-code approaches, direct Terraform CLI deployment offers maximum flexibility and automation capabilities. The deployment process centers on configuring the `variables.tf` or `terraform.tfvars` file with appropriate values for your environment and requirements.

Choose `Work with code` as a depoyment option on the Catalog page and then download the code to run locally . Later configuration process involves specifying fundamental deployment parameters in `variables.tf` or `terraform.tfvars`:

```hcl
# QuickStart variant

# Authentication and region
ibmcloud_api_key = "<your-api-key>"
ibmcloud_region = "<region-name>"

# Instance configuration
instance_name = "<instance-name>"
instance_zone = "<availability-zone>"
instance_profile = "<instance-profile>"

# Existing infrastructure references
vpc = "<vpc-name-or-id>"
subnet = "<subnet-name-or-id>"
security_group = "<security-group-name-or-id>"
public_gateway = "<public-gateway-id>"
resource_group = "<resource-group-name>"

# SSH access
ssh_key = "<ssh-key-name>"
ssh_private_key = "<path-to-private-key>"

#TLS Certificate details 
user_cert = "<TLS-certificate-fullchain>"
user_key ="<TLS-certificate-key>"

# Processing and model configuration
cpu_or_gpu = "gpu"
image = "<image-name>"
models = 1
```

Deployment execution follows standard Terraform patterns:

```bash
# Initialize the Terraform environment
terraform init
# Review the planned deployment
terraform plan
# Deploy the infrastructure
terraform apply -auto-approve
```
The Terraform approach provides complete deployment automation, making it ideal for CI/CD pipelines and teams that manage infrastructure through code. The same configuration file can be versioned, tested, and deployed consistently across different environments.

### Configuration Flexibility

Both deployment methods leverage the same underlying configuration system, offering identical customization options. The deployment architecture supports selective component activation, allowing teams to deploy only the components they need. Teams can choose to deploy a minimal AI inference stack with just Kubernetes and model serving capabilities, or a complete enterprise stack including identity management, API gateways, and comprehensive observability.

The CPU versus Gaudi processing choice significantly impacts deployment characteristics. Gaudi deployments automatically configure Intel Habana Gaudi drivers and optimization libraries, while CPU deployments focus on standard inference optimization. This choice affects both performance characteristics and infrastructure requirements, with Gaudi deployments requiring specific instance profiles that support AI accelerator hardware.

Model deployment configuration allows teams to specify which AI models to deploy during initial setup, with options for deploying additional models post-deployment. The platform supports multiple model formats and can accommodate custom model configurations through the deployment parameter system.


## Accessing the Endpoints

Once deployed, Enterprise Inference exposes standard OpenAI-compatible APIs that integrate seamlessly with existing applications and development workflows. This Deployable Architecture is pre-tested for certain models shown below .

meta-llama/Meta-Llama-3.1-8B-Instruct
meta-llama/Meta-Llama-3.1-70B-Instruct
meta-llama/Llama-3.1-405B-Instruct

For complete details on accessing deployed models, authentication workflows, and available model endpoints, refer to the [Enterprise Inference documentation](https://github.com/opea-project/Enterprise-Inference/blob/main/docs/accessing-deployed-models.md). This guide provides comprehensive examples and covers various deployment configurations.

**SSH Access to Your VSI Instance**
After Deployable Architecture execution completed successfully retrieve the public IP address from the outputs. Make sure the private key file (.pem) corresponding to the SSH key used during provisioning is present on your local machine.Set proper permissions on the key file:

```
chmod 600 /path/to/your-private-key.pem
```
Connect the instance via SSH
```
ssh -i /path/to/your-private-key.pem ubuntu@<IP_ADDRESS>
```
On first connection, SSH will prompt you to confirm the server’s authenticity. Type yes to continue
### Authentication and Token Generation

If your deployment includes Keycloak identity management and APISIX API gateway, you'll need to generate an access token before making API calls. The required parameters (BASE_URL, KEYCLOAK_CLIENT_ID, KEYCLOAK_CLIENT_SECRET) are provided as outputs from the deployment process:

##### Fetching the client Secret
For fetching the Keycloak client secret from please run this script  [**keycloak-fetch-client-secret.sh**](https://github.com/opea-project/Enterprise-Inference/blob/main/core/scripts/keycloak-fetch-client-secret.sh)
`````
keycloak-fetch-client-secret.sh <cluster-url> <keycloak-username> <keycloak-password> <keycloak-client-id>
Returns:
Logged in successfully
Client secret: keycloak-client-secret
`````
Once you have the keycloak client secret, please refer below steps

```bash
# Export variables
export BASE_URL=https://your-cluster-url
export KEYCLOAK_CLIENT_ID=ibm-app
export KEYCLOAK_CLIENT_SECRET=
export TOKEN_URL=https://$BASE_URL/token
```

```bash
# Generate access token for authenticated access
export TOKEN=$(curl -k -X POST $BASE_URL/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d "grant_type=client_credentials&client_id=${KEYCLOAK_CLIENT_ID}&client_secret=${KEYCLOAK_CLIENT_SECRET}" \
  | jq -r .access_token)
```

### REST API Integration

Direct API access follows OpenAI conventions, making integration straightforward for applications that already use OpenAI services:

```bash
# Basic chat completion request using Llama-3-70b
curl -k ${BASE_URL}/Meta-Llama-3.1-70B-Instruct/v1/completions \
  -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "meta-llama/Meta-Llama-3.1-70B-Instruct",
    "prompt": "Explain the benefits of edge computing for IoT applications",
    "max_tokens": 500,
    "temperature": 0.7
  }'
```

### Python SDK Integration

Python applications can integrate Enterprise Inference using the standard OpenAI Python client:

```python
from openai import OpenAI

# Initialize client with your Enterprise Inference endpoint
client = OpenAI(
    api_key="your-access-token",
    base_url="https://your-cluster-url/Meta-Llama-3.1-70B-Instruct/v1"
)

# Standard completion request
response = client.completions.create(
    model="meta-llama/Meta-Llama-3.1-70B-Instruct",
    prompt="Analyze quarterly sales trends and provide insights.",
    max_tokens=1000,
    temperature=0.3
)

print(response.choices[0].text)
```

This compatibility approach reduces integration friction while providing enterprises with control over their AI infrastructure. Applications can maintain familiar OpenAI patterns while benefiting from improved performance, lower latency, and enhanced data privacy through dedicated infrastructure.

## Conclusion

Intel AI for Enterprise Inference represents a transformative approach to enterprise AI deployment that addresses the fundamental challenges organizations face when implementing AI at scale. With IBM Cloud now offering Gaudi 3 accelerators alongside the platform's multi-hardware optimization strategy, enterprises can deploy OpenAI-compatible inference endpoints that deliver superior performance economics in the form of price-performance ratios for large models while maintaining complete API compatibility with existing applications. The deployable architecture methodology transforms what traditionally requires weeks of complex coordination between multiple teams into automated, repeatable patterns that provision production-ready AI infrastructure in hours rather than months. By supporting popular model families including Llama, Qwen, DeepSeek, and Mistral through familiar OpenAI APIs, the platform eliminates integration friction while providing the performance advantages of dedicated Intel hardware and the operational benefits of IBM Cloud's proven architectural blueprints. Organizations can focus on developing AI applications rather than managing infrastructure complexity, gaining a foundation that scales from pilot projects to production workloads while maintaining the governance, security, and operational excellence that enterprise environments demand.

**Ready to get started?** Deploy Intel AI for Enterprise Inference on your IBM Cloud environment today and experience the benefits of automated, enterprise-grade AI infrastructure.

[**Deploy Now →**](https://placeholder-url-to-deployable-architecture)
