# run config
kubectl apply -f frontend-config.yaml

# create deployment
kubectl apply -f frontend-deploy.yaml

# check pods related to the deployment
kubectl get pods -l app=frontend

# create service
kubectl apply -f frontend-service.yaml

# run deployment locally on port 3000
# kubectl port-forward deployment/frontend-deployment 3000:80

# or run via a service
minikube service --url frontend-service