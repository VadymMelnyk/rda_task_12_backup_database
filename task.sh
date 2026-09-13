#!/bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --single-transaction --skip-triggers --no-create-db ShopDB > backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --single-transaction --skip-triggers --no-create-info ShopDB > backup_data.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment -e "SET FOREIGN_KEY_CHECKS=0; TRUNCATE TABLE Products; SET FOREIGN_KEY_CHECKS=1;" 2>/dev/null || true

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup_data.sql