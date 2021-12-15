admin_password             = "" #insert password here 
subnet_id                  = "/subscriptions/TBD-SubscriptionId/resourceGroups/RG-TF-Test-WinVMModule/providers/Microsoft.Network/virtualNetworks/vnet-Tf-Test-WInVMModule/subnets/default"
backup_vault_enabled       = false
use_dynamic_plan           = false
vm_name                    = "vmWindows-022"
availability_set_id        = null
image_URN                  = "MicrosoftWindowsServer:WindowsServer:2019-Datacenter-smalldisk:latest"
Encrpyt_all_VM_Disks       = false
vm_size                    = "Standard_D4s_v4"
SRId                       = "11555"
resource_group_name        = "RG-TF-Test-WinVMModule"
tenant_id                  = "TBD-TenantId"
subscription_id            = "TBD-SubscriptionId"
store_admin_password_in_KV = false
data_disk_details = {
  12 = {
    disk_size_gb      = 100,
    managed_disk_type = "StandardSSD_LRS",
    lunID             = 12
  },
  13 = {
    disk_size_gb      = 100,
    managed_disk_type = "StandardSSD_LRS",
    lunID             = 13
  },
}
tags = {
  first = "First tag Windows VM"
}
admin_username = "adminusername"
