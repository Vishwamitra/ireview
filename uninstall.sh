helm uninstall frontend -n ireview-app

helm uninstall api -n ireview-app

helm uninstall postgres -n ireview-app

# uninstal roles
helm uninstall roles ./architecture/rbac/helm 