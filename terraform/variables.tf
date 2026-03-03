variable "location" {
  type    = string
  default = "westus3"
}

variable "project_name" {
  type    = string
  default = "zt-sentinel-lab"
}

variable "admin_username" {
  type    = string
  default = "azureadmin"
}

# Your public IP for RDP allowlist (recommended)
# Example: "203.0.113.10/32"
variable "allowed_rdp_cidr" {
  type        = string
  description = "CIDR allowed to RDP (TCP/3389) to the VM."
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s_v2"
}