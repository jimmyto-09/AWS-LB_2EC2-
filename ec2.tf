resource "aws_instance" "ec2v1" {
  ami           = "ami-08f9a9c699d2ab3f9"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.subnet1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>HOLA SOY INSTANCIA 1 </h1>" > /usr/share/nginx/html/index.html
              EOF


  tags = {
    Name = "ec2v1"
  }
}




resource "aws_instance" "ec2v2" {
  ami           = "ami-08f9a9c699d2ab3f9"
  instance_type = "t3.micro"
  subnet_id       = aws_subnet.subnet2.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>HOLA SOY INSTANCIA 2 </h1>" > /usr/share/nginx/html/index.html
              EOF

  tags = {
    Name = "ec2v2"
  }
}