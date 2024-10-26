# AWS IAM Management Using Terraform

This document outlines the process for managing IAM users and their roles using a YAML configuration file.

## Steps

1. **Provide user and roles info via YAML file**  
   Create a YAML file containing user information and roles.

2. **Read the YAML file and process data**  
   Use a script to read and decode the YAML file to extract user and role information.

3. **Create IAM users**  
   Use the extracted data to create IAM users in your AWS account.

4. **Generate passwords for the users**  
   Generate secure passwords for each user as part of the creation process.

5. **Attach policies/roles to each user**  
   Assign the appropriate IAM policies or roles to each user based on their designated role.
