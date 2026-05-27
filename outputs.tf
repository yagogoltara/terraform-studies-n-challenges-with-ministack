output "queue_arn" {
  value = concat([for p in module.pix_queue : p.sqs_queue_arn], [for q in module.loan_queues : q.sqs_queue_arn])
}

output "queue_url" {
  value = concat([for p in module.pix_queue : p.sqs_queue_url], [for q in module.loan_queues : q.sqs_queue_url])
}
