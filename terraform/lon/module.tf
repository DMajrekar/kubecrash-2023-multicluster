module "infra" {
    source = "../modules/infra"
    kubernetes_api_access = var.kubernetes_api_access
    name_prefix = "lon-kc"
    argocd_path = "${path.root}/../../argo/argocd/env/lon"
}
