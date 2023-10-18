resource "null_resource" "argocd-01" {
  provisioner "local-exec" {
    command     = "kustomize build ${var.argocd_path} | kubectl apply -f - --kubeconfig <(echo $KUBECONFIG | base64 --decode) > output-01"
    interpreter = ["/bin/bash", "-c"]
    environment = {
      KUBECONFIG = base64encode(civo_kubernetes_cluster.cluster.kubeconfig)
    }

  }
  triggers = {
    cluster_id = civo_kubernetes_cluster.cluster.id
  }
}

resource "null_resource" "argocd-02" {
  provisioner "local-exec" {
    command     = "sleep 1; kustomize build ${var.argocd_path} | kubectl apply -f - --kubeconfig <(echo $KUBECONFIG | base64 --decode) > output-02"
    interpreter = ["/bin/bash", "-c"]
    environment = {
      KUBECONFIG = base64encode(civo_kubernetes_cluster.cluster.kubeconfig)
    }

  }
  triggers = {
    cluster_id = civo_kubernetes_cluster.cluster.id
  }
  depends_on = [ null_resource.argocd-01 ]
}
