variable "ssh_key" {
  description = "SSH key name"
  type        = string
  default     = ""
}
variable "ssh_private_key" {
  default     = null
  description = "Provide the private SSH key (named id_rsa) used during the creation and configuration of the bastion server to securely authenticate and connect to the bastion server. This allows access to internal network resources from a secure entry point. Note: The corresponding public SSH key (named id_rsa.pub) must already be available in the ~/.ssh/authorized_keys file on the bastion host to establish authentication."
  type        = string
  sensitive   = true
}
variable "github_pat" {
  description = "GitHub Personal Access Token with the necessary permissions"
  type        = string
  sensitive   = true
}
variable "ibmcloud_region" {
  description = "IBM Cloud Region"
  type        = string
  default     = "us-south"
}
variable "cluster_url" {
  description = "The URL of the cluster"
  type        = string
  default     = "api.example.com"
}
variable "cert_file" {
  description = "The path to the certificate file"
  type        = string
  default     = "~/certs/cert.pem"
}
variable "key_file" {
  description = "The path to the key file"
  type        = string
  default     = "~/certs/key.pem"
}
variable "keycloak_client_id" {
  description = "Keycloak client id"
  type        = string
  default     = "ibm-app"
}
variable "keycloak_admin_user" {
  description = "Keycloak admin user name"
  type        = string
  default     = "admin"
}
variable "keycloak_admin_password" {
  description = "Keycloak admin password"
  type        = string
  default     = "admin"
}
variable "hugging_face_token" {
  description = "This variable specifies the hf token."
  type        = string
  default     = ""
}
variable "models" {
  description = "Model number to be deployed"
  type        = string
  default     = "11"
}
variable "cpu_or_gpu" {
  description = "This variable specifies where the model should be running"
  type        = string
  default     = "cpu"
}
variable "deploy_kubernetes_fresh" {
  description = "This variable specfies whether to deploy Kubernetes cluster freshly"
  type        = string
  default     = "yes"
}
variable "deploy_ingress_controller" {
  description = "This variable specfies whether to deploy NGNIX ingress controller or not"
  type        = string
  default     = "yes"
}
variable "deploy_keycloak_and_apisix" {
  description = "This variable specfies whether we need to run keycloak and Apisix components"
  type        = string
  default     = "no"
}
variable "deploy_llm_models" {
  description = "This variable specfies whether we need to deploy LLM models"
  type        = string
  default     = "yes"
}
variable "deploy_keycloak_apisix" {
  description = "This variable specfies whether we need to run keycloak and Apisix components"
  type        = string
  default     = "no"
}

