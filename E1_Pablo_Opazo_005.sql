-- CASO 1

SELECT 
    RPAD(UPPER(descripcion),39,'*' ) AS "NOMBRE PRODUCTO",
    TO_CHAR(vunitario,'$999G999') AS "VALOR DE VENTA",
    CASE
        WHEN valorcomprapeso BETWEEN 0 AND 99999 THEN
        '%' || TRIM(TO_CHAR((vunitario-valorcomprapeso)*100/valorcomprapeso,'999D9'))
    ELSE
        '%0'
    END AS "% DE GANANCIA"
FROM producto
WHERE valorcomprapeso IS NULL OR (vunitario-valorcomprapeso)*100/valorcomprapeso < 35
ORDER BY (vunitario-valorcomprapeso)*100/valorcomprapeso ASC;

-- CASO 2

SELECT
    CASE
        WHEN valorcompradolar IS NULL THEN
        SUBSTR(UPPER(descripcion),0,3) || '-' || codcategoria || '/ND' || LENGTH(descripcion)
    ELSE
        SUBSTR(UPPER(descripcion),0,3) || '-' || codcategoria || '/D' || LENGTH(descripcion)
    END AS "NUEVO CÓDIGO"
FROM producto
WHERE vunitario BETWEEN 20000 AND 30000;

-- CASO 3

SELECT
    CASE
        WHEN credito BETWEEN 0 AND 1000000 THEN
            'Estimado(a) ' || INITCAP(nombre) || ' usted como cliente PLATA lo citamos a una celebración el día ' || TO_DATE('24/9/2022','DD-MM-YY')
        WHEN credito BETWEEN 1000001 AND 2000000 THEN
            'Estimado(a) ' || INITCAP(nombre) || ' usted como cliente ORO lo citamos a una celebración el día ' || TO_DATE('25/9/2022','DD-MM-YY')
    ELSE
        'Estimado(a) ' || INITCAP(nombre) || ' usted como cliente DIAMANTE lo citamos a una celebración el día ' || TO_DATE('26/9/2022','DD-MM-YY')
    END AS "INVITACIÓN"  
FROM cliente
ORDER BY credito DESC, nombre ASC;

/*  RESPUESTAS DE PREGUNTAS CASO 3
1)  Saber qué tipo de cliente es cada persona en base a los créditos que posee.

2)  Los créditos de cada cliente.

3)  El propósito de esta solución es automatizar la invitación de cada cliente para ahorrar el trabajo de buscar
    a cada uno dentro de la lista.
    
4)  Va a mejorar el negocio en la rapidez de la creación de la invitación pero principalmente mejorará la fidelidad 
    de los clientes al fomentar el uso de créditos en AutoOK!.
*/