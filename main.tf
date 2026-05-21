resource "aws_s3_bucket" "skybank_s3_bucket_logs" {
  bucket = "${var.project_name}-${var.s3_bucket_name_logs}-${var.environment}"
  tags   = local.common_tags
}

resource "aws_s3_bucket" "skybank_s3_bucket_configs" {
  bucket = "${var.project_name}-${var.s3_bucket_name_configs}-${var.environment}"
  tags   = local.common_tags
}

resource "aws_sqs_queue" "skybank_sqs_payment_queues" {
  for_each                  = toset(var.sqs_queue_name)
  name                      = "${var.project_name}-${each.value}-${var.environment}"
  delay_seconds             = var.delay_seconds
  message_retention_seconds = var.message_retention_seconds
  max_message_size          = var.max_message_size
  tags                      = local.common_tags
}
