resource "aws_instance" "main" {
  ami                    = var.ec2.ami
  instance_type          = var.ec2.type
  key_name               = aws_key_pair.main.key_name
  subnet_id              = module.vpc.subnet_id
  vpc_security_group_ids = [module.vpc.security_group_id]

  connection {
    type        = var.ec2.connection.type
    user        = var.ec2.connection.user
    private_key = file(var.ssh_key_path)
    host        = self.public_ip
  }

  provisioner "file" {
    # source      = var.ec2.provisioners.odh_instance.source
    content     = templatefile("${path.module}/${var.ec2.provisioners.odh_instance.source}",
                                {
                                  odhProjectName  = var.odh_project_name,
                                  odhInstanceName = var.odh_instance_name,
                                }
                              ) 
    destination = var.ec2.provisioners.odh_instance.destination
  }

  provisioner "file" {
    source      = var.ec2.provisioners.odh_sub.source
    destination = var.ec2.provisioners.odh_sub.destination
  }

  provisioner "remote-exec" {
    inline = local.scripts
  }

  tags = merge(
    tomap({ "Name" = "ec2_${var.tags["Application"]}_${var.tags["Environment"]}" }),
    var.tags
  )
}
