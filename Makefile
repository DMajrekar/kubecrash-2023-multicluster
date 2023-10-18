
# setup will run a targetted apply of terraform resources in lon and nyc to make the demo quicker
setup:
	cd terraform/lon && terraform init
	cd terraform/lon && terraform apply -target module.infra.civo_network.network -auto-approve
	cd terraform/lon && terraform apply -target module.infra.civo_firewall.firewall -auto-approve
	cd terraform/lon && terraform apply -target module.infra.civo_kubernetes_cluster.cluster -auto-approve
	cd terraform/nyc && terraform init
	cd terraform/nyc && terraform apply -target module.infra.civo_network.network -auto-approve
	cd terraform/nyc && terraform apply -target module.infra.civo_firewall.firewall -auto-approve
	cd terraform/nyc && terraform apply -target module.infra.civo_kubernetes_cluster.cluster -auto-approve

destroy:
	cd terraform/lon && terraform destroy -auto-approve
	cd terraform/nyc && terraform destroy -auto-approve

step1:
	clear
	@echo "Terraform Module for London"
	@echo
	cat terraform/lon/module.tf
	@echo

step2:
	@read -n 1 -s -p "Press any key to continue..."
	@echo
	@echo "Terraform Module for NYC"
	@echo
	cat terraform/nyc/module.tf
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step3:
	clear
	@echo "Contents of the infra module"
	@echo
	ls -l terraform/modules/infra
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step4:
	clear
	@echo "Contents of the infra module"
	@echo
	cat terraform/modules/infra/civo_network-network.tf
	@echo
	cat terraform/modules/infra/civo_firewall-cluster.tf
	@echo
	cat terraform/modules/infra/civo_kubernetes_cluster-cluster.tf
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step5:
	clear
	@echo "Terraform plan the london module"
	@echo
	cd terraform/lon && terraform plan
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step6:
	clear
	@echo "Terraform apply the london module"
	@echo
	cd terraform/lon && terraform apply -auto-approve
	@echo
	@read -n 1 -s -p "Press any key to continue..."

# plan the nyc module
step7:
	clear
	@echo "Terraform plan the nyc module"
	@echo
	cd terraform/nyc && terraform plan
	@echo
	@read -n 1 -s -p "Press any key to continue..."


# Apply the nyc module
step8:
	clear
	@echo "Terraform apply the nyc module"
	@echo
	cd terraform/nyc && terraform apply -auto-approve
	@echo
	@read -n 1 -s -p "Press any key to continue..."

# Show the nodes in the Lon cluster
step9:
	clear
	@echo "Nodes in the Lon cluster"
	@echo
	kubectl --kubeconfig=terraform/lon/kubeconfig get nodes
	@echo
	@read -n 1 -s -p "Press any key to continue..."

# Show the nodes in the NYC cluster
step10:
	@echo "Nodes in the NYC cluster"
	@echo
	kubectl --kubeconfig=terraform/nyc/kubeconfig get nodes
	@echo
	@read -n 1 -s -p "Press any key to continue..."

# Show pods in the ArgoCD NS in lon
step11:
	clear
	@echo "Pods in the ArgoCD namespace in Lon"
	@echo
	kubectl --kubeconfig=terraform/lon/kubeconfig get pods -n argocd
	@echo
	@read -n 1 -s -p "Press any key to continue..."

# Show the appset in the argocd ns in lon
step12:
	clear
	@echo "Appset in the ArgoCD namespace in Lon"
	@echo
	kubectl --kubeconfig=terraform/lon/kubeconfig get appset -n argocd
	@echo
	@read -n 1 -s -p "Press any key to continue..."

# Get the jq path /spec/generators/0/git/directories from the appset in lon
step13:
	clear
	@echo "Application Deployment path in Lon"
	@echo
	kubectl --kubeconfig=terraform/lon/kubeconfig get appset -n argocd root -o json | jq '.spec.generators[0].git.directories'
	@echo
	@read -n 1 -s -p "Press any key to continue..."

# Get the jq path /spec/generators/0/git/directories from the appset in nyc
step14:
	@echo
	@echo "Application Deployment path in NYC"
	@echo
	kubectl --kubeconfig=terraform/nyc/kubeconfig get appset -n argocd root -o json | jq '.spec.generators[0].git.directories'
	@echo
	@read -n 1 -s -p "Press any key to continue..."

# Cat the files argo/argocd/env/lon/kustomization.yaml and argo/argocd/env/nyc/kustomization.yaml
step15:
	clear
	@echo "Contents of the kustomization.yaml files"
	@echo
	cat argo/argocd/env/lon/kustomization.yaml
	@echo
	cat argo/argocd/env/nyc/kustomization.yaml
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step16:
	clear
	@echo "Applications in Lon"
	@echo
	find argo -type d -name 'lon'
	@echo
	@read -n 1 -s -p "Press any key to continue..."

# kubectl list the apps in the argocd ns in lon1
step17:
	clear
	@echo "Applications in Lon"
	@echo
	kubectl --kubeconfig=terraform/lon/kubeconfig get applications -n argocd
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step18:
	clear
	@echo "Applications in NYC"
	@echo
	find argo -type d -name 'nyc'
	@echo
	@read -n 1 -s -p "Press any key to continue..."

step19:
	clear
	@echo "Applications in NYC"
	@echo
	kubectl --kubeconfig=terraform/nyc/kubeconfig get applications -n argocd
	@echo

# get all pods in all namespaces in both clusters
step20:
	clear
	@echo "Pods in all namespaces in Lon"
	@echo
	kubectl --kubeconfig=terraform/lon/kubeconfig get pods --all-namespaces
	@echo
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Pods in all namespaces in NYC"
	@echo
	kubectl --kubeconfig=terraform/nyc/kubeconfig get pods --all-namespaces
	@echo
	@read -n 1 -s -p "Press any key to continue..."


demo: step1 step2 step3 step4 step5 step6 step7 step8 step9 step10 step11 step12 step13 step14 step15 step16 step17 step18 step19 step20

.PHONY: demo destroy steup step1 step2 step3 step4 step5 step6 step7 step8 step9 step10 step11 step12 step13 step14 step15 step16 step17 step18 step19 step20
