#! bin/bash

# This script simplifies the process to establish an instance connection.
# It uses SSH.


# INPUTS
ssh_key=
staging=
production=


# SCRIPT
if [ "$1" == "" ]; then
        echo "Missing parameter: 'staging' or 'production'."
        exit 1

elif [ "$1" == "staging" ]; then
        ssh -i $ssh_key ubuntu@$staging

elif [ "$1" == "production" ]; then
        ssh -i $ssh_key ubuntu@$production

else
        echo "Invalid parameter. Must be 'staging' or 'production'."
        exit 1
fi
