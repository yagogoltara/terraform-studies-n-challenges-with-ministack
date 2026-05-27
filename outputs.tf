output "queue_arn" {
  value = [for q in module.loan_queues : q.sqs_queue_arn]
}

output "queue_url" {
  value = [for q in module.loan_queues : q.sqs_queue_url]
}
