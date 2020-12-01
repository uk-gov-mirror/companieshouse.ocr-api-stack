locals {
  service_name = "ocr-api"
  ocr_api_proxy_port = 11000 # local port number defined for proxy target of tdg service sitting behind eric
}

resource "aws_ecs_service" "ocr-api-ecs-service" {
  name            = "${var.environment}-${local.service_name}"
  cluster         = var.ecs_cluster_id
  task_definition = aws_ecs_task_definition.ocr-api-task-definition.arn
  desired_count   = 1
  depends_on      = [var.tocr-api-lb-arn]
  load_balancer {
    target_group_arn = aws_lb_target_group.ocr-api-target_group.arn
    container_port   = var.ocr_api_application_port
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
      external_top_level_domain  : var.external_top_level_domain
      log_level                  : var.log_level
      docker_registry            : var.docker_registry

      # tdg specific configs
      ocr_api_release_version    : var.ocr_api_release_version
      ocr_api_proxy_port         : local.ocr_api_proxy_port
    },
      var.secrets_arn_map
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
  # Add heath check port here in drop 2
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
