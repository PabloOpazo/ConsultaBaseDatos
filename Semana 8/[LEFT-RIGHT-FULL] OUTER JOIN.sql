--[tabla1] + interseccion
SELECT
    e.employee_id "ID EMPLEADO",
    e.first_name || ' ' || e.last_name "NOMBRE COMPLETO",
    d.department_name
FROM employees e LEFT JOIN departments d
    ON (e.department_id = d.department_id)
ORDER BY e.employee_id


--[tabla2] + interseccion
SELECT
    e.employee_id "ID EMPLEADO",
    e.first_name || ' ' || e.last_name "NOMBRE COMPLETO",
    d.department_name
FROM employees e RIGHT JOIN departments d
    ON (e.department_id = d.department_id)
ORDER BY e.employee_id


--[tabla1] + [tabla2]
SELECT
    e.employee_id "ID EMPLEADO",
    e.first_name || ' ' || e.last_name "NOMBRE COMPLETO",
    d.department_name
FROM employees e FULL JOIN departments d
    ON (e.department_id = d.department_id)
ORDER BY e.employee_id
