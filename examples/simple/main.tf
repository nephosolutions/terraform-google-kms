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

data "google_storage_project_service_account" "gcs_account" {
  project = var.project_id
}

module "kms" {
  source = "../../"

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
