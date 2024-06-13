resource "aws_vpc" "custom_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
}
resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.custom_vpc.id
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1a"
    cidr_block = "10.0.0.0/24"
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.custom_vpc.id
}
resource aws_route_table "custom_route" {
    vpc_id = aws_vpc.custom_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
} 
resource "aws_route_table_association" public_subnet_1a {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.custom_route.id
}
