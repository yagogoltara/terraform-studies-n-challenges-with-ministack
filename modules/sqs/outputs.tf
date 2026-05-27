output "sqs_queue_arn" {
  description = "SQS Queue ARN"
  value       = aws_sqs_queue.this.arn
}

output "sqs_queue_url" {
  description = "SQS Queue URL"
  value       = aws_sqs_queue.this.url
}

