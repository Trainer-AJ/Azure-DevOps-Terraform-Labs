# Azure-DevOps-Terraform-Labs

# IMPORTANT ⚠️
Use below Pre-Commit Hook to Avoid Pushing Your Secrets:
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
