terraform{
required_providers{
aws ={
source = "hasicorp/aws"
version = "~>4.0.0"
}
}
required_version {
version = "~>1.1.5"
}
}
resource "aws_vpc" "rtera2_vpc"{
     cidr_block = var.vpc_cidr-block
     enable_dns_hostname = true
tags{
name = "ramtera2"
}
}
resource "aws_internet_gateway" "ram2tr_igw"{
    vpc_id= aws_vpc.rtera2_vpc.id
tags {
name = "r2tera_igw"
}
}
resource "aws_subnet" r2tpublic_subnet"{
   vpc-id = aws_vpc.rtera2_vpc.id
   count = var.subnet_count.public
   cidr_block = var.public-subnet_cidr_blocks[count.index]

tags {
name = "ram2terra_public_${count.index}"
}
}
 resource "aws-subnet" "r2tprivate_subnet" { 
     vpc-id = aws_vpc.rtera2_vpc.id
      count = var.subnet_count.private
      cidr_block = var.private-subnet_cidr_blocks[count.index]

tags {
     name = "ram2terra_private_${count.index}"
}
}

resource "aws_route_table" "r2ter_public"{

    vpc-id = aws_vpc.rtera2_vpc.id
   route {
cidr_block=  "0.0.0.0/0"
gateway_id = aws_internet-gateway.ram2tr-igw.id
}
}

resource "aws_route_table_association" "public"{
count = var.subnet_count.public
route-table_id  = aws_route_table.r2ter_public.id
subnet_id= aws_subnet.r2tpublic_subnet[count.index].id
}

resource "aws_route_table" "r2ter_private"{

    vpc-id = aws_vpc.rtera2_vpc.id
   
}

resource "aws_route_table_association" "private"{
count = var.subnet_count.public
route-table_id  = aws_route_table.r2ter_private.id
subnet_id= aws_subnet.r2tprivate_subnet[count.index].id
}


resource "aws_security_group" "sgname"{
        name        = "ram2 terraform"
        description =  "lets see its going to connect through ssh"
        vpc_id      =  aws_vpc.rtera2_vpc.id

        ingress{
          description = "ssh"
         from_port = 22 
         to_port    = 22
         protocol   = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
        }
         ingress{
           description = "Http"
         from_port = 8080
         to_port   = 8080
         protocol = "tcp"
         cidr_blocks = ["0.0.0.0/0"]

       }
        egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }
}

output "hello world"{
value = hello world
}
