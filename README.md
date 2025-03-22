A few things to make this work.

1. Copy and paste the terraform.tfvars.boilerpate to the same folder and rename it terraform.tfvars

2. Replace all necessary variables in the new terraform.tfvars

3. Insert your azure service principle information into the .tfvars

   1. client_id = "your service principle id"
   2. client_secret = "your service principle secret"
   3. subscription_id = "your azure subscription id"
   4. tenant_id = "your azure tenant id"
   

4. generate and download your distributed cloud API certificate to the root of this file

   1. Login to the Distributed Cloud console
   2. Click on the user icon in the top right corner and select "Account Settings"
   3. Click Credentials
   4. Click "Add Credential"
   5. Give the Credential a name and select "API Certificate" as the type
   6. Enter and confirm the password
   7. Select an expiry date for the certificate (90 days is Max)
   8. Click "Download" and add to the root of this folder


5. Open the tf-python-choice.py and input the API Cert password and API cert location on lines 6 and 7

!!!!! If you DO NOT want to use the python script, you can set the export variables in the CLI.
This is recommended for the initial build, but the python script is much easier to use for subsequent builds.
   
   1. export VES_P12_PASSWORD="password of cert file"
   2. export VOLT_API_P12_FILE="path to cert file"

Then run the follwing steps 
1. terraform init
2. terraform plan
   ----hope and pray nothing needs modifying
3. terraform apply --auto-approve

Once you are finished showing the efficacy of XC Bot Defense versus Azure WAF and BOT, you can destroy the environment with "terraform destroy --auto-approve"



Once it's all been debugged....
Run the tf-python-choice.py with "python tf-python-choice.py" and select 1 to build.  
If there are any errors, they will dump to the screen.  They are usually verbose.
   
