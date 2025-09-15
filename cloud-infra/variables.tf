locals {
    ec2-ami = "ami-02d7ced41dff52ebc"
    ec2-instance-type = "t3.micro"
    ec2-key-name = "basic-key-pair"
    ec2-user-data-route = "./ec2_user_data/user_data.sh"
}