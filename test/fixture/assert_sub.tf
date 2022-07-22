data "azurerm_client_config" "current" {}

# locals {
#   #Terraform does not have an assert function, so this is a work around.  It does nothing, unless there is an error and then the Terraform fails.

#   # Assert the provided tenant is the same as the one logged into.
#   assert_target_tenant_matches_current = data.azurerm_client_config.current.tenant_id == var.target_tenant_id ? null : file("ERROR: The tenant found by Terraform does not match the target tenant provided as a variable.")

#   # Assert the provided subscription is the same as the one logged into.
#   assert_target_sub_matches_current = data.azurerm_client_config.current.subscription_id == var.target_subscription_id ? null : file("ERROR: The tenant found by Terraform does not match the target tenant provided as a variable.")
# }

# resource "null_resource" "assert_target_tenant_matches_current" {
#   # Assert the provided tenant is the same as the one logged into.
#   count = data.azurerm_client_config.current.tenant_id == var.target_tenant_id ? 0 : "ERROR: The tenant found by Terraform does not match the target tenant provided as a variable."
# }

# resource "null_resource" "assert_target_sub_matches_current" {
#   # Assert the provided tenant is the same as the one logged into.
#   count = data.azurerm_client_config.current.subscription_id == var.target_subscription_id ? 0 : "ERROR: The subsciption found by Terraform does not match the target subsciption provided as a variable."
# }