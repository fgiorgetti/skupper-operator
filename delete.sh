. common.sh

for i in skupper-site.yaml subscription-ocp.yaml operatorgroup-ocp.yaml catalog-ocp.yaml ; do kubectl delete -f $i; done
kubectl -n skupper-sandbox delete csv skupper-operator.v0.0.1
waitRemoved openshift-marketplace skupper-operator
kubectl delete ns skupper-sandbox
