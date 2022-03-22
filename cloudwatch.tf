#resource "aws_cloudwatch_log_group" "opensearch_log_group" {
#  name = "opensearch"
#}


#resource "aws_cloudwatch_log_resource_policy" "example" {
#  policy_name = "example"

#  policy_document = <<CONFIG
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Principal": {
#        "Service": "es.amazonaws.com"
#      },
#      "Action": [
#        "logs:PutLogEvents",
#        "logs:PutLogEventsBatch",
#        "logs:CreateLogStream"
#      ],
#      "Resource": "arn:aws:logs:*"
#    }
#  ]
#}
#CONFIG
#}
