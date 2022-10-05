--sueldos de medico > sueldo promedio
SELECT
    TO_CHAR(m.med_rut,'$00g000g000')||'-'||dv_rut AS "RUT MEDICO",
    UPPER(m.apaterno||' '||m.amaterno|| ' '|| pnombre) AS "NOMBRE MEDICO",
    UPPER(c.nombre) "DESCRIPCION CARGO",
    TO_CHAR(m.sueldo_base,'$999g999g999') AS "SUELDO",
    TO_CHAR(m.sueldo_base - (SELECT 
        ROUND(AVG(m1.sueldo_base))
    FROM medico m1),'$999G999G999') AS "DIFERENCIA CON PROMEDIO"
FROM medico m JOIN cargo c ON (m.car_id = c.car_id)
WHERE m.sueldo_base > (SELECT 
                            AVG(ROUND(m2.sueldo_base))
                        FROM medico m2)
ORDER BY m.sueldo_base ASC;

--caso 3
SELECT
    e.esp_id "ID ESPECIALIDAD",
    e.nombre "NOMBRE ESPECIALIDAD"
FROM especialidad e JOIN atencion a ON (e.esp_id = a.esp_id)
HAVING AVG(a.costo) = (SELECT 
            MAX(AVG(a2.costo))
        FROM atencion a2
        GROUP BY a2.esp_id) 
GROUP BY (e.esp_id, e.nombre);


-- caso 4
SELECT
    e.nombre AS "ESPECIALIDAD",
    TO_CHAR(a.fecha_atencion,'MM-YYYY') AS "PERIODO DE TIEMPO",
    TO_CHAR(AVG(a.costo),'$999g999') AS "COSTO PROMEDIO"
FROM especialidad e JOIN atencion a ON (e.esp_id = a.esp_id)
HAVING AVG(a.costo) < (SELECT 
                                ROUND(AVG(a2.costo))
                            FROM atencion a2
                            WHERE TO_CHAR(a.fecha_atencion,'MM-YYYY') = TO_CHAR(a2.fecha_atencion,'MM-YYYY'))
GROUP BY (e.nombre, TO_CHAR(a.fecha_atencion,'MM-YYYY'));



