output "ec2_public_ip" {
  description = "Public IP of the Flask EC2 instance"
  value       = aws_instance.flask_ec2.public_ip
}

output "ssh_connection_string" {
  description = "SSH command to connect to the EC2 instance"
  value       = "ssh -i ./basic-key-pair.pem ubuntu@${aws_instance.flask_ec2.public_ip}"
}

output "flask_url" {
  description = "URL to access the Flask app on port 5000"
  value       = "http://${aws_instance.flask_ec2.public_ip}:5000"
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "security_group_id" {
  description = "ID of the Flask/SSH security group"
  value       = aws_security_group.open_flask.id
}
