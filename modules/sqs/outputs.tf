output "sqs_queue_arn" {
  description = "SQS Queue ARN"
  value       = { for k, v in aws_sqs_queue.skybank_sqs_payment_queues : k => v.arn }
}
