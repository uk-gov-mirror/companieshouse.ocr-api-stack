locals {
  service_name = "ocr-api"
}

resource "aws_ecs_service" "ocr-api-ecs-service" {
  name            = "${var.environment}-${local.service_name}"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.ocr-api-task-definition.arn
  desired_count   = 1
  depends_on      = [var.tocr-api-lb-arn]
  load_balancer {
    target_group_arn = aws_lb_target_group.ocr-api-target_group.arn
    container_port   =  var.ocr_api_application_port
    container_name   = "ocr-api" # [ALB -> target group -> ocr-api] 
  }
}

locals {
  definition = merge(
    {
      service_name               : local.service_name
      environment                : var.environment
      name_prefix                : var.name_prefix
      aws_region                 : var.aws_region
      log_level                  : var.log_level
      docker_registry            : var.docker_registry

      # ocr specific configs
      ocr_api_release_version        : var.ocr_api_release_version
      ocr_api_application_port       : var.ocr_api_application_port
      ocr_tesseract_thread_pool_size : var.ocr_tesseract_thread_pool_size
    }
  )
}

resource "aws_ecs_task_definition" "ocr-api-task-definition" {
  family                = "${var.environment}-${local.service_name}"
  execution_role_arn    = var.task_execution_role_arn
  container_definitions = templatefile(
    "${path.module}/${local.service_name}-task-definition.tmpl", local.definition
  )
}

resource "aws_lb_target_group" "ocr-api-target_group" {
  name     = "${var.environment}-${local.service_name}"
  port     = var.ocr_api_application_port
  protocol = "HTTP" 
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "30"
    matcher             = "200"
    path                = "/ocr-api/healthcheck"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
  }
}

resource "aws_lb_listener_rule" "ocr-api" {
  listener_arn = var.ocr-api-lb-listener-arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ocr-api-target_group.arn
  }
  condition {
    field  = "path-pattern"
    values = ["/ocr-api/*"]
  }
}
