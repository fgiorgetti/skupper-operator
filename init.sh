. common.sh

kubectl create ns skupper-sandbox
kubectl apply -f catalog-ocp.yaml
waitRunning openshift-marketplace skupper-operator

[[ $1 == "catalog" ]] && exit 0

kubectl apply -f operatorgroup-ocp.yaml
kubectl apply -f subscription-ocp.yaml
waitRunning skupper-sandbox skupper-site-controller

kubectl apply -f skupper-site.yaml
