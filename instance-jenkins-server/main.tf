
resource "aws_instance" "my-web" {
  ami                         = "ami-0aaa5410833273cfe"
  instance_type               = "t2.small"
  key_name                    = "serverKey"
  subnet_id                   = aws_subnet.my-web_subnets[0].id
  security_groups             = [aws_security_group.my-web_security_group.id]
  availability_zone           = var.availability_zone[0]
  associate_public_ip_address = true
  user_data                   = file("installation-script.sh")
  tags = {
    Name = "${var.env_prefix}-server"
  }
}

# VPC configuration
resource "aws_vpc" "my-web_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.env_prefix}_vpc"

  }
}

# Public and Private Subnets configuration
resource "aws_subnet" "my-web_subnets" {
  count = 2

  cidr_block              = "10.0.${count.index + 1}.0/24"
  availability_zone       = var.availability_zone[count.index]
  vpc_id                  = aws_vpc.my-web_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "${element(var.subnet_names, count.index % length(var.subnet_names))}-publicsubnet-${count.index / length(var.subnet_names) + 1}"
  }
}

resource "aws_subnet" "private" {
  count = 2

  cidr_block        = "10.0.${count.index + 3}.0/24"
  availability_zone = var.availability_zone[count.index]
  vpc_id            = aws_vpc.my-web_vpc.id
  tags = {
    Name = "${element(var.subnet_names, count.index % length(var.subnet_names))}-privatesubnet-${count.index / length(var.subnet_names) + 1}"
  }
}


#configuring the network acl to control traffic

resource "aws_network_acl" "network-acl" {
  vpc_id     = aws_vpc.my-web_vpc.id
  subnet_ids = [aws_subnet.my-web_subnets[0].id]

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 400
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 300
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "${var.env_prefix}_network-acl"
  }
}





# Security Group configuration
resource "aws_security_group" "my-web_security_group" {
  vpc_id = aws_vpc.my-web_vpc.id
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "${var.env_prefix}_security_group"
  }

}

# # Security group for data plane
# resource "aws_security_group" "data_plane_sg" {
#   name   = "${var.env_prefix}_worker_sg"
#   vpc_id = aws_vpc.my-web_vpc.id

#   tags = {
#     Name = "${var.env_prefix}_worker_sg"
#   }
# }

# resource "aws_security_group_rule" "nodes_rule" {
#   type              = "ingress"
#   description       = "Allow nodes communicate with each other"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.data_plane_sg.id
# }

# resource "aws_security_group_rule" "nodes_inbound" {
#   type              = "ingress"
#   description       = "Allow Kubelets and pods communicate with the clusters"
#   from_port         = 1025
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.data_plane_sg.id
# }

# resource "aws_security_group_rule" "nodes_outbound" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.data_plane_sg.id
# }

# # Security group for control plane
# resource "aws_security_group" "control_plane_sg" {
#   name   = "${var.env_prefix}-ControlPlane-sg"
#   vpc_id = aws_vpc.my-web_vpc.id

#   tags = {
#     Name = "${var.env_prefix}-ControlPlane-sg"
#   }
# }

# # Security group traffic rules
# resource "aws_security_group_rule" "control_plane_inbound" {
#   security_group_id = aws_security_group.control_plane_sg.id
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# resource "aws_security_group_rule" "control_plane_outbound" {
#   security_group_id = aws_security_group.control_plane_sg.id
#   type              = "egress"
#   from_port         = 0
#   to_port           = 65535
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
# }



# Create Internet Gateway
resource "aws_internet_gateway" "my-web_internet_gateway" {
  vpc_id = aws_vpc.my-web_vpc.id
  tags = {
    Name = "${var.env_prefix}_internet_gateway"
  }
}

# Route Table configuration
resource "aws_route_table" "my-web_route_table" {
  vpc_id = aws_vpc.my-web_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-web_internet_gateway.id
  }
  tags = {
    Name = "${var.env_prefix}_route_table"
  }
}

#Route Table and Subnet Association config
resource "aws_route_table_association" "subnet1" {
  count          = 2
  subnet_id      = aws_subnet.my-web_subnets[count.index].id
  route_table_id = aws_route_table.my-web_route_table.id
}

#NAT Elastic IP
resource "aws_eip" "nat-eip" {
  vpc = true

  tags = {
    Name = "${var.env_prefix}_nat_gateway_ip"
  }
}

#NAT Gateway Config
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.my-web_subnets[0].id

  tags = {
    "Name" = "${var.env_prefix}_nat_gateway"
  }
}




