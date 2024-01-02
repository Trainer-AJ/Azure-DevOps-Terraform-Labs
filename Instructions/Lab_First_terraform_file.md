---
lab:
    title: 'IaC With Terraform'
    module: 'Module 2: Terraform basics'
---

# Lab Requirements:
Follow [Lab-1](https://trainer-aj.github.io/Azure-DevOps-Terraform-Labs/Instructions/0-Lab_Setup_Env.html) to setup things. 

# Lab Task:
1. **Authenticate Terraform to Azure using service principal**
2. **Create two Azure Resource Groups:**
   
| Resource group Name | Location | Tag |
| ------------------| --------| ------|
| Dev-RG-1 | East US| Env = Dev |
| UAT-RG-1| West Europe| Env = UAT |

3. **Verify In Azure Portal** 
4. **Destroy The Resources**
5. **(OPTIONAL) Repeat same process by AUTHENTICATING USING AZURE CLI to Replace the hard Coded Values of secret values.**

## Instructions
### 1. Authenticate Terraform to Azure using service principal
1. Open terminal and verify Azure CLI installation using : `az --version`
2. Run `az login` command
3. Create a service Principal In Azure Using below Command:
```sh
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/Your-Subscription-ID-Here" > creds.txt
```
4. Open the Newly created `creds.txt` file to see your credentials.
   
### 2. Create two Azure Resource Groups:

### 3. Verify In Azure Portal 
1. Login to `https://portal.azure.com/`
2. Search for Resource Groups
3. Verify The Creation of resources by Terraform 

### 4. Destroy The Resources
```sh
terraform destroy --auto-approve
```

### 5. (OPTIONAL) AUTHENTICATING USING AZURE CLI
- DO IT YOURSELF :)
- This helps you to research and reflect back on your learnings






