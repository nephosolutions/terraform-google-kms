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
  description = "List of IAM principals to grant `roles/cloudkms.admin` on the keyring."
  type        = list(string)
  nullable    = false
  default     = []
}

variable "location" {
  description = "[Location](https://cloud.google.com/kms/docs/locations) for the keyring."
  type        = string
  nullable    = false
}

variable "name" {
  description = "Name for the keyring."
  type        = string
  nullable    = false
}

variable "project_id" {
  description = "Project ID where the keyring will be created."
  type        = string
  nullable    = false
}

variable "viewers" {
  description = "List of IAM principals to grant `roles/cloudkms.viewer` on the keyring."
  type        = list(string)
  nullable    = false
  default     = []
}
