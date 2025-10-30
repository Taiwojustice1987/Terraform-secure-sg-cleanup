output "lambda_function_name" {
  value       = aws_lambda_function.sg_remediation.function_name
  description = "The name of the SG remediation Lambda function"
}

output "cloudwatch_rule" {
  value       = aws_cloudwatch_event_rule.every_hour.name
  description = "The CloudWatch EventBridge rule that triggers Lambda"
}
