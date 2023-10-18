
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

step3:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Contents of the infra module"
	@echo
	ls -l terraform/modules/infra
	@echo

step4:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Contents of the infra module"
	@echo
	cat terraform/modules/infra/civo_network-network.tf
	@echo
	cat terraform/modules/infra/civo_firewall-cluster.tf
	@echo
	cat terraform/modules/infra/civo_kubernetes_cluster-cluster.tf
	@echo

step5:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Terraform plan the london module"
	@echo
	cd terraform/lon && terraform plan
	@echo

step6:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Terraform apply the london module"
	@echo
	cd terraform/lon && terraform apply -auto-approve
	@echo

# plan the nyc module
step7:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Terraform plan the nyc module"
	@echo
	cd terraform/nyc && terraform plan
	@echo


# Apply the nyc module
step8:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Terraform apply the nyc module"
	@echo
	cd terraform/nyc && terraform apply -auto-approve
	@echo

# Show the nodes in the Lon cluster
step9:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Nodes in the Lon cluster"
	@echo
	kubectl --kubeconfig=terraform/lon/kubeconfig get nodes
	@echo

# Show the nodes in the NYC cluster
step10:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Nodes in the NYC cluster"
	@echo
	kubectl --kubeconfig=terraform/nyc/kubeconfig get nodes
	@echo

# Show pods in the ArgoCD NS in lon
step11:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Pods in the ArgoCD namespace in Lon"
	@echo
	kubectl --kubeconfig=terraform/lon/kubeconfig get pods -n argocd
	@echo

# Show the appset in the argocd ns in lon
step12:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Appset in the ArgoCD namespace in Lon"
	@echo
	kubectl --kubeconfig=terraform/lon/kubeconfig get appset -n argocd
	@echo

# Get the jq path /spec/generators/0/git/directories from the appset in lon
step13:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Application Deployment path in Lon"
	@echo
	kubectl --kubeconfig=terraform/lon/kubeconfig get appset -n argocd root -o json | jq '.spec.generators[0].git.directories'
	@echo

# Get the jq path /spec/generators/0/git/directories from the appset in nyc
step14:
	@read -n 1 -s -p "Press any key to continue..."
	@echo
	@echo "Application Deployment path in NYC"
	@echo
	kubectl --kubeconfig=terraform/nyc/kubeconfig get appset -n argocd root -o json | jq '.spec.generators[0].git.directories'
	@echo

# Cat the files argo/argocd/env/lon/kustomization.yaml and argo/argocd/env/nyc/kustomization.yaml
step15:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Contents of the kustomization.yaml files"
	@echo
	cat argo/argocd/env/lon/kustomization.yaml
	@echo
	cat argo/argocd/env/nyc/kustomization.yaml
	@echo

step16:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Applications in Lon"
	@echo
	find argo -type d -name 'lon'
	@echo

# kubectl list the apps in the argocd ns in lon1
step17:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Applications in Lon"
	@echo
	kubectl --kubeconfig=terraform/lon/kubeconfig get applications -n argocd
	@echo

step18:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Applications in NYC"
	@echo
	find argo -type d -name 'nyc'
	@echo

step19:
	@read -n 1 -s -p "Press any key to continue..."
	clear
	@echo "Applications in NYC"
	@echo
	kubectl --kubeconfig=terraform/nyc/kubeconfig get applications -n argocd
	@echo



demo: step1 step2 step3 step4 step5 step6 step7 step8 step9 step10 step11 step12 step13 step14 step15 step16 step17 step18 step19

.PHONY: demo destroy steup step1 step2 step3 step4 step5 step6 step7 step8 step9 step10 step11 step12 step13 step14 step15 step16 step17 step18 step19
