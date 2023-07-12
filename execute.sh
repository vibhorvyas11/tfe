#!/bin/sh
JSON_FILE= ".\\compute-engine.tfvars.json"
## Terraform steps
#terraform -version
#cd compute-engine/
pwd
echo "terraform init"
terraform init
echo "terraform plan -var-file=$JSON_FILE"
terraform plan  -var-file=$JSON_FILE
echo "terraform apply -var-file=$JSON_FILE"
terraform apply -var-file=$JSON_FILE
