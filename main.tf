terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "airflow_dag_failure_due_to_upstream_system_changes" {
  source    = "./modules/airflow_dag_failure_due_to_upstream_system_changes"

  providers = {
    shoreline = shoreline
  }
}