# Hashicorp Examples


## Packer
Examples of using Packer 

This example demo's how to deploy a simple Debian image in Azure.

get list of windows images from Debian publisher

    #az vm image list-skus --location uksouth --publisher Debian --offer debian-11 

[MS Guide to using Packer with a Linux Image](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer)

[MS Guide on using AZ CLI for querying images available](https://docs.microsoft.com/en-us/cli/azure/vm/image?view=azure-cli-latest#az-vm-image-list-skus)

### Note 
This these examples are using azure cli for demonstration purposes only whereas they should be using a Service Principle Name