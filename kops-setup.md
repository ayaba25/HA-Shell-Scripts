# KOPS Setup
Setup Kubernetes (K8s) Cluster on AWS Using KOPS

#!/bin/bash
=#1) Create Ubuntu EC2 instance in AWS and create kops user
   sudo adduser kops
   sudo echo "kops  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/kops
   sudo su - kops

=#2) install AWSCLI

 sudo apt update -y
 sudo apt install unzip wget -y
 sudo curl https://s3.amazonaws.com/aws-cli/awscli-bundle.zip -o awscli-bundle.zip
 sudo apt install python3.8 -y
 sudo unzip awscli-bundle.zip
 sudo apt install awscli 
 sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
 
 
=#3) Install kops software on ubuntu instance:

 	#Install wget if not installed
 	sudo apt install wget -y
 	sudo wget https://github.com/kubernetes/kops/releases/download/v1.18.2/kops-linux-amd64
 	sudo chmod +x kops-linux-amd64
 	sudo mv kops-linux-amd64 /usr/local/bin/kops
 
=#4) Install kubectl = command line utility for kubernetes

 sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
 sudo chmod +x ./kubectl
 sudo mv ./kubectl /usr/local/bin/kubectl
 
 
 
 aws s3 mb s3:/class24.local
 # lifesoft.local
 aws s3 ls

=# 5) Create an IAM role from AWS Console or CLI with below Policies.

	AmazonEC2FullAccess  = ecs instances
	AmazonS3FullAccess   = key-value-store 
	IAMFullAccess        = 
	AmazonVPCFullAccess  = vpc 
    user cannot manage billing 


Then Attach IAM role to ubuntu server from Console Select KOPS Server --> Actions --> 
    Instance Settings/Security --> Attach/Replace IAM Role --> Select the role which
You Created. --> Save.
   


#6) create an S3 bucket Execute below commond in KOPS Server use unique bucket name if you get bucket name exists error.

	aws s3 mb s3://lifesoft.local
	aws s3 ls
	
    ex:
	S3 bucket name should be unique across AWS accounts 
	aws s3 mb mb s3://lifesoft.local 
     
	Expose environment variable:

    # Add env variables in bashrc
    vi .bashrc
	
	# Give Unique Name And S3 Bucket which you created.

    export KOPS_STATE_STORE=s3://lifesoft.local
    export NAME=lifesoft.k8s.local
 
    source .bashrc
	
=#7) Create sshkeys before creating cluster

    ssh-keygen
 

=# 8)Create kubernetes cluster definitions on S3 bucket

kops create cluster --zones us-east-1a --networking weave --master-size t2.medium --master-count 1 --node-size t2.medium --node-count=2 ${NAME}
	
	kops create cluster --zones us-east-2a, \
  zones us-east-2c --networking weave --master-size t2.medium \
  --master-count 2 --node-size t2.medium --node-count=2 ${NAME}

	kops create secret --name ${NAME} sshpublickey admin -i ~/.ssh/id_rsa.pub

# 9) Create kubernetes cluser

	 kops update cluster ${NAME} --yes

# 10) Validate your cluster(KOPS will take some time to create cluster ,Execute below commond after 3 or 4 mins)

	   kops validate cluster
 
# 11) To list nodes

	  kubectl get nodes 
  
  # we can provision and manage resources now in the cluster.
  
# 12) To Delete Cluster

   kops delete cluster --name=${NAME} --state=${KOPS_STATE_STORE} --yes  
   
===================================================================
