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
ORDER BY e.employee_id;


--actividad
SELECT
    es.nombre,
    COUNT(em.esp_id)
    
FROM especialidad es LEFT JOIN especialidad_medico em
    ON (es.esp_id = em.esp_id)
GROUP BY es.nombre
HAVING COUNT(em.esp_id) = 0;


SELECT
    TO_CHAR(p.pac_rut,'00G000G000')||'-'||p.dv_rut "RUT",
    p.pnombre ||' '||p.apaterno ||' '||p.amaterno AS "NOMBRE PACIENTE",
    TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento)/12) AS "EDAD",
    CASE
        WHEN d.porcentaje_descto IS NULL THEN
            'EN EL AÑO '||(65 - TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento)/12) + EXTRACT(YEAR  FROM SYSDATE))||' TENDRÁ DESCUENTO'
        ELSE
            d.porcentaje_descto||'%'
    END "DESCUENTO"
    
FROM 
    paciente p LEFT JOIN porc_descto_3ra_edad d
    ON (TRUNC(MONTHS_BETWEEN(SYSDATE, p.fecha_nacimiento)/12) BETWEEN d.anno_ini AND d.anno_ter);


SELECT
    TO_CHAR(m.med_rut,'00G000G000')||'-'||m.dv_rut "MEDICO",
    TO_CHAR(jf.jefe_rut,'00G000G000')||'-'|| jf.dv_rut "RUT JEFE",
    UPPER(jf.pnombre) ||' '|| UPPER(jf.apaterno)||' '|| UPPER(jf.amaterno) "NOMBRE JEFE"
FROM 
    medico m JOIN medico jf
    ON(m.jefe_rut = jf.med_rut)
WHERE jf.jefe_rut IS NOT NULL
ORDER BY TO_CHAR(jf.jefe_rut,'00G000G000')||'-'|| jf.dv_rut;


SELECT 
    TO_CHAR(m.med_rut,'00G000G000')||'-'|| m.dv_rut "RUT MEDICO",
    UPPER(m.pnombre) ||' '|| UPPER(m.snombre) ||' '|| UPPER(m.apaterno)||' '|| UPPER(m.amaterno) "NOMBRE MEDICO",
    COUNT(a.ate_id) "TOTAL ATENCIONES"
FROM medico m 
    FULL JOIN especialidad_medico em ON (m.med_rut = em.med_rut)
    FULL JOIN atencion a ON (em.med_rut = a.med_rut) 
GROUP BY TO_CHAR(m.med_rut,'00G000G000')||'-'|| m.dv_rut, UPPER(m.pnombre) ||' '|| UPPER(m.snombre) ||' '|| UPPER(m.apaterno)||' '|| UPPER(m.amaterno)
ORDER BY TO_CHAR(m.med_rut,'00G000G000')||'-'|| m.dv_rut;
