# Overview
This repo is an Azure Windows VM consumable compatible with the CAF LZ. The design philosophy of this consumable is that it is meant to be run by a pipeline, therefore there is a level of abstraction from the user for values which should be set in the answers file (windows-vm.tfvars). The Terraform configuration files are scaffolded at the root of the repo.

------------

# Requirements
1. Populate the `windows-vm.tfvars` answers file accordingly for your environment. Reference `examples` for a sample.
2. Ensure `-var-file` in `Makefile` points to a valid `.tfvars` answers file.
3. In `test/main_test.go`, ensure the `VarFiles` points to a valid `.tfvars` answers file.
4. In `test/Makefile`, ensure the `Makefile` targets are named accurately to reflect the abstractions of the `go` test suite. 
5. In `.github/workflows/integration_pipeline.yml`, ensure the `working-directory` path for Terratest is valid `(line # 42,45)` and the `run` command on `line 46` references a valid `Makefile` target. 

------------

# Limitations
N/A

------------

# Usage
To trigger a CI build in Github Actions, submit your dev/feature branch as a pull request (PR).

To trigger terratest in the local environment:
```bash
$ cd test
$ make test-windowsvm
```

To deploy to an Azure tenant:
```bash
$ make apply
```

To destroy the infra in the Azure tenant:
```bash
$ make destroy
```

To cleanup the TF configuration files in your local dev env:
```bash
$ make clean
```

