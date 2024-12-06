# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(

    var.tags, { Name = "${var.project_name}-public_route_table" }

  )
}

# Associating the route to internet
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Associating route to the subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.public.id
}