to use the infrastructure change the path to gcp credentials.
then in terraform dir simply terraform apply.

The bug that I've mentioned in the previous lab was related to the fact 
that firestore can't purge and recreate the DB immediately. That is why
I decided to split my terraform project in two parts - main part with everythin
except for firestore db creation and firestore db creation separatly.

Now to run the project 
```bash
cd terraform/firestore
terraform init
terraform apply

cd ../terraform/main
terraform init
terraform apply
```