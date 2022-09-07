-- Caso 1

SELECT 
    nombre "Nombre del curso",
    hrtotal || ' Hrs' "Horas totales",
    CASE
        WHEN areaid = 100 THEN
            TRIM(to_char(costo * 0.9, '$999G999G999'))
        ELSE
            TRIM(to_char(costo, '$999G999G999')) 
    END "costo"

FROM curso
WHERE areaid in (100, 600, 700, 800) AND nivelid = 100
ORDER BY areaid ASC;



-- Caso 2
SELECT 
    UPPER(nombre ||' '|| apaterno ||' '|| amaterno) "Nombre Completo",
    LOWER(SUBSTR(nombre,0,3) ||apaterno ||TO_CHAR(fechanacimiento,'YYYY')||'@sabelotodo.cl') "Correo Alumno",
    RPAD(LENGTH(apaterno)||LENGTH(amaterno)||SUBSTR(nombre,-3,3),8,'0') AS "Contraseña"
FROM participante
WHERE (TO_CHAR(fechanacimiento,'yyyy')) < 1980
ORDER BY apaterno ASC;

-- Caso 3
SELECT
    UPPER(nombre ||' '|| apaterno ||' '|| amaterno) "Nombre Completo",
    NVL(TO_CHAR(telefono), 'No tiene celular') "Celular",
    TRUNC(MONTHS_BETWEEN(SYSDATE, fechanacimiento)/12) AS "edad",
    CASE 
        WHEN EXTRACT (MONTH FROM fechanacimiento) BETWEEN 1 AND 4 THEN
        'Primera celebracion'
        WHEN EXTRACT (MONTH FROM fechanacimiento) BETWEEN 5 AND 8 THEN
        'Segunda celebracion'
        ELSE
        'Tercera celebracion'
    END "Celebracion"
FROM participante
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, fechanacimiento)/12) < 40 OR (genero='F' and empresaid= 200) 
ORDER BY EXTRACT (MONTH FROM fechanacimiento);


-- Caso 4

--138 Amadeus
--108 Word
--129 Windows 8

SELECT
    CASE
        WHEN cursoid = 138 THEN 
            'Amadeus'
        WHEN cursoid = 108 THEN 
            'Word'
        WHEN cursoid = 129 THEN 
            'Windows 8'
    END "curso",
    SUBSTR(periodoid,0,4) "Año",
    SUBSTR(periodoid,-1,1) "Semestre",
    SUBSTR(versionid,-1,1) "Versión"
    
FROM oferta_curso
WHERE cursoid IN (138,108,129)
ORDER BY versionid ASC;
