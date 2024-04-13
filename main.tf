# resource "aws_instance" "ec2-instance1" {
#   ami           = "ami-051f8a213df8bc089"
#   instance_type = "t2.micro"

#   tags = {
#     Name = "demo-server1"
#   }
# }


# resource "aws_instance" "ec2-Instance2" {
#   provider      = aws.west
#   ami           = "ami-0b990d3cfca306617" # AMI for us-west-1
#   instance_type = "t2.micro"

#   tags = {
#     Name = "demo-server2"
#   }
# }


resource "aws_vpc" "main" {
  cidr_block = "172.31.0.0/16"
}

resource "aws_subnet" "subnet1" {
  vpc_id            = "vpc-02fd83bf2e6978122"
  cidr_block        = "172.31.0.0/17"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "subnet2" {
  provider          = aws.duplicate
  vpc_id            = "vpc-02fd83bf2e6978122"
  cidr_block        = "172.31.128.0/17"
  availability_zone = "us-east-1b"
}

resource "aws_instance" "ec2-instance1" {
  ami           = "ami-051f8a213df8bc089"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet1.id

  tags = {
    Name = "demo-server1"
  }
}

resource "aws_instance" "ec2-instance2" {
  provider      = aws.west
  ami           = "ami-0b990d3cfca306617"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet2.id

  tags = {
    Name = "demo-server2"
  }
}
