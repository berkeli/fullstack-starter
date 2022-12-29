.PHONY: clean init_staging init_prod destroy_staging destroy_prod
clean:
	rm -rf ./.terraform

init_staging:
	make clean
	terraform init  -backend-config="resource_group_name=Cloud-Final-Project-staging" -backend-config="storage_account_name=berkelifpstatestaging"

init_prod:
	make clean
	terraform init  -backend-config="resource_group_name=Cloud-Final-Project-production" -backend-config="storage_account_name=berkelifpstateproduction"

destroy_staging:
	make init_staging
	terraform destroy -auto-approve -var-file=staging.tfvars

destroy_prod:
	make init_prod
	terraform destroy -auto-approve -var-file=prod.tfvars

