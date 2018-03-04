ENV_NAME := "basic-rails"

lint:
	helm lint .

update-dependencies:
	helm dependency update .

install: lint update-dependencies
	helm install --name ${ENV_NAME} --namespace ${ENV_NAME} . \
		--set global.hostname="${ENV_NAME}.${K8S_NAME}" \
		--set rails.mysql.mysqlRootPassword="r00tb33r" \
		--set rails.mysql.mysqlUser="rails" \
		--set rails.mysql.mysqlPassword="rails" \
		--set rails.mysql.mysqlDatabase="${ENV_NAME}"

upgrade: lint update-dependencies
	helm upgrade ${ENV_NAME} --namespace ${ENV_NAME} . \
		--set global.hostname="${ENV_NAME}.${K8S_NAME}" \
		--set rails.mysql.mysqlRootPassword="r00tb33r" \
		--set rails.mysql.mysqlUser="rails" \
		--set rails.mysql.mysqlPassword="rails" \
		--set rails.mysql.mysqlDatabase="${ENV_NAME}"

delete:
	helm delete --purge ${ENV_NAME}
