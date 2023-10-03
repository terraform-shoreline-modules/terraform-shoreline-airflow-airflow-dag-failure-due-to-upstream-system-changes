

#!/bin/bash



# Set variables

UPSTREAM_URL=${UPSTREAM_URL}

UPSTREAM_VERSION=${UPSTREAM_VERSION}



# Rollback changes in upstream system

echo "Rolling back changes in upstream system..."

curl -X POST -H "Content-Type: application/json" -d '{"version": $UPSTREAM_VERSION}' $UPSTREAM_URL/rollback



echo "Rollback complete."