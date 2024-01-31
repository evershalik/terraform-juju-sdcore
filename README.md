# SD-Core Control Plane Terraform Module

This SD-Core Control Plane Terraform module aims to deploy the [sdcore-control-plane-k8s bundle](https://charmhub.io/sdcore-control-plane-k8s) via Terraform.

## Getting Started

### Prerequisites

The following software and tools needs to be installed and should be running in the local environment.

- `microk8s`
- `juju 3.x`
- `terrafom`

### Deploy the sdcore-control-plane-k8s bundle using Terraform

Make sure that `storage`, `multus` and `metallb` plugins are enabled for Microk8s:

```console
sudo microk8s enable hostpath-storage multus
sudo microk8s enable metallb:10.0.0.2-10.0.0.4
```

Initialise the provider:

```console
terraform init
```

Customize the configuration inputs under `terraform.tfvars` file according to requirement.

Replace the values in the `terraform.tfvars` file. The provided model-name is not expected to pre-exist and will be created by Juju Terraform Provider.

```yaml
# Mandatory Config Options
model_name             = "put your model-name here"
```

Run Terraform Plan by providing var-file:

```console
terraform plan -var-file="terraform.tfvars" 
```

Deploy the resources, skip the approval:

```console
terraform apply -auto-approve 
```

### Check the Output

Run `juju switch <juju model>` to switch to the target Juju model and observe the status of the applications.

```console
juju status --relations
```

### Clean up

Remove the applications:

```console
terraform destroy -auto-approve
```
