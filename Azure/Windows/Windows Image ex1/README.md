# Hashicorp Examples


## Packer
Examples of using Packer 

This example demo's how to deploy a simple image in Azure.


get list of windows images from ms publisher

    az vm image list-offers --location uksouth --publisher MicrosoftWindowsServer


filter to just one image demoing queries

    az vm image list-offers --location uksouth --publisher MicrosoftWindowsServer --query "[? contains(name, 'WindowsServer') && ! contains(name, 'WindowsServerSemiAnnual')]"


### Note 
This these examples are using azure cli for demonstration purposes only whereas they should be using a Service Principle Name