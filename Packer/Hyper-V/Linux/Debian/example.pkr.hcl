source "hyperv-iso" "vm" {


  iso_checksum          = "F8449B103C9FE9A4A80004D19046A4220B25DFAA532825F9F86A4D6B42DFA7F4"
  iso_url               = "./debian-10.10.0-amd64-DVD-1.iso"
  vm_name               = "Debian3"
  communicator          = "ssh"
  ssh_wait_timeout      = "1800s"
  ssh_password          = "vagrant"
  ssh_username          = "vagrant"
  enable_secure_boot    = "false"
  disk_block_size       = "1"
  disk_size             = "30000"
  cpus                  = "2"
  memory                = "4096"
  enable_dynamic_memory = "true"
  generation            = "1"
  guest_additions_mode  = "disable"
  switch_name           = "Ext"
  temp_path             = "."
  boot_wait             = "50s"
  http_directory= "http"
  boot_command = [
    "<esc><wait>",
    "auto <wait>",
    "auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
    "<enter><wait>"
]    
  shutdown_command      = "echo 'vagrant' | sudo -S shutdown -P now"
  shutdown_timeout      = "30m"
}
build {
  sources = ["source.hyperv-iso.vm"]
  provisioner "shell" {
    inline            = ["sleep 30","sudo apt-get update && sudo apt-get upgrade -y"]
  }

}

