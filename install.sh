echo "Installing postgres DB..."

helm install postgres ./architecture/db/helm/postgres/ -n development

echo "Installing Api...."

helm install api ./architecture/api/helm/api -n development

echo "installing front end now..."

helm install frontend ./architecture/frontend/helm/frontend -n development

echo "installing roles..."

helm install roles ./architecture/rbac/helm 

echo "installation done..."