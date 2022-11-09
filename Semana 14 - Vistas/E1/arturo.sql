CREATE TABLE estudiante (
    id NUMBER PRIMARY KEY,
    nombre VARCHAR2(40),
    nota_final NUMBER(5,2)
);

CREATE SEQUENCE seq_estudiante
INCREMENT BY 5
START WITH 100
;

INSERT INTO estudiante (id, nombre, nota_final) VALUES (seq_estudiante.NEXTVAL, 'Pablo Opazo', 5.3);
INSERT INTO estudiante (id, nombre, nota_final) VALUES (seq_estudiante.NEXTVAL, 'Matias Aniñir', 4.1);
INSERT INTO estudiante (id, nombre, nota_final) VALUES (seq_estudiante.NEXTVAL, 'Samuel Garrido', 6.9);
INSERT INTO estudiante (id, nombre, nota_final) VALUES (seq_estudiante.NEXTVAL, 'Angelo Lopez', 5.1);


CREATE VIEW v_estudiantes AS (
SELECT 
    id AS "ID",
    nombre AS "NOMBRE ESTUDIANTE"
FROM estudiante
);

CREATE PUBLIC SYNONYM s_estudiantes FOR v_estudiantes;
