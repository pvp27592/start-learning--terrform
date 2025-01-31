resource "aws_instance" webserver {
    ami = "ami-0cc9838aa7ab1dce7"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    associate_public_ip_address = "true"
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install httpd -y
    echo "<html><h1>webpage 1(webserver by terraform)</h1></html>" > /var/www/html/index.html
    service httpd start
    chkconfig httpd on
    EOF

    tags = {
        "Name": "webserver-by-terraform"
    }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}
