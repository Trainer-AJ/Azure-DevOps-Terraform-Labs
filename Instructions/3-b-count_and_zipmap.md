---
lab:
    title: 'Terraform Meta Arguments - Count and ZipMap functions'
    module: 'Module 6: Terraform Meta Arguments'
---

## Tasks:

## 1. Specify Azure Regions as Variables to use `count` meta-argument
## 2. Create a 3 Public IP in "EastUS", "central India", "West Europe" respectively uaing `Count`
## 3. Use Zipmap Function to get output as: 
```tf
ip = {
      + terraform-ip-0 = (known after apply)
      + terraform-ip-1 = (known after apply)
      + terraform-ip-2 = (known after apply)
    }
```

## Instructions 
**Check `Terraform Code` [here](../Codes/ip/main.tf)** 
