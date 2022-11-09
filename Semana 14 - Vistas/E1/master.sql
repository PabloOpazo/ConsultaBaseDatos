-- USER 1
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
-- USER SQL
CREATE USER ARTURO IDENTIFIED BY CHILE
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER ARTURO QUOTA UNLIMITED ON USERS;

-- ROLES
GRANT CREATE SESSION TO ARTURO;
GRANT CREATE TABLE TO ARTURO;
GRANT CREATE SEQUENCE TO ARTURO;
GRANT CREATE VIEW TO ARTURO;
GRANT CREATE PUBLIC SYNONYM TO ARTURO;
GRANT DROP PUBLIC SYNONYM TO ARTURO;

-- USER 2
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
-- USER SQL
CREATE USER JOAQUIN IDENTIFIED BY ECUADOR
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER JOAQUIN QUOTA UNLIMITED ON USERS;

-- ROLES
GRANT CREATE SESSION TO JOAQUIN;
GRANT SELECT ON s_estudiantes TO JOAQUIN;