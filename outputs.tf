output "sqs_queue_arn" {
  description = "SQS Queue ARN"
  value       = module.sqs.sqs_queue_name.arn
}
