-- Ver la fecha actual
SELECT SYSDATE
FROM DUAL;

-- Ejercicio 1
SELECT 
    id_arriendo,
    nro_patente,
    fecha_ini_arriendo
FROM arriendo_camion 
WhERE fecha_ini_arriendo < TO_DATE('31-12-2021','DD-MM-YY')
ORDER BY fecha_ini_arriendo ASC;

-- Ejercicio 2
    -- versión 1.0
SELECT 
    id_arriendo,
    nro_patente,
    TO_CHAR(fecha_ini_arriendo,'"DESDE" DD MONTH YYYY ') || 
    TO_CHAR(fecha_devolucion,'"HASTA" DD Month YYYY') "PERIODO ARRIENDO"
    
FROM arriendo_camion;
    
    -- version 2.0
SELECT 
    id_arriendo,
    nro_patente,
    TO_CHAR(fecha_ini_arriendo,'"DESDE" DD ') ||
    TRIM(TO_CHAR(fecha_ini_arriendo,'MONTH')) ||
    TO_CHAR(fecha_ini_arriendo,' YYYY ') ||
    TO_CHAR(fecha_devolucion,'"HASTA" DD ') ||
    TRIM(TO_CHAR(fecha_devolucion,'MONTH')) ||
    TO_CHAR(fecha_devolucion,' YYYY ') "PERIODO ARRIENDO"
FROM arriendo_camion;


-- Ejercicio 3
SELECT
    TO_CHAR(numrun_emp,'99G999G999') || '-' || dvrun_emp "RUT",
    TO_CHAR(sueldo_base, '$9G999G999') "SUELDO BASE"
FROM empleado
ORDER BY sueldo_base DESC;


--Ejercicio 4
SELECT 
    TO_CHAR(numrun_emp,'99G999G999') || '-' || dvrun_emp "RUT",
    NVL(TO_CHAR(fono_fijo_emp), 'SIN REGISTRO') "FONO FIJO"

FROM empleado;


--Ejercicio 5
SELECT
    id_arriendo,
    nro_patente,
    fecha_ini_arriendo
FROM arriendo_camion
WHERE fecha_ini_arriendo = TO_DATE('&FECHA_CONSULTA');


--Ejercicio 6
    --Version 1.0
SELECT
    TO_CHAR(numrun_emp,'99G999G999') || '-' || dvrun_emp "RUT",
    CASE
        WHEN UPPER(sexo) = 'F' THEN
        'FEMENINO'
        WHEN UPPER(sexo) = 'M' THEN
        'MASCULINO'
    ELSE
        'NO BINARIO'
    END "GÉNERO"
FROM empleado;

    --Version 1.0
SELECT
    TO_CHAR(numrun_emp,'99G999G999') || '-' || dvrun_emp "RUT",
    DECODE(UPPER(sexo),'F','FEMENINO','M','MASCULINO','C','CAMIÓN 3/4') "GÉNERO"
FROM empleado;
