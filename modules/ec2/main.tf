resource "aws_key_pair" "terraform-keys2" {
  key_name = "${var.instance_name}-${var.environment_name}"
  public_key = file("./mammam_rsa.pub")
}

resource "aws_instance" "ec2_instance" {
  ami                         = "ami-07315f74f3fa6a5a3"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = "${var.instance_name}-${var.environment_name}"
  subnet_id                   = var.subnet_ids[0]
  vpc_security_group_ids      = var.security_group_ids

  provisioner "file" {
    source      = "./mammam_rsa"
    destination = "/home/ec2-user/mammam_rsa"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./mammam_rsa")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = ["chmod 400 ~/mammam_rsa"]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("mammam_rsa")
      host        = self.public_ip
    }
  }
}