#descomentar para utilizar chave KMS customizada
#resource "aws_kms_key" "elastic_kms_key" {
#    description             = "Chave KMS do opensearch"
#    multi_region = var.kms_multi_region
#  
#}
#
#resource "aws_kms_alias" "elastic_kms_alias" {
#  name          = "alias/elastic-kms-key"
#  target_key_id = aws_kms_key.elastic_kms_key.key_id
#}