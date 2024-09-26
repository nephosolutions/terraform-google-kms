# Google KMS Keyring Terraform Module

Simple Cloud KMS module that allows managing a KMS keyring and IAM role bindings.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a KMS key ring
- Create IAM role bindings for admins and viewers

## Usage

```hcl
module "keyring" {
  source  = "nephosolutions/kms/google//modules/key_ring"
  version = "1.0.0"

  admins     = var.keyring_admins
  location   = var.location
  name       = var.keyring
  project_id = var.project_id
  viewers    = var.keyring_viewers
}
```

<!-- BEGIN_TF_DOCS -->
Copyright 2023 NephoSolutions srl, Sebastian Trebitz

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.53, < 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_kms_key_ring.key_ring](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring) | resource |
| [google_kms_key_ring_iam_binding.admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring_iam_binding) | resource |
| [google_kms_key_ring_iam_binding.viewers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_key_ring_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admins"></a> [admins](#input\_admins) | List of IAM principals to grant `roles/cloudkms.admin` on the keyring. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | [Location](https://cloud.google.com/kms/docs/locations) for the keyring. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name for the keyring. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID where the keyring will be created. | `string` | n/a | yes |
| <a name="input_viewers"></a> [viewers](#input\_viewers) | List of IAM principals to grant `roles/cloudkms.viewer` on the keyring. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The identifier of the KeyRing. |
| <a name="output_location"></a> [location](#output\_location) | The location of the KeyRing. |
| <a name="output_name"></a> [name](#output\_name) | The resource name for the KeyRing. |
| <a name="output_project"></a> [project](#output\_project) | The ID of the project in which the keyring belongs. |
<!-- END_TF_DOCS -->
