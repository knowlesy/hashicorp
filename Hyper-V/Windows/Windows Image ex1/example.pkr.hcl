
variable "disk_size" {
  type    = string
  default = ""
}

variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_checksum_type" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "output_directory" {
  type    = string
  default = ""
}

variable "output_vagrant" {
  type    = string
  default = ""
}

variable "secondary_iso_image" {
  type    = string
  default = ""
}

variable "switch_name" {
  type    = string
  default = ""
}

variable "sysprep_unattended" {
  type    = string
  default = ""
}


variable "vagrantfile_template" {
  type    = string
  default = ""
}

variable "upgrade_timeout" {
  type    = string
  default = ""
}

variable "vagrant_sysprep_unattended" {
  type    = string
  default = ""
}

variable "vlan_id" {
  type    = string
  default = ""
}

variable "vm_name" {
  type    = string
  default = ""
}

source "hyperv-iso" "vm" {
  boot_command          = ["a<enter><wait>a<enter><wait>a<enter><wait>a<enter>"]
  boot_wait             = "1s"
  communicator          = "winrm"
  cpus                  = 4
  disk_size             = "80000"
  enable_dynamic_memory = "true"
  enable_secure_boot    = false
  generation            = 2
  guest_additions_mode  = "disable"
  iso_checksum          = "5140AC5FB8F48EFDF4BFCF1E7BE14030F9164A824F12A9D08A45CDC72DAC8D15"
  iso_url               = "./2022.iso"
  memory                = 4096
  secondary_iso_images  = ["./secondary.iso"]
  shutdown_timeout      = "30m"
  skip_export           = true
  switch_name           = "External"
  temp_path             = "."
  
  vm_name               = "packer-windows2022dc-g2"
  winrm_password        = "password"
  winrm_timeout         = "8h"
  winrm_username        = "Administrator"
}

build {
  sources = ["source.hyperv-iso.vm"]

  

}