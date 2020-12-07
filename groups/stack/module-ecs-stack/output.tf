output "ocr-api-lb-listener-arn" {
  value = aws_lb_listener.ocr-api-lb-listener.arn
}

output "ocr-api-lb-arn" {
  value = aws_lb.ocr-api-lb.arn
}
