# Hashicorp Examples


## Packer
Examples of using Packer 

This example demo's how to perform a windows update to the image

initialize the template 

    packer init .\example.pkr.hcl

build the image 

    packer build .\example.pkr.hcl

[Windows update plugin](https://github.com/rgl/packer-plugin-windows-update)


### Note 
This these examples are using azure cli for demonstration purposes only whereas they should be using a Service Principle Name