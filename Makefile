az_sp:
	az ad sp create-for-rbac --name {NAME} \
                         --role Contributor \
                         --scopes /subscriptions/{SUBSCRIPTION ID}/resourceGroups/{RG NAME} --sdk-auth
