SELECT *
FROM departments;

SELECT department_id, location_id
FROM departments;

SELECT 
    first_name ||' '|| last_name AS "nombre completo",
    hire_date AS "fecha de contratación",
    salary AS salario,
    salary * 12 AS "salario anual",
    commission_pct AS comisión,
    salary + commission_pct AS "salario + comisión"-- cualquier número sumado o restado a (null) es (null)
    
FROM employees
WHERE department_id = 50
ORDER BY hire_date ASC;

-- Informe
SELECT
    'el empleado: '||first_name ||' '|| last_name ||' trabaja en el departamento #'|| department_id informe
FROM employees;

-- Utilizando DISTINCT
SELECT DISTINCT department_id
FROM employees
ORDER BY department_id;
