# Copyright 2023 NephoSolutions srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "crypto_keys" {
  type = set(string)
}

variable "crypto_key_admins" {
  description = "List of IAM principals to grant `roles/cloudkms.admin` on the key."
  type        = map(list(string))
  default     = {}
}

variable "crypto_key_decrypters" {
  description = "List of IAM principals to grant `roles/cloudkms.cryptoKeyDecrypter` on the key."
  type        = map(list(string))
  default     = {}
}

variable "crypto_key_encrypters" {
  description = "List of IAM principals to grant `roles/cloudkms.cryptoKeyEncrypter` on the key."
  type        = map(list(string))
  default     = {}
}

variable "crypto_key_algorithm" {
  type        = string
  description = "The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs."
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
}

variable "crypto_key_protection_level" {
  type        = string
  description = "The protection level to use when creating a version based on this template. Default value: \"SOFTWARE\" Possible values: [\"SOFTWARE\", \"HSM\"]"
  default     = "SOFTWARE"
}

variable "crypto_key_viewers" {
  description = "List of IAM principals to grant `roles/cloudkms.viewer` on the key."
  type        = map(list(string))
  default     = {}
}

variable "keyring" {
  description = "Name for the keyring."
  type        = string
}

variable "keyring_admins" {
  description = "List of IAM principals to grant `roles/cloudkms.admin` on the keyring."
  type        = list(string)
  default     = []
}

variable "keyring_viewers" {
  description = "List of IAM principals to grant `roles/cloudkms.viewer` on the keyring."
  type        = list(string)
  default     = []
}

variable "labels" {
  type        = map(string)
  description = "Labels, provided as a map"
  default     = {}
}

variable "location" {
  description = "[Location](https://cloud.google.com/kms/docs/locations) for the keyring."
  type        = string
}

variable "prevent_destroy" {
  description = "Set the prevent_destroy lifecycle attribute on the keys."
  type        = bool
  default     = true
}

variable "project_id" {
  description = "Project ID where the keyring will be created."
  type        = string
}

variable "purpose" {
  description = "The immutable purpose of the CryptoKeys. See the [purpose reference](https://cloud.google.com/kms/docs/reference/rest/v1/projects.locations.keyRings.cryptoKeys#CryptoKeyPurpose) for possible inputs."
  type        = string
  default     = "ENCRYPT_DECRYPT"

  validation {
    condition     = contains(["ENCRYPT_DECRYPT", "ASYMMETRIC_SIGN", "ASYMMETRIC_DECRYPT", "MAC"], var.purpose)
    error_message = "Not a valid purpose."
  }
}

variable "rotation_period" {
  description = "Every time this period passes, generate a new CryptoKeyVersion and set it as the primary. The first rotation will take place after the specified period. The rotation period has the format of a decimal number with up to 9 fractional digits. It must be greater than a day (ie, 86400)."
  type        = number
  default     = 2592000

  validation {
    condition     = var.rotation_period >= 86400 && var.rotation_period < 1000000000
    error_message = "Invalid retention period. Must be grater or equal then 86400 and smaller then 1000000000."
  }
}
