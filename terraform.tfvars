environment = {
  name   = "dev"
  type   = "development"
  region = {
    primary   = "eastus"
    secondary = "westus"
  }
}

common_resource_group = {
  name = "com"
  location = "eastus"
}


resource_group = {
  name = "storage"
  location = "eatus"
}

network_rg = {
  name = "dev-networkrg"
  location = "eastus"
}


storage_accounts = {
  stazuredevopspulse-01 = {
    name             = "stazuredevopspulse01"
    tier             = "Standard"
    replication_type = "LRS"
    enable_failover  = false
    enable_backup    = true
    containers = [
      { name = "backup" },
      { name = "logs" }
    ]
  },
  stazuredevopspulse-02 = { 
    name             = "stazuredevopspulse02"
    tier             = "Standard"
    replication_type = "LRS"
    enable_failover  = true
    enable_backup    = false
    containers = [
      { name = "backup" },
      { name = "archived" }
    ]
  },
  
}

tags = {
  environment    = "dev"               
  App_owner      = "Hriyen"           
  managed_by     = "Terraform"                     
  cost_center    = "CC-12345"  
  business_unit  = "Finance"           
  project        = "E-Commerce-Portal" 
  backup_policy  = "enabled"           
  retention      = "30-days"           
  auto_shutdown  = "enabled"          
  provisioned_by = "Terraform"        
  expiry_date    = "N/A"       
  patching_group = "Group-A"        
  sla            = "99.9%"          
  support_team   = "DevOps"    
}





network = {
  vnet_name   = "vnetpulse100"
  address_space = ["10.0.0.0/16"]
  subnet_name = "dev-subnet"
  address_prefixes = ["10.0.1.0/24"]
  nsg_name    = "my-nsg"
  created_network  = true
  resource_group = {
    name = "pulserg-staging"
    location = "eastus"
  }
  nsg_rules = [
    {
      name                       = "Allow_RDP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "Allow_SSH"
      priority                   = 200
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "Deny_All"
      priority                   = 300
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}


virtual_machines = {
  "windows" = {
    name                = "windowspulse100"
    resource_group_name = "devrg"
    type                = "windows"
    vm_size             = "standard_b1s"
    disk_size_gb        = 127
    image = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2022-Datacenter"
      version   = "latest"
    }
    username = "adminuser"
    password = "password123!"
    public_ip = {
      enabled = false
    }
  },

  # "linux" = {
  #   name                = "Linuxpulse200"
  #   resource_group_name = "rg-pulse"
  #   type                = "linux"
  #   vm_size             = "Standard_B1s"
  #   disk_size_gb        = 127
  #   image = {
  #     publisher = "Canonical"
  #     offer     = "UbuntuServer"
  #     sku       = "20_04-lts"
  #     version   = "latest"
  #   }
  #   username = "adminuser"
  #   password = "password123!"
  #   public_ip = {
  #     enabled = false
  #   }
  # }
}


