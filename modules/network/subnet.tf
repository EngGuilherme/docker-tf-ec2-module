
# Your subnet
resource "aws_subnet" "main_subnet" {
  count                   = var.instance_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]


  tags = merge(

    var.tags, { Name = "${var.project_name}-subnet-${count.index}" }

  )
}
data "aws_availability_zones" "available" {
  state = "available"
}