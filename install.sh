helm install postgres ./architecture/db/helm/postgres/ -n ireview-app

echo "Installing Api...."

helm install api ./architecture/api/helm/api -n ireview-app

echo "installing front end now..."

helm install frontend ./architecture/frontend/frontend-chart/ -n ireview-app

echo " all installation done"
