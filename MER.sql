-- MASTER
    ALTER SESSION SET "_ORACLE_SCRIPT"=true;
    -- USER 1
        CREATE USER USUARIO_P3_1 IDENTIFIED BY USUARIO_P3_1
        DEFAULT TABLESPACE "USERS"
        TEMPORARY TABLESPACE "TEMP";
        ALTER USER USUARIO_P3_1 QUOTA UNLIMITED ON USERS;

        -- PERMISOS
        GRANT CREATE SESSION TO USUARIO_P3_1;
        GRANT CREATE TABLE TO USUARIO_P3_1;
        GRANT CREATE PUBLIC SYNONYM TO USUARIO_P3_1;
        GRANT CREATE SYNONYM TO USUARIO_P3_1;
        GRANT CREATE ANY INDEX TO USUARIO_P3_1;
        GRANT CREATE SEQUENCE TO USUARIO_P3_1; --Para montar BD


    -- USER 2
        CREATE USER USUARIO_P3_2 IDENTIFIED BY USUARIO_P3_2
        DEFAULT TABLESPACE "USERS"
        TEMPORARY TABLESPACE "TEMP";
        ALTER USER USUARIO_P3_2 QUOTA UNLIMITED ON USERS;

        -- PERMISOS
        GRANT CREATE SESSION TO USUARIO_P3_2;
        GRANT CREATE PROCEDURE TO USUARIO_P3_2;
        GRANT CREATE SEQUENCE TO USUARIO_P3_2;
        GRANT CREATE VIEW TO USUARIO_P3_2;
        GRANT CREATE MATERIALIZED VIEW TO USUARIO_P3_2;

        GRANT SELECT ON syn_ciudad TO USUARIO_P3_2;
        GRANT SELECT ON syn_comuna TO USUARIO_P3_2;
        GRANT SELECT ON USUARIO_P3_1.syn_factura TO USUARIO_P3_2;
        GRANT SELECT ON USUARIO_P3_1.syn_vendedor TO USUARIO_P3_2;


    -- ROLES Y ASIGNACIÓN DE ROLES
        CREATE ROLE ROL_TI;
        GRANT UPDATE, INSERT, DELETE ON USUARIO_P3_1.syn_vendedor TO ROL_TI;
        GRANT ROL_TI TO USUARIO_P3_2;  
        ALTER USER USUARIO_P3_2 DEFAULT ROLE "ROL_TI";


--CONEXIONES
    --Montar BD
    -- Crear sinónimos (USER 1)
        CREATE PUBLIC SYNONYM syn_ciudad FOR ciudad;
        CREATE PUBLIC SYNONYM syn_comuna FOR comuna;
        CREATE SYNONYM USUARIO_P3_1.syn_factura FOR factura;
        CREATE SYNONYM USUARIO_P3_1.syn_vendedor FOR vendedor;

    --caso2 (USER 2)
        CREATE OR REPLACE VIEW vw_vendedores AS
        SELECT
            v.rutvendedor AS "RUT",
            v.nombre AS "NOMBRE VENDEDOR",
            INITCAP( v.direccion ||', '|| co.descripcion ||', '|| ci.descripcion) AS "DIRECCIÓN",
            LOWER(v.mail) AS "EMAIL",
            LPAD(TRIM(TO_CHAR(SUM(f.total),'$999g999g999')),15,'*') AS "TOTAL VENDIDO EN EFECTIVO"
        FROM USUARIO_P3_1.vendedor v
            JOIN syn_comuna co ON(v.codcomuna = co.codcomuna)
            JOIN syn_ciudad ci ON(co.codciudad = ci.codciudad)
            JOIN USUARIO_P3_1.factura f ON(v.rutvendedor = f.rutvendedor)

        where f.codpago = 1
        GROUP BY (v.rutvendedor, v.nombre, v.direccion, co.descripcion, ci.descripcion, LOWER(v.mail))

        ORDER BY co.descripcion ASC, ci.descripcion DESC;

        --------------------------------------------------

        CREATE OR REPLACE MATERIALIZED VIEW vw_vendedores AS
        SELECT
            v.rutvendedor AS "RUT",
            v.nombre AS "NOMBRE VENDEDOR",
            INITCAP( v.direccion ||', '|| co.descripcion ||', '|| ci.descripcion) AS "DIRECCIÓN",
            LOWER(v.mail) AS "EMAIL",
            LPAD(TRIM(TO_CHAR(SUM(f.total),'$999g999g999')),15,'*') AS "TOTAL VENDIDO EN EFECTIVO"
        FROM USUARIO_P3_1.vendedor v
            JOIN syn_comuna co ON(v.codcomuna = co.codcomuna)
            JOIN syn_ciudad ci ON(co.codciudad = ci.codciudad)
            JOIN USUARIO_P3_1.factura f ON(v.rutvendedor = f.rutvendedor)

        where f.codpago = 1
        GROUP BY (v.rutvendedor, v.nombre, v.direccion, co.descripcion, ci.descripcion, LOWER(v.mail))

        ORDER BY co.descripcion ASC, ci.descripcion DESC;


    --caso3 (USER 1)
        SELECT
            b.numboleta "NRO_BOLETA",
            to_char(b.fecha, 'MM/YYYY') "MES/AÑO_VENTA",
            to_char(b.total, '$999g999g999') "TOTAL",
            INITCAP(fp.descripcion) "formadepago"
        FROM boleta b 
            JOIN forma_pago fp ON(b.codpago=fp.codpago)
        WHERE TO_CHAR(b.fecha, 'MM/YYYY') = '02/2022'
        ORDER BY 3;

        CREATE INDEX idx_fecha ON boleta(TO_CHAR(fecha, 'MM/YYYY'));
        -----------------------------------------------------------------
        SELECT 
            db.numboleta "NRO BOLETA",
            db.cantidad "CANTIDAD",
            INITCAP(p.descripcion) "NOMBRE PRODUCTO",
            TO_CHAR(p.vunitario, '$999g999g999') "VALOR UNITARIO",
            TO_CHAR(db.totallinea, '$999g999g999') "SUBTOTAL"
        FROM detalle_boleta db 
            JOIN producto p ON(db.codproducto = p.codproducto)
            JOIN boleta b ON(b.numboleta = db.numboleta)
        WHERE b.codbanco=1 AND b.total<200000;

        CREATE INDEX idx_banco ON  boleta(codbanco, total);


--PREGUNTAS
    
    --1) la información significativa es el total vendido por cada vendedor realizadas en factura y en efectivo

    --2) se deben obtener los datos de cada vendedor (rut, nombre, direccion, email) y luego sumar los totales ($) de las facturas por cada vendedor, teniendo en cuenta que se hayan pagado en efectivo

    --3) Una alternativa es crear una vista y almacenarla (MATERIALIZED VIEW), esto aumentaría la eficiencia, pero se utilizaría espacio en la memoria.