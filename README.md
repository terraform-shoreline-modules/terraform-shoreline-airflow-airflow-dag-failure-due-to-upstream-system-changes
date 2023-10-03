
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Airflow DAG Failure due to Upstream System Changes.
---

When an Airflow DAG has many dependencies on upstream systems, any changes made to those systems can cause the DAG to fail. This can result in issues such as failed or delayed tasks, missed SLAs, and other downstream problems. It is important to monitor dependencies closely and have processes in place to handle changes to upstream systems to prevent DAG failures.

### Parameters
```shell
export DEPENDENCY_NAME="PLACEHOLDER"

export DAG_ID="PLACEHOLDER"

export UPSTREAM_SYSTEM="PLACEHOLDER"

export TASK_ID="PLACEHOLDER"

export FIELD_NAME="PLACEHOLDER"

export API_URL="PLACEHOLDER"

export UPSTREAM_VERSION="PLACEHOLDER"

export UPSTREAM_URL="PLACEHOLDER"
```

## Debug

### Check if Airflow is running
```shell
systemctl status airflow-webserver
```

### Check if the airflow worker is running
```shell
systemctl status airflow-worker
```

### Check if all dependencies are installed
```shell
pip list | grep ${DEPENDENCY_NAME}
```

### Check if the DAG is running
```shell
airflow dags list
```

### Check if there are any errors in the DAG
```shell
airflow dags show ${DAG_ID}
```

### Check if there are any issues with upstream systems
```shell
ping ${UPSTREAM_SYSTEM}
```

### Check if there are any errors in the logs
```shell
tail -f /var/log/airflow/${DAG_ID}/${TASK_ID}.log
```

### Changes in the API response structure of an upstream system that the Airflow DAG depends on.
```shell
bash

#!/bin/bash



# Set variables

API_URL="${API_URL}"

EXPECTED_FIELD="${FIELD_NAME}"



# Call API and save response to variable

API_RESPONSE=$(curl -s $API_URL)



# Check if expected field is present in API response

if [[ $API_RESPONSE == *"$EXPECTED_FIELD"* ]]; then

  echo "API is functioning properly. No issues with Airflow DAG dependencies."

else

  echo "API response structure has changed. Airflow DAG may be affected. Investigate further."

fi


```

## Repair

### Rollback the changes in upstream systems to restore the previous state of the system.
```shell


#!/bin/bash



# Set variables

UPSTREAM_URL=${UPSTREAM_URL}

UPSTREAM_VERSION=${UPSTREAM_VERSION}



# Rollback changes in upstream system

echo "Rolling back changes in upstream system..."

curl -X POST -H "Content-Type: application/json" -d '{"version": $UPSTREAM_VERSION}' $UPSTREAM_URL/rollback



echo "Rollback complete."


```