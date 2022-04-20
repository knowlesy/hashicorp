#to login
az login
#sets subscription
az account set -s "aaaaaaaaaaaaaaa"


#build the image 
packer build .\example.json

#deploy / testing image 
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
    