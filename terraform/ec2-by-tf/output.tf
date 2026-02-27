output "summary" {
  value = {
    ec2_instance_id         = aws_instance.tf_ec2.id
    ec2_instance_public_ip  = aws_instance.tf_ec2.public_ip
    ec2_instance_private_ip = aws_instance.tf_ec2.private_ip
    security_group_id       = aws_security_group.tf_sg.id
    ebs_volume_id           = aws_ebs_volume.tf_ebs.id
    ebs_device_attachment   = aws_volume_attachment.tf_ebs_attach.device_name
    root_volume_size        = aws_instance.tf_ec2.root_block_device[0].volume_size
  }
}