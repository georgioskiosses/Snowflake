/* ============================================================
   Snowflake Trial Setup Script
   Purpose: Prepare Snowflake for Databricks Spark Connector
   Author: <your name>
   ============================================================ */

/* ------------------------------------------------------------
   1. Create Role for External Access
   ------------------------------------------------------------ */

CREATE OR REPLACE ROLE BI_CONNECTOR_ROLE;

/* ------------------------------------------------------------
   2. Create Warehouse
   ------------------------------------------------------------ */

CREATE OR REPLACE WAREHOUSE BI_TEST_WH
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

GRANT USAGE ON WAREHOUSE BI_TEST_WH TO ROLE BI_CONNECTOR_ROLE;

/* ------------------------------------------------------------
   3. Create Database and Schema
   ------------------------------------------------------------ */

CREATE OR REPLACE DATABASE BI_TEST_DB;
CREATE OR REPLACE SCHEMA BI_TEST_DB.PUBLIC;

GRANT USAGE ON DATABASE BI_TEST_DB TO ROLE BI_CONNECTOR_ROLE;
GRANT USAGE ON SCHEMA BI_TEST_DB.PUBLIC TO ROLE BI_CONNECTOR_ROLE;

/* ------------------------------------------------------------
   4. Create Test Table
   ------------------------------------------------------------ */

CREATE OR REPLACE TABLE BI_TEST_DB.PUBLIC.TEST_TABLE (
    ID INT,
    NAME STRING
);

INSERT INTO BI_TEST_DB.PUBLIC.TEST_TABLE (ID, NAME) VALUES
    (1, 'Alpha'),
    (2, 'Beta');

/* ------------------------------------------------------------
   5. Grant Table Permissions
   ------------------------------------------------------------ */

GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLE BI_TEST_DB.PUBLIC.TEST_TABLE
TO ROLE BI_CONNECTOR_ROLE;

/* ------------------------------------------------------------
   6. Create Dedicated Technical User (Optional but Recommended)
   ------------------------------------------------------------ */

/* Replace password before execution */
CREATE OR REPLACE USER BI_CONNECTOR_USER
  PASSWORD = 'ChangeMe123!'
  DEFAULT_ROLE = BI_CONNECTOR_ROLE
  DEFAULT_WAREHOUSE = BI_TEST_WH
  MUST_CHANGE_PASSWORD = FALSE;

GRANT ROLE BI_CONNECTOR_ROLE TO USER BI_CONNECTOR_USER;

/* ============================================================
   Setup Complete
   ============================================================ */