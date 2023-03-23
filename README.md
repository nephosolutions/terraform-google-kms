# Google KMS Terraform Module

Simple Cloud KMS module that allows managing a keyring, zero or more keys in the keyring, and IAM role bindings on individual keys.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a KMS keyring in the provided project
- Create zero or more keys in the keyring
- Create IAM role bindings for owners, encrypters, decrypters

## Usage

```hcl
data "google_storage_project_service_account" "gcs_account" {
  project = var.project_id
}

module "kms" {
  source  = "nephosolutions/kms/google"
  version = "1.0.0"

  project_id = data.google_storage_project_service_account.gcs_account.project
  keyring    = "kr-example"
  location   = "europe"

  crypto_keys     = ["cmek-example"]
  rotation_period = var.key_rotation_period

  crypto_key_encrypters = { cmek-example = [
    "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
  ] }

  crypto_key_decrypters = { cmek-example = [
    "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
  ] }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.53, < 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_crypto_key"></a> [crypto\_key](#module\_crypto\_key) | ./modules/crypto_key | n/a |
| <a name="module_keyring"></a> [keyring](#module\_keyring) | ./modules/key_ring | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_crypto_key_admins"></a> [crypto\_key\_admins](#input\_crypto\_key\_admins) | List of IAM principals to grant `roles/cloudkms.admin` on the key. | `map(list(string))` | `{}` | no |
| <a name="input_crypto_key_algorithm"></a> [crypto\_key\_algorithm](#input\_crypto\_key\_algorithm) | The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs. | `string` | `"GOOGLE_SYMMETRIC_ENCRYPTION"` | no |
| <a name="input_crypto_key_decrypters"></a> [crypto\_key\_decrypters](#input\_crypto\_key\_decrypters) | List of IAM principals to grant `roles/cloudkms.cryptoKeyDecrypter` on the key. | `map(list(string))` | `{}` | no |
| <a name="input_crypto_key_encrypters"></a> [crypto\_key\_encrypters](#input\_crypto\_key\_encrypters) | List of IAM principals to grant `roles/cloudkms.cryptoKeyEncrypter` on the key. | `map(list(string))` | `{}` | no |
| <a name="input_crypto_key_protection_level"></a> [crypto\_key\_protection\_level](#input\_crypto\_key\_protection\_level) | The protection level to use when creating a version based on this template. Default value: "SOFTWARE" Possible values: ["SOFTWARE", "HSM"] | `string` | `"SOFTWARE"` | no |
| <a name="input_crypto_key_viewers"></a> [crypto\_key\_viewers](#input\_crypto\_key\_viewers) | List of IAM principals to grant `roles/cloudkms.viewer` on the key. | `map(list(string))` | `{}` | no |
| <a name="input_crypto_keys"></a> [crypto\_keys](#input\_crypto\_keys) | n/a | `set(string)` | n/a | yes |
| <a name="input_keyring"></a> [keyring](#input\_keyring) | Name for the keyring. | `string` | n/a | yes |
| <a name="input_keyring_admins"></a> [keyring\_admins](#input\_keyring\_admins) | List of IAM principals to grant `roles/cloudkms.admin` on the keyring. | `list(string)` | `[]` | no |
| <a name="input_keyring_viewers"></a> [keyring\_viewers](#input\_keyring\_viewers) | List of IAM principals to grant `roles/cloudkms.viewer` on the keyring. | `list(string)` | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels, provided as a map | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | [Location](https://cloud.google.com/kms/docs/locations) for the keyring. | `string` | n/a | yes |
| <a name="input_prevent_destroy"></a> [prevent\_destroy](#input\_prevent\_destroy) | Set the prevent\_destroy lifecycle attribute on the keys. | `bool` | `true` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID where the keyring will be created. | `string` | n/a | yes |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | The immutable purpose of the CryptoKeys. See the [purpose reference](https://cloud.google.com/kms/docs/reference/rest/v1/projects.locations.keyRings.cryptoKeys#CryptoKeyPurpose) for possible inputs. | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_rotation_period"></a> [rotation\_period](#input\_rotation\_period) | Every time this period passes, generate a new CryptoKeyVersion and set it as the primary. The first rotation will take place after the specified period. The rotation period has the format of a decimal number with up to 9 fractional digits. It must be greater than a day (ie, 86400). | `number` | `2592000` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_crypto_key_ids"></a> [crypto\_key\_ids](#output\_crypto\_key\_ids) | Map of key name => key self link. |
| <a name="output_crypto_key_purposes"></a> [crypto\_key\_purposes](#output\_crypto\_key\_purposes) | Map of key name => key purpose. |
| <a name="output_keyring_id"></a> [keyring\_id](#output\_keyring\_id) | The identifier of the KeyRing. |
| <a name="output_keyring_name"></a> [keyring\_name](#output\_keyring\_name) | The resource name for the KeyRing. |
| <a name="output_location"></a> [location](#output\_location) | The location of the KeyRing. |
| <a name="output_project"></a> [project](#output\_project) | The ID of the project in which the keyring belongs. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
