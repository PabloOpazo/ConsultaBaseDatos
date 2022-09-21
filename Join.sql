SELECT
    e.employee_id "ID",
    e.first_name || ' ' || e.last_name "Nombre empleado",
    d.department_name "Nombre del departamento",
    l.street_address "Direccion departamento",
    c.country_name "Pais departamento"
    
FROM employees e
    JOIN departments d ON(e.department_id = d.department_id)
    JOIN locations l ON (d.location_id = l.location_id)
    JOIN countries c ON (l.country_id = c.country_id);
    
    
SELECT 
    c.country_name "Nombre pais",
    COUNT(*) "Cantidad de empleados"
    
FROM employees e
    JOIN departments d ON (e.department_id = d.department_id)
    JOIN locations l ON (d.location_id = l.location_id)
    JOIN countries c ON (l.country_id = c.country_id)
    GROUP BY c.country_name;
