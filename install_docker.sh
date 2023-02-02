# install docker on Amazon Linux 2
################################
sudo yum update -y		
sudo yum install docker -y
sudo systemctl start docker

#Install Docker on AWS RHEL
##############################
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce-3:18.09.1-3.el7 -y
sudo systemctl enable docker
sudo systemctl start docker
sudo docker info
adduser simon

# install and configure docker on ubuntu 18.04
###################################
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker.service
sudo systemctl status docker
