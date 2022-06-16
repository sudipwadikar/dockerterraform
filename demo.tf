# Configure and downloading plugins for aws
provider "aws" {
  #access_key = "${var.access_key}"
  #secret_key = "${var.secret_key}"
  region     = "${var.aws_region}"
}

# Creating VPC
# Creating Internet Gateway 
# Creating 1st subnet 
# Creating 2nd subnet 
# Creating Security Group
# Creating key pair
# Creating Instances
resource "aws_instance" "demoinstance1" {
  # SSH into instance 
  connection {
    # The default username for our AMI
    user = "ec2-user"
    # Private key for connection
    private_key = "${file(var.private_key)}"
    # Type of connection
    type = "ssh"
    host = "Demo-Instance"
  }
  
  # Installing splunk & creating distributed indexer clustering on newly created instance
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo service docker start",
      "sudo usermod -a -G docker ec2-user",
      "sudo chkconfig docker on",
      "sudo yum install -y git",
      "sudo chmod 666 /var/run/docker.sock",
      "docker pull ubuntu",
      "docker run -d ubuntu sleep 300"   
  ]
 }
}
