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

resource "google_kms_crypto_key" "key" {
  count = var.prevent_destroy ? 1 : 0

  name            = var.name
  key_ring        = var.keyring_id
  labels          = var.labels
  purpose         = var.purpose
  rotation_period = "${var.rotation_period}s"

  lifecycle {
    prevent_destroy = true
  }

  version_template {
    algorithm        = var.key_algorithm
    protection_level = var.key_protection_level
  }
}

resource "google_kms_crypto_key" "key_ephemeral" {
  count = var.prevent_destroy ? 0 : 1

  name            = var.name
  key_ring        = var.keyring_id
  labels          = var.labels
  purpose         = var.purpose
  rotation_period = "${var.rotation_period}s"

  lifecycle {
    prevent_destroy = false
  }

  version_template {
    algorithm        = var.key_algorithm
    protection_level = var.key_protection_level
  }
}

resource "google_kms_crypto_key_iam_binding" "admin" {
  crypto_key_id = try(google_kms_crypto_key.key[0].id, google_kms_crypto_key.key_ephemeral[0].id)
  role          = "roles/cloudkms.admin"
  members       = var.admins
}

resource "google_kms_crypto_key_iam_binding" "decrypters" {
  crypto_key_id = try(google_kms_crypto_key.key[0].id, google_kms_crypto_key.key_ephemeral[0].id)
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  members       = var.decrypters
}

resource "google_kms_crypto_key_iam_binding" "encrypters" {
  crypto_key_id = try(google_kms_crypto_key.key[0].id, google_kms_crypto_key.key_ephemeral[0].id)
  role          = "roles/cloudkms.cryptoKeyEncrypter"
  members       = var.encrypters
}

resource "google_kms_crypto_key_iam_binding" "viewers" {
  crypto_key_id = try(google_kms_crypto_key.key[0].id, google_kms_crypto_key.key_ephemeral[0].id)
  role          = "roles/cloudkms.viewer"
  members       = var.viewers
}
