output "vpc_id" {
  value = aws_vpc.main.id
}
output "subnet_ids" {
  value       = aws_subnet.main_subnet[*].id
  description = "List of subnet IDs created in the network module"

}
