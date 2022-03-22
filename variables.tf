#Nome
variable "elastic_domain_name" {
  type        = string
  description = "(Required) This will be the name of the cluster."
  default     = "opensearch-2wenergia"
}

variable "region" {
  type        = string
  description = "(Required) Region"
  default     = "sa-east-1"
}

#Versao
variable "elastic_version" {
  type        = number
  description = "(Optional) Version of Elasticsearch to deploy."
  default     = "7.10"
}

variable "az_number" {
  type        = number
  description = "Number of Availability Zones for the domain to use with zone_awareness_enabled. Defaults to 2. Valid values: 2 or 3."
  default     = "3"
}

variable "elastic_instance_number" {
  type        = number
  description = "(Optional) Number of instances in the cluster."
  default     = "3"
}

variable "elastic_instance_type" {
  type        = string
  description = " (Optional) Instance type of data nodes in the cluster. please check [aws documentation](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/supported-instance-types.html) "
  default     = "t3.medium.elasticsearch"
}

#variable "kms_multi_region" {
#  type        = bool
#  description = "(Optional) Opção de Multi AZ da chave KMS"
#  default     = false
#}

variable "elastic_acm_certificate" {
  type        = string
  description = "(Optional) ACM certificate ARN for your custom endpoint."
  default     = "arn:"
}

variable "elastic_endpoint" {
  type        = string
  description = "(Optional) Fully qualified domain for your custom endpoint."
  default     = "opensearch.2wenergia.com.br"
}

#Usuario
variable "master_name" {
  type        = string
  description = "(Optional) Main user's username, which is stored in the Amazon Elasticsearch Service domain's internal database. Only specify if internal_user_database_enabled is set to true."
  default     = ""

}
variable "master_password" {
  type        = string
  description = "(Optional) Main user's password, which is stored in the Amazon Elasticsearch Service domain's internal database. Only specify if internal_user_database_enabled is set to true"
  default     = ""
}

#EBS
variable "iops_option" {
  type        = number
  description = "(Optional) Baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type."
  default     = null
}

variable "volume_size_option" {
  type        = number
  description = "(Required if ebs_enabled is set to true.) Size of EBS volumes attached to data nodes (in GiB)."
  default     = "10"
}

variable "volume_type_option" {
  type        = string
  description = "(Optional) Type of EBS volumes attached to data nodes."
  default     = null
}


