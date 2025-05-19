resource_groups = {
  rg1 = {
    name     = "cmaz-vwx4iuxh-mod5-rg-01"
    location = "eastus"
    tags = {
      Creator = "pellakuru_navyasri@epam.com"
    }
  }
  rg2 = {
    name     = "cmaz-vwx4iuxh-mod5-rg-02"
    location = "westus"
    tags = {
      Creator = "pellakuru_navyasri@epam.com"
    }
  }
  rg3 = {
    name     = "cmaz-vwx4iuxh-mod5-rg-03"
    location = "centralus"
    tags = {
      Creator = "pellakuru_navyasri@epam.com"
    }
  }
}

app_service_plans = {
  asp1 = {

    name         = "cmaz-vwx4iuxh-mod5-asp-01"
    location     = "eastus"
    sku_name     = "P0v3"
    worker_count = 2
    rg_key       = "rg1"
    os_type      = "Linux"
    tags = {
      Creator = "pellakuru_navyasri@epam.com"
    }
  }
  asp2 = {
    name         = "cmaz-vwx4iuxh-mod5-asp-02"
    rg_key       = "rg2"
    location     = "westus"
    sku_name     = "P1v3"
    os_type      = "Windows"
    worker_count = 1
    tags = {
      Creator = "pellakuru_navyasri@epam.com"
    }
  }
}


app_services = {
  app1 = {
    name                = "cmaz-vwx4iuxh-mod5-app-01"
    resource_group_name = "cmaz-vwx4iuxh-mod5-rg-01"
    name                = "cmaz-vwx4iuxh-mod5-app-01"
    resource_group_name = "cmaz-vwx4iuxh-mod5-rg-01"
    location            = "eastus"
    app_service_plan_id = ""
    allowed_ip_addresses = {
      ip1 = {
        name       = "allow-ip"
        ip_address = "18.153.146.156/32"
        priority   = 101
      }
    }
    tm_rule = {
      name     = "allow-tm"
      priority = 100
    }
    tags = {
      Creator = "pellakuru_navyasri@epam.com"
    }
  }
  app2 = {
    name                = "cmaz-vwx4iuxh-mod5-app-02"
    resource_group_name = "cmaz-vwx4iuxh-mod5-rg-02"
    name                = "cmaz-vwx4iuxh-mod5-app-02"
    resource_group_name = "cmaz-vwx4iuxh-mod5-rg-02"
    location            = "westus"
    app_service_plan_id = ""
    allowed_ip_addresses = {
      ip1 = {
        name       = "allow-ip"
        ip_address = "18.153.146.156/32"
        priority   = 101
      }
    }
    tm_rule = {
      name     = "allow-tm"
      priority = 100
    }
    tags = {
      Creator = "pellakuru_navyasri@epam.com"
    }
  }
}

traffic_manager = {
  name                = "cmaz-vwx4iuxh-mod5-traf"
  resource_group_name = "cmaz-vwx4iuxh-mod5-rg-03"
  routing_method      = "Performance"
  tags = {
    Creator = "pellakuru_navyasri@epam.com"
  }
  endpoints = {
    app1 = {
      target_resource_id = ""
      location           = "eastus"
      priority           = 1
    }
    app2 = {
      target_resource_id = ""
      location           = "westus"
      priority           = 2
    }
  }
}