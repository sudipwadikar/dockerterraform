provider "aws" {
  region     = "${var.aws_region}"
}

resource "aws_instance" "Demo-Instance" {
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = "${file(var.private_key)}
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


