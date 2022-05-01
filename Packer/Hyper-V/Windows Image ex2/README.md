# Hashicorp Examples


## Packer
Examples of using Packer 

This example demo's how to use packer with Hyper V from a Windows ISO thats stored locally. This will deployan OS, downloadsysinternals, create a few directories, perform windows updates, cleanup the OS and then Sysprep it.

[Copying files into Image](https://www.packer.io/docs/provisioners/file)

[Template used from here "Github marcinbojko"](https://github.com/marcinbojko/hv-packer#hyper-v-generation-2-windows-server-20h2-standard-image)

build the image 

    packer build .\example.hcl



Scripts / Autounattend, unattend, bg file have all been added or modified since the initial prepreq on this 
