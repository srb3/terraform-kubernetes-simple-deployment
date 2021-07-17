locals {
  internal_dns_endpoint = (
    var.create_service
    ?
    "${kubernetes_service.this-service.0.metadata.0.name}.${var.namespace}.svc.cluster.local:${local.port}"
    :
    ""
  )
  internal_dns_name = (
    var.create_service
    ?
    "${kubernetes_service.this-service.0.metadata.0.name}.${var.namespace}.svc.cluster.local"
    :
    ""
  )
  internal_dns_endpoint_ext = (
    var.create_service
    ?
    "${kubernetes_service.this-service.0.metadata.0.name}.${var.namespace}.svc.cluster.local:${local.port_ext}"
    :
    ""
  )
}
output "connection" {
  value = {
    cluster_ip                = local.cluster_ip
    load_balancer_ip          = local.load_balancer_ip
    port                      = local.port
    port_ext                  = local.port_ext
    internal_endpoint         = "${local.cluster_ip}:${local.port}"
    external_endpoint         = "${local.load_balancer_ip}:${local.port}"
    internal_dns_endpoint     = local.internal_dns_endpoint
    internal_dns_name         = local.internal_dns_name
    internal_endpoint_ext     = "${local.cluster_ip}:${local.port_ext}"
    external_endpoint_ext     = "${local.load_balancer_ip}:${local.port_ext}"
    internal_dns_endpoint_ext = local.internal_dns_endpoint_ext
  }
}
