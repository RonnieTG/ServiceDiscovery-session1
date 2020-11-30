# Installing Consul server instances
resource "aws_instance" "consul_server" {

  count         = var.server_ec2_number
  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  key_name      = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.opsschool_consul.id]
  user_data = file("/consul-server.sh")
  tags = {
    Name = "${var.environment_tag}-Server-${count.index + 1}"
    consul_server = "true"
  }
}


# Installing Consul agent instances
resource "aws_instance" "consul_agent" {

  count = var.agent_ec2_number
  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  key_name      = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.opsschool_consul.id]
  user_data = file("./consul-agent.sh")
  tags = {
    Name = "${var.environment_tag}-Agent-${count.index + 1}"
  }
}


# Outputs
output "server" {
  value = aws_instance.consul_server.*.public_dns
}

output "agent" {
  value = aws_instance.consul_agent.*.public_dns
}