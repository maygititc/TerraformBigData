# variables.tf

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "UK South"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "data_factory_name" {
  description = "Name of the Azure Data Factory"
  type        = string
}

variable "databricks_name" {
  description = "Name of the Azure Databricks workspace"
  type        = string
}

variable "eventhub_namespace_name" {
  description = "Name of the Event Hub namespace"
  type        = string
}

variable "eventhub_name" {
  description = "Name of the Event Hub"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "function_app_name" {
  description = "Name of the Function App"
  type        = string
}

variable "cosmosdb_account_name" {
  description = "Name of the Cosmos DB account"
  type        = string
}

variable "cosmosdb_database_name" {
  description = "Name of the Cosmos DB database"
  type        = string
}

variable "servicebus_namespace_name" {
  description = "Name of the Service Bus namespace"
  type        = string
}

variable "servicebus_queue_name" {
  description = "Name of the Service Bus queue"
  type        = string
}

variable "data_lake_filesystem_name" {
  description = "Name of the Data Lake Gen2 filesystem"
  type        = string
}