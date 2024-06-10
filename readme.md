# Terraform Ansible EC2 Minecraft Server

## Description
This is a project that allows anyone to create a minecraft server using ansible and terraform. The cloud provider that we use is Amazon EC2.

## Pre-Requisites
1. Please make sure to download and install [Terraform](https://www.terraform.io/) and its dependencies, [Ansible](https://www.ansible.com/), and [AWS CLI](https://aws.amazon.com/cli/).

2. Make sure to add your AWS credentials to ~/.aws/credentials. Please grab your credentials from your AWS account and if the file is not present, add it yourself with touch or any text editor of your choice

3. Make sure to have a keypair that you can assosciate with your EC2 instance, if you need to get one find that [here](https://www.digitalocean.com/community/tutorials/how-to-create-ssh-keys-with-openssh-on-macos-or-linux)

 [or here for Windows users](https://www.puttygen.com/)

## creating the minecraft server

1. download this repository using git clone or the download button

2. copy your RSA public key into main.tf under line 29 Public_key = "your public key here"

3. In the directory run these commands in sequence
 
 <code>terraform init</code>
 
 <code>terraform apply</code>

 when it ask for a password hit enter multiple times until you get the prompt to type "yes"

 4. your instance will be created in EC2 and you will now have your public IP

 5. copy your public ip of the EC2 instance and add it to hosts.yml one line under [minecraft]

6. Time to run the ansible script! we run the playbook using the host file with our EC2 public ip, and our SSH key we created for the project. 

<code>ansible-playbook -i ./hosts.yml playbook.yml --private-key=id_rsa</code>

7. The minecraft server is running! have fun!