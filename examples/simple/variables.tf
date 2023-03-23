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

variable "key_rotation_period" {
  description = "Rotation period in seconds to be used for KMS Keys"
  type        = string
  nullable    = false
  default     = 604800
}

variable "project_id" {
  description = "The Google project_id in which the resources will be created."
  type        = string
  nullable    = false
}
