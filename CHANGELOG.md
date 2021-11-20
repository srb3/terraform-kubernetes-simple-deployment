# Changelog

## 0.0.7

🆕 New features:

- Added the ability to attach empty volume mounts to deployments

  ([PR #7](https://github.com/srb3/terraform-kubernetes-simple-deployment/pull/7))

## 0.0.6

💥 Breaking changes:

- Replaced extra_labels variable with deployment_labels, value of deployment labels
  is no longer merged with the deployment name and the app key

  ([PR #6](https://github.com/srb3/terraform-kubernetes-simple-deployment/pull/6))

## 0.0.5

🆕 New features:

- Added service_name, image_args, service_selector_labels and image_name options

  ([PR #5](https://github.com/srb3/terraform-kubernetes-simple-deployment/pull/5))

## 0.0.4

🆕 New features:

- Made service creation optional, added a no service example

  ([PR #4](https://github.com/srb3/terraform-kubernetes-simple-deployment/pull/4))

## 0.0.3

🆕 New features:

- Added option to pass labels to the deployment

  ([PR #3](https://github.com/srb3/terraform-kubernetes-simple-deployment/pull/3))

## 0.0.2

🔧 Fixes:

- Removed minikube metallb and ingress setup steps from pr workflow

  ([PR #2](https://github.com/srb3/terraform-kubernetes-simple-deployment/pull/2))

## 0.0.1

🆕 New features:

- repo created, examples added, make file created for
  running a test deployment

  CHANGELOG and CONTRIBUTING added.

  ([PR #1](https://github.com/srb3/terraform-kubernetes-simple-deployment/pull/1))
