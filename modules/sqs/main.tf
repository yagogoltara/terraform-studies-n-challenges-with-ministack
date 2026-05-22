resource "aws_sqs_queue" "skybank_sqs_payment_queues" {
  name                      = "${var.project_name}-${var.sqs_queue_name}-${var.environment}"
  delay_seconds             = var.delay_seconds
  message_retention_seconds = var.message_retention_seconds
  max_message_size          = var.max_message_size
  tags                      = local.common_tags
}
