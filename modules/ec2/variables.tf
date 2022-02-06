variable "instance_name" {
  description = "Instance name"
  default     = ""
}

variable "environment_name" {
  description = "The name of environment."
  default     = ""
}

variable "subnet_ids" {
  description = "The list of subnet."
  default     = []
  type        = list
}

variable "security_group_ids" {
  description = "The list of security group."
  default     = []
  type        = list
}
