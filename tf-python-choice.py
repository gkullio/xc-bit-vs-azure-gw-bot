import subprocess
import sys
import os
import time

# Set environment variables before running commands
os.environ["VES_P12_PASSWORD"] = ""
os.environ["VOLT_API_P12_FILE"] = ""

def run_prep():
    """Executes the prep.sh script and stops if an error occurs."""
    print("\nEnvironmental Variables Set\n")
    print("This script is designed to build an Azure Web App behind a Azure App Gateway with WAF and BOT, a Distributed Cloud Load Balancer with WAF and BOT using Terraform\n")
    # Print environment variables to verify
    #print(os.environ.get("VES_P12_PASSWORD"))
    #print(os.environ.get("VOLT_API_P12_FILE"))

def run_terraform_command(command):
    """Executes a Terraform command and stops if an error occurs."""
    print(f"\nRunning: {' '.join(command)}\n")
    process = subprocess.run(command, capture_output=True, text=True)
    
    # Print the command output
    print(process.stdout)
    
    # Check for errors
    if process.returncode != 0:
        print(f"Error encountered in command: {' '.join(command)}")
        print(process.stderr)
        sys.exit(1)

def main():
    start_time = time.time()
    print(f"Start time: {time.ctime(start_time)}\n")

    # Execute the prep.sh script first
    run_prep()

    # Prompt for input: build or destroy
    print("\n===Choose a Terraform operation.===\n   1. Build\n   2. Destroy\n\nBoth will execute terraform init first.\nChoosing 1 will run init, plan, and apply --auto-approve.\nChoosing 2 will run init and destroy --auto-approve.\n")
    operation = input("Enter Terraform operation (1 or 2): ").strip().lower()
    if operation not in ["1", "2"]:
        print("Invalid operation. Exiting!")
        sys.exit(1)

    # If the destroy option is selected, ask for a yes/no confirmation.
    if operation == "2":
        print("\nNOTE: DESTROYING THE RESOURCES WILL DELETE ALL RESOURCES CREATED BY TERRAFORM.")
        print("THIS OPERATION IS IRREVERSIBLE AND WILL NOT PROMPT FOR FURTHER CONFIRMATION.\n")
        confirm = input("Are you sure you want to proceed? (yes/no): ").strip().lower()
        if confirm != "yes":
            print("Operation canceled. Exiting!")
            sys.exit(1)

    # Define Terraform commands based on the user's choice
    if operation == "1": # build
        commands = [
            ["terraform", "init"],
            ["terraform", "plan"],
            ["terraform", "apply", "--auto-approve"]
        ]
    else:  # destroy
        commands = [
            ["terraform", "init"],
            ["terraform", "destroy", "--auto-approve"]
        ]

    # Run Terraform commands sequentially
    for command in commands:
        run_terraform_command(command)

    print(f"\nTerraform {operation} operation completed successfully.")

    end_time = time.time()  # end timer
    elapsed = end_time - start_time
    minutes = int(elapsed // 60)
    seconds = elapsed % 60
    print(f"\nTotal elapsed time: {minutes} minute(s) and {seconds:.2f} second(s).")

if __name__ == '__main__':
    main()