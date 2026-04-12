#!/bin/bash

read -s -p "Postgres Password: " PGPASSWORD
echo
export PGPASSWORD

DB_NAME="exam_db"
DB_USER="postgres"

# ===== Get absolute path of this script =====
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Project root (database folder is relative to script location)
BASE_PATH="$SCRIPT_DIR/database"

echo "Using base path: $BASE_PATH"

echo "Creating database..."
psql -U $DB_USER -c "CREATE DATABASE $DB_NAME;" 2>/dev/null

echo "Running schema..."
psql -U $DB_USER -d $DB_NAME -f "$BASE_PATH/schema/tables.sql"
psql -U $DB_USER -d $DB_NAME -f "$BASE_PATH/schema/constraints.sql"
psql -U $DB_USER -d $DB_NAME -f "$BASE_PATH/schema/indexes.sql"
psql -U $DB_USER -d $DB_NAME -f "$BASE_PATH/schema/roles.sql"

echo "Seeding data..."
psql -U $DB_USER -d $DB_NAME -f "$BASE_PATH/seed/sample_data.sql"

echo "Running procedures..."

# run ALL SQL files in order automatically
for file in "$BASE_PATH/procedures/"*.sql; do
    echo "Executing: $(basename "$file")"
    psql -U $DB_USER -d $DB_NAME -f "$file"
done

echo "Running reports..."
psql -U $DB_USER -d $DB_NAME -f "$BASE_PATH/reports/reports.sql"

echo "Done successfully."