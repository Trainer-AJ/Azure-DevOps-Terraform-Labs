---
lab:
    title: 'Get Started with Azure DevOps & Boards'
    module: 'Module 1: Azure DevOps basics'
---
## Tasks
1. **Create Azure DevOps Organisation and an Agile Project**
2. **Add Users to Azure DevOps Project**
3. **Create a work item**

## Instructions:
## 1. Create Azure DevOps Organisation 
## 2. Create the Azure DevOps Project 
## 3. Add Users to Project
## 4. Create work item 

### Exercise 0: Configure the lab prerequisites

> **Note**: make sure you completed the steps to create your Azure DevOps Organization before continuing with these steps.

In this exercise, you will set up the prerequisites for the lab, which consist of a new Azure DevOps project with a repository based on the [AJ's Github](https://github.com/Trainer-AJ/Azure-DevOps-Terraform-Labs).

#### Task 1:  Create and configure the team project

In this task, you will create an **Azure-DevOps-Terraform-Labs** Azure DevOps project to be used by several labs.

1. On your lab computer, in a browser window open your Azure DevOps organization. Click on **New Project**. Give your project the following settings:
    - name: **Azure-DevOps-Terraform-Labs**
    - visibility: **Private**
    - Advanced: Version Control: **Git**
    - Advanced: Work Item Process: **Agile**

2. Click **Create**.

    ![Create Project](../images/create-project.png)

#### Task 2:  Import Azure-DevOps-Terraform-Labs Git Repository

In this task you will import the Azure-DevOps-Terraform-Labs Git repository that will be used by several labs.

1. On your lab computer, in a browser window open your Azure DevOps organization and the previously created **Azure-DevOps-Terraform-Labs** project. Click on **Repos>Files** , **Import a Repository**. Select **Import**. On the **Import a Git Repository** window, paste the following URL https://github.com/Trainer-AJ/Azure-DevOps-Terraform-Labs.git  and click **Import**:

    ![Import Repository](../images/import-repo.png)
   
[MS Docs](https://learn.microsoft.com/en-us/azure/devops/organizations/accounts/create-organization?toc=%2Fazure%2Fdevops%2Fget-started%2Ftoc.json&view=azure-devops#create-an-organization)

