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

module "keyring" {
  source = "./modules/key_ring"

  admins     = var.keyring_admins
  location   = var.location
  name       = var.keyring
  project_id = var.project_id
  viewers    = var.keyring_viewers
}

module "crypto_key" {
  source   = "./modules/crypto_key"
  for_each = var.crypto_keys

  keyring_id = module.keyring.id
  name       = each.key
  labels     = var.labels

  key_algorithm        = var.crypto_key_algorithm
  key_protection_level = var.crypto_key_protection_level
  prevent_destroy      = var.prevent_destroy
  purpose              = var.purpose
  rotation_period      = var.rotation_period

  admins     = lookup(var.crypto_key_admins, each.key, null)
  decrypters = lookup(var.crypto_key_decrypters, each.key, null)
  encrypters = lookup(var.crypto_key_encrypters, each.key, null)
  viewers    = lookup(var.crypto_key_viewers, each.key, null)
}
