-- USER 2

SELECT
    *
FROM s_departamentos;


SELECT
    *
FROM ANYELOWEKO.s_paises;


SELECT
    *
FROM ANYELOWEKO.s_empleados;


UPDATE ANYELOWEKO.s_empleados
SET salary = 80000 
WHERE employee_id = 100;

COMMIT;
