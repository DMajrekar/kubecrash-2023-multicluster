module "infra" {
    source = "../modules/infra"
    name_prefix = "nyc-kc"
    kubernetes_api_access = var.kubernetes_api_access
    argocd_path = "${path.root}/../../argo/argocd/env/nyc"
}
