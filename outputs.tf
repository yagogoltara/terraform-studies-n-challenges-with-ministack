output "sqs_queue_arn" {
  description = "SQS Queue ARN"
  value       = { for k, v in aws_sqs_queue.skybank_sqs_payment_queues : k => v.arn }
}
output "s3_bucket_logs_id" {
  value = aws_s3_bucket.skybank_s3_bucket_logs.id
}

output "s3_bucket_configs_id" {
  value = aws_s3_bucket.skybank_s3_bucket_configs.id
}
