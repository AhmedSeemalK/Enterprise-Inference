#!/bin/bash
sudo apt-get update && sudo apt-get install -y git unzip
GITHUB_PAT=$1
reserved_ip=$2
git config --global credential.helper 'store --file .git-credentials'
echo "https://$GITHUB_PAT:x-oauth-basic@github.com" > ~/.git-credentials
git clone --branch tags/v6.0.0-rc --single-branch https://github.com/intel-innersource/applications.ai.erag.infra-automation.git /home/ubuntu/
git clone https://github.com/intel-innersource/applications.ai.erag.infra-automation-ida-cloud-providers.git /home/ubuntu/
cp /home/ubuntu/applications.ai.erag.infra-automation-ida-cloud-providers/hosts.yaml /home/ubuntu/applications.ai.erag.infra-automation-6.0.0-rc/ida/inventory/
sed -i 's/\(ansible_host:\s*\)[0-9\.]\+/\1'$reserved_ip'/' /home/ubuntu/applications.ai.erag.infra-automation-6.0.0-rc/ida/inventory/hosts.yaml
echo "$reserved_ip api.example.com" | sudo tee -a /etc/hosts > /dev/null
mkdir -p ~/certs && cd ~/certs && openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes -subj "/CN=api.example.com"
cp /home/ubuntu/inference-config.cfg /home/ubuntu/applications.ai.erag.infra-automation-6.0.0-rc/ida/inference-config.cfg
ssh-keygen -t rsa -b 4096 -N '' -f ~/.ssh/id_rsa -q && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
chmod +x /home/ubuntu/applications.ai.erag.infra-automation-6.0.0-rc/ida/inference-as-auto-deploy.sh
cd /home/ubuntu/applications.ai.erag.infra-automation-6.0.0-rc/ida; echo -e '1\nyes\n' | bash /home/ubuntu/applications.ai.erag.infra-automation-6.0.0-rc/ida/inference-as-auto-deploy.sh
