-- CASO 1
SELECT
    c.pnombre || ' ' || c.appaterno || ' ' || c.apmaterno "Cliente",
    UPPER(t.nombre_tipo_cliente) "Tipo cliente"

FROM cliente c
    JOIN tipo_cliente t ON (c.cod_tipo_cliente = t.cod_tipo_cliente)
ORDER BY t.cod_tipo_cliente;


-- CASO 2
SELECT
    cc.nro_solic_credito "NRO. CREDITO",
    TO_CHAR(cc.monto_solicitado, '$999G999') "MONTO CREDITO",
    sb.direccion "DIRECCION"
    
FROM credito_cliente cc
    JOIN sucursal_banco sb ON (cc.id_sucursal = sb.id_sucursal) 
WHERE (cc.monto_solicitado >= 100000 AND cc.monto_solicitado <= 500000)
ORDER BY cc.monto_solicitado;


--CASO 3
SELECT 
    tc.nombre_tipo_cliente "TIPO CLIENTE",
    COUNT(*) "TOTAL CLIENTES"
    
FROM tipo_cliente tc
    JOIN cliente c ON (tc.cod_tipo_cliente = c.cod_tipo_cliente)
GROUP BY tc.nombre_tipo_cliente
ORDER BY tc.nombre_tipo_cliente;



--CASO 4
SELECT
    po.nombre_prof_ofic "PROFESION-OFICIO",
    COUNT(po.cod_prof_ofic) "TOTAL CLIENTES"
    
FROM profesion_oficio po
    JOIN cliente c ON (po.cod_prof_ofic = c.cod_prof_ofic)
HAVING COUNT(po.cod_prof_ofic) > 7
GROUP BY po.nombre_prof_ofic;
