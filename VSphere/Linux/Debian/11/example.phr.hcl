source "vsphere-iso" "Deb11-vm" {

  vm_name              = "packer-debian11"
  CPUs                 = 2
  RAM                  = 4096
  guest_os_type        = "debian10_64Guest"
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size             = 20000
    disk_thin_provisioned = true
  }
  firmware = "bios"
  network_adapters {
    network      = "Build"
    network_card = "vmxnet3"
  }
  http_directory = "http"
  cdrom_type = "sata"
  iso_checksum   = "99A532675EC9733C277A3F4661638B5471DC5BCE989B3A2DBC3AC694C964A7F7"
  iso_paths = ["[XYZ-SANVolume] iso/debian-11.5.0-amd64-DVD-1.iso"]
  remove_cdrom = "true"
  boot_wait    = "2s"
  boot_command = [
    "<esc><wait>",
    "auto <wait>",
    "netcfg/disable_autoconfig=true ",
    "netcfg/use_autoconfig=false ",
    "netcfg/get_ipaddress=192.168.90.11 ",
    "netcfg/get_netmask=255.255.255.0 ",
    "netcfg/get_gateway=192.168.90.1 ",
    "netcfg/get_nameservers=192.168.90.1 ",
    "netcfg/confirm_static=true <wait>",
    "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}//preseed.cfg <wait>",
    "<enter><wait>"
  ]
  shutdown_timeout = "30m"
  communicator     = "ssh"

  ssh_password = "vagrant"
  ssh_username = "vagrant"

  // vCenter Server Endpoint Settings and Credentials
  vcenter_server            = "192.168.1.10
  username                  = "test.user@test.com"
  password                  = "Password1#"
  insecure_connection       = true

  // vSphere Settings
  datacenter                = "DC-NAME"
  cluster                   = "XYZCluster"
  datastore                 = "XYZ-SANVolume"
  folder                    = "Images"

  // Template and Content Library Settings
  convert_to_template = "true"

}

build {
  sources = ["source.vsphere-iso.Deb11-vm"]

}