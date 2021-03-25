# Skupper Operator

Skupper operator proposal that just produces a bundle and an index images.
The goal of this proposal is to avoid introducing a new CRD, just relying
on the site-controller to kick things off based on an existing skupper-site
configmap.

# Building the bundle and index images

Just run: `make` and it should take care of it.
Currently it is tied to my local user, for evaluation.

# Adding it to the catalog

If you want to test your catalog against a local minikube cluster,
you'll need to install OLM first. For more info, check this out:
https://olm.operatorframework.io/docs/getting-started/

In an OpenShift cluster, OLM is already installed. So you just need to 
create your CatalogSource.

## Minikube

```
kubectl apply -f catalog-k8s.yaml
```

## OpenShift

```
kubectl apply -f catalog-ocp.yaml
```

# Installing the operator

This is working on OpenShift only for now. Needs further investigation on k8s.

This sample uses the `skupper-sandbox` namespace. So first it needs to be created
then we need to create the operatorgroup and the subscription in order to get
the operator running, see:

```
kubectl create ns skupper-sandbox
kubectl apply -f operatorgroup-ocp.yaml
kubectl apply -f subscription-ocp.yaml
```

Now you can wait for the skupper operator pod (site-controller) to be running
on your namespace.

# Creating a new skupper site

Just create your skupper-site now using the provided sample yaml:

```
kubectl apply -f skupper-site.yaml
```

# Manual steps executed to scaffold the project (for reference only)

The following steps were initially executed to create this project
from scratch:


## Creating a new operator using the sdk

The SDK will create the initial infrastructure needed.

```
operator-sdk init --domain skupper.io --repo github.com/skupperproject/skupper-operator
```

## Adding a dummy CRD

Without a CRD the SDK does not introduce the bundle manifests.
So we need it before we can customize them.

```
operator-sdk create api --version v1beta1 --kind Site --resource --controller
```

## Creating the initial bundle

```
make bundle

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

... and after that remove the generated CRD for the dummy Site kind.

```
rm bundle/manifests/skupper.io.skupper.io_sites.yaml
```

## Building and pushing using the originally produced articats

```
make bundle-build BUNDLE_IMG=quay.io/fgiorgetti/skupper-operator-bundle:v0.0.1
docker push quay.io/fgiorgetti/skupper-operator-bundle:v0.0.1
opm index add --bundles quay.io/fgiorgetti/skupper-operator-bundle:v0.0.1 --tag quay.io/fgiorgetti/skupper-operator-index:v0.0.1
podman push quay.io/fgiorgetti/skupper-operator-index:v0.0.1
```

## Manual clean up and changes

After that, I have removed all unnecessary files, adjusted Makefile and the
content of the `bundle/` directory.
