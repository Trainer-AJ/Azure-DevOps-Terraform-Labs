---
lab:
    title: 'Terraform Meta Arguments'
    module: 'Module 6: Terraform Meta Arguments'
---
## Tasks:

## 1. Create Public IP for 3 Environments:

| Resource Group Name | Location | Public IP Name |
| --------| ------| -------| 
| prod | west us| ip-westus |
| dev | south india | ip-southindia |
| sit | uk south | ip-uksouth |

## 2. Add output block to get output like `ip-westus` => `20.13.8.9`

## 3. Add output block that `depends on` **azurerm_public_ip** resource 
