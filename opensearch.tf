
#Criação do DOMAIN
resource "aws_elasticsearch_domain" "elastic_domain" {
  domain_name           = var.elastic_domain_name
  elasticsearch_version = var.elastic_version

  #Configuração de VPC para uso privado (sem passar pela internet) - --falta alterar os ids das subnets---
  #vpc_options {
  #   subnet_ids = [
  #     data.aws_subnet_ids.selected.ids[0],
  #     data.aws_subnet_ids.selected.ids[1],
  #   ]
  #
  #    security_group_ids = [aws_security_group.elastic_sg.id]
  #   testando dependencia da criação do SG
  #   depends_on = [
  #   aws_security_group.elastic_sg,
  #   ]
  # }

  #Opção de Master user
  advanced_security_options {
    enabled                        = true
    internal_user_database_enabled = true
    master_user_options {
      master_user_name             = var.master_name
      master_user_password         = var.master_password
    }
  }

  #HTTPS
  domain_endpoint_options {
    enforce_https                   = true
#    custom_endpoint_enabled         = true
#    custom_endpoint                 = var.elastic_endpoint
#    custom_endpoint_certificate_arn = var.elastic_acm_certificate
    tls_security_policy             = "Policy-Min-TLS-1-2-2019-07"
  }

  #Opção de Encriptação KMS
  encrypt_at_rest {
    enabled = true
    #    Para utilizar kms
    #    kms_key_id = aws_kms_key.elastic_kms_key.id 
  }

  node_to_node_encryption {
    enabled = true
  }

  #Configurações do cluster
  cluster_config {
    #Tamanho do cluster  
    instance_type  = var.elastic_instance_type
    instance_count = var.elastic_instance_number
    #Quantidade de AZs que será utilizada pelo domain = 2 ou 3
    zone_awareness_enabled = true
    zone_awareness_config {
      availability_zone_count = var.az_number
    }
  }

  #EBS
  ebs_options {
    ebs_enabled = true
  #  iops        = var.iops_option
    volume_size = var.volume_size_option
 #   volume_type = var.volume_type_option
  }

  #Cloudwatch
  #log_publishing_options {
  #  cloudwatch_log_group_arn = aws_cloudwatch_log_group.opensearch_log_group.arn
  #  log_type                 = "INDEX_SLOW_LOGS"
  #}

  #dependencia para criar o service-linked-role
  #depends_on = [aws_iam_service_linked_role.es]
}

#Policy de acesso do opensearch
resource "aws_elasticsearch_domain_policy" "opensearch_policy" {
  domain_name = aws_elasticsearch_domain.elastic_domain.domain_name

  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "${aws_elasticsearch_domain.elastic_domain.arn}/*"
        }
    ]
}
POLICIES
}

#Criação do service linked role necessário para usar acesso via VPC
#resource "aws_iam_service_linked_role" "es" {
#  aws_service_name = "es.amazonaws.com"
#}

#data "aws_vpc" "selected" {
#  id = var.vpc_id
#}

#Security Group - Restringindo acesso à VPC
#resource "aws_security_group" "elastic_sg" {
#  name        = "Opensearch Security Group"
#  description = "Managed by Terraform"
#  vpc_id      = data.aws_vpc.selected.id
#
#  ingress {
#    from_port = 443
#    to_port   = 443
#    protocol  = "tcp"
#
#    cidr_blocks = [
#      data.aws_vpc.selected.cidr_block,
#    ]
#  }
#}

