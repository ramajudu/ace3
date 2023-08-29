# this is to declre in which region our server nneds to be created 
variable "aws_region" {
  default = "ap-southeast-2"
}


resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
count= 3

  tags = {
    Name = "ram_terraform"
  }
}

resource "aws_security_group" "sgname"{
        name        = "rama terraform"
        description =  "lets see its going to connect through ssh"
        vpc_id      =  aws_vpc.my_vpc.id
        count=3

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
 ## this is to specify the cidr block range 
   variable "aws_cidr_block"{
     description = "CIDR  block for vpc"
     type = string
     default = "10.0.0.0/16"
   }
     // this variable holds the number of public and proivate subnets
   variable "subnet_count" {
     description = "number of subnets "
     type = map(number)
     default = {
       public = 3
       private = 3
     }
   }

   // this variable contains the configuration 
   // contions the settings for your server or data base

   
       
        
// thsi variable contains the cidr range for subnets

         variable "public-subnet_cidr_blocks" {
           description = "available cidr block for subnets"
           type = list(string)
           default =[
             "10.0.1.0/24",
             "10.0.2.0/24",
             "10.0.3.0/24",
             "10.0.4.0/24"
           ]
         }
         
          variable "private_subnet_cidr_blocks" {
           description = "available cidr block for subnets"
           type = list(string)
           default =[
             "10.0.101.0/24",
             "10.0.102.0/24",
             "10.0.103.0/24",
             "10.0.104.0/24",
           ]
         }
         
