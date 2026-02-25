---> set the Role
USE ROLE SNOWFLAKE_LEARNING_ROLE;

---> set the Warehouse
USE WAREHOUSE SNOWFLAKE_LEARNING_WH;

---> set the Database
USE DATABASE SNOWFLAKE_LEARNING_DB;

---> set schema
USE SCHEMA GEORGIOSKIOSSES_LOAD_SAMPLE_DATA_FROM_S3;

---> test SQL
SELECT
   menu_item_name
FROM menu
WHERE truck_brand_name = 'Freezing Point';
