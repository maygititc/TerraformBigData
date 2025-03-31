# examples/main.tf

module "azure_infrastructure" {
  source = "../"  # Path to the module directory
  
  resource_group_name      = "big-data-analytics-rg"
  location                 = "UK South"
  storage_account_name     = "myanalyticsstore2025"
  data_factory_name        = "my-analytics-adf"
  databricks_name          = "my-analytics-databricks"
  eventhub_namespace_name  = "my-analytics-eventhub-ns"
  eventhub_name            = "my-analytics-eventhub"
  app_service_plan_name    = "my-analytics-asp"
  function_app_name        = "my-analytics-function"
  cosmosdb_account_name    = "my-analytics-cosmos"
  cosmosdb_database_name   = "analytics"
  servicebus_namespace_name = "my-analytics-sb-ns"
  servicebus_queue_name    = "analytics-queue"
  data_lake_filesystem_name = "analyticslake"
  
  tags = {
    Environment = "Development"
    Project     = "Data Analytics Platform"
    Owner       = "Data Team"
  }
}

output "function_app_hostname" {
  value = module.azure_infrastructure.function_app_default_hostname
}

output "databricks_workspace_url" {
  value = module.azure_infrastructure.databricks_workspace_url
}