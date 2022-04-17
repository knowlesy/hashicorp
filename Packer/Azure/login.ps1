#ref
#https://docs.microsoft.com/en-us/azure/virtual-machines/windows/cli-ps-findimage
#https://www.packer.io/plugins/builders/azure/arm
#https://youtu.be/JzFS8l0xNRQ
#https://docs.microsoft.com/en-gb/cli/azure/query-azure-cli
#https://github.com/hashicorp/packer-plugin-azure/tree/main/example
#https://docs.microsoft.com/en-us/azure/virtual-machines/windows/build-image-with-packer

az login

az account set -s "aaaaaaaaaaaaaaa"

#get list of windows images from ms publisher
az vm image list-offers --location uksouth --publisher MicrosoftWindowsServer


#filter to just one image demoign queries
az vm image list-offers --location uksouth --publisher MicrosoftWindowsServer --query "[? contains(name, 'WindowsServer') && ! contains(name, 'WindowsServerSemiAnnual')]"

$Username = "MyUser"
$Password = 'Password123!' | ConvertTo-SecureString -Force -AsPlainText
$Credential = New-Object -TypeName PSCredential -ArgumentList ($Username, $Password)
#$Credential = Get-Credential
New-AzVm `
    -ResourceGroupName rg-packer `
    -Name "myVM" `
    -Location uksouth `
    -VirtualNetworkName "myVnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "myNetworkSecurityGroup" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 3389 `
    -Image "Windows_test_packer_image" `
    -Credential $Credential
    