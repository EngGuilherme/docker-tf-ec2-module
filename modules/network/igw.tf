# Internet Gateway (IGW)
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(

    var.tags, { Name = "${var.project_name}-igw" }

  )
}
