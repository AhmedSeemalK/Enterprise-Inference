### Accessing Models from OpenAI based Client
For interacting with deployed models you can utilize any client that supports OpenAPI specification, such as Swagger UI or Open WebUI. 
These tools facilitate seamless integration by offering interactive documentation and features like automatic code generation.  
As an example, we will demonstrate how to use Open WebUI to connect with these models, allowing you to execute API calls and effectively manage your interactions with the models.

To integrate Open WebUI with your models, follow these commands:
```shell
helm repo add open-webui https://helm.openwebui.com/
helm repo update
helm install open-webui open-webui/open-webui --namespace open-webui --create-namespace
kubectl port-forward -n open-webui svc/open-webui 9090:80
```
```
Settings -> connections -> Add model -> https://domain-name/Meta-Llama-3.1-8B-Instruct-vllmcpu/v1/ (Model Endpoint which is deployed)
Model id -> meta-llama/Meta-Llama-3.1-8B-Instruct (Model Id which is deployed)
Interact with Deployed model
```

###### For visual assistance, refer to the following example image of a OpenAPI based client request and response:
<img src="https://github.com/intel-innersource/applications.ai.erag.infra-automation/blob/opea-vllm-image-update/ida/catalog/docs/pictures/AI-Inference-as-Service-openapi-based-client.png" alt="AI Inference Model API curl request" width="800" height="220"/>
