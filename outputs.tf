# outputs.tf

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.main.id
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.main.id
}

output "storage_account_primary_access_key" {
  description = "Primary access key for the storage account"
  value       = azurerm_storage_account.main.primary_access_key
  sensitive   = true
}

output "data_factory_id" {
  description = "ID of the Data Factory"
  value       = azurerm_data_factory.main.id
}

output "databricks_workspace_url" {
  description = "URL of the Databricks workspace"
  value       = azurerm_databricks_workspace.main.workspace_url
}

output "eventhub_namespace_id" {
  description = "ID of the Event Hub namespace"
  value       = azurerm_eventhub_namespace.main.id
}

output "eventhub_id" {
  description = "ID of the Event Hub"
  value       = azurerm_eventhub.main.id
}

output "function_app_id" {
  description = "ID of the Function App"
  value       = azurerm_function_app.main.id
}

output "function_app_default_hostname" {
  description = "Default hostname of the Function App"
  value       = azurerm_function_app.main.default_hostname
}

output "cosmosdb_account_id" {
  description = "ID of the Cosmos DB account"
  value       = azurerm_cosmosdb_account.main.id
}

# output "cosmosdb_connection_strings" {
#   description = "Connection strings for the Cosmos DB account"
#   value       = azurerm_cosmosdb_account.main.connection_strings
#   sensitive   = true
# }

output "servicebus_namespace_id" {
  description = "ID of the Service Bus namespace"
  value       = azurerm_servicebus_namespace.main.id
}

output "servicebus_queue_id" {
  description = "ID of the Service Bus queue"
  value       = azurerm_servicebus_queue.main.id
}

output "data_lake_filesystem_id" {
  description = "ID of the Data Lake Gen2 filesystem"
  value       = azurerm_storage_data_lake_gen2_filesystem.main.id
}