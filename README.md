
# Infrastructure as Code (IaC)

If you get stuck, delete the terraform.tfstate file, and manually destroy the resources that were created.

## Get token and SSH key name from your DigitalOcean account

    export OCEAN_TOKEN="0f97..."
    export OCEAN_SSH_KEY="greg..."

## Enable logging to STDOUT

    export TF_LOG=1

## Initialize local directory

    cd ~/projects/infrastructure/
    terraform init

## Plan then apply

    terraform plan  -var "do_token=${OCEAN_TOKEN}" -var "pvt_key=$HOME/.ssh/id_rsa" -var "ocean_ssh_key=${OCEAN_SSH_KEY}"
    terraform apply -var "do_token=${OCEAN_TOKEN}" -var "pvt_key=$HOME/.ssh/id_rsa" -var "ocean_ssh_key=${OCEAN_SSH_KEY}" --auto-approve

## Check the state after server created

    terraform show terraform.tfstate

## Destroy server; check terraform.tfplan before applying

    terraform plan -destroy -out=terraform.tfplan -var "do_token=${OCEAN_TOKEN}" -var "pvt_key=$HOME/.ssh/id_rsa" -var "ocean_ssh_key=${OCEAN_SSH_KEY}"
    terraform apply terraform.tfplan

