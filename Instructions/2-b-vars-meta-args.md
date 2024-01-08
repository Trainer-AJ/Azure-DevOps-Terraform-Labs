---
lab:
    title: 'Terraform Variables and Meta Arguments Intro'
    module: 'Module: 4'
---
## Tasks:
1. **Create Azure Resource Groups using Variables**
   
| Resource group Name | Location | Tag | Variable to Specify | Data Type | Takes Value From |
| ------------------| --------| ------|----|---|--|
| Dev-RG-1 | East US| Env = Dev | location | STRING | command line |
| UAT-RG-1| West Europe| Env = UAT | location | STRING | Default Value |
| Map-RG | West Europe | | Name, Location | Map | tfvars file |
| List-RG | East US | | Name, Location | List | Custom Tfvars FIle |

2. **[Optional] Create 3 diffrent Azure Resource Groups in 3 locations - "East US", "Central India", "South India" respectively**

## Instructions:
1. The Terraform code is [here](../Codes/2-vars-meta-args.tf)
