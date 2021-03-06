# SAML: Auth0 credentials
resource "aws_secretsmanager_secret" "auth0_saml" {
  name        = "auth0_saml"
  description = "Auth0 Machine to Machine credentials for Terraform to setup Auth0 for IAM Federated Access"
  tags        = local.global_resources
}

data "aws_secretsmanager_secret_version" "auth0_saml" {
  secret_id = aws_secretsmanager_secret.auth0_saml.id
}

# SAML: GitHub client ID and secrets
resource "aws_secretsmanager_secret" "github_saml" {
  name        = "github_saml"
  description = "GitHub client id and secret for the Ministry of Justice owned OAuth app"
  tags        = local.global_resources
}

data "aws_secretsmanager_secret_version" "github_saml" {
  secret_id = aws_secretsmanager_secret.github_saml.id
}

locals {
  auth0_saml  = jsondecode(data.aws_secretsmanager_secret_version.auth0_saml.secret_string)
  github_saml = jsondecode(data.aws_secretsmanager_secret_version.github_saml.secret_string)
}
