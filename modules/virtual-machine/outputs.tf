# output "virtual_machine_details" {
#   value = {
#     for vm_name, vm in var.virtual_machines : vm_name => {
#       name                = vm_name
#       os_type             = vm.type
#       vm_size             = vm.vm_size
#       disk_size_gb        = vm.disk_size_gb
#       private_ip          = vm.private_ip != "" ? vm.private_ip : null
#       public_ip_enabled   = vm.public_ip.enabled
#       public_ip           = vm.public_ip.enabled ? azurerm_public_ip.public_ip[vm_name].ip_address : null
#       network_interface   = vm.type == "windows" ? azurerm_network_interface.windows_nic[vm_name].id : azurerm_network_interface.linux_nic[vm_name].id
#     }
#   }
#   description = "Details of all virtual machines (VM name, OS type, size, IP configuration, etc.)"
# }

output "virtual_machine_details" {
  value = {
    for vm_name, vm in var.virtual_machines : vm_name => {
      name                = vm_name
      os_type             = vm.type
      vm_size             = vm.vm_size
      disk_size_gb        = vm.disk_size_gb
      private_ip          = vm.private_ip != "" ? vm.private_ip : null
      public_ip_enabled   = vm.public_ip.enabled
      public_ip           = vm.public_ip.enabled ? (
        vm.type == "windows" ? azurerm_public_ip.pip-windows[vm_name].ip_address :
        azurerm_public_ip.pip-linux[vm_name].ip_address
      ) : null
      network_interface   = vm.type == "windows" ? azurerm_network_interface.windows_nic[vm_name].id : azurerm_network_interface.linux_nic[vm_name].id
    }
  }
  description = "Details of all virtual machines (VM name, OS type, size, IP configuration, etc.)"
}
