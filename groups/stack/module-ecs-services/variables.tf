# Environment
variable "environment" {
  type        = string
  description = "The environment name, defined in envrionments vars."
}
variable "aws_region" {
  type        = string
  description = "The AWS region for deployment."
}

# Networking
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC for the target group and security group."
}
variable "tocr-api-lb-arn" {
  type        = string
  description = "The ARN of the load balancer created in the ecs-stack module."
}
variable "ocr-api-lb-listener-arn" {
  type        = string
  description = "The ARN of the lb listener created in the ecs-stack module."
}
variable "subnet_ids" {
  type        = string
  description = "Subnet IDs of application subnets from aws-mm-networks remote state."
}
variable "web_access_cidrs" {
  type        = list(string)
  description = "Subnet CIDRs for web ingress rules in the security group."
}

# DNS
variable "external_top_level_domain" {
  type        = string
  description = "The type levelel of the DNS domain for external access."
}
variable "internal_top_level_domain" {
  type        = string
  description = "The type levelel of the DNS domain for internal access."
}

# ECS Service
variable "name_prefix" {
  type        = string
  description = "The name prefix to be used for stack / environment name spacing."
}
variable "ecs_cluster_id" {
  type        = string
  description = "The ARN of the ECS cluster to deploy the service to."
}
variable "number_of_tasks" {
  type        = number
  description = "The number of instances of the ocr-api task to run" 
}

# Docker Container
variable "docker_registry" {
  type        = string
  description = "The FQDN of the Docker registry."
}
variable "task_execution_role_arn" {
  type        = string
  description = "The ARN of the task execution role that the container can assume."
}
variable "log_level" {
  type        = string
  description = "The log level to be set in the environment variables for the container."
}
variable "ocr_tesseract_thread_pool_size" {
  type        = string
  description = "The number of threads used in the ocr-api application for Tesseract processing (Image to text)"
}

# Certificates
variable "ssl_certificate_id" {
  type        = string
  description = "The ARN of the certificate for https access through the ALB."
}

# Machine properties
variable "machine_cpu_count" {
  type        = number
  description = "The number of vCPUs the ocr-api uses."
}
variable "machine_amount_of_memory_mib" {
  type        = number
  description = "The amount of memory to allocate to the ocr-api."
}

# ------------------------------------------------------------------------------

# Services


# ocr-api
variable "ocr_api_release_version" {
  type        = string
  description = "The release version for the ocr-api service."
}
variable "ocr_api_application_port" {
  type        = string
  description = "The port number for the ocr-api service."
}
