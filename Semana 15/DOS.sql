SELECT
    *
FROM US_UNO.syn_comuna;

SELECT
    *
FROM syn_a_camion;

SELECT
    *
FROM syn_cliente;



-- alternativa 1
CREATE OR REPLACE VIEW view_arriendos 
AS
SELECT
    cl.appaterno_cli ||' '|| cl.apmaterno_cli ||' '|| cl.pnombre_cli AS "CLIENTE",
    co.nombre_comuna AS "COMUNA",
    COUNT(ac.numrun_cli) AS "TOTAL ARRIENDOS"
FROM syn_cliente cl
    LEFT JOIN syn_a_camion ac ON(cl.numrun_cli = ac.numrun_cli)
    JOIN US_UNO.syn_comuna co ON(cl.id_comuna = co.id_comuna)
GROUP BY cl.appaterno_cli, cl.apmaterno_cli, cl.pnombre_cli, co.nombre_comuna
ORDER BY 3 DESC, 1 ASC;


-- alternativa 2 xikos
SELECT
    cl.appaterno_cli ||' '|| cl.apmaterno_cli ||' '|| cl.pnombre_cli AS "CLIENTE",
    co.nombre_comuna AS "COMUNA",
    COUNT(ac.numrun_cli) AS "TOTAL ARRIENDOS"
FROM syn_cliente cl
    JOIN syn_a_camion ac ON(cl.numrun_cli = ac.numrun_cli)
    JOIN US_UNO.syn_comuna co ON(cl.id_comuna = co.id_comuna)
GROUP BY cl.appaterno_cli, cl.apmaterno_cli, cl.pnombre_cli, co.nombre_comuna
UNION
SELECT 
    cl2.appaterno_cli ||' '|| cl2.apmaterno_cli ||' '|| cl2.pnombre_cli AS "CLIENTE",
    co2.nombre_comuna AS "COMUNA",
    0
FROM syn_cliente cl2
    JOIN US_UNO.syn_comuna co2 ON(cl2.id_comuna = co2.id_comuna)
WHERE cl2.numrun_cli NOT IN (SELECT 
                                numrun_cli
                            FROM syn_a_camion)
ORDER BY 3 DESC, 1 ASC


