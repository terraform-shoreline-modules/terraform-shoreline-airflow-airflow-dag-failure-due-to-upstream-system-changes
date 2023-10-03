resource "shoreline_notebook" "airflow_dag_failure_due_to_upstream_system_changes" {
  name       = "airflow_dag_failure_due_to_upstream_system_changes"
  data       = file("${path.module}/data/airflow_dag_failure_due_to_upstream_system_changes.json")
  depends_on = [shoreline_action.invoke_api_check_script,shoreline_action.invoke_rollback_changes_upstream]
}

resource "shoreline_file" "api_check_script" {
  name             = "api_check_script"
  input_file       = "${path.module}/data/api_check_script.sh"
  md5              = filemd5("${path.module}/data/api_check_script.sh")
  description      = "Changes in the API response structure of an upstream system that the Airflow DAG depends on."
  destination_path = "/agent/scripts/api_check_script.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "rollback_changes_upstream" {
  name             = "rollback_changes_upstream"
  input_file       = "${path.module}/data/rollback_changes_upstream.sh"
  md5              = filemd5("${path.module}/data/rollback_changes_upstream.sh")
  description      = "Rollback the changes in upstream systems to restore the previous state of the system."
  destination_path = "/agent/scripts/rollback_changes_upstream.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_api_check_script" {
  name        = "invoke_api_check_script"
  description = "Changes in the API response structure of an upstream system that the Airflow DAG depends on."
  command     = "`chmod +x /agent/scripts/api_check_script.sh && /agent/scripts/api_check_script.sh`"
  params      = ["API_URL","FIELD_NAME"]
  file_deps   = ["api_check_script"]
  enabled     = true
  depends_on  = [shoreline_file.api_check_script]
}

resource "shoreline_action" "invoke_rollback_changes_upstream" {
  name        = "invoke_rollback_changes_upstream"
  description = "Rollback the changes in upstream systems to restore the previous state of the system."
  command     = "`chmod +x /agent/scripts/rollback_changes_upstream.sh && /agent/scripts/rollback_changes_upstream.sh`"
  params      = ["UPSTREAM_VERSION","UPSTREAM_URL"]
  file_deps   = ["rollback_changes_upstream"]
  enabled     = true
  depends_on  = [shoreline_file.rollback_changes_upstream]
}

