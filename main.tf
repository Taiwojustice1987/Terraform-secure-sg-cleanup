resource "aws_lambda_function" "sg_remediation" {
  function_name = "sg-remediation-lambda"
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"
  role          = aws_iam_role.lambda_sg_remediation_role.arn
  filename      = "lambda/sg_remediation.zip"
  source_code_hash = filebase64sha256("lambda/sg_remediation.zip")
  timeout       = 60
}

resource "aws_cloudwatch_event_rule" "every_hour" {
  name                = "sg-remediation-hourly"
  description         = "Trigger Lambda every hour"
  schedule_expression = "rate(1 hour)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.every_hour.name
  target_id = "SGRemediationLambda"
  arn       = aws_lambda_function.sg_remediation.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sg_remediation.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_hour.arn
}
