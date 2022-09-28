SELECT 
    employee_id "Numero empleado",
    first_name "nombre",
    last_name "apellido",
    manager_id "Codigo manager"
    
FROM employees;


SELECT 
    emp.employee_id "ID emp",
    emp.first_name || ' ' || emp.last_name "NOMBRE EMPLEADO",
    jefe.employee_id "ID jefe",
    jefe.first_name || ' ' || jefe.last_name "NOMBRE JEFE"
    
FROM employees emp JOIN employees jefe ON (emp.manager_id = jefe.employee_id);


SELECT 
    jefe.first_name || ' ' || jefe.last_name "NOMBRE JEFE",
    COUNT(emp.employee_id) "EMPLEADOS A CARGO"
    
FROM employees emp JOIN employees jefe ON (emp.manager_id = jefe.employee_id)
GROUP BY jefe.first_name || ' ' || jefe.last_name;


SELECT 
    emp.employee_id "Numero empleado",
    emp.salary "Sueldo",
    ROUND(MONTHS_BETWEEN(SYSDATE, emp.hire_date)/12) "años de trabajo",
    pb.porcentaje_bono ||'%' "% bono"
    
FROM employees emp JOIN porcentaje_bono pb ON (ROUND(MONTHS_BETWEEN(SYSDATE, emp.hire_date)/12) BETWEEN pb.ano_ini AND pb.ano_ter);

