output "connection" {
  value = {
    cluster_ip                = local.cluster_ip
    load_balancer_ip          = local.load_balancer_ip
    port                      = local.port
    port_ext                  = local.port_ext
    internal_endpoint         = "${local.cluster_ip}:${local.port}"
    external_endpoint         = "${local.load_balancer_ip}:${local.port}"
    internal_dns_endpoint     = "${kubernetes_service.this-service.metadata.0.name}.${var.namespace}.svc.cluster.local:${local.port}"
    internal_dns_name         = "${kubernetes_service.this-service.metadata.0.name}.${var.namespace}.svc.cluster.local"
    internal_endpoint_ext     = "${local.cluster_ip}:${local.port_ext}"
    external_endpoint_ext     = "${local.load_balancer_ip}:${local.port_ext}"
    internal_dns_endpoint_ext = "${kubernetes_service.this-service.metadata.0.name}.${var.namespace}.svc.cluster.local:${local.port_ext}"
  }
}
