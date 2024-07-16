# ----ecs/main.tf -----

# criação de policy e roles
resource "aws_iam_role" "ecs_task_execution_role" {
    name = "restapirole"
    assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
    role = aws_iam_role.ecs_task_execution_role.name
    policy_arn = data.aws_iam_policy.ecs_task_execution_role.arn
}

#Log Group
resource "aws_cloudwatch_log_group" "log_group" {
    name = "/ecs/${var.app_name}"
}

#ECS
resource "aws_ecs_cluster" "cluster_ecs" {
    name = "${var.app_name}-cluster"
    tags = {
    }
}

resource "aws_ecs_task_definition" "task_definition" {
    family = "${var.app_name}-service"
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
    container_definitions = jsonencode([
        {
            name = "${var.app_name}-container"
            image = var.container_image
            cpu = 256
            memory = 512
            essential = true
            portMappings = [
                {
                    containerPort = var.app_port
                    hostPort = var.app_port
                    protocol = "tcp"
                }    
            ]
            environment = var.env_vars
            logConfiguration = {
                logDriver = "awslogs"
                options = {
                    awslogs-create-group = "true"
                    awslogs-region = var.aws_region
                    awslogs-group = "/ecs/${var.app_name}"
                    awslogs-stream-prefix = "ecs"
                }
            }
        }
    ])
    cpu = 256
    memory = 512
    requires_compatibilities = [ "FARGATE" ]
    network_mode = "awsvpc"
    runtime_platform {
      cpu_architecture = "X86_64"
      operating_system_family = "LINUX"
    }
}


resource "aws_ecs_service" "ecs_service" {
    name = "${var.app_name}-service"
    task_definition = aws_ecs_task_definition.task_definition.arn 
    cluster = aws_ecs_cluster.cluster_ecs.id
    launch_type = "FARGATE"
    desired_count = 1
    network_configuration {
        assign_public_ip = true
        security_groups = var.security_group
        subnets = var.subnet_ids
    }
    load_balancer {
        target_group_arn = var.target_group_arn
        container_name = "${var.app_name}-container"
        container_port = "${var.app_port}"
    }
}
