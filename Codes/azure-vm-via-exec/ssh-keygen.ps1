# Specify the key size
$keySize = 2048

# Specify the path for the SSH key
$sshKeyPath = "$env:USERPROFILE\.ssh\id_rsa"

# Specify the path for the SSH public key
$sshPubKeyPath = "$sshKeyPath.pub"

# Delete existing id_rsa files
Remove-Item -Path $sshKeyPath -ErrorAction SilentlyContinue
Remove-Item -Path $sshPubKeyPath -ErrorAction SilentlyContinue

# Create the .ssh directory if it doesn't exist
if (-not (Test-Path "$env:USERPROFILE\.ssh")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE\.ssh"
}

# Generate the SSH key without passphrase and accepting defaults
ssh-keygen -t rsa -b $keySize -f $sshKeyPath -N "" -q

# Display a message
Write-Host "SSH key (no passphrase, defaults accepted) generated and saved to: $sshKeyPath"
