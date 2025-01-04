# Azure-DevOps-Terraform-Labs

### [Labs Link](https://trainer-aj.github.io/Azure-DevOps-Terraform-Labs/Instructions/3-a-pipelne_agent_installation.html)

### [Check all Important Links to revise here](imp-links.md)

[We recommend using either a Service Principal or Managed Service Identity when running Terraform non-interactively (such as when running Terraform in a CI server) - and authenticating using the Azure CLI when running Terraform locally](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_oidc)

# IMPORTANT ⚠️
- You need a remote backend as each new commit triggers new pipeline...
- so it will go crazy saying import resources to terraform (no state file ... TF can't maintain previously created resources via terraform) !
- Use below Pre-Commit Hook to Avoid Pushing Your Secrets:
```sh
#!/bin/bash

# Pre-commit hook to replace sensitive values in all Terraform configurations with "YOUR-VALUES-HERE"

# Find all Terraform configuration files in the repository
terraform_files=$(find . -name '*.tf')

# Define the values to be replaced
replace_values=(
    "client_id"
    "client_secret"
    "tenant_id"
    "subscription_id"
)

# Replace each sensitive value with "YOUR-VALUES-HERE" in all Terraform files
for file in ${terraform_files}; do
    for value in "${replace_values[@]}"; do
        sed -i -E "s/${value}\s*=\s*\"[^\"]+\"/${value} = \"YOUR-VALUES-HERE\"/g" "${file}"
    done
    # Add the changes to the staging area
    git add "${file}"
done

exit 0
```
