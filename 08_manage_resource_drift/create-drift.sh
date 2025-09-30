

$  export SG_ID=$(aws ec2 create-security-group --group-name "sg_web" --description "allow 8080" --output text)


#Next, create a new rule for your group to provide TCP access to the instance on port 8080.


$ aws ec2 authorize-security-group-ingress --group-name "sg_web" --protocol tcp --port 8080 --cidr 0.0.0.0/0


# Associate the security group you created manually with the EC2 instance provisioned by Terraform.

$ aws ec2 modify-instance-attribute --instance-id $(terraform output -raw instance_id) --groups $SG_ID


#############@ Import Sections after create SG using CLI aws

#Run terraform import to associate your resource definition with the security group created in the AWS CLI.
terraform import aws_security_group.sg_web $SG_ID


# Import your security group rule.
terraform import aws_security_group_rule.sg_web "$SG_ID"_ingress_tcp_8080_8080_0.0.0.0/0



## Test port 8080
curl $(terraform output -raw public_ip):8080