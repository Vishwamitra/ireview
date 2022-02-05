echo "Installing postgres DB..."

sudo microk8s helm3 install postgres ./architecture/db/helm/postgres/ -n ireview-app

echo "Installing Api...."

sudo microk8s helm3 install api ./architecture/api/helm/api -n ireview-app

echo "installing front end now..."

sudo microk8s helm3 install frontend ./architecture/frontend/helm/frontend -n ireview-app

echo " all installation done"
