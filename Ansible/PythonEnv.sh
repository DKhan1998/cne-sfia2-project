# Install python environment
ansible-galaxy collection install community.aws

# Install mysql requirements
sudo yum update -y
sudo yum install mysql -y

# Install python environment

sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get install -y python3-pip

pip3 install pytest

sudo apt-get install build-essential libssl-dev libffi-dev python-dev

sudo apt-get install -y python3-venv

mkdir environments
cd environments

python3 -m venv test_env

source test_env/bin/activate