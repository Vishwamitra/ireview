# check if diederik and eva are junior fullstack developers, only permission all resources in development namespace
kubectl auth can-i get pods -n development --as diederik
-> yes
kubectl auth can-i get pods -n development --as eva
-> yes

# check if vishwa is a frontend engineer, permission to only frontend resources within all namespaces
kubectl auth can-i get services/frontend -n development --as vishwa
-> yes
kubectl auth can-i get services/backend -n development --as vishwa
-> no
kubectl auth can-i get deployments/frontend -n development --as vishwa
-> yes
kubectl auth can-i get deployments/backend -n development --as vishwa
-> no