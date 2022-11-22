--Master
    --CREAR USUARIOS

        ALTER SESSION SET "_ORACLE_SCRIPT"=true; -- Sólo una vez por master
        -- USER SQL
        CREATE USER usuario IDENTIFIED BY contraseña
        DEFAULT TABLESPACE "USERS"
        TEMPORARY TABLESPACE "TEMP";

        -- QUOTAS
        ALTER USER usuario QUOTA UNLIMITED ON USERS;

    -- PERMISOS (GRANT) 
        GRANT CREATE SESSION TO usuario;            -- Crear conexiones
        GRANT CREATE TABLE TO usuario;              -- Crear tablas
        GRANT CREATE PUBLIC SYNONYM TO usuario;     -- Crear sinónimos públicos
        GRANT CREATE SYNONYM TO usuario;            -- Crear sinónimos privados
        GRANT CREATE SEQUENCE TO usuario;           -- Crear secuencias
        GRANT CREATE VIEW TO usuario;               -- Crear vistas
        GRANT CREATE ROLE TO usuario;               -- Crear roles
        GRANT CREATE ANY INDEX TO usuario;          -- Crear cualquier tipo de índice

    -- ROLES
        CREATE ROLE rol_nombre;                                         -- Crear un rol
        GRANT CREATE TABLE TO rol_nombre;                               -- Añadir un permiso al rol creado
        GRANT SELECT,INSERT,UPDATE,DELETE ON objeto TO rol_nombre;      -- Añadir un permiso sobre un objeto al rol creado
        GRANT rol_nombre TO usuario;                                    -- Dar rol al usuario
        ALTER USER usuario DEFAULT ROLE "ROL_NOMBRE";                   -- Dar rol por defecto al usuario

    --QUITAR PERMISOS
        REVOKE privilegio ON objeto FROM usuario;   -- Quitar privilegio sobre un objeto al usuario

-- Usuarios
    -- CREAR/ELIMINAR VISTAS
        CREATE (OR REPLACE NO FORCE) VIEW vw_nombre_vista (alias) 
        AS consulta;
        (WITH CHECK OPTION (CONSTRAINT nombre_constraint));
        (WITH READ ONLY (CONSTRAINT nombre_constraint));

        --eliminar
        DROP VIEW nombre_vista;

    -- CREAR/ELIMINAR SECUENCIAS
        CREATE SEQUENCE seq_nombre_secuencia
        INCREMENT BY n
        START WITH n
        MAXVALUE n (NOMAXVALUE)
        MINVALUE n (NOMINVALUE)
        CYCLE (NOCYCLE)
        CACHE n (NOCACHE)
        ORDER (NOORDER);

        --eliminar
        DROP SEQUENCE seq_nombre_secuencia;

    -- CREAR/ELIMINAR SINÓNIMOS
        CREATE (OR REPLACE) (PUBLIC) SYNONYM syn_nombre_sinónimo FOR objeto;

        --eliminar
        DROP (PUBLIC) SYNONYM syn_nombre_sinónimo;
    
    -- CREAR/ELIMINAR ÍNDICES (PARA MEJORAR ACCESO A DATOS) // TENER EN CUENTA EL "WHERE" DE LA CONSULTA
        CREATE (UNIQUE) INDEX idx_nombre_indice ON tabla(restricción_WHERE);

        --eliminar
        DROP INDEX idx_nombre_indice;

    -- SiNTAXIS DE UNA CONSULTA
        SELECT
            *
        FROM tabla t
            JOIN tabla2 t2 ON(t.atributo = t2.atributo)
            LEFT JOIN tabla3 t3 ON(t2.atributo = t3.atributo)
            RIGHT JOIN tabla4 t4 ON(t3.atributo = t4.atributo)

        WHERE condicion = 0 AND condicion = 1
        HAVING/GROUP BY automático
        ORDER BY 1 ASC, 2 DESC;