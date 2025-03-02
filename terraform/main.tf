resource "azurerm_resource_group" "proyecto_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_public_ip" "proyecto_public_ip" {
  name                = "proyecto-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.proyecto_rg.name
  allocation_method   = "Static"
}

resource "azurerm_virtual_network" "proyecto_vnet" {
  name                = "proyecto-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.proyecto_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "proyecto_subnet" {
  name                 = "proyecto-subnet"
  resource_group_name  = azurerm_resource_group.proyecto_rg.name
  virtual_network_name = azurerm_virtual_network.proyecto_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "proyecto_nic" {
  name                = "proyecto-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.proyecto_rg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.proyecto_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.proyecto_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "proyecto_vm" {
  name                = "proyecto-vm"
  resource_group_name = azurerm_resource_group.proyecto_rg.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.vm_admin_user
  network_interface_ids = [azurerm_network_interface.proyecto_nic.id]
  admin_ssh_key {
    username   = var.vm_admin_user
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
resource "azurerm_network_security_group" "proyecto_nsg" {
  name                = "proyecto-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.proyecto_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1010
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Asociar el NSG a la NIC (Interfaz de red)
resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.proyecto_nic.id
  network_security_group_id = azurerm_network_security_group.proyecto_nsg.id
}
