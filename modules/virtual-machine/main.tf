resource "azurerm_network_interface" "windows_nic" {
  for_each = { for k, v in var.virtual_machines : k => v if v.type == "windows" }

  name                = "nic-${each.value.name}-${var.environment.region.primary}"
  location            = var.network.resource_group.location
  resource_group_name = var.network.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.network.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = each.value.public_ip.enabled ? azurerm_public_ip.pip-windows[each.key].id : null
  }

  tags = merge(var.tags, {
    "OSType" = "Windows"
  })
}

resource "azurerm_network_interface" "linux_nic" {
  for_each = { for k, v in var.virtual_machines : k => v if v.type == "linux" }

  name                = "nic-${each.value.name}-${var.environment.region.primary}"
  location            = var.network.resource_group.location
  resource_group_name = var.network.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.network.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = each.value.public_ip.enabled ? azurerm_public_ip.pip-linux[each.key].id : null
  }


  tags = merge(var.tags, {
    "OSType" = "Linux"
  })
}

resource "azurerm_public_ip" "pip-windows" {
  for_each = {
    for k, v in var.virtual_machines : k => v 
    if v.public_ip.enabled == true
  }

  name                = "pip-${each.value.name}-${var.environment.region.primary}"
  location            = var.network.resource_group.location
  resource_group_name = var.network.resource_group.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = merge(var.tags, {
    "OSType" = each.value.type
  })
}

resource "azurerm_public_ip" "pip-linux" {
  for_each = {
    for k, v in var.virtual_machines : k => v 
    if v.public_ip.enabled == true
  }

  name                = "pip-${each.value.name}-${var.environment.region.primary}"
  location            = var.network.resource_group.location
  resource_group_name = var.network.resource_group.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  tags = merge(var.tags, {
    "OSType" = each.value.type
  })
}

# resource "azurerm_network_interface" "nic" {
#   for_each = var.virtual_machines

#   name                = "nic-${each.key}-${var.environment.region.primary}"
#   location            = var.network.resource_group.location
#   resource_group_name = var.network.resource_group.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = var.network.subnet_id
#     private_ip_address_allocation = "Dynamic"
#   }

#   tags = var.tags
# }

resource "azurerm_windows_virtual_machine" "vm-windows" {
  for_each = { for k, v in var.virtual_machines : k => v if v.type == "windows" }

  name                = each.value.name
  computer_name       = replace(each.value.name, "[^a-zA-Z0-9]", "")
  resource_group_name = var.network.resource_group.name
  location            = var.network.resource_group.location
  size                = each.value.vm_size != null ? each.value.vm_size : "Standard_B1s"

  admin_username = each.value.username
  admin_password = each.value.password

  network_interface_ids = [azurerm_network_interface.windows_nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = each.value.disk_size_gb
  }

  source_image_reference {
  publisher = each.value.image.publisher
  offer     = each.value.image.offer
  sku       = each.value.image.sku
  version   = each.value.image.version
}
  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "vm-linux" {
  for_each = { for k, v in var.virtual_machines : k => v if v.type == "linux" }

  name                = each.value.name
  computer_name       = replace(each.value.name, "[^a-zA-Z0-9]", "")
  resource_group_name = var.network.resource_group.name
  location            = var.network.resource_group.location
  size                = each.value.vm_size != null ? each.value.vm_size : "Standard_B1s"

  admin_username                  = each.value.username
  admin_password                  = each.value.password
  disable_password_authentication = false

  network_interface_ids = [azurerm_network_interface.linux_nic[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = each.value.disk_size_gb
  }

    source_image_reference {
    publisher = each.value.image.publisher
    offer     = each.value.image.offer
    sku       = each.value.image.sku
    version   = each.value.image.version
}
  tags = var.tags
}
