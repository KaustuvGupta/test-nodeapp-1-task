output "vpc_id"{
    value = module.vpc.vpc_id
}

output "sg_bastion_id"{
    value = aws_security_group.sg_bastion.id
}

output "sg_public_id"{
    value = aws_security_group.sg_public.id
}

output "sg_private_id"{
    value = aws_security_group.sg_private.id
}

output "bastion_machine_id"{
    value = module.ec2_instances1[*].id #module.ec2_instances1.ec2_id
}

output "jenkins_machine_id"{
    value = module.ec2_instances2[*].id 
}

output "app_machine_id"{
    value = module.ec2_instances3[*].id 
}

output "bastion_public_ip"{
    value = module.ec2_instances1[*].public_ip
}

output "bastion_private_ip"{
    value = module.ec2_instances1[*].private_ip
}

output "jenkins_private_id"{
    value = module.ec2_instances2[*].private_ip
}

output "app_private_id"{
    value = module.ec2_instances3[*].private_ip
}

output "lb_dns_name"{
    value = aws_elb.jenkins_elb.dns_name
}

output "public_subnet_id"{
    value = module.vpc.public_subnets[*]
}