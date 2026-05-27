variable "loan_queues_config" {
  type = map(object({
    delay_seconds     = number
    retention_seconds = number
    message_size      = number
  }))
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "tags" {
  type = map(string)
}
