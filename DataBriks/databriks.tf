# Creating Workspace
resource "azurerm_databricks_workspace" "databricks_workspace" {
  name                = "databricks-test"
  resource_group_name = var.resource_groupname
  location            = var.resource_location
  sku                 = "standard"

  tags = {
    Environment = var.env
  }
}

# create DataBricks cluster. 
data "databricks_node_type" "smallest" {
  local_disk = true
}

data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

resource "databricks_cluster" "shared_autoscaling" {
  cluster_name            = var.databricks_cluster_name
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = data.databricks_node_type.smallest.id
  autotermination_minutes = 60
  autoscale {
    min_workers = 1
    max_workers = 10
  }
}
