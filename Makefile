dev:
    @rm -rf .terraform
    @terraform init -backend-config=env-dev/state.tfvars
    @terraform apply -auto-approve - var-file=env.dev/main.tfvars


# dev:
#     @rm -rf .terraform
#     @terraform init -backend-config=env-dev/state.tfvars
#     @terraform apply -auto-approve - var-file=env.dev/main.tfvars

# for the shell command we use @
# to execute the command we use (make dev or prod) to execute the above or below command

#prod:
#    @rm -rf .terraform
#    @terraform init -backend-config=env-prod/state.tfvars
#    @terraform apply -auto-approve - var-file=env.prod/main.tfvars