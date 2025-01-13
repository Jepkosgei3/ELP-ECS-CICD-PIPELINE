
resource "aws_ecs_cluster" "backend_cluster" {
  name = "backend-cluster"
}

resource "aws_ecr_repository" "backend_repo" {
  name = "backend-app"
}

resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Security group for backend service"
  vpc_id      = "vpc-00e0ceb176ba4da81"

  ingress {
    from_port   = 8080  # Change to your backend port
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from anywhere (adjust as necessary)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_ecs_task_definition" "backend_task" {
  family                   = "backend-task"
  execution_role_arn       = aws_iam_role.execution_role.arn
  task_role_arn            = aws_iam_role.task_role.arn
  requires_compatibilities = ["FARGATE"]
  network_mode            = "awsvpc"
  cpu                     = "256"
  memory                  = "512"

  container_definitions = jsonencode([{
    name      = "backend"
    image     = "${aws_ecr_repository.backend_repo.repository_url}:latest"
    essential = true
    portMappings = [{
      containerPort = 8080  # Change to your backend port
      hostPort      = 8080
      protocol      = "tcp"
    }]
  }])
}

resource "aws_db_instance" "default" {
  identifier         = "mydb"
  engine             = "mysql"  # Change to your desired database engine
  instance_class     = "db.t3.micro"
  allocated_storage   = 20
  username           = "root"
  password           = "mypassword"  # Use a secure method to manage passwords
  db_name            = "mydb"
  skip_final_snapshot = true
  publicly_accessible = true  # Set to false for production
  vpc_security_group_ids = [aws_security_group.backend_sg.id]

  tags = {
    Name = "MyDB"
  }
}

resource "aws_ecs_service" "backend_service" {
  name            = "backend-service"
  cluster         = aws_ecs_cluster.backend_cluster.id
  task_definition = aws_ecs_task_definition.backend_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["subnet-09b63d86afe46804d", "subnet-0ba72403b29834935"]
    security_groups  = [aws_security_group.backend_sg.id]
    assign_public_ip = true
  }
}
