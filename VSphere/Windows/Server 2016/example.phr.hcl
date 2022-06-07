surce "vsphere-iso" "Windows2016-vm" {
 boot_command              = ["a<enter><wait>a<enter><wait>a<enter><wait>a<enter>"]
  boot_wait                 = "2s"
  vm_name                   = "packer-windows2016"
  CPUs                      = 2
  RAM               	    = 4096
  disk_controller_type      = ["pvscsi"]
  storage {
    disk_size               = 80000
    disk_thin_provisioned   = true
  }
	firmware                = "efi"
  network_adapters {
        network             = "Packer_Network"
        network_card        = "vmxnet3"
  }
  iso_checksum              = "3CBA4A103DD9D90246B77544426120078B8F79D93CDB920E4C92F340622889BE"
  cdrom_type                = "sata"
  iso_paths = [
                            "[XYZ-SANVolume] iso/2016.iso",
                            "[XYZ-SANVolume iso/secondary.iso",
                            "[] /vmimages/tools-isoimages/windows.iso"]
  remove_cdrom              = "true"
  shutdown_timeout          = "30m"
  communicator              = "winrm"
  winrm_password            = "password"
  winrm_timeout             = "8h"
  winrm_username            = "Administrator"
  
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
  
  

  guest_os_type 		    = "windows9Server64Guest"
  tools_upgrade_policy      = "true"
  
  
    // Template and Content Library Settings
  convert_to_template       = "false"

}

build {
  sources                   = ["source.vsphere-iso.Windows2016-vm"]

  

}