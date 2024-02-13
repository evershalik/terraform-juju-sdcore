# SD-Core Control Plane Terraform Module

This folder contains the [Terraform][Terraform] module for the [sdcore-control-plane-k8s][sdcore-control-plane-k8s] bundle.

The module uses the [Terraform Juju provider][Terraform Juju provider] to model the charm deployment onto any Kubernetes environment managed by [Juju][Juju].

The module can be used to deploy the `sdcore-control-plane-k8s` separately as well as a part of `sdcore-k8s` module, depending on the deployment architecture.

## Module structure

- **main.tf** - Defines the Juju application to be deployed.
- **variables.tf** - Allows customization of the deployment. Except for exposing the deployment options (Juju model name, channel) also allows overwriting charm's default configuration.
- **terraform.tf** - Defines the Terraform provider.

## Deploying sdcore-control-plane-k8s module separately

### Pre-requisites

The following tools needs to be installed and should be running in the environment. 

- A Kubernetes cluster with the `Multus` and `Metallb` addon enabled.
- Juju 3.x
- Juju controller bootstrapped onto the K8s cluster
- Terraform

### Preparing deployment environment

Install MicroK8s and add your user to the snap_microk8s group:

```shell
sudo snap install microk8s --channel=1.27-strict/stable
sudo usermod -a -G snap_microk8s $USER
newgrp snap_microk8s
```

Add the community repository for Multus MicroK8s addon:

```shell
sudo microk8s addons repo add community https://github.com/canonical/microk8s-community-addons --reference feat/strict-fix-multus
```

Enable the `hostpath-storage`, `multus` and `metallb` MicroK8s addons.
```shell
sudo microk8s enable hostpath-storage
sudo microk8s enable multus
sudo microk8s enable metallb:10.0.0.2-10.0.0.3
```

Install Juju:

```shell
sudo snap install juju --channel=3.1/stable
```

Bootstrap a Juju controller:

```shell
juju bootstrap microk8s
```

### Deploying sdcore-control-plane-k8s with Terraform

Initialize the provider:

```console
terraform init
```

Create the `terraform.tfvars` file to specify the name of the Juju model to deploy to. Reusing already existing model is not recommended.

```yaml
# Mandatory Config Options
model_name = "put your model-name here"

# Customize the configuration variables here if needed
```

Create the Terraform Plan:

```console
terraform plan -var-file="terraform.tfvars" 
```

Deploy the resources:

```console
terraform apply -auto-approve 
```

### Check the Output

Run `juju switch <juju model>` to switch to the target Juju model and observe the status of the applications.

```console
juju status --relations
```

### Clean up

Destroy the deployment:

```console
terraform destroy -auto-approve
```

## Using sdcore-control-plane-k8s module in higher level modules

If you want to use `sdcore-control-plane-k8s` module as part of your Terraform module, import it like shown below:

```text
module "sdcore-control-plane" {
  source = "git::https://github.com/canonical/https://github.com/canonical/terraform-juju-sdcore-k8s//modules/sdcore-control-plane-k8s"
  
  model_name = "juju_model_name"
  (Customize configuration variables here if needed)
}
```

[Terraform]: https://www.terraform.io/
[Terraform Juju provider]: https://registry.terraform.io/providers/juju/juju/latest
[Juju]: https://juju.is
[sdcore-control-plane-k8s]: https://charmhub.io/sdcore-control-plane-k8s
