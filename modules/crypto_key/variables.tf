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

/**
 * Copyright 2023 NephoSolutions srl
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "admins" {
  description = "List of IAM principals to grant `roles/cloudkms.admin` on the key."
  type        = list(string)
  nullable    = false
  default     = []
}

variable "decrypters" {
  description = "List of IAM principals to grant `roles/cloudkms.cryptoKeyDecrypter` on the key."
  type        = list(string)
  nullable    = false
  default     = []
}

variable "encrypters" {
  description = "List of IAM principals to grant `roles/cloudkms.cryptoKeyEncrypter` on the key."
  type        = list(string)
  nullable    = false
  default     = []
}

variable "key_algorithm" {
  type        = string
  description = "The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs."
  nullable    = false
  default     = "GOOGLE_SYMMETRIC_ENCRYPTION"
}

variable "key_protection_level" {
  type        = string
  description = "The protection level to use when creating a version based on this template. Default value: \"SOFTWARE\" Possible values: [\"SOFTWARE\", \"HSM\"]"
  nullable    = false
  default     = "SOFTWARE"
}

variable "keyring_id" {
  description = "The KeyRing that this key belongs to."
  type        = string
  nullable    = false
}

variable "labels" {
  type        = map(string)
  description = "Labels, provided as a map"
  default     = {}
}

variable "name" {
  description = "Name for the keyring."
  type        = string
  nullable    = false
}

variable "prevent_destroy" {
  description = "Set the prevent_destroy lifecycle attribute on the key."
  type        = bool
  nullable    = false
  default     = true
}

variable "purpose" {
  description = "The immutable purpose of this CryptoKey. See the [purpose reference](https://cloud.google.com/kms/docs/reference/rest/v1/projects.locations.keyRings.cryptoKeys#CryptoKeyPurpose) for possible inputs."
  type        = string
  nullable    = false
  default     = "ENCRYPT_DECRYPT"

  validation {
    condition     = contains(["ENCRYPT_DECRYPT", "ASYMMETRIC_SIGN", "ASYMMETRIC_DECRYPT", "MAC"], var.purpose)
    error_message = "Not a valid purpose."
  }
}

variable "rotation_period" {
  description = "Every time this period passes, generate a new CryptoKeyVersion and set it as the primary. The first rotation will take place after the specified period. The rotation period has the format of a decimal number with up to 9 fractional digits. It must be greater than a day (ie, 86400)."
  type        = number
  nullable    = false
  default     = 2592000

  validation {
    condition     = var.rotation_period >= 86400 && var.rotation_period < 1000000000
    error_message = "Invalid retention period. Must be grater or equal then 86400 and smaller then 1000000000."
  }
}

variable "viewers" {
  description = "List of IAM principals to grant `roles/cloudkms.viewer` on the key."
  type        = list(string)
  nullable    = false
  default     = []
}
