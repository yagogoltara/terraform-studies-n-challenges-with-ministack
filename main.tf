module "sqs" {
  source                    = "./modules/sqs"
  for_each                  = var.sqs_queue_name
  project_name              = var.project_name
  environment               = var.environment
  delay_seconds             = var.delay_seconds
  max_message_size          = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  sqs_queue_name            = each.value
  tags                      = var.tags
  region                    = var.region
}
