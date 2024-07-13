output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds_subnet_group.*.name
}

output "db_security_group" {
  value = [aws_security_group.mtc-sg["rds"].id]
}

output "alb_security_group" {
  value = [aws_security_group.mtc-sg["public"].id]
}

output "public_subnets" {
  value = aws_subnet.public_subnet.*.id
}