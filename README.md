# Manual steps executed to scaffold the project

operator-sdk init --domain skupper.io --repo github.com/skupperproject/skupper-operator

operator-sdk create api --version v1beta1 --kind Site --resource --controller

make manifests

make bundle

rm bundle/manifests/skupper.io.skupper.io_sites.yaml

```
Display name for the operator (required): 
> Skupper         

Description for the operator (required): 
> Skupper site operator

Provider's name for the operator (required): 
> Skupper Project

Any relevant URL for the provider name (optional): 
> https://skupper.io

Comma-separated list of keywords for your operator (required): 
> skupper

Comma-separated list of maintainers and their emails (e.g. 'name1:email1, name2:email2') (required): 
> Fernando Giorgetti:fgiorgetti@gmail.com
```


Building and pushing

```
make bundle-build BUNDLE_IMG=quay.io/fgiorgetti/skupper-operator-bundle:v0.0.1

docker push quay.io/fgiorgetti/skupper-operator-bundle:v0.0.1

opm index add --bundles quay.io/fgiorgetti/skupper-operator-bundle:v0.0.1 --tag quay.io/fgiorgetti/skupper-operator-index:v0.0.1

podman push quay.io/fgiorgetti/skupper-operator-index:v0.0.1

```
