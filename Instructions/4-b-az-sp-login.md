---
lab:
    title: 'Terraform authentication using Key Vault'
    module: 'Module 7: Variables in Azure Pipelines'
---

## Tasks:

## Pre-requisite
1. create storage account
```sh
az group create --name "az-devops-RG" --location "centralindia"
STR=backend$RANDOM
az storage account create -n $STR -g az-devops-RG -l centralindia --sku Standard_LRS
az storage container-rm create --storage-account $STR --name terraform
```

## 1. Create Service Principal in Azure
1. Open terminal of local computer, run the below command:
```sh
az ad sp create-for-rbac -n az-devops-key-vault --role Contributor --scopes /subscriptions/YOUR-SUBSCRIPTION-ID-HERE
``` 
![sp-create](../images/sp-create-az-cli.png)

2. Copy and Save the output in NOtepad .. You will need it

3. **Add service connection in azure devops project**

4. Go to Project settings => Left Side under Pipelines => Service COnnection
![](../images/create-service-connection-window.png)

5. Click on Create => Choose `Azure Resource Manager` Option

6. Choose `service principal (manual)`

![](../images/sp-connection-creation.png)

7. Enter your details and verify 

![](../images/verify-sp.png)

## 2. Create Key Vault in Azure
1. create it via cli
```sh
az keyvault create --location centralindia --name DevopsKeyvault-$RANDOM -g az-devops-RG
```
2. In the [Azure portal](https://portal.azure.com), navigate to the Key Vault resource. 

3.	Select **Access policies**, then select **Create**:

	![Select Access policies, selecting Add role assignment](https://learn.microsoft.com/en-us/azure/key-vault/media/authentication/assign-access-01.png)

4.	Select the permissions **GET** & **LIST** under  **Secret permissions**
	![Specifying access policy permissions](../images/get-list-kv.png)

5. Under the **Principal** selection pane, enter the name of service principal **az-devops-key-vault** in the search field and select the appropriate result.

	![Selecting the security principal for the access policy](../images/choose-sp-kv.png)

    If you're using a managed identity for the app, search for and select the name of the app itself. For more information on security principals, see [Key Vault authentication](authentication.md).
 
6.	Review the access policy changes and select **Create** to save the access policy.

	![Adding the access policy with the security principal assigned](../images/review-kv.png)

7. Back on the **Access policies** page, verify that your access policy is listed. 

	![Saving the access policy changes](../images/final-verification-kv.png)

8. create secrets in key-vault

a. Copy Azure storage key 

![](../images/stoarge-access-keys.png)

| name | Value |
| ------- | --------- |
|TENANT | AZURE TENANT ID|
|SP| APP ID OF SERVICE PRINCIPAL CREATED ABOVE |
|SECRET | PASSWORD OF SERVICE PRINCIPAL CREATED ABOVE |
| KEY | KEY1 OF STORAGE ACCOUNT CREATED ABOVE | 

b. Now Your key vault should like below:
![](../images/kv-with-all-secrest.png)

## 3. Add Variable Group with Key Vault 

/Codes/Pipelines/key-vault-multi-stage-vm-v1.yml



