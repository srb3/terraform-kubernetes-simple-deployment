# Create any config maps
resource "kubernetes_config_map" "this-config-map" {
  for_each = { for c in var.config_map_volumes : c.name => { name = c.name, data = c.data } }
  metadata {
    name      = each.value.name
    namespace = var.namespace
  }
  data = each.value.data
}

# Create a kubernetes service to expose the deployment
resource "kubernetes_service" "this-service" {
  metadata {
    name        = var.service_name
    namespace   = var.namespace
    annotations = var.service_annotations
  }
  spec {
    type = var.service_type
    dynamic "port" {
      for_each = var.ports
      content {
        name        = port.key
        port        = port.value.port
        protocol    = port.value.protocol
        target_port = port.value.container_port
      }
    }
    selector = {
      app = kubernetes_deployment.this-deployment.metadata.0.labels.app
    }
  }
}

# Creating the deployment
resource "kubernetes_deployment" "this-deployment" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
    labels = {
      app = var.service_name
    }
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = {
        app = var.service_name
      }
    }
    template {
      metadata {
        labels = {
          app = var.service_name
        }
      }
      spec {
        dynamic "volume" {
          for_each = toset(var.config_map_volumes)
          content {
            name = volume.value.name
            config_map {
              name = volume.value.name
            }
          }
        }

        dynamic "volume" {
          for_each = toset(var.volume_secrets)
          content {
            name = volume.value.name
            secret {
              secret_name = volume.value.secret_name
            }
          }
        }

        container {
          resources {
            requests = var.resource_requests
            limits   = var.resource_limits
          }
          image = var.image
          name  = var.service_name

          dynamic "env" {
            for_each = var.env
            content {
              name  = env.key
              value = env.value
            }
          }

          args = var.args

          dynamic "volume_mount" {
            for_each = toset(var.config_map_volumes)
            content {
              name       = volume_mount.value.name
              read_only  = volume_mount.value.read_only
              mount_path = volume_mount.value.mount_path
            }
          }

          dynamic "volume_mount" {
            for_each = toset(var.volume_mounts)
            content {
              mount_path = volume_mount.value.mount_path
              name       = volume_mount.value.name
              read_only  = volume_mount.value.read_only
            }
          }

          dynamic "port" {
            for_each = var.ports
            content {
              name           = port.key
              protocol       = port.value.protocol
              container_port = port.value.container_port
            }
          }

          dynamic "readiness_probe" {
            for_each = var.readiness_probe
            content {
              dynamic "http_get" {
                for_each = lookup(var.readiness_probe, "http_get", null) != null ? ["http_get"] : []
                content {
                  path   = var.readiness_probe["http_get"]["path"]
                  port   = var.readiness_probe["http_get"]["port"]
                  scheme = var.readiness_probe["http_get"]["scheme"]
                }
              }
            }
          }

        }
      }
    }
  }
  depends_on = [kubernetes_config_map.this-config-map]
}

# The locals are used as helpers for this modules outputs
locals {
  load_balancer_ip = (
    length(kubernetes_service.this-service.status.0.load_balancer.0.ingress) > 0
    ?
    kubernetes_service.this-service.status.0.load_balancer.0.ingress.0.hostname != ""
    ?
    kubernetes_service.this-service.status.0.load_balancer.0.ingress.0.hostname
    :
    kubernetes_service.this-service.status.0.load_balancer.0.ingress.0.ip
    :
    ""
  )
  cluster_ip = kubernetes_service.this-service.spec.0.cluster_ip
  port       = kubernetes_service.this-service.spec.0.port.0.port
  port_ext = (
    length(keys(var.ports)) > 1 ?
    kubernetes_service.this-service.spec.0.port.1.port :
    ""
  )
}
