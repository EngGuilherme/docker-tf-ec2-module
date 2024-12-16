# Criando a instância EC2
resource "aws_instance" "web_server" {
  ami                    = var.ami # AMI Ubuntu
  instance_type          = var.instance_type
  subnet_id              = module.ec2_network.subnet_ids[count.index % length(module.ec2_network.subnet_ids)]
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = var.key_name       # key pair
  count                  = var.instance_count # Group of instances

  # user_data script to install Apache
  user_data = <<-EOF
    #! /bin/bash
    set -e

    echo "Updating the system..."
    sudo apt-get update -y
    sudo apt-get upgrade -y

    echo "Installing the Docker..."
    sudo apt-get install curl -y
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh ./get-docker.sh

    echo "Verifying Docker instalation..."
    docker --version || { echo "Docker install error"; exit 1; }

    echo "Installing Apache image..."
    sudo docker pull httpd:latest

    echo "Creating application directory..."
    mkdir -p /home/ubuntu/app

    echo "Copying website files to the instance..."
    # The "app" folder will be automatically copied by the "file" provisioner

    echo "Running Apache in Docker..."
    sudo docker run -d -p 80:80 --name apache-server -v /home/ubuntu/app:/usr/local/apache2/htdocs/ httpd:latest

    echo "Script finished."

EOF

  # File Provisor
  provisioner "file" {
    source      = var.local_folder   # local diretory of your app folder
    destination = "/home/ubuntu/app" # Destination path on the EC2 instance

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key)
      host        = self.public_ip
    }
  }

  associate_public_ip_address = true

  tags = merge(

    var.tags, {
      Name = "${var.project_name}-web-server-${count.index}"
    }

  )

  depends_on = [aws_security_group.web_sg]
  # Ensuring that the security group is created before the instance
}
