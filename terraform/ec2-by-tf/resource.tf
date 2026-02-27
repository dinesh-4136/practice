resource "aws_security_group" "tf_sg" {
    name = "tf-sg"
    description = "Security group for Terraform EC2 instance"
    vpc_id = data.aws_vpc.default.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "tf_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.tf_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              set -eux

              # Wait for EBS device to appear
              while [ ! -e /dev/nvme1n1 ]; do
                sleep 2
              done

              # Format if not already formatted
              if ! blkid /dev/nvme1n1; then
                mkfs -t ext4 /dev/nvme1n1
              fi

              mkdir -p /data
              mount /dev/nvme1n1 /data

              echo "/dev/nvme1n1 /data ext4 defaults,nofail 0 2" >> /etc/fstab
              EOF

  tags = {
    Name = "Terraform-EC2"
  }
}

resource "aws_ebs_volume" "tf_ebs" {
  availability_zone = aws_instance.tf_ec2.availability_zone
  size              = 10
  type              = "gp3"

  tags = {
    Name = "Terraform-EBS"
  }
}

resource "aws_volume_attachment" "tf_ebs_attach" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.tf_ebs.id
  instance_id = aws_instance.tf_ec2.id

  depends_on = [aws_instance.tf_ec2]
}
