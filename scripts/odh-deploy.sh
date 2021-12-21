# download rosa
wget https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/rosa/latest/rosa-linux.tar.gz
tar -xvf rosa-linux.tar.gz
sudo mv rosa /usr/local/bin/rosa
# install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip";
unzip awscliv2.zip
sudo ./aws/install
# set aws credential
aws configure set aws_access_key_id ${access_key}
aws configure set aws_secret_access_key ${secret_key}
aws configure set default.region us-east-1
aws configure set default.output json
# download oc cli
rosa download oc
sudo tar -xvf openshift-client-linux.tar.gz
sudo mv oc /usr/local/bin/oc
# authenticate to redhat
rosa init --token=${redhatToken}
sleep 60
# create cluster admin
rosa create admin --cluster=${clusterName} > clusterAdminInfo.txt
sleep 60
# authenticate as cluster admin user
grep oc clusterAdminInfo.txt > oclogin0.sh
sleep 30
echo "--insecure-skip-tls-verify" > end
paste oclogin0.sh end >> oclogin.sh
rm end oclogin0.sh
sudo chmod +x oclogin.sh
sleep 30
./oclogin.sh 
sleep 60
# create subscription to install odh operator
oc apply -f odh-sub.yml
sleep 60
# create odh project
oc new-project ${odhProjectName} --display-name ${odhProjectDisplayName}
sleep 30
# create odh instance 
oc apply -f odh-instance.yml