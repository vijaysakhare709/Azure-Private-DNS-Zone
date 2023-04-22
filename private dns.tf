# Resource-1 Azure private dns zone
resource "azurerm_private_dns_zone" "priavte_dns_zone" {
  name                = "mydomain.com" # anything because priavte hai to chalenga kuch bhi ager public hota to nahi chalta
  resource_group_name = azurerm_resource_group.vijay.name  #   resource group jo bhi hai
}


# Resource-2 Azure associate private zone to virtual network

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "test"  # anything as our need
  resource_group_name   = azurerm_resource_group.vijay.name
  private_dns_zone_name = azurerm_private_dns_zone.priavte_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.example.id       # jo bhi virtual network mai lgna uski virtual network id
}

# Resource-3 Interanal load balancer DNS A record

resource "azurerm_private_dns_a_record" "example" {
  name                = "applb"
  zone_name           = azurerm_private_dns_zone.priavte_dns_zone.name
  resource_group_name = azurerm_resource_group.vijay.name
  ttl                 = 300
  records             = ["azurerm_lb.app_lb.frontend_ip_configuration[0].private_ip_address"]  # yaha private ip address diya quki private dns create kiya hai islye otherwise public ip de diya hota or waise bhi load balancer internal hai 
}

