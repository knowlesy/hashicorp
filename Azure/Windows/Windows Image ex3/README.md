# Hashicorp Examples


## Packer
Examples of using Packer 

This example demo's how to upgrade a packer json file to a packer hcl file 

Upgrade template to HCL

    cd <folder containing packer template>
    packer hcl2_upgrade .\example.json

You may need to rename the file after this for example my orginal file was ***"example.json.pkr.hcl"*** so I updated to ***"example.pkr.hcl"***

[Packer Azure VS Code Extension NOT OFFICIAL](https://marketplace.visualstudio.com/items?itemName=4ops.packer&ssr=false#overview)

[HCL update documentation](https://www.packer.io/docs/commands/hcl2_upgrade)

[Packer Template documentation 1.7](https://www.packer.io/guides/1.7-template-upgrade)

### Note 
This these examples are using azure cli for demonstration purposes only whereas they should be using a Service Principle Name