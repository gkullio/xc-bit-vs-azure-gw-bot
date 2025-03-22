A few things to make this work.

1. replace your desired variables in the terraform.tfvars.boilerpate
2. remove the .boilerplate from the file name
3. Insert your azure service principle information into the .tfvars
4. download your distributed cloud API certificate to the root of this file
5. Open the tf-python-choice.py and input the API Cert password and API cert location on lines 6 and 7

After the API cert is in the root, set the export variables in the folder from the CLI.
export VES_P12_PASSWORD="password"
export VOLT_API_P12_FILE="path to cert file"

Then run the follwing steps 
1.terraform init
2. terraform plan

3. hope and pray nothing needs modifying

4. terraform apply --auto-approve



Once it's all been debugged....
Run the tf-python-choice.py with "python tf-python-choice.py" and select 1 to build.  
If there are any errors, they will dump to the screen.  They are usually verbose.
   
