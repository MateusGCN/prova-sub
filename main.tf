provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "instance" {
  name        = "instance"
  description = "Permite acesso a instancia"

  egress {
    from_port   = 5432  
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [aws_db_instance.default.vpc_security_group_ids[0]]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.4"
  instance_class       = "db.t2.micro"
  username             = var.database_user
  password             = var.database_password
  parameter_group_name = "default.postgres12"
  skip_final_snapshot  = true
}

resource "aws_instance" "example" {
  ami           = "ami-0c02fb55956c7d316"  
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  tags = {
    Name = "prova-sub"
  }
}