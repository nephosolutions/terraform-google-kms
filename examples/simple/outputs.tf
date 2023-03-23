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

output "keyring_id" {
  description = "The identifier of the KeyRing."
  value       = module.kms.keyring_id
}

output "keyring_name" {
  description = "The resource name for the KeyRing."
  value       = module.kms.keyring_name
}

output "location" {
  description = "The location of the KeyRing."
  value       = module.kms.location
}

output "project" {
  description = "The ID of the project in which the keyring belongs."
  value       = module.kms.project
}

output "crypto_key_ids" {
  description = "Map of key name => key self link."
  value       = module.kms.crypto_key_ids
}

output "crypto_key_purposes" {
  description = "Map of key name => key purpose."
  value       = module.kms.crypto_key_purposes
}
