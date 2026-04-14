provider "aws" {
    region = "ap-south-2"
}

resource "aws_instance" "game_server" {
    ami = var.ubuntu
    instance_type = var.t3_small
    key_name = "devopskey"
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.sg_game.id]

    tags = {
        Name = "game"
    }
}

resource "aws_security_group" "sg_game" {
    name = "game_sg"
    description = "Allow SSH, HTTP"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "game_security_group"
    }
}