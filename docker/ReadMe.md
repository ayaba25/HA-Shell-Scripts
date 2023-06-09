# INSTALLATION OF DOCKER-COMPOSE
1) sudo yum update

Install Docker Compose using the official Docker Compose installation script:
2) sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

Make the Docker Compose binary executable:
3) sudo chmod +x /usr/local/bin/docker-compose

Verify the installation by checking the version of Docker Compose:
4) docker-compose --version
