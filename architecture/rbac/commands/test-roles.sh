# check if diederik and eva are junior fullstack developers, only permission to development environment
kubectl auth can-i get pods -n development --as diederik
kubectl auth can-i get pods -n development --as eva
