module "loan_queues" {
  source                    = "./modules/sqs"
  for_each                  = var.loan_queues_config
  queue_name                = "${var.project_name}-${each.key}-${var.environment}"
  delay_seconds             = each.value.delay_seconds
  max_message_size          = each.value.message_size
  message_retention_seconds = each.value.retention_seconds
  tags                      = var.tags
}

module "pix_queue" {
  source                    = "./modules/sqs"
  for_each                  = toset(var.pix_queue_names)
  queue_name                = "${var.project_name}-${each.value}-${var.environment}"
  max_message_size          = var.pix_max_message_size
  delay_seconds             = var.pix_delay_seconds
  message_retention_seconds = var.pix_message_retention_seconds
  tags                      = var.tags
}