------------
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.8 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 2.88.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | = 2.88.1 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_AddDisks"></a> [AddDisks](#module\_AddDisks) | ./modules/addDisks_v1 | n/a |
| <a name="module_InitializeDisks"></a> [InitializeDisks](#module\_InitializeDisks) | ./modules/WindowsScriptExtension_v1 | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_backup_protected_vm.protection_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/resources/backup_protected_vm) | resource |
| [azurerm_key_vault_key.disks](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_secret.password](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/resources/key_vault_secret) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_extension.ADE](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.IaaSAntimalware](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/resources/virtual_machine_extension) | resource |
| [azurerm_windows_virtual_machine.main](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/resources/windows_virtual_machine) | resource |
| [null_resource.delay](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azurerm_backup_policy_vm.protection_policy](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/data-sources/backup_policy_vm) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.PWkeyvault](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.disks](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/data-sources/key_vault) | data source |
| [azurerm_resource_group.resourcegroup](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.net](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/data-sources/subnet) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/data-sources/subscription) | data source |
| [azurerm_virtual_network.net](https://registry.terraform.io/providers/hashicorp/azurerm/2.88.1/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_Disk_Encryt_key_vault_name"></a> [Disk\_Encryt\_key\_vault\_name](#input\_Disk\_Encryt\_key\_vault\_name) | The name of the Key Vault to use for Disk Encryption. | `string` | `""` | no |
| <a name="input_Disk_Encryt_key_vault_resource_group"></a> [Disk\_Encryt\_key\_vault\_resource\_group](#input\_Disk\_Encryt\_key\_vault\_resource\_group) | The name of the Resource Group that contains the  Key Vault to be used for Disk Encryption. | `string` | `""` | no |
| <a name="input_Encrpyt_all_VM_Disks"></a> [Encrpyt\_all\_VM\_Disks](#input\_Encrpyt\_all\_VM\_Disks) | Set to true to encrpyt all the disks. | `bool` | `false` | no |
| <a name="input_PW_key_vault_name"></a> [PW\_key\_vault\_name](#input\_PW\_key\_vault\_name) | The name of the Key Vault where the password will be stored. | `string` | `""` | no |
| <a name="input_PW_key_vault_resource_group"></a> [PW\_key\_vault\_resource\_group](#input\_PW\_key\_vault\_resource\_group) | The name of the Resource Group that holds the Key Vault to be used for password storage. | `string` | `""` | no |
| <a name="input_SRId"></a> [SRId](#input\_SRId) | This is the Order ID of the DWPa Service Request to build the Azure Resource. | `string` | `""` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The admin password for the VM.  If the admin PW is blank, randomly generte one.  store\_admin\_password\_in\_KV can be used to store it in an Azure Key Vault. | `string` | `""` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | Default login account name. | `string` | `"adminuser"` | no |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | The availibility set is created outside of this process.  If this string is empty, then VM will not use AV Set.  Otherwise, it should be the AV Set ID. | `string` | `""` | no |
| <a name="input_backup_vault_enabled"></a> [backup\_vault\_enabled](#input\_backup\_vault\_enabled) | VM will be added to the backup policy specified in backup\_vault\_name - backup\_vault\_policy\_name if true. | `bool` | `false` | no |
| <a name="input_backup_vault_name"></a> [backup\_vault\_name](#input\_backup\_vault\_name) | The backup policy is assigned in this TF. | `string` | `""` | no |
| <a name="input_backup_vault_policy_name"></a> [backup\_vault\_policy\_name](#input\_backup\_vault\_policy\_name) | Resource Group of the Backup Vault referenced in backup\_vault\_name. | `string` | `""` | no |
| <a name="input_backup_vault_resource_group"></a> [backup\_vault\_resource\_group](#input\_backup\_vault\_resource\_group) | Resource Group of the Backup Vault referenced in backup\_vault\_name. | `string` | `""` | no |
| <a name="input_data_disk_details"></a> [data\_disk\_details](#input\_data\_disk\_details) | A map of disks to add.  MAKE SURE THE LUNID IS UNIQUE or the process will fail.  An empty array (e.g. []) will not add disks. | `map(object({ disk_size_gb = number, managed_disk_type = string, lunID = number }))` | `{}` | no |
| <a name="input_image_URN"></a> [image\_URN](#input\_image\_URN) | Azure Image Publisher, Offer, SKU, and Version in one string separate by a colon (:).  I.e 'Publisher:Offer:Sku:Version'.  Further information here - https://docs.microsoft.com/en-us/azure/virtual-machines/windows/cli-ps-findimage | `string` | n/a | yes |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | The type of disk cahcing enabled on the OS disk. | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_disk_size_gb"></a> [os\_disk\_disk\_size\_gb](#input\_os\_disk\_disk\_size\_gb) | The size of the OS disk. | `string` | `"127"` | no |
| <a name="input_os_disk_managed_disk_type"></a> [os\_disk\_managed\_disk\_type](#input\_os\_disk\_managed\_disk\_type) | The type of disk to use for the OS disk. | `string` | `"StandardSSD_LRS"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The Resource Group for the virtual machine. | `string` | n/a | yes |
| <a name="input_store_admin_password_in_KV"></a> [store\_admin\_password\_in\_KV](#input\_store\_admin\_password\_in\_KV) | True value stores the password in a Key Vault for safe keeping.  If the admin\_password is blank, then a random password will be generated and may need to be stored for use. | `bool` | `false` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID of the subnet to join the VM to. | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Subscription ID | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the Virtual Machine. | `map(any)` | `{}` | no |
| <a name="input_tags_customer_sub"></a> [tags\_customer\_sub](#input\_tags\_customer\_sub) | These tags can be set in SubID.auto.tfvars.json.  They will apply to all Azure Resources built in a subscription matching the subID. | `map(any)` | `{}` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Tenant ID | `string` | n/a | yes |
| <a name="input_use_dynamic_plan"></a> [use\_dynamic\_plan](#input\_use\_dynamic\_plan) | If true, the image details (publisher, offer, etc.) will be used in by a plan block which describes a Marketplace Image. | `bool` | `false` | no |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | The name of the virtual machine to be created. | `string` | n/a | yes |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Azure VM size. example 'Standard\_DS2s\_v2'. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rg_id"></a> [rg\_id](#output\_rg\_id) | Resource Group ID |
| <a name="output_rg_name"></a> [rg\_name](#output\_rg\_name) | Resource Group Name |
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | Subnet ID |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | Subnet name |
| <a name="output_virtual_machine_id"></a> [virtual\_machine\_id](#output\_virtual\_machine\_id) | Windows VM ID |
| <a name="output_virtual_machine_name"></a> [virtual\_machine\_name](#output\_virtual\_machine\_name) | Windows VM name |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | vNet ID |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | vNet Name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->