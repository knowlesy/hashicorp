#https://github.com/robertmircea/packer-collections/blob/master/scripts/
Install-WindowsFeature -Name FS-Resource-Manager -IncludeManagementTools
New-Item -Path "c:\" -Name "temp" -ItemType "directory"
