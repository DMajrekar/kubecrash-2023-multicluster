resource "civo_kubernetes_cluster" "cluster" {
  name        = "${var.name_prefix}-cluster"
  firewall_id = civo_firewall.firewall.id
  network_id = civo_network.network.id

  pools {
    node_count = var.cluster_node_count
    size       = var.cluster_node_size
  }
  timeouts {
    create = "5m"
  }
}

resource "local_file" "cluster-config" {
  content              = civo_kubernetes_cluster.cluster.kubeconfig

  filename             = "${path.root}/kubeconfig"
  file_permission      = "0600"
  directory_permission = "0755"
}
