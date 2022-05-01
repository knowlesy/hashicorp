packer {
  required_plugins {
    windows-update = {
      version = "0.14.0"
      source = "github.com/rgl/windows-update"
    }
  }
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



    provisioner "windows-update" {
    filters         = ["exclude:$_.Title -like '*Preview*'", "include:$true"]
    search_criteria = "IsInstalled=0"
    update_limit    = 25
  }
    provisioner "powershell" {
    script = "script.ps1"
  }
  provisioner "file"{
    source = "bginfo-config.bgi"
    destination = "c:/support/key/"
  }
    provisioner "file"{
    source = "Bginfo.lnk"
    destination = "C:/ProgramData/Microsoft/Windows/Start Menu/Programs/Startup/"
  }
    provisioner "file"{
    source = "unattend.xml"
    destination = "C:/Windows/System32/Sysprep/"
  }
provisioner "powershell" {
inline = ["Write-Output Sysprep", "C:/Windows/system32/Sysprep/sysprep.exe /generalize /oobe /mode:vm /unattend:C:/Windows/System32/Sysprep/unattend.xml"]
 
  }

}