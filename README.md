A few things to make this work.

1. Copy and paste the terraform.tfvars.boilerpate to the same folder and rename it terraform.tfvars
2. Replace all necessary variables in the new terraform.tfvars
3. Insert your azure service principle information into the .tfvars
4. generate and download your distributed cloud API certificate to the root of this file
5. Open the tf-python-choice.py and input the API Cert password and API cert location on lines 6 and 7

After the API cert is in the root, set the export variables in the folder from the CLI.
export VES_P12_PASSWORD="password of cert file"
export VOLT_API_P12_FILE="path to cert file"

Then run the follwing steps 
1. terraform init
2. terraform plan
   ----hope and pray nothing needs modifying
3. terraform apply --auto-approve



Once it's all been debugged....
Run the tf-python-choice.py with "python tf-python-choice.py" and select 1 to build.  
If there are any errors, they will dump to the screen.  They are usually verbose.
   
