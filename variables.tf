variable "namespace" {
  description = "The name of the namespace to deploy into"
  type        = string
}

variable "name" {
  description = "The name of the service to create to expose this deployment"
  type        = string
}

variable "image" {
  description = "The image to use for the deployment"
  type        = string
}

variable "image_name" {
  description = "The name you want to give the image, if you want it to be different to the value specified in the name variable"
  type        = string
  default     = ""
}

variable "image_args" {
  description = "arguments that you want to pass to the container"
  type        = list(string)
  default     = []
}

variable "replicas" {
  description = "The number of replias for this deployment"
  type        = number
  default     = 1
}

variable "service_type" {
  description = "The type of service to use to expose this deployment"
  type        = string
  default     = "ClusterIP"
}

variable "service_annotations" {
  description = "A map of annotations for the service that exposes this deployment"
  type        = map(string)
  default     = {}
}

variable "service_name" {
  description = "The name of the service, if you want it to be different to the value specified in the name variable"
  type        = string
  default     = ""
}

variable "service_selector_labels" {
  description = "A map of labels for the service to select on, if you want the value to be different to the name variable and extra lables"
  type        = map(string)
  default     = {}
}

variable "deployment_labels" {
  description = "Any labels you want to add to the deployment, if none are set then the value of the name variable is added to label key of app"
  type        = map(string)
  default     = {}
}

variable "env" {
  description = "The items in this map will be set as the environment variables in the container"
  type        = map(string)
  default     = {}
}

variable "ports" {
  description = "A map of port objects"
  type = map(object({
    container_port = number
    protocol       = string
    port           = number
  }))
  default = {}
}

variable "readiness_probe" {
  description = "Define any readiness_probes in the following map"
  type        = map(any)
  default     = {}
}

variable "sudo_pass" {
  description = "Enter a string or empty string here to write to the hosts file"
  sensitive   = true

  type    = string
  default = null
}

variable "dns_name" {
  description = "The dns name used if writing to the hosts file"
  type        = string
  default     = ""
}

variable "volume_mounts" {
  description = "Pod volumes to mount into the container's filesystem. Cannot be updated"
  type = list(object({
    mount_path = string
    name       = string
    read_only  = bool
  }))
  default = []
}

variable "volume_secrets" {
  description = "List of secrets to be mounted as data volumes"
  type = list(object({
    name        = string
    secret_name = string
  }))
  default = []
}

variable "config_map_volumes" {
  description = "List of config maps to be mounted as data volumes"
  type = list(object({
    name       = string
    mount_path = string
    read_only  = bool
    data       = map(string)
  }))
  default = []
}

variable "empty_dir_volumes" {
  description = "List of config maps to be mounted as data volumes"
  type = list(object({
    name       = string
    mount_path = string
    read_only  = bool
  }))
  default = []
}

variable "config_map_data" {
  description = "map of config map data items"
  type        = map(string)
  default     = {}
}

variable "resource_requests" {
  description = "Compute Resources requested by this container"
  type = object({
    cpu    = string
    memory = string
  })
  default = null
}

variable "resource_limits" {
  description = "Compute Resources limits for this container"
  type = object({
    cpu    = string
    memory = string
  })
  default = null
}

variable "create_service" {
  description = "Should a service be created for this deployment"
  type        = bool
  default     = true
}
