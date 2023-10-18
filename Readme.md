# KubeCrash 2023 Demo

This demo shows off how you can deploy to multiple clusters in multiple 
regions using Terraform. Once the infrastucture is online, ArgoCD is
used to manage applications that are deployed to the clusters.


## Prerequisites

- terraform
- kustomize
- kubectl

## Setup

1. Create a Civo Account - www.civo.com
2. Get the Civo API Key