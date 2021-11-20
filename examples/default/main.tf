# Kubernetes provider used to generate
# a namespace for our kuma deployment
provider "kubernetes" {
  config_path = var.kube_config_file
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "deployment-example"
  }
}

locals {
  ns = kubernetes_namespace.example.metadata[0].name
  postgres_env = {
    "POSTGRES_USER"     = "example"
    "POSTGRES_PASSWORD" = "example"
    "POSTGRES_DB"       = "example"
  }
  postgres_ports = {
    "postgres" = {
      container_port = 5432
      port           = 5432
      protocol       = "TCP"
    }
  }
  postgres_limits = {
    cpu    = "150m"
    memory = "256Mi"
  }
  postgres_requests = {
    cpu    = "100m"
    memory = "128Mi"
  }
  postgres_labels = {
    "app"   = "postgres-master"
    "test1" = "alpha"
    "test2" = "beta"
  }
  empty_dir_volumes = [
    {
      name       = "pg-storage"
      mount_path = "/tmp/pg_tmp"
      read_only  = false
    }
  ]
}

module "deployment_example" {
  source            = "../../"
  namespace         = local.ns
  name              = "postgres-master"
  image             = "postgres:latest"
  env               = local.postgres_env
  ports             = local.postgres_ports
  resource_limits   = local.postgres_limits
  resource_requests = local.postgres_requests
  deployment_labels = local.postgres_labels
  empty_dir_volumes = local.empty_dir_volumes
  replicas          = 1
}
