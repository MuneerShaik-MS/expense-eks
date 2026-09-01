
# --- EC2 instance (VPC-friendly) ---
resource "aws_instance" "ec2" {
  vpc_security_group_ids = [local.bastion_sg_id]
  subnet_id = local.subnet_id
  instance_type               = var.instance_type
  ami                         = data.aws_ami.joindevops.id  
  
  associate_public_ip_address = true

  tags = var.resource_name
  root_block_device {
volume_type = "gp3"
volume_size = 50
delete_on_termination = true
encrypted = false
}
}



# --- Install Docker on RHEL via SSH (null_resource + remote-exec) ---
resource "null_resource" "eks-bastion" {
  depends_on = [aws_instance.ec2]   # ensure instance is ready

  triggers = {
    instance_id = aws_instance.ec2.id
    # bump this to force re-run if needed
    setup_version = "v1"
  }

  connection {
    type        = "ssh"
    host        = aws_instance.ec2.public_ip
    user        = "ec2-user"                   # RHEL default
    password = "DevOps321"
     # path to your private key
  }

  
 provisioner "file" {
    source      = "bastion.sh"  # local path
    destination = "/home/ec2-user/bastion.sh" # remote path
  }

  # Now execute it (optional)
  provisioner "remote-exec" {
    inline = [
      "set -euxo pipefail",
      "sudo chmod +x /home/ec2-user/bastion.sh",
      "sudo /home/ec2-user/bastion.sh",
    ]
  }


}


