# OpenVPN Demo Project with 2FA using time based tokens
## IMPORTANT: As this is a demo project when using this demo project as a base to getting started on your setup, please ensure you re-generate all the relevant keys and take relevant security measures to protect them

## Adding new users:

Create a linux user by adding the user to openvpn_playbook.yml. To generate the hash for the user password follow:

1) `pip install passlib`

This will install the required dependencies

2) `python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())"`

This will prompt you for a password and print the hashed value, copy the entire string over the open vpn playbook for your username.

## How to generate your google_authenticator file.

## 1. Install google_authenticator locally
Github: https://github.com/google/homebrew-google-authenticator/blob/master/README.md 
Run the following commands to install google-authenticator on os x using brew:

`brew tap timothybasanov/google-authenticator`

`brew install google-authenticator`

## 2. Generate your secret key
Please run this command:

`google-authenticator -t -f -d --qr-mode=NONE -r 3 -R 30 -w 1 --secret={USER_ID}_google_authenticator`

(Copy the '.google_authenticator' file to roles/openvpn/keys/googleAuthenticator/{USER_ID}_google_authenticator)

## 3. Add generated secret key to Google authenticator on phone

## 4. chmod +w {USER_ID}_google_authenticator file

## Running terraform to create the infrastructure (AWS):

Go to the relevant terraform module and run: 

`terraform apply`

Ensure the AWS credential file is created on your machine. Path: ~/.aws/credentials

## Running terraform to destroy the infrastructure:

Go to the relevant terraform module and run: 

`terraform destory`

The tunnelblickconfig folder contains the client config which can be used in Tunnel Blick.
Please note to update the config with the domain name or public IP of the instance running open vpn.
Search for '{ENTER_PUBLIC_IP_FOR_OPENVPN}' in `opendemo.ovpn`

## Provisioning openvpn

Run the provision_openvpn script under ansible directory

Note: The openvpn server configuration is done in a way so that it will push out routes for the VPC rather than re-routing all traffic of the client via the VPN (split tunneling). The routes will need to be updated for your VPC CIDR block. See roles/openvpn/templates/server.j2  
'# push vpc route
push "route 10.10.0.0 255.255.255.0"' for example

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


