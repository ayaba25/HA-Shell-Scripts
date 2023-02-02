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

