#!bin/bash

# This script simplifies the process to enable git signed commits.
# The key is valid for a year.

# When executing this script, inform the:
# 	1. Name and Last Name. (e.g. "John Doe")
# 	2. Email. (e.g. "john.doe@email.com")
# 	3. Passphrase. (e.g. "This@Is!John_Doe#Passphrase%54321")
# After the script execution, copy the public key generated and paste it in your GitHub account at SSH and GPG personal settings.

if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]; then
	echo "Missing one or more Parameters: NameAndLastName | Email | Passphrase"
	exit 1
fi

echo "Name and Last Name: $1 | Email: $2 | Passphrase: $3"

echo "Generating GPG key..."
gpg --batch --gen-key <<EOF
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Name-Real: $1
Name-Email: $2
Passphrase:	$3
Expire-Date: 1y
EOF
echo

key_id="$(gpg --list-secret-key --keyid-form LONG | grep -o -P '(?<=sec   rsa4096/)[[:xdigit:]]{16}')"
echo "YOUR KEY ID: $key_id"
echo

echo "Configuring Git signatures with GPG key..."
git config --global user.singninkey $key_id
git config --global commit.gpgsign true
git config --global tag.gpgSign true
echo

echo "Exporting GPG..."
echo "export GPG_TTY=$(tty)" >>~/.bash_profile
echo

echo "Setting GPG agent..."
echo "use-agent" >~/.gnupg/gpg.conf
gpgconf --launch gpg-agent
echo

echo "Register this public key into your GitHub repository:"
gpg --armor --export $key_id
echo

echo "Process completed. You are good to go!"
exit 0
