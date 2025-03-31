# main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Storage Account (Blob)
resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true
  tags                     = var.tags
}

resource "azurerm_storage_container" "main" {
  name                  = "${var.storage_account_name}-container"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

# Azure Data Factory
resource "azurerm_data_factory" "main" {
  name                = var.data_factory_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

# Azure Databricks
resource "azurerm_databricks_workspace" "main" {
  name                = var.databricks_name
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "standard"
  tags                = var.tags
}

# Azure Event Hubs
resource "azurerm_eventhub_namespace" "main" {
  name                = var.eventhub_namespace_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard"
  capacity            = 1
  tags                = var.tags
}

resource "azurerm_eventhub" "main" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.main.name
  resource_group_name = azurerm_resource_group.main.name
  partition_count     = 2
  message_retention   = 1
}

# Azure Function App
resource "azurerm_app_service_plan" "main" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "FunctionApp"
  reserved            = true # Required for Linux

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
  tags = var.tags
}

resource "azurerm_function_app" "main" {
  name                       = var.function_app_name
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  app_service_plan_id        = azurerm_app_service_plan.main.id
  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  version                    = "~4"
  os_type                    = "linux"
  
  site_config {
    linux_fx_version = "DOTNET|6.0"
  }
  
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet"
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
  
  tags = var.tags
}

# Azure Cosmos DB
resource "azurerm_cosmosdb_account" "main" {
  name                = var.cosmosdb_account_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  geo_location {
    location          = azurerm_resource_group.main.location
    failover_priority = 0
  }

  tags = var.tags
}

resource "azurerm_cosmosdb_sql_database" "main" {
  name                = var.cosmosdb_database_name
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.main.name
  throughput          = 400
}

# Azure Service Bus
resource "azurerm_servicebus_namespace" "main" {
  name                = var.servicebus_namespace_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_servicebus_queue" "main" {
  name                = var.servicebus_queue_name
  namespace_id        = azurerm_servicebus_namespace.main.id
}

# Azure Data Lake Storage (Using the previously created storage account with HNS enabled)
resource "azurerm_storage_data_lake_gen2_filesystem" "main" {
  name               = var.data_lake_filesystem_name
  storage_account_id = azurerm_storage_account.main.id
}