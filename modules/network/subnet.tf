
# Your subnet
resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.cidr_block
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = merge(

    var.tags, { Name = "${var.project_name}-subnet" }

  )
}