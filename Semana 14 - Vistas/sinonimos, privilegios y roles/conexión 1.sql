-- USER 1

--PUBLICOS
CREATE PUBLIC SYNONYM s_departamentos FOR departments;

SELECT
    *
FROM s_departamentos;




-- PRIVADOS
CREATE SYNONYM s_paises FOR countries;

SELECT
    *
FROM s_paises;


CREATE SYNONYM s_empleados FOR employees;

SELECT
    *
FROM s_empleados;




SELECT
    *
FROM employees;

UPDATE employees
SET salary = 80000 
WHERE employee_id = 100;
