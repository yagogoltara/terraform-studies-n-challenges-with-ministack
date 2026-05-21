variable "project_name" {
  description = "Project name"
  type        = string
  nullable    = false
}

variable "s3_bucket_name_configs" {
  description = "S3 Bucket configs"
  type        = string
  nullable    = false
}

variable "s3_bucket_name_logs" {
  description = "S3 Bucket logs"
  type        = string
  nullable    = false
}

variable "sqs_queue_name" {
  description = "SQS Queue name"
  type        = string
  nullable    = false
}

variable "region" {
  description = "AWS Region"
  type        = string
  nullable    = true
}

variable "environment" {
  description = "Environment"
  type        = string
  nullable    = false
}

variable "tags" {
  description = "Common tags used by AWS resources"
  type        = map(string)
  nullable    = false
}

variable "delay_seconds" {
  type        = number
  description = "Delay seconds for delivering message from SQS Queue"
  nullable    = false
}

variable "message_retention_seconds" {
  type        = number
  description = "Message retation in seconds"
  nullable    = false
}

variable "max_message_size" {
  type        = number
  description = "Max message size in bytes"
  nullable    = false
}

