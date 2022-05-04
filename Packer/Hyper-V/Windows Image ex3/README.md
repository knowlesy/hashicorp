# Hashicorp Examples


## Packer
Examples of using Packer 

This is examples of using variables internal to the config file, passing via the command line and via a variable file 

[Youtube Guide](https://youtu.be/XuyKg85lMYM)

[Packer Documentation on Variables](https://www.packer.io/docs/templates/hcl_templates/blocks/variable)

build the image 

    packer init .\example.pkr.hcl

    packer build -var-file="variables.pkrvars.hcl" -var "disksize=80000" .\example.pkr.hcl



Scripts / Autounattend, unattend, bg file have all been added or modified since the initial prepreq on this 
