# ----ecs/main.tf -----

# criação de policy e roles
resource "aws_iam_role" "ecs_task_execution_role" {
    name = var.iamrole_name
    assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
    role = aws_iam_role.ecs_task_execution_role.arn
    policy_arn = data.aws_iam_policy.ecs_task_execution_role.arn
}

#Log Group
resource "aws_cloudwatch_log_group" "log_group" {
    name = "/ecs/${var.cluster_name}"
}

#ECS
resource "aws_ecs_cluster" "cluster_ecs" {
    name = var.cluster_name
    tags = {
    }
}

resource "aws_ecs_task_definition" "webapp" {
    family = "webapp"
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
    container_definitions = <<EOF
    [
        {
            "name": "webapp",
            "image": "${var.container_image}",
            "portMappings": [
                {
                    "containerPort": 8000,
                    "hostPort": 8000
                }
            ],
            "environment": [

            ],
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-region": "us-east-1",
                    "awslogs-group": "/ecs/webapp",
                    "awslogs-stream-prefix": "ecs"
                }
            }
        }
    ]
    EOF

    cpu = 512
    memory = 1024
    requires_compatibilities = [ "FARGATE" ]
    network_mode = "awsvpc"
    tags = {
        Ambiente = "Medcloud-challenge"
    }
}


resource "aws_ecs_service" "ecs-webapp" {
    name = "ecs-webapp"
    task_definition = aws_ecs_task_definition.webapp.arn 
    cluster = aws_ecs_cluster.cluster_ecs.id
    launch_type = "FARGATE"
    desired_count = 1
    network_configuration {
        assign_public_ip = true
        security_groups = [aws_security_group.sg-ecs.id]
        subnets = [ aws_subnet.public-subnet[0].id, aws_subnet.public-subnet[1].id ]
    }
    load_balancer {
        target_group_arn = aws_lb_target_group.webapp.arn
        container_name = "webapp"
        container_port = "8000"
    }
    tags = {
        Ambiente = "Medcloud-challenge"
    }
}
