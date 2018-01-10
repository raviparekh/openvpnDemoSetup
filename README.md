# OpenVPN Demo Project with 2FA using time based tokens
####  Runs on Ubuntu

## IMPORTANT: As this is a demo project when using this demo project as a base to getting started on your setup, please ensure you re-generate all the relevant keys and take relevant security measures to protect them


## Install dependencies

Terraform 0.11.2 - Use your OS package manager to install terraform
Python 2.7 - Use your OS package manager to download Python (Usually comes with PIP, if not go to the link below)
PIP - https://pip.pypa.io/en/stable/installing/
Ansible 2.4.2.0 - Use PIP to install (pip install ansible==2.4.2.0)
Boto 2.48.0 - Use pip to install

## Adding new users:

Create a linux user by adding the user to openvpn_playbook.yml. To generate the hash for the user password follow:

1) `pip install passlib`

This will install the required dependencies

2) `python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())"`

3) This will prompt you for a password and print the hashed value

4) Copy the entire string over the open vpn playbook for your username.

## How to generate your google_authenticator file.

## 1. Install google_authenticator locally
Github: https://github.com/google/homebrew-google-authenticator/blob/master/README.md 
Run the following commands to install google-authenticator on os x using brew:

`brew tap timothybasanov/google-authenticator`

`brew install google-authenticator`

## 2. Generate your secret key
Please run this command:

`google-authenticator -t -f -d --qr-mode=NONE -r 3 -R 30 -w 1 --secret={USER_ID}_google_authenticator`

(Copy the '{USER_ID}_google_authenticator' file to roles/openvpn/keys/googleAuthenticator/{USER_ID}_google_authenticator)

## 3. Add generated secret key to Google authenticator on phone

## 4. chmod +w {USER_ID}_google_authenticator file

## Running terraform to create the infrastructure (AWS):

Go to the relevant terraform module and run: 

`terraform init`

`terraform apply`

Ensure the AWS credential file is created on your machine. Path: ~/.aws/credentials

## Running terraform to destroy the infrastructure:

Go to the relevant terraform module and run: 

`terraform destory`

The `tunnelblickconfig` folder contains the client config which can be used in Tunnel Blick (For Mac, there are other VPN clients available for other platforms, there is a OpenVPN client on at https://openvpn.net).
Please note to update the config with the domain name or public IP of the instance running open vpn.
Search for '{ENTER_PUBLIC_IP_FOR_OPENVPN}' in `opendemo.ovpn`

## Provisioning openvpn

Run the provision_openvpn script under ansible directory

## Generating new certs and private keys

Generating keys can be done with easy-rsa

1) apt-get install easy-rsa

2) The scripts should be available as /usr/share/easy-rsa

3) Change to root to avoid permission issues when running some of the scripts

4) Edit the vars script and enter the relevant information

5) run source ./vars

6) run ./clean-all

7) run ./build-ca

8) run ./build-key-server {KEY_NAME value as in the vars script}

9) openssl dhparam -out /etc/openvpn/dh2048.pem 2048


