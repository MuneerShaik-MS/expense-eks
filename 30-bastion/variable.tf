# variable "ami" {
#   default = "ami-09c813fb71547fc4f" # value

# }
variable "instance_type" {
  
  default = "t3.micro"
}
variable "resource_name" {
  default = {
    Name = "eks-bastion"
    resource_type = "server"
    Owner = "Muneer"
    Environment = "Test"
    component = "aws-eks-client"
  }
}

variable "sg_id" {
  default = ["sg-0f9a9879631cb8191"]
}
variable "subnet_id" {
  default = "subnet-04a33a62bf6532211"
}


