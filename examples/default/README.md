# Example Postgres Deployment

The following example will create one deployment of
postgres, and one service exposing that deployment. It
also sets a few optional mondule inputs.

```HCL
locals {
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
}

module "deployment_example" {
  source            = "srb3/simple-deployment/kubernetes"
  namespace         = kubernetes_namespace.example.metadata[0].name
  service_name      = "postgres-master"
  image             = "postgres:latest"
  env               = local.postgres_env
  ports             = local.postgres_ports
  resource_limits   = local.postgres_limits
  resource_requests = local.postgres_requests
  replicas          = 1
}
```

## Testing

Tests are run via the makefile
