locals {
  common_tags = merge(var.tags, {
    Env = var.environment
  })
}
