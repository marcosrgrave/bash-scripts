#!bin/bash

# Change the 'XX' values: Name-Real, Name-Email and Passphrase.

echo "Generating GPG key..."
gpg --batch --gen-key <<EOF
Key-Type: 1
Key-Length: 4096
Subkey-Type: 1
Subkey-Length: 4096
Name-Real: XXNameXLastNameXX
Name-Email: XXuser@email.comXX
Passphrase: XXpassphraseXX
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
