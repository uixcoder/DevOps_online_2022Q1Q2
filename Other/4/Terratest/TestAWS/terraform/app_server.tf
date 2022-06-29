
resource "aws_instance" "App_Ubuntu_Terraform" {
  ami                    = "ami-000e50175c5f86214"
  instance_type          = "t3.micro"
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.sgh_app.id]
  credit_specification {
    cpu_credits = "standard"
  }
  tags = {
    Name    = "App_test"
    Owner   = "Ivan Danyliuk"
    Project = "Geocitizen"
  }
}

resource "aws_security_group" "sgh_app" {
  name = "app_test"
  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "App_Geo_test"
  }
}

