CREATE PUBLIC SYNONYM syn_cliente FOR cliente;
CREATE PUBLIC SYNONYM syn_a_camion FOR arriendo_camion;
CREATE SYNONYM syn_comuna FOR comuna;



SELECT 
    id_arriendo, 
    fecha_devolucion - fecha_ini_arriendo,
    ac.numrun_cli, 
    co.nombre_comuna
from cliente c
    JOIN arriendo_camion ac ON(c.numrun_cli = ac.numrun_cli)
    JOIN comuna co ON(c.id_comuna = co.id_comuna)
WHERE renta = 100000;

CREATE INDEX idx_renta ON cliente(renta);


SELECT 
    numrun_emp,
    nombre_estado_civil
FROM empleado e 
    JOIN estado_civil ec ON(e.id_estado_civil = ec.id_estado_civil)
WHERE TO_CHAR(fecha_nac, 'MM') = 6;

drop index idx_mes_nac;
CREATE INDEX idx_mes_nac ON empleado(TO_CHAR(fecha_nac, 'MM'));
