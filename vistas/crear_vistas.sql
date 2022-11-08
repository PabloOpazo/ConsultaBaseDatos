-- MASTER

-- PERMISOS (create user)
GRANT CREATE VIEW TO [user];
GRANT CREATE SYNONYM TO [user];
GRANT CREATE PUBLIC SYNONYM TO [user];

-- PRIVILEGIOS PARA [user2]
GRANT SELECT  ON nikiyam.departments TO jordan23;

-- USER 1
------------- nikiyam -------------

-- CREAR TABLA
CREATE TABLE empleado AS SELECT
                            employee_id AS "ID",
                            last_name AS "APELLIDO",
                            salary AS "SUELDO"
                        FROM employees;

-- CREAR VISTA DE LA TABLA CREADA
CREATE OR REPLACE VIEW v_empleado AS 
SELECT
    employee_id AS "ID",
    last_name AS "APELLIDO",
    salary AS "SUELDO"
FROM employees;

--------------------------------------
-- SELECCIONAR LA VISTA
SELECT
    *
FROM v_empleado;

-- ALTERAR DATOS
UPDATE 
    employees SET salary = 10000
WHERE employee_id = 200;

-- INFORMACIÓN DE LA VISTA/TABLA
DESC v_empleado;

--------------------------------------
-- SINÓNIMOS 
-- CREAR SINÓNIMO

CREATE SYNONYM syn_hogar FOR departments;

SELECT
    *
FROM syn_hogar;


-- CREAR SINÓNIMO PÚBLICO
CREATE PUBLIC SYNONYM syn_trabajador FOR employees;

SELECT
    *
FROM syn_trabajador;

--------------------------------------



-- USER 2

-- joldan
SELECT 
    *
FROM nikiyam.departments;
