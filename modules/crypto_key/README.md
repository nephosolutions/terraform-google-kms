# Google KMS Crypto Key Terraform Module

Simple Cloud KMS module that allows managing KMS crypto keys in a keyring, and IAM role bindings on the individual key.

The resources/services/activations/deletions that this module will create/trigger are:

- Create a KMS crypto key
- Create IAM role bindings for admins, encrypters, decrypters and viewers

## Usage

```hcl
module "crypto_key" {
  source  = "nephosolutions/kms/google//modules/crypto_key"
  version = "1.0.0"

  for_each = var.crypto_keys

  keyring_id = module.keyring.id
  name       = each.key
  labels     = var.labels

  key_algorithm        = var.crypto_key_algorithm
  key_protection_level = var.crypto_key_protection_level
  prevent_destroy      = var.prevent_destroy
  purpose              = var.purpose
  rotation_period      = var.rotation_period

  admins     = var.crypto_key_admins
  decrypters = var.crypto_key_decrypters
  encrypters = var.crypto_key_encrypters
  viewers    = var.crypto_key_viewers
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.53, < 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_kms_crypto_key.key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key.key_ephemeral](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key) | resource |
| [google_kms_crypto_key_iam_binding.admin](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_binding) | resource |
| [google_kms_crypto_key_iam_binding.decrypters](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_binding) | resource |
| [google_kms_crypto_key_iam_binding.encrypters](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_binding) | resource |
| [google_kms_crypto_key_iam_binding.viewers](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admins"></a> [admins](#input\_admins) | List of IAM principals to grant `roles/cloudkms.admin` on the key. | `list(string)` | `[]` | no |
| <a name="input_decrypters"></a> [decrypters](#input\_decrypters) | List of IAM principals to grant `roles/cloudkms.cryptoKeyDecrypter` on the key. | `list(string)` | `[]` | no |
| <a name="input_encrypters"></a> [encrypters](#input\_encrypters) | List of IAM principals to grant `roles/cloudkms.cryptoKeyEncrypter` on the key. | `list(string)` | `[]` | no |
| <a name="input_key_algorithm"></a> [key\_algorithm](#input\_key\_algorithm) | The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs. | `string` | `"GOOGLE_SYMMETRIC_ENCRYPTION"` | no |
| <a name="input_key_protection_level"></a> [key\_protection\_level](#input\_key\_protection\_level) | The protection level to use when creating a version based on this template. Default value: "SOFTWARE" Possible values: ["SOFTWARE", "HSM"] | `string` | `"SOFTWARE"` | no |
| <a name="input_keyring_id"></a> [keyring\_id](#input\_keyring\_id) | The KeyRing that this key belongs to. | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels, provided as a map | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the keyring. | `string` | n/a | yes |
| <a name="input_prevent_destroy"></a> [prevent\_destroy](#input\_prevent\_destroy) | Set the prevent\_destroy lifecycle attribute on the key. | `bool` | `true` | no |
| <a name="input_purpose"></a> [purpose](#input\_purpose) | The immutable purpose of this CryptoKey. See the [purpose reference](https://cloud.google.com/kms/docs/reference/rest/v1/projects.locations.keyRings.cryptoKeys#CryptoKeyPurpose) for possible inputs. | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_rotation_period"></a> [rotation\_period](#input\_rotation\_period) | Every time this period passes, generate a new CryptoKeyVersion and set it as the primary. The first rotation will take place after the specified period. The rotation period has the format of a decimal number with up to 9 fractional digits. It must be greater than a day (ie, 86400). | `number` | `2592000` | no |
| <a name="input_viewers"></a> [viewers](#input\_viewers) | List of IAM principals to grant `roles/cloudkms.viewer` on the key. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The identifier of the KeyRing. |
| <a name="output_key_ring"></a> [key\_ring](#output\_key\_ring) | The location of the KeyRing. |
| <a name="output_name"></a> [name](#output\_name) | The resource name for the KeyRing. |
| <a name="output_purpose"></a> [purpose](#output\_purpose) | The ID of the project in which the keyring belongs. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
