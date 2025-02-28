/*
DROP TABLE aumentos_mes_cliente CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE comuna CASCADE CONSTRAINTS;
DROP TABLE cuota_transac_tarjeta_cliente CASCADE CONSTRAINTS;
DROP TABLE forma_pago CASCADE CONSTRAINTS; 
DROP TABLE ocupacion CASCADE CONSTRAINTS;
DROP TABLE pago_tarjetas CASCADE CONSTRAINTS;
DROP TABLE pesos_premier CASCADE CONSTRAINTS;
DROP TABLE producto CASCADE CONSTRAINTS;
DROP TABLE provincia CASCADE CONSTRAINTS;
DROP TABLE rango_aumento_cupocompra CASCADE CONSTRAINTS;
DROP TABLE rango_aumento_superavance CASCADE CONSTRAINTS;
DROP TABLE region CASCADE CONSTRAINTS;
DROP TABLE resum_avances_mes CASCADE CONSTRAINTS;
DROP TABLE sucursal CASCADE CONSTRAINTS;
DROP TABLE tarjeta_cliente CASCADE CONSTRAINTS;
DROP TABLE tipo_transaccion_tarjeta CASCADE CONSTRAINTS;
DROP TABLE tipos_de_cliente CASCADE CONSTRAINTS;
DROP TABLE transaccion_tarjeta_cliente CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_PRODUCTO;
DROP SEQUENCE SEQ_TP_TRANSAC_TARJETA;
DROP SEQUENCE SEQ_TIPOS_CLIENTE;
DROP SEQUENCE SEQ_REGION;
DROP SEQUENCE SEQ_SUCURSAL;

DROP SEQUENCE SEQ_PROFESION_OFICIO;
DROP SEQUENCE SEQ_DET_AVAN_SAVAN_MENSUALES;
DROP SEQUENCE SEQ_RES_AVAN_SAVAN_MENSUALES;
DROP SEQUENCE SEQ_ERROR;

*/


CREATE SEQUENCE SEQ_PRODUCTO
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE SEQ_TP_TRANSAC_TARJETA
START WITH 101
INCREMENT BY 1;

CREATE SEQUENCE SEQ_TIPOS_CLIENTE
START WITH 10
INCREMENT BY 10;

CREATE SEQUENCE SEQ_REGION
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE SEQ_SUCURSAL
START WITH 100
INCREMENT BY 10;

CREATE SEQUENCE SEQ_PROFESION_OFICIO
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE SEQ_DET_AVAN_SAVAN_MENSUALES;

CREATE SEQUENCE SEQ_RES_AVAN_SAVAN_MENSUALES;

CREATE SEQUENCE SEQ_ERROR;

CREATE TABLE aumentos_mes_cliente (
    fecha_proceso      DATE NOT NULL,
    numrun             NUMBER(10) NOT NULL,
    dvrun              VARCHAR2(1) NOT NULL,
    fecha_nacimiento   DATE NOT NULL,
    cupo_compras       NUMBER(15) NOT NULL,
    cupo_super_avance  NUMBER(15) NOT NULL
);

ALTER TABLE aumentos_mes_cliente ADD CONSTRAINT aumentos_mes_cliente_pk PRIMARY KEY ( fecha_proceso,
                                                                                      numrun );

CREATE TABLE cliente (
    numrun             NUMBER(10) NOT NULL,
    dvrun              VARCHAR2(1) NOT NULL,
    pnombre            VARCHAR2(50) NOT NULL,
    snombre            VARCHAR2(50),
    appaterno          VARCHAR2(50) NOT NULL,
    apmaterno          VARCHAR2(50),
    fecha_nacimiento   DATE NOT NULL,
    fecha_inscripcion  DATE NOT NULL,
    correo             VARCHAR2(20),
    fono_contacto      NUMBER(10),
    direccion          VARCHAR2(50) NOT NULL,
    cod_region         NUMBER(3) NOT NULL,
    cod_provincia      NUMBER(3) NOT NULL,
    cod_comuna         NUMBER(3) NOT NULL,
    cod_ocupacion      NUMBER(3) NOT NULL,
    cod_tipo           NUMBER(3) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT pk_cliente PRIMARY KEY ( numrun );

CREATE TABLE comuna (
    cod_region     NUMBER(3) NOT NULL,
    cod_provincia  NUMBER(3) NOT NULL,
    cod_comuna     NUMBER(3) NOT NULL,
    nombre_comuna  VARCHAR2(50) NOT NULL
);

ALTER TABLE comuna
    ADD CONSTRAINT pk_comuna PRIMARY KEY ( cod_region,
                                           cod_provincia,
                                           cod_comuna );

CREATE TABLE cuota_transac_tarjeta_cliente (
    nro_tarjeta       NUMBER(30) NOT NULL,
    nro_transaccion   NUMBER(10) NOT NULL,
    nro_cuota         NUMBER(2) NOT NULL,
    fecha_venc_cuota  DATE NOT NULL,
    valor_cuota       NUMBER(10) NOT NULL
);

ALTER TABLE cuota_transac_tarjeta_cliente
    ADD CONSTRAINT pk_cuota_trans_tarjeta_cliente PRIMARY KEY ( nro_tarjeta,
                                                                nro_transaccion,
                                                                nro_cuota );

CREATE TABLE forma_pago (
    cod_forma_pago     NUMBER(2) NOT NULL,
    nombre_forma_pago  VARCHAR2(50) NOT NULL
);

ALTER TABLE forma_pago ADD CONSTRAINT pk_forma_pago PRIMARY KEY ( cod_forma_pago );

CREATE TABLE ocupacion (
    cod_ocupacion     NUMBER(3) NOT NULL,
    nombre_prof_ofic  VARCHAR2(50) NOT NULL
);

ALTER TABLE ocupacion ADD CONSTRAINT pk_ocupacion PRIMARY KEY ( cod_ocupacion );

CREATE TABLE pago_tarjetas (
    nro_tarjeta        NUMBER(30) NOT NULL,
    anno_mes_pago      NUMBER(6) NOT NULL,
    fecha_vencimiento  DATE NOT NULL,
    fecha_pago         DATE NOT NULL,
    monto_total_pagar  NUMBER(10) NOT NULL,
    monto_pagado       NUMBER(10) NOT NULL,
    saldo_por_pagar    NUMBER(10) NOT NULL,
    cod_forma_pago     NUMBER(2)
);

ALTER TABLE pago_tarjetas ADD CONSTRAINT pk_pago_menstarj_cliente PRIMARY KEY ( nro_tarjeta,
                                                                                anno_mes_pago );

CREATE TABLE pesos_premier (
    nro_tarjeta          NUMBER(30) NOT NULL,
    total_puntos         NUMBER(8) NOT NULL,
    fecha_actualizacion  DATE NOT NULL
);

ALTER TABLE pesos_premier ADD CONSTRAINT pk_pesos_premier PRIMARY KEY ( nro_tarjeta );

CREATE TABLE producto (
    cod_producto            NUMBER(3) NOT NULL,
    nombre_producto         VARCHAR2(50) NOT NULL,
    desc_producto           VARCHAR2(400) NOT NULL,
    tasaint_producto        NUMBER(4, 2),
    nro_maximo_cuotas_prod  NUMBER(3)
);

ALTER TABLE producto ADD CONSTRAINT pk_producto PRIMARY KEY ( cod_producto );

CREATE TABLE provincia (
    cod_region        NUMBER(3) NOT NULL,
    cod_provincia     NUMBER(3) NOT NULL,
    nombre_provincia  VARCHAR2(50) NOT NULL
);

ALTER TABLE provincia ADD CONSTRAINT pk_provincia PRIMARY KEY ( cod_region,
                                                                cod_provincia );

CREATE TABLE rango_aumento_cupocompra (
    id_rango      NUMBER(3) NOT NULL,
    ant_min       NUMBER(3) NOT NULL,
    ant_max       NUMBER(3) NOT NULL,
    porc_aumento  NUMBER(3) NOT NULL
);

ALTER TABLE rango_aumento_cupocompra ADD CONSTRAINT rango_antiguedad_pk PRIMARY KEY ( id_rango );

CREATE TABLE rango_aumento_superavance (
    id_rango      NUMBER(3) NOT NULL,
    edad_min      NUMBER(3) NOT NULL,
    edad_max      NUMBER(3) NOT NULL,
    porc_aumento  NUMBER(3) NOT NULL
);

ALTER TABLE rango_aumento_superavance ADD CONSTRAINT rango_antiguedadv1_pk PRIMARY KEY ( id_rango );

CREATE TABLE region (
    cod_region     NUMBER(3) NOT NULL,
    nombre_region  VARCHAR2(50) NOT NULL
);

ALTER TABLE region ADD CONSTRAINT pk_region PRIMARY KEY ( cod_region );

CREATE TABLE resum_avances_mes (
    correlativo             NUMBER(6) NOT NULL,
    mes_anno_proceso        VARCHAR2(7) NOT NULL,
    fecha_transaccion       DATE NOT NULL,
    monto_total_solicitado  NUMBER(15) NOT NULL,
    monto_total_avan_savan  NUMBER(15) NOT NULL,
    monto_total_sbif        NUMBER(10) NOT NULL
);

ALTER TABLE resum_avances_mes ADD CONSTRAINT pk_res_avan_savanm PRIMARY KEY ( correlativo );

CREATE TABLE sucursal (
    id_sucursal    NUMBER(6) NOT NULL,
    direccion      VARCHAR2(40) NOT NULL,
    telefono       NUMBER(15) NOT NULL,
    cod_region     NUMBER(3) NOT NULL,
    cod_provincia  NUMBER(3) NOT NULL,
    cod_comuna     NUMBER(3) NOT NULL
);

ALTER TABLE sucursal ADD CONSTRAINT pk_sucurs PRIMARY KEY ( id_sucursal );

CREATE TABLE tarjeta_cliente (
    nro_tarjeta          NUMBER(30) NOT NULL,
    numrun               NUMBER(10) NOT NULL,
    fecha_solic_tarjeta  DATE NOT NULL,
    dia_pago_mensual     NUMBER(2) NOT NULL,
    cupo_compra          NUMBER(10) NOT NULL,
    cupo_super_avance    NUMBER(10) NOT NULL,
    cupo_disp_compra     NUMBER(10) NOT NULL,
    cupo_disp_sp_avance  NUMBER(10) NOT NULL
);

ALTER TABLE tarjeta_cliente ADD CONSTRAINT pk_tarjeta_cliente PRIMARY KEY ( nro_tarjeta );

CREATE TABLE tipo_transaccion_tarjeta (
    cod_tptran_tarjeta      NUMBER(4) NOT NULL,
    nombre_tptran_tarjeta   VARCHAR2(50) NOT NULL,
    tasaint_tptran_tarjeta  NUMBER(4, 2) NOT NULL,
    nro_maximo_cuotas_tran  NUMBER(3) NOT NULL,
    cod_producto            NUMBER(3) NOT NULL
);

ALTER TABLE tipo_transaccion_tarjeta ADD CONSTRAINT pk_tipo_transac_tarjeta PRIMARY KEY ( cod_tptran_tarjeta );

CREATE TABLE tipos_de_cliente (
    cod_tipo        NUMBER(3) NOT NULL,
    nombre_tipo     VARCHAR2(30) NOT NULL,
    promedio_renta  VARCHAR2(40) NOT NULL
);

ALTER TABLE tipos_de_cliente ADD CONSTRAINT pk_ticliente PRIMARY KEY ( cod_tipo );

CREATE TABLE transaccion_tarjeta_cliente (
    nro_tarjeta               NUMBER(30) NOT NULL,
    nro_transaccion           NUMBER(10) NOT NULL,
    fecha_transaccion         DATE NOT NULL,
    monto_transaccion         NUMBER(10) NOT NULL,
    total_cuotas_transaccion  NUMBER(2) NOT NULL,
    monto_total_transaccion   NUMBER(10) NOT NULL,
    cod_tptran_tarjeta        NUMBER(4) NOT NULL,
    id_sucursal               NUMBER(6) NOT NULL
);

ALTER TABLE transaccion_tarjeta_cliente ADD CONSTRAINT pk_transactarj_cliente PRIMARY KEY ( nro_tarjeta,
                                                                                            nro_transaccion );

ALTER TABLE cliente
    ADD CONSTRAINT fk_cliente_comuna FOREIGN KEY ( cod_region,
                                                   cod_provincia,
                                                   cod_comuna )
        REFERENCES comuna ( cod_region,
                            cod_provincia,
                            cod_comuna );

ALTER TABLE cliente
    ADD CONSTRAINT fk_cliente_ocupacion FOREIGN KEY ( cod_ocupacion )
        REFERENCES ocupacion ( cod_ocupacion );

ALTER TABLE cliente
    ADD CONSTRAINT fk_cliente_ti_de_cliente FOREIGN KEY ( cod_tipo )
        REFERENCES tipos_de_cliente ( cod_tipo );

ALTER TABLE comuna
    ADD CONSTRAINT fk_comuna_provincia FOREIGN KEY ( cod_region,
                                                     cod_provincia )
        REFERENCES provincia ( cod_region,
                               cod_provincia );

ALTER TABLE pago_tarjetas
    ADD CONSTRAINT fk_pago_menstarj_forma_pago FOREIGN KEY ( cod_forma_pago )
        REFERENCES forma_pago ( cod_forma_pago );

ALTER TABLE pago_tarjetas
    ADD CONSTRAINT fk_pago_menstarj_tarjeta FOREIGN KEY ( nro_tarjeta )
        REFERENCES tarjeta_cliente ( nro_tarjeta );

ALTER TABLE pesos_premier
    ADD CONSTRAINT fk_pesos_premier FOREIGN KEY ( nro_tarjeta )
        REFERENCES tarjeta_cliente ( nro_tarjeta );

ALTER TABLE provincia
    ADD CONSTRAINT fk_provincia_region FOREIGN KEY ( cod_region )
        REFERENCES region ( cod_region );

ALTER TABLE sucursal
    ADD CONSTRAINT fk_suc__comuna FOREIGN KEY ( cod_region,
                                                cod_provincia,
                                                cod_comuna )
        REFERENCES comuna ( cod_region,
                            cod_provincia,
                            cod_comuna );

ALTER TABLE tarjeta_cliente
    ADD CONSTRAINT fk_tarcliente_cliente FOREIGN KEY ( numrun )
        REFERENCES cliente ( numrun );

ALTER TABLE transaccion_tarjeta_cliente
    ADD CONSTRAINT fk_tarcliente_suc_retail FOREIGN KEY ( id_sucursal )
        REFERENCES sucursal ( id_sucursal );

ALTER TABLE tipo_transaccion_tarjeta
    ADD CONSTRAINT fk_tipo_transaccion_tarjeta FOREIGN KEY ( cod_producto )
        REFERENCES producto ( cod_producto );

ALTER TABLE transaccion_tarjeta_cliente
    ADD CONSTRAINT fk_transactarj_tarjeta FOREIGN KEY ( nro_tarjeta )
        REFERENCES tarjeta_cliente ( nro_tarjeta );

ALTER TABLE transaccion_tarjeta_cliente
    ADD CONSTRAINT fk_transactarj_tptrabtarj FOREIGN KEY ( cod_tptran_tarjeta )
        REFERENCES tipo_transaccion_tarjeta ( cod_tptran_tarjeta );

ALTER TABLE cuota_transac_tarjeta_cliente
    ADD CONSTRAINT fk_trantarj_tran_tarj_cliente FOREIGN KEY ( nro_tarjeta,
                                                               nro_transaccion )
        REFERENCES transaccion_tarjeta_cliente ( nro_tarjeta,
                                                 nro_transaccion );

/*ALTER TABLE det_avances_mes
    ADD CONSTRAINT fk_det_asamen_tarjeta FOREIGN KEY ( nro_tarjeta )
        REFERENCES tarjeta_cliente ( nro_tarjeta );
*/
-- Tabla que debe ser llenada en unos de los requerimientos del ET
--truncate TABLE rango_aumento_superavance;
/*delete  from rango_aumento_cupocompra*/
DROP TABLE seleccion_tipo_transaccion CASCADE CONSTRAINTS;
CREATE TABLE seleccion_tipo_transaccion
(
fecha VARCHAR2(10) NOT NULL,
cod_tipo_transac NUMBER NOT NULL,
nombre_tipo_transac VARCHAR2(60) NOT NULL, 
monto_promedio NUMBER NOT NULL,
CONSTRAINT pk_seleccions PRIMARY KEY(cod_tipo_transac, fecha)
);        

select * from rango_aumento_superavance;

insert into rango_aumento_superavance values (1,18,25,5);
insert into rango_aumento_superavance values (2,26,50,10);
insert into rango_aumento_superavance values (3,51,55,15);
insert into rango_aumento_superavance values (4,56,80,20);

insert into rango_aumento_cupocompra values (1,1,5,5);
insert into rango_aumento_cupocompra values (2,6,10,10);
insert into rango_aumento_cupocompra values (3,11,80,20);
commit;
 
INSERT INTO PRODUCTO VALUES(SEQ_PRODUCTO.NEXTVAL,'Tarjeta Premier','Permite efectuar compras en cualquier tienda (fisica o virtual) que pertenece al Retail y en cualquier tienda adherida. Ademas permite solicitar Avances y Super Avances de Dinero',NULL,NULL);
INSERT INTO PRODUCTO VALUES(SEQ_PRODUCTO.NEXTVAL,'Credito de Consumo','Credito para financiar la compra de bienes de consumo o realizar el pago de servicios destinado a socios que acrediten renta minima de $900.000 mensual. El tope del Credito es de $5.000.000',0.50,72);
INSERT INTO PRODUCTO VALUES(SEQ_PRODUCTO.NEXTVAL,'Credito Automotriz','Credito para la adquisicion de vehiculo nuevo o usado destinado a trabajadores (dependientes o independientes) que acrediten renta minima de $900.000 mensual. El tope del Credito es de $10.000.000',0.4,60);
INSERT INTO PRODUCTO VALUES(SEQ_PRODUCTO.NEXTVAL,'Credito de Emergencia','Credito para solucionar un imprevisto de salud o catastrofe destinado a los socios que acrediten renta minima de $900.000 mensual (para trabajadores) o una pension minima de $150.000 mensual (para pensionados o tercera edad). El tope del Credito es de $1.000.000 para trabajadores y de $300.000 para pensionados o tercera edad',0.35,48);
INSERT INTO PRODUCTO VALUES(SEQ_PRODUCTO.NEXTVAL,'SOAP Seguro Automotiz','Seguro Obligatorio de Accidentes Personales (SOAP)',NULL,NULL);
INSERT INTO PRODUCTO VALUES(SEQ_PRODUCTO.NEXTVAL,'Seguro de Vida','Seguro de proteccion que si al final del periodo contratado no se ha se devuelve un porcentaje de lo pagado en UF',NULL,NULL);
INSERT INTO PRODUCTO VALUES(SEQ_PRODUCTO.NEXTVAL,'Seguro de Salud','Seguro de proteccion ante un futuro cancer y luego de 5 anos, en caso de no haberse usado, se le bonifica en UF',NULL,NULL);
INSERT INTO PRODUCTO VALUES(SEQ_PRODUCTO.NEXTVAL,'Seguro de Hogar','Seguro de hogar que puede proteger en forma parcial o completa cualquier problema de infraestructura y/o sinistro',NULL,NULL);
 
INSERT INTO TIPOS_DE_CLIENTE VALUES(SEQ_TIPOS_CLIENTE.NEXTVAL,'Trabajadores Dependientes','utimos 6 meses');
INSERT INTO TIPOS_DE_CLIENTE VALUES(SEQ_TIPOS_CLIENTE.NEXTVAL,'Trabajadores Independientes','utimos 3 años');
INSERT INTO TIPOS_DE_CLIENTE VALUES(SEQ_TIPOS_CLIENTE.NEXTVAL,'Duena(o) de Casa','Certificado que acredite renta fija');
INSERT INTO TIPOs_de_CLIENTE VALUES(SEQ_TIPOs_CLIENTE.NEXTVAL,'Pensionados y Tercera Edad','De las ultimas 12 rentas acreditadas');

INSERT INTO FORMA_PAGO VALUES(1,'Efectivo');
INSERT INTO FORMA_PAGO VALUES(2,'Transferencia Electronica');
INSERT INTO FORMA_PAGO VALUES(3,'Cheque');

INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'Tarapaca');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'Antofagasta');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'Atacama');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'Coquimbo');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'Valparaiso');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'Del Libertador Gral. Bernardo OHiggins');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'Del Maule');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'Del Biobio');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'De la Araucania');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'De Los Lagos');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'Aysen del Gral.Carlos Ibanez del Campo');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'De Magallanes y de la Antartica Chilena');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'Metropolitana de Santiago');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'De Los Rios');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'Arica y Parinacota');
INSERT INTO REGION VALUES(SEQ_REGION.NEXTVAL, 'De Nuble');

INSERT INTO PROVINCIA VALUES(1,1,'Iquique');
INSERT INTO PROVINCIA VALUES(1,2,'Tamarugal');
INSERT INTO PROVINCIA VALUES(2,1,'Antofagasta');
INSERT INTO PROVINCIA VALUES(2,2,'El Loa');
INSERT INTO PROVINCIA VALUES(2,3,'Tocopilla');
INSERT INTO PROVINCIA VALUES(3,1,'Copiapo');
INSERT INTO PROVINCIA VALUES(3,2,'Chanaral');
INSERT INTO PROVINCIA VALUES(3,3,'Huasco');
INSERT INTO PROVINCIA VALUES(4,1,'Elqui');
INSERT INTO PROVINCIA VALUES(4,2,'Choapa');
INSERT INTO PROVINCIA VALUES(4,3,'Limari');
INSERT INTO PROVINCIA VALUES(5,1,'Valparaiso');
INSERT INTO PROVINCIA VALUES(5,2,'Isla de Pascua');
INSERT INTO PROVINCIA VALUES(5,3,'Los Andes');
INSERT INTO PROVINCIA VALUES(5,4,'Petorca');
INSERT INTO PROVINCIA VALUES(5,5,'Quillota');
INSERT INTO PROVINCIA VALUES(5,6,'San Antonio');
INSERT INTO PROVINCIA VALUES(5,7,'San Felipe de Aconcagua');
INSERT INTO PROVINCIA VALUES(5,8,'Marga Marga');
INSERT INTO PROVINCIA VALUES(6,1,'Cachapoal');
INSERT INTO PROVINCIA VALUES(6,2,'Cardenal Caro');
INSERT INTO PROVINCIA VALUES(6,3,'Colchagua');
INSERT INTO PROVINCIA VALUES(7,1,'Talca');
INSERT INTO PROVINCIA VALUES(7,2,'Cauquenes');
INSERT INTO PROVINCIA VALUES(7,3,'Curico');
INSERT INTO PROVINCIA VALUES(7,4,'Linares');
INSERT INTO PROVINCIA VALUES(8,1,'Concepcion');
INSERT INTO PROVINCIA VALUES(8,2,'Arauco');
INSERT INTO PROVINCIA VALUES(8,3,'Biobio');
INSERT INTO PROVINCIA VALUES(9,1,'Cautin');
INSERT INTO PROVINCIA VALUES(9,2,'Malleco');
INSERT INTO PROVINCIA VALUES(10,1,'Llanquihue');
INSERT INTO PROVINCIA VALUES(10,2,'Chiloe');
INSERT INTO PROVINCIA VALUES(10,3,'Osorno');
INSERT INTO PROVINCIA VALUES(10,4,'Palena');
INSERT INTO PROVINCIA VALUES(11,1,'Coihaique');
INSERT INTO PROVINCIA VALUES(11,2,'Aisen');
INSERT INTO PROVINCIA VALUES(11,3,'Capitan Prat');
INSERT INTO PROVINCIA VALUES(11,4,'General Carrera');
INSERT INTO PROVINCIA VALUES(12,1,'Magallanes');
INSERT INTO PROVINCIA VALUES(12,2,'Antartica Chilena');
INSERT INTO PROVINCIA VALUES(12,3,'Tierra del Fuego');
INSERT INTO PROVINCIA VALUES(12,4,'Ultima Esperanza');
INSERT INTO PROVINCIA VALUES(13,1,'Santiago');
INSERT INTO PROVINCIA VALUES(13,2,'Cordillera');
INSERT INTO PROVINCIA VALUES(13,3,'Chacabuco');
INSERT INTO PROVINCIA VALUES(13,4,'Maipo');
INSERT INTO PROVINCIA VALUES(13,5,'Melipilla');
INSERT INTO PROVINCIA VALUES(13,6,'Talagante');
INSERT INTO PROVINCIA VALUES(14,1,'Valdivia');
INSERT INTO PROVINCIA VALUES(14,2,'Ranco');
INSERT INTO PROVINCIA VALUES(15,1,'Arica');
INSERT INTO PROVINCIA VALUES(15,2,'Parinacota');
INSERT INTO PROVINCIA VALUES(15,4,'Tamarugal');
INSERT INTO PROVINCIA VALUES(16,1,'Diguillun');
INSERT INTO PROVINCIA VALUES(16,2,'Punilla');
INSERT INTO PROVINCIA VALUES(16,3,'Itata');

INSERT INTO COMUNA VALUES(1,1,1,'Iquique');
INSERT INTO COMUNA VALUES(1,1,2,'Alto Hospicio');
INSERT INTO COMUNA VALUES(1,2,1,'Pozo Almonte');
INSERT INTO COMUNA VALUES(1,2,2,'Camina');
INSERT INTO COMUNA VALUES(1,2,3,'Colchane');
INSERT INTO COMUNA VALUES(1,2,4,'Huara');
INSERT INTO COMUNA VALUES(1,2,5,'Pica');
INSERT INTO COMUNA VALUES(2,1,1,'Antofagasta');
INSERT INTO COMUNA VALUES(2,1,2,'Mejillones');
INSERT INTO COMUNA VALUES(2,1,3,'Sierra Gorda');
INSERT INTO COMUNA VALUES(2,1,4,'Taltal');
INSERT INTO COMUNA VALUES(2,2,1,'Calama');
INSERT INTO COMUNA VALUES(2,2,2,'Ollague');
INSERT INTO COMUNA VALUES(2,2,3,'San Pedro de Atacama');
INSERT INTO COMUNA VALUES(2,3,1,'Tocopilla');
INSERT INTO COMUNA VALUES(2,3,2,'Maria Elena');
INSERT INTO COMUNA VALUES(3,1,1,'Copiapo');
INSERT INTO COMUNA VALUES(3,1,2,'Caldera');
INSERT INTO COMUNA VALUES(3,1,3,'Tierra Amarilla');
INSERT INTO COMUNA VALUES(3,2,1,'Chanaral');
INSERT INTO COMUNA VALUES(3,2,3,'Diego de Almagro');
INSERT INTO COMUNA VALUES(3,3,1,'Vallenar');
INSERT INTO COMUNA VALUES(3,3,2,'Alto del Carmen');
INSERT INTO COMUNA VALUES(3,3,3,'Freirina');
INSERT INTO COMUNA VALUES(3,3,4,'Huasco');
INSERT INTO COMUNA VALUES(4,1,1,'La Serena');
INSERT INTO COMUNA VALUES(4,1,2,'Coquimbo');
INSERT INTO COMUNA VALUES(4,1,3,'Andacollo');
INSERT INTO COMUNA VALUES(4,1,4,'La Higuera');
INSERT INTO COMUNA VALUES(4,1,5,'Paiguano');
INSERT INTO COMUNA VALUES(4,1,6,'Vicuna');
INSERT INTO COMUNA VALUES(4,2,1,'Illapel');
INSERT INTO COMUNA VALUES(4,2,2,'Canela');
INSERT INTO COMUNA VALUES(4,2,3,'Los Vilos');
INSERT INTO COMUNA VALUES(4,2,4,'Salamanca');
INSERT INTO COMUNA VALUES(4,3,1,'Ovalle');
INSERT INTO COMUNA VALUES(4,3,2,'Combarbala');
INSERT INTO COMUNA VALUES(4,3,3,'Monte Patria');
INSERT INTO COMUNA VALUES(4,3,4,'Punitaqui');
INSERT INTO COMUNA VALUES(4,3,5,'Rio Hurtado');
INSERT INTO COMUNA VALUES(5,1,1,'Valparaiso');
INSERT INTO COMUNA VALUES(5,1,2,'Casablanca');
INSERT INTO COMUNA VALUES(5,1,3,'Concon');
INSERT INTO COMUNA VALUES(5,1,4,'Juan Fernandez');
INSERT INTO COMUNA VALUES(5,1,5,'Puchuncavi');
INSERT INTO COMUNA VALUES(5,1,6,'Quintero');
INSERT INTO COMUNA VALUES(5,1,7,'Vina del Mar');
INSERT INTO COMUNA VALUES(5,2,1,'Isla de Pascua');
INSERT INTO COMUNA VALUES(5,3,1,'Los Andes');
INSERT INTO COMUNA VALUES(5,3,2,'Calle Larga');
INSERT INTO COMUNA VALUES(5,3,3,'Rinconada');
INSERT INTO COMUNA VALUES(5,3,4,'San Esteban');
INSERT INTO COMUNA VALUES(5,4,1,'La Ligua');
INSERT INTO COMUNA VALUES(5,4,2,'Cabildo');
INSERT INTO COMUNA VALUES(5,4,3,'Papudo');
INSERT INTO COMUNA VALUES(5,4,4,'Petorca');
INSERT INTO COMUNA VALUES(5,4,5,'Zapallar');
INSERT INTO COMUNA VALUES(5,5,1,'Quillota');
INSERT INTO COMUNA VALUES(5,5,2,'Calera');
INSERT INTO COMUNA VALUES(5,5,3,'Hijuelas');
INSERT INTO COMUNA VALUES(5,5,4,'La Cruz');
INSERT INTO COMUNA VALUES(5,5,5,'Nogales');
INSERT INTO COMUNA VALUES(5,6,1,'San Antonio');
INSERT INTO COMUNA VALUES(5,6,2,'Algarrobo');
INSERT INTO COMUNA VALUES(5,6,3,'Cartagena');
INSERT INTO COMUNA VALUES(5,6,4,'El Quisco');
INSERT INTO COMUNA VALUES(5,6,5,'El Tabo');
INSERT INTO COMUNA VALUES(5,6,6,'Santo Domingo');
INSERT INTO COMUNA VALUES(5,7,1,'San Felipe');
INSERT INTO COMUNA VALUES(5,7,2,'Catemu');
INSERT INTO COMUNA VALUES(5,7,3,'Llaillay');
INSERT INTO COMUNA VALUES(5,7,4,'Panquehue');
INSERT INTO COMUNA VALUES(5,7,5,'Putaendo');
INSERT INTO COMUNA VALUES(5,7,6,'Santa Maria');
INSERT INTO COMUNA VALUES(5,8,1,'Quilpue');
INSERT INTO COMUNA VALUES(5,8,2,'Limache');
INSERT INTO COMUNA VALUES(5,8,3,'Olmue');
INSERT INTO COMUNA VALUES(5,8,4,'Villa Alemana');
INSERT INTO COMUNA VALUES(6,1,1,'Rancagua');
INSERT INTO COMUNA VALUES(7,1,1,'Talca');
INSERT INTO COMUNA VALUES(7,2,1,'Cauquenes');
INSERT INTO COMUNA VALUES(7,3,1,'Curico');
INSERT INTO COMUNA VALUES(7,4,1,'Linares');
INSERT INTO COMUNA VALUES(8,1,1,'Concepcion');
INSERT INTO COMUNA VALUES(8,2,1,'Lebu');
INSERT INTO COMUNA VALUES(8,3,1,'Los Angeles');
INSERT INTO COMUNA VALUES(9,1,1,'Temuco');
INSERT INTO COMUNA VALUES(10,1,1,'Puerto Montt');
INSERT INTO COMUNA VALUES(10,1,9,'Puerto Varas');
INSERT INTO COMUNA VALUES(10,2,1,'Castro');
INSERT INTO COMUNA VALUES(10,3,1,'Osorno');
INSERT INTO COMUNA VALUES(11,1,1,'Coihaique');
INSERT INTO COMUNA VALUES(11,2,1,'Aisen');
INSERT INTO COMUNA VALUES(12,1,1,'Punta Arenas');
INSERT INTO COMUNA VALUES(13,1,1,'Santiago');
INSERT INTO COMUNA VALUES(13,1,14,'Las Condes');
INSERT INTO COMUNA VALUES(13,1,32,'Vitacura');
INSERT INTO COMUNA VALUES(13,2,1,'Puente Alto');
INSERT INTO COMUNA VALUES(13,3,1,'Colina');
INSERT INTO COMUNA VALUES(13,4,1,'San Bernardo');
INSERT INTO COMUNA VALUES(13,5,1,'Melipilla');
INSERT INTO COMUNA VALUES(13,6,1,'Talagante');
INSERT INTO COMUNA VALUES(14,1,1,'Valdivia');
INSERT INTO COMUNA VALUES(14,2,1,'La Union');
INSERT INTO COMUNA VALUES(15,1,1,'Arica');
INSERT INTO COMUNA VALUES(16,1,1,'Chillan');

INSERT INTO SUCURSAL VALUES('1011','Avda, Las Parcelas 3512','572573496','1','1','1');
INSERT INTO SUCURSAL VALUES('2011','Barros Arana 5821','552244768','2','1','1');
INSERT INTO SUCURSAL VALUES('3011','Los Carrera 587','522357702','3','1','1');
INSERT INTO SUCURSAL VALUES('3031','Vicuna Mackena 16387','522357150','3','3','1');
INSERT INTO SUCURSAL VALUES('4011','Amunategui 4879','512223060','4','1','1');
INSERT INTO SUCURSAL VALUES('4012','Las Acacias 9876','512245293','4','1','2');
INSERT INTO SUCURSAL VALUES('5011','Avda. Pedro Montt 452','322594673','5','1','1');
INSERT INTO SUCURSAL VALUES('5017','Avda. Libertad 4587','322696323','5','1','7');
INSERT INTO SUCURSAL VALUES('6011','Andres de Alcazar 57','722203300','6','1','1');
INSERT INTO SUCURSAL VALUES('7011','Mateo Toro y Zambrano 45','712203452','7','1','1');
INSERT INTO SUCURSAL VALUES('8011','Avda. Los Carrera 10','412251260','8','1','1');
INSERT INTO SUCURSAL VALUES('10011','Alcalde 734','652316229','10','1','1');
INSERT INTO SUCURSAL VALUES('1111','Simon Bolivar 191','672232555','11','1','1');
INSERT INTO SUCURSAL VALUES('1211','Plaza Munoz Gamero 25','612200306','12','1','1');
INSERT INTO SUCURSAL VALUES('1311','Avda. Domingo Santa Maria 345','226972920','13','1','1');
INSERT INTO SUCURSAL VALUES('13114','Alonso de Cordova 4578','225401407','13','1','14');
INSERT INTO SUCURSAL VALUES('13132','Avda. Vitacura 3478','225401308','13','1','32');
INSERT INTO SUCURSAL VALUES('1321','Adolfo Ruiz Martinez 10','226451407','13','2','1');
INSERT INTO SUCURSAL VALUES('1341','18 de Septiembre 25','225401201','13','4','1');
INSERT INTO SUCURSAL VALUES('1511','Dieciocho de Septiembre 257','582458797','15','1','1');
INSERT INTO SUCURSAL VALUES('1611','El Roble 4578','428793214','16','1','1');

INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Abogado');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Consejero vocacional');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Ingeniero comercial');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Enfermera(o)');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Contador');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Tecnico del Area de la salud');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Tecnico en computacion');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Ingeniero en Informatica');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Ingeniero en Redes y Telecomunicaciones');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Conductor de camion');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Mecanico de auto');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Operario de maquinaria');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Contador');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Disenador');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Dentista');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Educadora(o) de parvulo');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Cajero');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Vendedor');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Conserje');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Profesor');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Pensionado');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Asesor Financiero');
INSERT INTO OCUPACION VALUES(SEQ_PROFESION_OFICIO.NEXTVAL,'Administrativo');

INSERT INTO CLIENTE VALUES('8333032','5','RODOLFO ','SERGIO','FRITZ','OTAROLA','14/11/1953','19/09/1993',null,null,'Errazuriz 234 Depto 45 Edificio Vista Mar','5','1','1','2','20');
INSERT INTO CLIENTE VALUES('16000472','k','ROBERTO','JUAN','MENDEZ','GIRARDI','01/08/1976','17/02/2003',null,null,'Emiliano Zapata 864','13','1','1','11','10');
INSERT INTO CLIENTE VALUES('16044255','7','STEPHANIE',null,'DIAZ','KOHNERT','07/09/1977','18/10/2003',null,null,'Avda. General Velasquez 123 Depto 45','13','1','1','12','10');
INSERT INTO CLIENTE VALUES('10534911','4','CATALINA','ANDREA','AGUIRRE','PEREIRA','21/12/1965','30/04/1995',null,null,'Avda. Domingo Santa Maria 34','13','1','1','5','20');
INSERT INTO CLIENTE VALUES('21425048','9','SEBASTIAN','PATRICIO','QUINTANA','BERRIOS','20/02/1990','19/04/2009',null,null,'Alonso de Cordova 234 Depto 23 Edificio Sol','13','1','14','23','20');
INSERT INTO CLIENTE VALUES('21815820','k','HERNAN','CESAR','CASTRO','VALLADARES','12/10/1992','19/09/2010',null,null,'Padre Alberto de Agostini 23','12','1','1','3','10');
INSERT INTO CLIENTE VALUES('14405524','1','CARLOS','CLAUDIO','HERNANDEZ','BARRA','10/09/1972','01/10/2000',null,null,'Gabriela Mistral 986','11','1','1','8','10');
INSERT INTO CLIENTE VALUES('9053148','4','ALVARO','MIGUEL','MONCADA','RIQUELME','01/08/1961','28/02/1994',null,null,'Alcalde Eduardo Melero 235','6','1','1','3','10');
INSERT INTO CLIENTE VALUES('14423721','8','CLAUDIO','JUAN','ARAVENA','ARANCIBIA','30/03/1973','30/09/2001',null,null,'Avda. Alemania 23','5','1','1','9','20');
INSERT INTO CLIENTE VALUES('14439730','4','ELSA','ESPERANZA','GOMEZ','ARAVENA','19/12/1974','29/03/2002',null,null,'Avda. Alemania 2345','5','1','1','10','30');
INSERT INTO CLIENTE VALUES('14423722','8','CLAUDIO','MANUEL','ARANCIBIA','ARAVENA','28/07/1974','10/05/2002',null,null,'2 Oriente 2345 Depto 101 Edificio Costa Mar','5','1','7','10','20');
INSERT INTO CLIENTE VALUES('14412583','7','CARMEN',null,'ARANCIBIA','PEREZ','20/10/1972','17/10/2001',null,null,'Los Almendros 123 Miraflores Bajo','5','1','7','9','10');
INSERT INTO CLIENTE VALUES('22503814','7','JULIAN','PAUL','ARRIAGADA','LUJAN','19/12/1991','28/02/2012',null,null,'Amunategui 46 Depto 2 Edificio Vista Mar','4','1','1','3','10');
INSERT INTO CLIENTE VALUES('21037593','7','ANDREA','BELEN','GUAJARDO','LOPEZ','01/08/1988','17/10/2008',null,null,'Ana Maria Ibaceta 90','2','1','1','23','20');
INSERT INTO CLIENTE VALUES('20393065','k','SEBASTIAN',null,'ABELLI','MORENO','17/02/1985','01/10/2007',null,null,'Santa Magdalena 43 Depto 45 Torre A','2','1','1','19','20');
INSERT INTO CLIENTE VALUES('6868859','0','ALICIA','LORENA','OPAZO','RIQUELME','23/03/1948','09/12/1991',null,null,'Abel Altura35','1','1','1','21','40');
INSERT INTO CLIENTE VALUES('6889505','7','JOAQUIN','RONNY','GUTIERREZ','SALGADO','20/10/1947','17/10/1992',null,null,'Guatacondo 57 Depto 35 Edificio Mar Bello','1','1','1','21','40');
INSERT INTO CLIENTE VALUES('17613770','3','MARIA','JESUS','VALLADARES','CARCAMO','09/08/1984','09/10/2005',null,null,'Pedro de Valdivia 63','1','1','1','15','10');
INSERT INTO CLIENTE VALUES('5331148','2','JUAN','CARLOS','LOPEZ','ALVAREZ','20/02/1946','04/01/1990',null,null,'Avda. Los Aromos 1743','1','1','1','21','40');

INSERT INTO CLIENTE VALUES('8925537','6','LORENA','DE LAS NIEVES','FIGUEROA','RODRIGUEZ','16/04/1958','03/10/1993',null,null,'Andres de Alcazar 234','6','1','1','2','20');
INSERT INTO CLIENTE VALUES('8948642','4','SANDRA','CLAUDIA','ARIAS','PONCE','20/02/1960','04/01/1994',null,null,'Aconcagua 543','6','1','1','3','20');
INSERT INTO CLIENTE VALUES('17046055','3','MARCIA ','MONICA','BENITEZ','SIERRA','12/09/1980','25/05/2005',null,null,'Sergio Valdovinos 123','13','1','1','14','10');
INSERT INTO CLIENTE VALUES('13635211','3','VALESKA',null,'GODOY','ALTAMIRANO','24/09/1970','06/01/2000',null,null,'Jose Joaquin Perez 456','13','1','1','7','10');
INSERT INTO CLIENTE VALUES('16439752','1','LUIS','MIGUEL','ALVAREZ','PEREZ','12/12/1978','19/12/2004',null,null,'Salvador Gutierrez 7865','13','1','1','12','10');
INSERT INTO CLIENTE VALUES('16947140','1','PAMELA',null,'GATICA','MANDIOLA','16/04/1979','03/10/2004',null,null,'Miguel de Cervantes 89','13','1','1','13','10');
INSERT INTO CLIENTE VALUES('9074608','1','AXEL','PABLO','HOGGER','GUZMAN','10/09/1962','01/10/1994',null,null,'Avda.San Miguel 298','7','1','1','3','10');
INSERT INTO CLIENTE VALUES('22424125','9','NICOLAS','PABLO','BERMUDEZ','DOMINGUEZ','30/03/1990','12/01/2011',null,null,'Cienfuegos 256','4','1','1','3','10');
INSERT INTO CLIENTE VALUES('22176844','2','SILVANA','MARIA','DUARTE','VALENZUELA','09/09/1992','04/01/2010',null,null,'Pablo Ramon Aranda 45','12','1','1','3','10');
INSERT INTO CLIENTE VALUES('7455785','6','ANDREA','ROXANA','ROMERO','GUAJARDO','12/10/1957','14/09/1993',null,null,'Agustina 234','13','1','1','1','20');
INSERT INTO CLIENTE VALUES('21454911','5','JOSE',' MIGUEL','TOBAR','TAPIA','23/06/1991','14/09/2009',null,null,'Jose Manuel Balmaceda 456','13','1','1','23','20');
INSERT INTO CLIENTE VALUES('7467775','4','FELIPE','CLAUDIO','GONZALEZ','MARIN','20/10/1956','04/04/1993',null,null,'Ercilla 234 Cerro Baron','5','1','1','1','20');
INSERT INTO CLIENTE VALUES('21281335','4','ANTONELLA','SOFIA','ALVARADO','GUZMAN','23/10/1989','30/09/2008',null,null,'Aurora de Chile 345','13','1','1','22','20');
INSERT INTO CLIENTE VALUES('14415535','1','FABIOLA',null,'MENESES','SILVA','09/09/1973','12/08/2001',null,null,'Gran Bretana 345 Playa Ancha','5','1','1','9','20');
INSERT INTO CLIENTE VALUES('7035297','4','DORIS','PAMELA','FONSECA','ARREDONDO','17/02/1956','19/04/1992',null,null,'Garcia Lorca 46','2','1','1','21','40');
INSERT INTO CLIENTE VALUES('22558061','8','AMANDA','ROMINA','LIZANA','MARAMBIO','17/02/1991','01/10/2013',null,null,'Los Carrera 875','4','1','1','4','20');
INSERT INTO CLIENTE VALUES('6433225','2','BELEN',null,'FIGUEROA','SEPULVEDA','12/09/1948','25/05/1990',null,null,'Heroes de la Concepcion 45','1','1','1','21','40');
INSERT INTO CLIENTE VALUES('6918258','5','DENISSE','SOFIA','MARDONES','SMITH','06/01/1951','19/11/1992',null,null,'Gran Bretana 36','12','1','1','21','40');
INSERT INTO CLIENTE VALUES('7471610','5','CLAUDIA','ANDREA','CASTILLO','CONTRERAS','23/10/1956','07/07/1993',null,null,'Los Placeres 23 Depto 45 Cerro Los Placeres','5','1','1','2','20');
INSERT INTO CLIENTE VALUES('23309886','8','HECTOR','ALAN','CONTRERAS','TOLOZA','07/09/1990','19/09/2016',null,null,'Los Loros 1256','3','1','1','5','20');
INSERT INTO CLIENTE VALUES('20866869','2','ANDRES','HUGO','MORALES','CONTRERAS','23/03/1983','09/12/2007',null,null,'Ana Maria Ibaceta 46','2','1','1','20','20');
INSERT INTO CLIENTE VALUES('20393064','k','SEBASTIAN','JOSE','MORENO','ABELLI','21/12/1989','09/10/2007',null,null,'Javiera Carrera Depto 34 Edificio Norte','2','1','1','18','10');
INSERT INTO CLIENTE VALUES('21300628','2','LUIS','CLAUDIO','LUNA','JORQUERA','14/11/1988','29/03/2008',null,null,'Avda. Independencia 3456','13','1','1','13','20');
INSERT INTO CLIENTE VALUES('24617340','0','KATHERINE','ANDREA','MUNOZ','ESTRADA','14/11/1991','06/01/2017',null,null,'Avda. Los Carrera 2356','8','1','1','5','10');
INSERT INTO CLIENTE VALUES('12173453','2','VIVIANA',null,'GALDAMES','GODOY','23/10/1969','07/07/1998',null,null,'Alfonso Alcalde 873','12','1','1','6','10');
INSERT INTO CLIENTE VALUES('18274953','2','CAROLINA',null,'SILVA','BLANCO','23/03/1987','09/12/2006',null,null,'General Mendoza 328','1','1','1','15','10');
INSERT INTO CLIENTE VALUES('12362092','5','SANDRA','XIMENA','AGUILAR','FALCON','14/11/1969','19/09/1999',null,null,'Hernando de Magallanes 123','12','1','1','7','10');
INSERT INTO CLIENTE VALUES('6604004','6','CRISTIAN','LUIS','RODRIGUEZ','VALDES','09/08/1953','09/10/1991',null,null,'Almirante Latorre 45','1','1','1','21','40');
INSERT INTO CLIENTE VALUES('21713767','5','RODRIGO','DAMASO','PARRA','BERNAL','10/09/1991','07/07/2010',null,null,'Avda. Apoquindo 23','13','1','14','5','20');
INSERT INTO CLIENTE VALUES('10964217','7','PATRICIO','LUIS','PRADENAS','VIDAL','23/03/1966','23/11/1996',null,null,'Adela Von Hagrn 567','10','1','1','5','20');
INSERT INTO CLIENTE VALUES('6969889','1','FERNANDO','LUIS','BUGUENO','CARVAJAL','19/12/1956','29/03/1992',null,null,'Barros Arana 456','2','1','1','21','40');
INSERT INTO CLIENTE VALUES('21487945','k','CARLOS','MARIO','ROA','GUTIERREZ','01/08/1990','04/04/2009',null,null,'Tomas Moro 234','13','1','14','22','20');
INSERT INTO CLIENTE VALUES('12084102','5','JOSE','MIGUEL','QUIROZ','CANDIA','20/10/1968','04/04/1997',null,null,'Alcalde Roberto Mackay 12','11','1','1','6','20');
INSERT INTO CLIENTE VALUES('14286264','6','ALEXIS','HERNAN','CONA','CONTRERAS','12/09/1971','25/05/2000',null,null,'Avda. Argentina 134','16','1','1','8','40');
INSERT INTO CLIENTE VALUES('17024034','0','LEONARDO','CRISTIAN','DUARTE','AREVALO','24/09/1981','06/01/2004',null,null,'Avda. Presidente Riesco 1245','13','1','14','13','10');
INSERT INTO CLIENTE VALUES('18936554','3','PAOLA','MARIA','SIEBERT','OJEDA','06/01/1987','06/01/2007',null,null,'Jose Miguel Carrera 235','1','1','1','17','10');
INSERT INTO CLIENTE VALUES('22725177','8','XIMENA',null,'URRUTIA','PEREZ','12/10/1991','09/09/2013',null,null,'Los Carrera 87 Depto 21 Edificio Luna','3','1','1','4','20');
INSERT INTO CLIENTE VALUES('9043491','8','FRANCISCA','ROSA','CASTRO','CONTRERAS','23/06/1960','12/01/1994',null,null,'Giuseppe Verdi 27','6','1','1','3','10');
INSERT INTO CLIENTE VALUES('10105553','1','ALICIA','ROMINA','SALDIVAR','SEPULVEDA','30/03/1964','30/09/1995',null,null,'Los militares 2378','13','1','14','4','20');
INSERT INTO CLIENTE VALUES('14412582','7','CARMEN','LUISA','PEREZ','ARANCIBIA','12/10/1973','09/09/2001',null,null,'Avda. Alemania 123 Deto 67 Edificio Bella Vista','5','1','1','9','10');
INSERT INTO CLIENTE VALUES('14318610','5','VALESKA',null,'RIQUELME','CARVALLO','09/08/1972','09/10/2000',null,null,'Bernardo O''Higgins 124','15','1','1','8','30');
INSERT INTO CLIENTE VALUES('18858542','6','DENISSE','ALICIA','DIAZ','MIRANDA','09/09/1986','12/08/2006',null,null,'Las Acacias 57','1','1','1','16','10');
INSERT INTO CLIENTE VALUES('13386967','0','CLAUDIA','CAROLINA','KOHNERT','TOLOZA','20/02/1970','04/01/1999',null,null,'Tiziano 34','13','1','14','7','10');
INSERT INTO CLIENTE VALUES('9806691','8','MARCIA','LORENA','GUTIERREZ','URZUA','06/01/1964','19/11/1995',null,null,'Albacete 98','13','1','14','4','20');
INSERT INTO CLIENTE VALUES('11633656','1','GIANNINA','FRANCISCA','AGUIRRE','GREZ','01/08/1967','17/02/1997',null,null,'Altas Cumbres Depto 23','11','1','1','6','20');
INSERT INTO CLIENTE VALUES('6953740','5','ELENA',null,'OPAZO','SILVA','28/07/1957','10/05/1992',null,null,'Larrain Mancheno 67','2','1','1','21','40');
INSERT INTO CLIENTE VALUES('23131860','7','PAMELA','ANDREA','GUERRERO','DIAZ','20/10/1991','12/08/2015',null,null,'Luis Flores 456','3','1','1','5','30');
INSERT INTO CLIENTE VALUES('21242003','4','KAREN','SOFIA','PRADENAS','MANDIOLA','07/09/1985','19/11/2008',null,null,'Martin de Zamora 23','13','1','14','22','20');
INSERT INTO CLIENTE VALUES('5802137','7','ANA',null,'LIBERONA','VALDES','24/09/1946','06/01/1990',null,null,'Avda, Las Parcelas 1863','1','1','1','21','40');
INSERT INTO CLIENTE VALUES('6175302','8','MARTA','ANDREA','AGUILAR','BAQUEDANO','23/06/1950','12/01/1990',null,null,'Blanco Encalada 23','1','1','1','21','40');
INSERT INTO CLIENTE VALUES('14652456','7','CAROLINA',null,'PINO','MUNOZ','17/02/1975','19/04/2002',null,null,'Avda. Apoquindo 786','13','1','14','10','10');
INSERT INTO CLIENTE VALUES('18181488','8','VIVIANA',null,'PRADA','ESCOBAR','10/09/1985','01/10/2005',null,null,'Las Magnolias 56','1','1','1','15','10');
INSERT INTO CLIENTE VALUES('9334416','2','JAVIERA','SOFIA','PEREIRA','ROA','12/10/1963','09/09/1994',null,null,'Mateo Toro y Zambrano 23','7','1','1','4','10');
INSERT INTO CLIENTE VALUES('6868860','0','ALICIA','MARLENE','RIQUELME','OPAZO','12/10/1946','09/09/1992',null,null,'Playa Lobito Depto 67 Edificio Iquique','1','1','1','21','40');
INSERT INTO CLIENTE VALUES('16044256','7','STEPHANIE',null,'KOHNERT','DIAZ','23/10/1978','07/07/2003',null,null,'Alonso de Cordova 98','13','1','14','12','10');
INSERT INTO CLIENTE VALUES('8948643','4','SANDRA',null,'PONCE','ARIAS','24/09/1960','06/01/1994',null,null,'Hernando de Magallanes 76','6','1','1','3','10');
INSERT INTO CLIENTE VALUES('13635212','3','VALESKA','NICOLE','ALTAMIRANO','GODOY','23/06/1971','12/01/2000',null,null,'El Roble 234 Depto 23','16','1','1','7','30');
INSERT INTO CLIENTE VALUES('16439753','1','LUIS','JAIME','PEREZ','ALVAREZ','14/11/1979','19/09/2004',null,null,'Calle Luis Pasteur567','13','1','32','13','10');
INSERT INTO CLIENTE VALUES('21815821','k','HERNAN','DAVID','VALLADARES','CASTRO','20/10/1992','03/10/2010',null,null,'Andres Stambuk Urzic 12','12','1','1','3','10');
INSERT INTO CLIENTE VALUES('16947141','1','PAMELA','ROCIO','MANDIOLA','GATICA','20/02/1981','04/01/2004',null,null,'Avda. Vitacura 34','13','1','32','13','10');
INSERT INTO CLIENTE VALUES('14405525','1','CARLOS','JOEL','BARRA','HERNANDEZ','23/03/1972','09/12/2001',null,null,'18 Septiembre 23 Condominio San Roque Casa 2','15','1','1','8','10');
INSERT INTO CLIENTE VALUES('9074609','1','AXEL','MIGUEL','GUZMAN','HOGGER','23/03/1963','09/12/1994',null,null,'Brisas del Claro 256','7','1','1','4','10');
INSERT INTO CLIENTE VALUES('9053149','4','ALVARO','RODRIGO','RIQUELME','MONCADA','09/08/1962','09/10/1994',null,null,'Las Araucarias 38','7','1','1','3','10');
INSERT INTO CLIENTE VALUES('22424126','9','NICOLAS','JUAN','DOMINGUEZ','BERMUDEZ','28/07/1992','25/05/2012',null,null,'Jose Manuel Balmaceda 284','4','1','1','3','10');
INSERT INTO CLIENTE VALUES('21037594','7','ANDREA',null,'LOPEZ','GUAJARDO','20/10/1989','12/08/2008',null,null,'Leonardo DaVinci 34','2','1','1','22','20');
INSERT INTO CLIENTE VALUES('22176845','2','SILVANA','MARTINA','VALENZUELA','DUARTE','06/01/1991','06/01/2011',null,null,'Avenida Costanera del Estrecho 35','12','1','1','3','10');
INSERT INTO CLIENTE VALUES('7455786','6','ANDREA','PAZ','GUAJARDO','ROMERO','01/08/1952','17/02/1993',null,null,'Las Hualtatas 765','13','1','32','1','20');
INSERT INTO CLIENTE VALUES('6889506','7','JOAQUIN','CARLOS','SALGADO','GUTIERREZ','09/09/1959','12/08/1992',null,null,'Las Pasionarias 678','1','1','1','21','40');
INSERT INTO CLIENTE VALUES('10534912','4','CATALINA','SOFIA','PEREIRA','AGUIRRE','17/02/1966','19/04/1996',null,null,'Alborada 345','10','1','1','5','20');
INSERT INTO CLIENTE VALUES('15583473','2','RICARDO','ALEX','ARIAS','FERNANDEZ','12/10/1975','14/09/2003',null,null,'Las Garzas 345','13','2','1','11','10');
INSERT INTO CLIENTE VALUES('21454912','5','JOSE','MIGUEL','TAPIA','TOBAR','12/09/1991','17/02/2009',null,null,'27 de Septiembre 9843','13','2','1','22','20');
INSERT INTO CLIENTE VALUES('7467776','4','FELIPE','CRISTIAN','MARIN','GONZALEZ','07/09/1953','18/10/1993',null,null,'Avda. Los Castanos 234','5','1','7','1','20');
INSERT INTO CLIENTE VALUES('21281336','4','ANTONELLA',null,'GUZMAN','ALVARADO','12/12/1990','10/05/2008',null,null,'Las Orquideas Depto 34 Torre E','13','2','1','22','20');
INSERT INTO CLIENTE VALUES('14415536','1','FABIOLA','ANDREA','SILVA','MENESES','06/01/1973','19/11/2001',null,null,'8 Norte 234 Depto 765 Edificio Santa Clara','5','1','7','9','20');
INSERT INTO CLIENTE VALUES('7035298','4','DORIS','YANINA','ARREDONDO','FONSECA','23/03/1952','23/11/1993',null,null,'Adolfo Ruiz Martinez 456','13','2','1','1','20');
INSERT INTO CLIENTE VALUES('22558062','8','AMANDA','FABIOLA','MARAMBIO','LIZANA','23/03/1993','09/12/2013',null,null,'Avda. Videla 754','4','1','2','4','20');
INSERT INTO CLIENTE VALUES('16000473','k','ROBERTO','DANIEL','GIRARDI','MENDEZ','20/10/1977','04/04/2003',null,null,'Almirante Latorre 3456','13','2','1','12','10');
INSERT INTO CLIENTE VALUES('6433226','2','BELEN','JACQUELINE','SEPULVEDA','FIGUEROA','01/08/1954','28/02/1991',null,null,'Llanquihue 1567','1','1','1','21','40');
INSERT INTO CLIENTE VALUES('6918259','5','DENISSE','ALEJANDRA','SMITH','MARDONES','30/03/1959','30/09/1992',null,null,'Carlos Von Buren 654','2','1','1','21','40');
INSERT INTO CLIENTE VALUES('7471611','5','CLAUDIA',null,'CONTRERAS','CASTILLO','12/12/1959','19/12/1993',null,null,'Avda. San Martin 654 Depto 94 Edificio Sol','5','1','7','2','20');
INSERT INTO CLIENTE VALUES('23309887','8','HECTOR','FRANCISCO','TOLOZA','CONTRERAS','23/10/1992','03/10/2016',null,null,'Sgto. Aldea 86','3','3','1','5','10');
INSERT INTO CLIENTE VALUES('18333033','5','RODOLFO','CRISTIAN','OTAROLA','FRITZ','20/10/1984','17/10/2006',null,null,'Pukara Ticara 578','1','1','1','16','10');
INSERT INTO CLIENTE VALUES('20866870','2','ANDRES','LUIS','CONTRERAS','MORALES','12/10/1987','09/09/2008',null,null,'Leonardo DaVinci 57','2','1','1','23','20');
INSERT INTO CLIENTE VALUES('22503815','7','JULIAN','CARLOS','LUJAN','ARRIAGADA','21/12/1990','09/10/2012',null,null,'Avda. Costanera 1574','4','1','2','4','10');
INSERT INTO CLIENTE VALUES('21300629','2','LUIS',null,'JORQUERA','LUNA','16/04/1990','30/04/2009',null,null,'Alto Los Leones 8873','13','2','1','13','20');
INSERT INTO CLIENTE VALUES('24617341','0','KATHERINE','ROSA','ESTRADA','MUNOZ','16/04/1992','12/01/2017',null,null,'Alcalde Juan Jose de Mira 1235','10','1','1','5','10');
INSERT INTO CLIENTE VALUES('9575921','3','MARIA','EUGENIA','LARRAIN','ESCOBAR','09/09/1964','12/08/1995',null,null,'Isla Juan Fernendez 2345','13','4','1','4','10');
INSERT INTO CLIENTE VALUES('12173454','2','VIVIANA','ANDREA','GODOY','GALDAMES','12/12/1969','19/12/1998',null,null,'Avenida Los Generales 675','12','1','1','7','10');
INSERT INTO CLIENTE VALUES('18274954','2','CAROLINA','AMANDA','BLANCO','SILVA','12/10/1987','09/09/2006',null,null,'Salitrera La Pampa 932','1','1','1','16','10');
INSERT INTO CLIENTE VALUES('12362093','5','SANDRA','LORENA','FALCON','AGUILAR','16/04/1969','03/10/1999',null,null,'18 de Septiembre 982','13','4','1','7','10');
INSERT INTO CLIENTE VALUES('6604005','6','CRISTIAN','JUAN','VALDES','RODRIGUEZ','10/09/1947','01/10/1991',null,null,'San Pedro 45','1','1','1','21','40');
INSERT INTO CLIENTE VALUES('21713768','5','RODRIGO','FREDY','BERNAL','PARRA','23/03/1990','19/12/2010',null,null,'Doctor Eduardo Valdes 1256','12','1','1','5','10');
INSERT INTO CLIENTE VALUES('10964218','7','PATRICIO','ARNOLDO','VIDAL','PRADENAS','12/10/1967','14/09/1997',null,null,'Lago O''Higgins 45','10','1','1','5','20');
INSERT INTO CLIENTE VALUES('21425049','9','SEBASTIAN',null,'BERRIOS','QUINTANA','24/09/1990','23/11/2009',null,null,'Adolfo Stierling 174','13','4','1','23','20');
INSERT INTO CLIENTE VALUES('6969890','1','FERNANDO','RAFAEL','CARVAJAL','BUGUENO','21/12/1959','30/04/1992',null,null,'Alfonso Casanova 3456','13','4','1','21','40');
INSERT INTO CLIENTE VALUES('21487946','k','CARLOS','RAFAEL','GUTIERREZ','ROA','09/08/1991','18/10/2009',null,null,'Amazonas 9886','13','4','1','5','20');
INSERT INTO CLIENTE VALUES('19348481','8','SEBASTIAN','NICOLAS','RETAMAL','DIAZ','19/12/1989','28/02/2007',null,null,'Cienfuegos 176','2','1','1','18','10');
INSERT INTO CLIENTE VALUES('12084103','5','JOSE','MIGUEL','CANDIA','QUIROZ','07/09/1968','18/10/1997',null,null,'Maria Luisa Bombal 534','11','1','1','6','10');
INSERT INTO CLIENTE VALUES('14286265','6','ALEXIS','FERNANDO','CONTRERAS','CONA','01/08/1970','28/02/2000',null,null,'Avenida Chapiquina 345','15','1','1','8','40');
INSERT INTO CLIENTE VALUES('17024035','0','LEONARDO','ANDRES','AREVALO','DUARTE','23/06/1982','12/01/2005',null,null,'Lago Caburga 996','13','4','1','14','10');
INSERT INTO CLIENTE VALUES('18936555','3','PAOLA','MARGARITA','OJEDA','SIEBERT','30/03/1988','12/01/2007',null,null,'Los Manzanos 345','2','1','1','17','10');
INSERT INTO CLIENTE VALUES('22725178','8','XIMENA','MARCELA','PEREZ','URRUTIA','01/08/1992','17/10/2015',null,null,'Lautaro 85','3','3','1','4','20');
INSERT INTO CLIENTE VALUES('9043492','8','FRANCISCA','PAULA','CONTRERAS','CASTRO','12/09/1961','25/05/1994',null,null,'Jose Sotomayor 976','6','1','1','3','10');
INSERT INTO CLIENTE VALUES('10105554','1','ALICIA','NANCY','SEPULVEDA','SALDIVAR','28/07/1965','10/05/1995',null,null,'Blanco Encalada Depto 34 Edificio San Bernardo','13','4','1','5','20');
INSERT INTO CLIENTE VALUES('14439731','4','ELSA','MARIA','ARAVENA','GOMEZ','21/12/1974','30/04/2002',null,null,'Alvarez 234 Depto 123 Edificio San Luis','5','1','7','10','20');
INSERT INTO CLIENTE VALUES('15583472','2','RICARDO','JUAN','FERNANDEZ','ARIAS','23/03/1975','23/11/2002',null,null,'Palermo 984','13','1','1','11','10');
INSERT INTO CLIENTE VALUES('19348480','8','SEBASTIAN','MANUEL','DIAZ','RETAMAL','28/07/1988','25/05/2007',null,null,'La Rinconada 53','2','1','1','17','10');
INSERT INTO CLIENTE VALUES('9575920','3','MARIA','EUGENIA','ESCOBAR','LARRAIN','20/10/1963','17/10/1994',null,null,'Los Tamarugos 1456','7','1','1','4','10');
INSERT INTO CLIENTE VALUES('23552593','3','SANDRA','JIMENA','HERNANDEZ','CAVIERES','12/12/1992','04/01/2016',null,null,'Vicuna Mackena 163','3','1','1','5','30');
INSERT INTO CLIENTE VALUES('17046056','3','MARCIA','PAULA','SIERRA','BENITEZ','01/08/1983','28/02/2005',null,null,'Fernando de Aragon 23','13','1','14','14','10');
INSERT INTO CLIENTE VALUES('10238016','9','MARLENE',null,'MONDEJA','BARROS','19/12/1965','29/03/1995',null,null,'Avda. Presidente Riesco 234 ','13','1','14','5','20');


--******************************************************************************************************************
/*delete from TARJETA_CLIENTE;

select * from TARJETA_CLIENTE;

DROP TABLE tarjeta_cliente CASCADE CONSTRAINTS;*/

INSERT INTO TARJETA_CLIENTE VALUES('32924617341','24617341','19/12/2013','20','1660000','1162000','498000','464800');
INSERT INTO TARJETA_CLIENTE VALUES('32824617340','24617340','28/02/2011','20','1200000','840000','360000','336000');
INSERT INTO TARJETA_CLIENTE VALUES('32723552593','23552593','23/11/2013','20','1280000','896000','384000','358400');
INSERT INTO TARJETA_CLIENTE VALUES('32623309887','23309887','18/10/2013','20','840000','588000','252000','235200');
INSERT INTO TARJETA_CLIENTE VALUES('32523309886','23309886','12/08/2012','15','1750000','1225000','525000','490000');
INSERT INTO TARJETA_CLIENTE VALUES('32423131860','23131860','17/02/2013','15','1570000','1099000','471000','439600');
INSERT INTO TARJETA_CLIENTE VALUES('32322725178','22725178','09/09/2012','15','250000','175000','75000','70000');
INSERT INTO TARJETA_CLIENTE VALUES('32222725177','22725177','12/01/2010','15','1375000','962500','412500','385000');
INSERT INTO TARJETA_CLIENTE VALUES('32122558062','22558062','06/01/2010','10','1250000','875000','375000','350000');
INSERT INTO TARJETA_CLIENTE VALUES('32022558061','22558061','10/05/2012','10','1710000','1197000','513000','478800');
INSERT INTO TARJETA_CLIENTE VALUES('31922503815','22503815','04/01/2010','10','1000000','700000','300000','280000');
INSERT INTO TARJETA_CLIENTE VALUES('31822503814','22503814','29/03/2012','25','1600000','1120000','480000','448000');
INSERT INTO TARJETA_CLIENTE VALUES('31722424126','22424126','09/10/2011','25','620000','434000','186000','173600');
INSERT INTO TARJETA_CLIENTE VALUES('31622424125','22424125','07/07/2013','30','690000','483000','207000','193200');
INSERT INTO TARJETA_CLIENTE VALUES('31522176845','22176845','19/11/2012','5','850000','595000','255000','238000');
INSERT INTO TARJETA_CLIENTE VALUES('31422176844','22176844','25/05/2010','10','1295000','906500','388500','362600');
INSERT INTO TARJETA_CLIENTE VALUES('31321815821','21815821','19/04/2012','15','1380000','966000','414000','386400');
INSERT INTO TARJETA_CLIENTE VALUES('31221815820','21815820','04/04/2013','25','1110000','777000','333000','310800');
INSERT INTO TARJETA_CLIENTE VALUES('31121713768','21713768','14/09/2013','10','1200000','840000','360000','336000');
INSERT INTO TARJETA_CLIENTE VALUES('31021713767','21713767','17/10/2012','25','1200000','840000','360000','336000');
INSERT INTO TARJETA_CLIENTE VALUES('30921487946','21487946','09/12/2011','30','940000','658000','282000','263200');
INSERT INTO TARJETA_CLIENTE VALUES('30821487945','21487945','18/02/2010','10','1470000','1029000','441000','411600');
INSERT INTO TARJETA_CLIENTE VALUES('30721454912','21454912','29/12/2019','10','1825000','1277500','547500','511000');
INSERT INTO TARJETA_CLIENTE VALUES('30621454911','21454911','18/02/2010','25','880000','616000','264000','246400');
INSERT INTO TARJETA_CLIENTE VALUES('30521425049','21425049','29/12/2015','15','1520000','1064000','456000','425600');
INSERT INTO TARJETA_CLIENTE VALUES('30421425048','21425048','16/10/2010','25','1360000','952000','408000','380800');
INSERT INTO TARJETA_CLIENTE VALUES('30321300629','21300629','15/11/2010','30','1200000','840000','360000','336000');
INSERT INTO TARJETA_CLIENTE VALUES('30221300628','21300628','06/04/2010','30','1295000','906500','388500','362600');
INSERT INTO TARJETA_CLIENTE VALUES('30121281336','21281336','30/07/2012','30','2230000','1561000','669000','624400');
INSERT INTO TARJETA_CLIENTE VALUES('30021281335','21281335','05/02/2012','30','860000','602000','258000','240800');
INSERT INTO TARJETA_CLIENTE VALUES('29921242003','21242003','17/09/2019','30','1624000','1136800','487200','454720');
INSERT INTO TARJETA_CLIENTE VALUES('29821037594','21037594','15/09/2010','30','460000','322000','138000','128800');
INSERT INTO TARJETA_CLIENTE VALUES('29721037593','21037593','25/06/2011','20','630000','441000','189000','176400');
INSERT INTO TARJETA_CLIENTE VALUES('29620866870','20866870','01/03/2011','20','1420000','994000','426000','397600');
INSERT INTO TARJETA_CLIENTE VALUES('29520866869','20866869','20/01/2012','20','640000','448000','192000','179200');
INSERT INTO TARJETA_CLIENTE VALUES('29420393065','20393065','12/12/2013','15','1520000','1064000','456000','425600');
INSERT INTO TARJETA_CLIENTE VALUES('29320393064','20393064','25/03/2015','15','2395000','1500000','1418500','900600');
INSERT INTO TARJETA_CLIENTE VALUES('29219348481','19348481','15/12/2016','15','964000','674800','289200','269920');
INSERT INTO TARJETA_CLIENTE VALUES('29119348480','19348480','16/02/2010','15','400000','280000','120000','112000');
INSERT INTO TARJETA_CLIENTE VALUES('29018936555','18936555','18/02/2012','10','920000','644000','276000','257600');
INSERT INTO TARJETA_CLIENTE VALUES('28918936554','18936554','29/12/2019','10','1960000','1372000','588000','548800');
INSERT INTO TARJETA_CLIENTE VALUES('28818858542','18858542','16/10/2016','10','850000','595000','255000','238000');
INSERT INTO TARJETA_CLIENTE VALUES('28718333033','18333033','15/11/2019','25','1500000','1050000','450000','420000');
INSERT INTO TARJETA_CLIENTE VALUES('28618274954','18274954','06/04/2020','25','1696000','1187200','508800','474880');
INSERT INTO TARJETA_CLIENTE VALUES('28518274953','18274953','30/07/2013','30','340000','238000','102000','95200');
INSERT INTO TARJETA_CLIENTE VALUES('28418181488','18181488','05/02/2014','5','1150000','805000','970000','805000');
INSERT INTO TARJETA_CLIENTE VALUES('28317613770','17613770','17/09/2015','10','1280000','896000','384000','358400');
INSERT INTO TARJETA_CLIENTE VALUES('28217046056','17046056','15/09/2019','15','1163000','814100','348900','325640');
INSERT INTO TARJETA_CLIENTE VALUES('28117046055','17046055','25/06/2016','25','380000','266000','114000','106400');
INSERT INTO TARJETA_CLIENTE VALUES('28017024035','17024035','01/03/2010','10','935000','654500','280500','261800');
INSERT INTO TARJETA_CLIENTE VALUES('27917024034','17024034','20/01/2016','25','1315000','920500','394500','368200');
INSERT INTO TARJETA_CLIENTE VALUES('27816947141','16947141','12/12/2016','30','1342000','939400','402600','375760');
INSERT INTO TARJETA_CLIENTE VALUES('27716947140','16947140','18/02/2020','25','1600000','1120000','480000','448000');
INSERT INTO TARJETA_CLIENTE VALUES('27616439753','16439753','29/12/2019','15','1900000','1330000','570000','532000');
INSERT INTO TARJETA_CLIENTE VALUES('27516439752','16439752','16/10/2019','25','1175000','822500','352500','329000');
INSERT INTO TARJETA_CLIENTE VALUES('27416044256','16044256','15/11/2016','30','1136000','795200','340800','318080');
INSERT INTO TARJETA_CLIENTE VALUES('27316044255','16044255','06/04/2020','30','1175000','822500','352500','329000');
INSERT INTO TARJETA_CLIENTE VALUES('27216000473','16000473','30/07/2019','30','1573500','1101450','472050','440580');
INSERT INTO TARJETA_CLIENTE VALUES('27116000472','16000472','05/02/2020','30','1179000','825300','353700','330120');
INSERT INTO TARJETA_CLIENTE VALUES('27015583473','15583473','17/09/2019','30','958000','670600','287400','268240');
INSERT INTO TARJETA_CLIENTE VALUES('26915583472','15583472','15/09/2016','30','337500','236250','101250','94500');
INSERT INTO TARJETA_CLIENTE VALUES('26814652456','14652456','25/06/2019','20','988000','691600','296400','276640');
INSERT INTO TARJETA_CLIENTE VALUES('26714439731','14439731','01/03/2019','20','2111000','1477700','633300','591080');
INSERT INTO TARJETA_CLIENTE VALUES('26614439730','14439730','20/01/2019','20','1710001','1197001','513000','478800');
INSERT INTO TARJETA_CLIENTE VALUES('26514423722','14423722','12/12/2016','15','663000','464100','198900','185640');
INSERT INTO TARJETA_CLIENTE VALUES('26414423721','14423721','25/03/2019','15','1800000','1260000','540000','504000');
INSERT INTO TARJETA_CLIENTE VALUES('26314415536','14415536','15/12/2016','15','1186000','830200','355800','332080');
INSERT INTO TARJETA_CLIENTE VALUES('26214415535','14415535','16/02/2019','15','1320000','924000','396000','369600');
INSERT INTO TARJETA_CLIENTE VALUES('26114412583','14412583','18/02/2020','10','1531000','1071700','459300','428680');
INSERT INTO TARJETA_CLIENTE VALUES('26014412582','14412582','29/12/2019','10','1800000','1260000','540000','504000');
INSERT INTO TARJETA_CLIENTE VALUES('25914405525','14405525','16/10/2016','10','870000','609000','261000','243600');
INSERT INTO TARJETA_CLIENTE VALUES('25814405524','14405524','15/11/2019','25','1250000','875000','375000','350000');
INSERT INTO TARJETA_CLIENTE VALUES('25714318610','14318610','06/04/2020','25','1681000','1176700','504300','470680');
INSERT INTO TARJETA_CLIENTE VALUES('25614286265','14286265','30/07/2019','30','1150000','805000','345000','322000');
INSERT INTO TARJETA_CLIENTE VALUES('25514286264','14286264','05/02/2020','5','2100000','1470000','630000','588000');
INSERT INTO TARJETA_CLIENTE VALUES('25413635212','13635212','17/09/2015','10','520000','364000','156000','145600');
INSERT INTO TARJETA_CLIENTE VALUES('25313635211','13635211','15/09/2019','15','1342000','939400','402600','375760');
INSERT INTO TARJETA_CLIENTE VALUES('25213386967','13386967','25/06/2016','25','1000001','700001','300000','280000');
INSERT INTO TARJETA_CLIENTE VALUES('25112362093','12362093','01/03/2020','10','1200000','840000','360000','336000');
INSERT INTO TARJETA_CLIENTE VALUES('25012362092','12362092','20/01/2016','25','1230000','861000','369000','344400');
INSERT INTO TARJETA_CLIENTE VALUES('24912173454','12173454','12/12/2019','30','1665000','1165500','499500','466200');
INSERT INTO TARJETA_CLIENTE VALUES('24812173453','12173453','18/02/2020','25','1540000','1078000','462000','431200');
INSERT INTO TARJETA_CLIENTE VALUES('24712084103','12084103','29/12/2019','20','1621000','1134700','486300','453880');
INSERT INTO TARJETA_CLIENTE VALUES('24612084102','12084102','16/10/2019','20','1547000','1082900','464100','433160');
INSERT INTO TARJETA_CLIENTE VALUES('24511633656','11633656','15/11/2016','20','1120000','784000','336000','313600');
INSERT INTO TARJETA_CLIENTE VALUES('24410964218','10964218','06/04/2020','15','1256000','879200','376800','351680');
INSERT INTO TARJETA_CLIENTE VALUES('24310964217','10964217','30/07/2019','15','952000','666400','285600','266560');
INSERT INTO TARJETA_CLIENTE VALUES('24210534912','10534912','05/02/2020','15','1250000','875000','375000','350000');
INSERT INTO TARJETA_CLIENTE VALUES('24110534911','10534911','17/09/2019','15','1800000','1260000','540000','504000');
INSERT INTO TARJETA_CLIENTE VALUES('24010238016','10238016','15/09/2016','10','588000','411600','176400','164640');
INSERT INTO TARJETA_CLIENTE VALUES('23910105554','10105554','25/06/2019','10','1880000','1316000','564000','526400');
INSERT INTO TARJETA_CLIENTE VALUES('23810105553','10105553','01/03/2019','10','1100000','770000','330000','308000');
INSERT INTO TARJETA_CLIENTE VALUES('2379806691','9806691','20/01/2019','25','1323000','926100','396900','370440');
INSERT INTO TARJETA_CLIENTE VALUES('2369575921','9575921','12/12/2016','25','1294000','905800','388200','362320');
INSERT INTO TARJETA_CLIENTE VALUES('2359575920','9575920','25/03/2019','30','869000','608300','260700','243320');
INSERT INTO TARJETA_CLIENTE VALUES('2349334416','9334416','25/03/2019','5','1837500','1286250','551250','514500');
INSERT INTO TARJETA_CLIENTE VALUES('2339074609','9074609','15/12/2016','10','1360000','952000','408000','380800');
INSERT INTO TARJETA_CLIENTE VALUES('2329074608','9074608','16/02/2019','15','950000','665000','285000','266000');
INSERT INTO TARJETA_CLIENTE VALUES('2319053149','9053149','18/02/2020','25','1488000','1041600','446400','416640');
INSERT INTO TARJETA_CLIENTE VALUES('2309053148','9053148','29/12/2019','15','1660000','1162000','498000','464800');
INSERT INTO TARJETA_CLIENTE VALUES('2299043492','9043492','16/10/2019','25','1539000','1077300','461700','430920');
INSERT INTO TARJETA_CLIENTE VALUES('2289043491','9043491','15/11/2016','30','1200000','840000','360000','336000');
INSERT INTO TARJETA_CLIENTE VALUES('2278948643','8948643','06/04/2020','30','1592000','1114400','477600','445760');
INSERT INTO TARJETA_CLIENTE VALUES('2268948642','8948642','30/07/2019','30','990000','693000','297000','277200');
INSERT INTO TARJETA_CLIENTE VALUES('2258925537','8925537','05/02/2020','30','1400000','980000','420000','392000');
INSERT INTO TARJETA_CLIENTE VALUES('2248333032','8333032','17/09/2019','30','1210000','847000','363000','338800');
INSERT INTO TARJETA_CLIENTE VALUES('2237471611','7471611','15/09/2016','30','400000','280000','120000','112000');
INSERT INTO TARJETA_CLIENTE VALUES('2227471610','7471610','25/06/2019','20','1667000','1166900','500100','466760');
INSERT INTO TARJETA_CLIENTE VALUES('2217467776','7467776','01/03/2019','20','1357000','949900','407100','379960');
INSERT INTO TARJETA_CLIENTE VALUES('2207467775','7467775','20/01/2019','20','1338000','936600','401400','374640');
INSERT INTO TARJETA_CLIENTE VALUES('2197455786','7455786','12/12/2016','15','662000','463400','198600','185360');
INSERT INTO TARJETA_CLIENTE VALUES('2187455785','7455785','25/03/2019','15','1340000','938000','402000','375200');
INSERT INTO TARJETA_CLIENTE VALUES('2177035298','7035298','15/12/2016','15','1192000','834400','357600','333760');
INSERT INTO TARJETA_CLIENTE VALUES('2167035297','7035297','16/02/2019','15','1175000','822500','352500','329000');
INSERT INTO TARJETA_CLIENTE VALUES('2156969890','6969890','18/02/2020','10','1441000','1008700','432300','403480');
INSERT INTO TARJETA_CLIENTE VALUES('2146969889','6969889','29/12/2019','10','1840000','1288000','552000','515200');
INSERT INTO TARJETA_CLIENTE VALUES('2136953740','6953740','16/10/2016','10','946000','662200','283800','264880');
INSERT INTO TARJETA_CLIENTE VALUES('2126918259','6918259','15/11/2019','25','1688000','1181600','506400','472640');
INSERT INTO TARJETA_CLIENTE VALUES('2116918258','6918258','06/04/2020','25','1175000','822500','352500','329000');
INSERT INTO TARJETA_CLIENTE VALUES('2106889506','6889506','30/07/2019','30','1120000','784000','336000','313600');
INSERT INTO TARJETA_CLIENTE VALUES('2096889505','6889505','05/02/2020','5','1552000','1086400','465600','434560');
INSERT INTO TARJETA_CLIENTE VALUES('2086868860','6868860','17/09/2019','10','2058000','1440600','617400','576240');
INSERT INTO TARJETA_CLIENTE VALUES('2076868859','6868859','17/09/2019','10','1264000','884800','379200','353920');
INSERT INTO TARJETA_CLIENTE VALUES('2066604005','6604005','17/09/2015','10','1680000','1176000','504000','470400');
INSERT INTO TARJETA_CLIENTE VALUES('2056604004','6604004','15/09/2019','15','1410000','987000','423000','394800');
INSERT INTO TARJETA_CLIENTE VALUES('2046433226','6433226','25/06/2016','25','630000','441000','189000','176400');
INSERT INTO TARJETA_CLIENTE VALUES('2036433225','6433225','01/03/2020','10','1300000','910000','390000','364000');
INSERT INTO TARJETA_CLIENTE VALUES('2026175302','6175302','20/01/2016','25','1200000','840000','360000','336000');
INSERT INTO TARJETA_CLIENTE VALUES('2015802137','5802137','12/03/2015','30','1145000','801500','343500','320600');
INSERT INTO TARJETA_CLIENTE VALUES('2005331148','5331148','12/12/2019','30','1869000','1308300','560700','523320');


INSERT INTO TIPO_TRANSACCION_TARJETA VALUES(SEQ_TP_TRANSAC_TARJETA.NEXTVAL,'Compras Tiendas Retail o Asociadas',0.03,48,1);
INSERT INTO TIPO_TRANSACCION_TARJETA VALUES(SEQ_TP_TRANSAC_TARJETA.NEXTVAL,'Avance en Efectivo',0.04,24,1);
INSERT INTO TIPO_TRANSACCION_TARJETA VALUES(SEQ_TP_TRANSAC_TARJETA.NEXTVAL,'Super Avance en Efectivo',0.15,36,1);
INSERT INTO TIPO_TRANSACCION_TARJETA VALUES(SEQ_TP_TRANSAC_TARJETA.NEXTVAL,'Compras Tiendas Retail o Asociadas',0.02,48,4);
INSERT INTO TIPO_TRANSACCION_TARJETA VALUES(SEQ_TP_TRANSAC_TARJETA.NEXTVAL,'Avance en Efectivo',0.02,24,4);
INSERT INTO TIPO_TRANSACCION_TARJETA VALUES(SEQ_TP_TRANSAC_TARJETA.NEXTVAL,'Super Avance en Efectivo',0.15,36,4);
INSERT INTO TIPO_TRANSACCION_TARJETA VALUES(SEQ_TP_TRANSAC_TARJETA.NEXTVAL,'Compras Tiendas Retail o Asociadas',0.03,48,2);
INSERT INTO TIPO_TRANSACCION_TARJETA VALUES(SEQ_TP_TRANSAC_TARJETA.NEXTVAL,'Avance en Efectivo',0.03,24,2);
INSERT INTO TIPO_TRANSACCION_TARJETA VALUES(SEQ_TP_TRANSAC_TARJETA.NEXTVAL,'Super Avance en Efectivo',0.18,36,2);


--***********************************
/
select * from tipo_transaccion_tarjeta;
select * from TRANSACCION_TARJETA_CLIENTE;

select * from TARJETA_CLIENTE where nro_tarjeta='31021713767';
*/
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31021713767','1001','17/10/2019','420000','10','441000','101','1311');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31021713767','1002','03/02/2020','420000','10','441000','102','1311');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31021713767','1003','17/02/2020','504000','12','554400','103','1311');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31121713768','1001','14/01/2020','800000','24','840000','101','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31121713768','1002','20/03/2020','40000','6','42000','102','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31121713768','1003','22/03/2020','504000','12','554400','103','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31221815820','1001','04/12/2019','500000','12','525000','101','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31221815820','1002','14/01/2020','277000','10','290850','102','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31221815820','1003','21/01/2020','466200','10','512820','103','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31321815821','1001','19/12/2019','300000','10','315000','101','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31321815821','1002','04/01/2020','300000','10','315000','101','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31321815821','1003','25/01/2020','366000','10','384300','101','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31422176844','1001','25/11/2019','606500','12','636825','101','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31422176844','1002','05/01/2020','300000','10','315000','102','8011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31422176844','1003','12/02/2020','543900','12','598290','103','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31522176845','1002','13/01/2019','95000','6','99750','101','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31522176845','1001','19/12/2019','500000','12','525000','101','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31522176845','1003','17/01/2020','357000','10','392700','103','1211');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31622424125','1001','07/02/2019','400000','10','420000','101','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31622424125','1002','17/02/2020','83000','6','87150','101','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31622424125','1003','27/02/2020','289800','10','318780','103','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31722424126','1001','09/01/2020','217000','10','227850','101','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31722424126','1002','03/02/2020','217000','10','227850','102','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31722424126','1003','26/02/2020','260400','10','286440','103','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31822503814','1001','29/04/2019','120000','6','126000','101','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31822503814','1002','19/01/2020','1000000','24','1050000','102','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31822503814','1003','25/01/2020','672000','12','739200','103','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31922503815','1001','04/01/2020','350000','10','367500','101','4012');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31922503815','1002','14/01/2020','350000','10','367500','102','4012');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('31922503815','1003','24/01/2020','420000','10','462000','103','4012');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32022558061','1001','10/12/2015','1000000','24','1050000','101','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32022558061','1002','14/02/2020','197000','6','206850','102','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32022558061','1003','26/02/2020','718200','12','790020','103','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32122558062','1001','06/01/2020','800000','24','840000','101','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32122558062','1002','16/01/2020','75000','6','78750','101','4011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32122558062','1003','26/01/2020','525000','12','577500','103','4012');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32222725177','1001','12/01/2020','900000','24','945000','101','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32222725177','1002','18/01/2020','62500','6','65625','102','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32222725177','1003','12/02/2020','577500','12','635250','103','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32322725178','1001','09/01/2020','800000','24','840000','101','3031');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32322725178','1002','21/01/2020','75000','6','78750','102','3031');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32322725178','1003','29/01/2020','525000','12','577500','103','3031');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32423131860','1001','17/12/2019','1000000','24','1050000','101','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32423131860','1002','01/02/2020','99000','6','103950','102','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32423131860','1003','12/02/2020','659400','12','725340','103','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32523309886','1001','12/12/2019','1000000','24','1050000','101','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32523309886','1002','21/01/2020','225000','10','236250','102','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32523309886','1003','02/02/2020','735000','12','808500','103','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32623309887','1001','11/01/2020','500000','12','525000','101','3031');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32623309887','1002','18/01/2020','88000','6','92400','102','3031');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32623309887','1003','23/01/2020','352800','10','388080','103','3031');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32723552593','1001','23/11/2019','800000','24','840000','101','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32723552593','1002','23/02/2020','96000','6','100800','101','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32723552593','1003','27/02/2020','537600','12','591360','103','3011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32824617340','1001','12/01/2020','420000','10','441000','101','8011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32824617340','1002','13/01/2020','420000','10','441000','102','8011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32824617340','1003','02/02/2020','504000','12','554400','103','8011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32924617341','1001','19/12/2019','500000','12','525000','101','10011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32924617341','1002','24/12/2019','500000','12','525000','101','10011');
INSERT INTO TRANSACCION_TARJETA_CLIENTE VALUES('32924617341','1003','12/02/2020','62000','6','65100','101','10011');


/*********************************************************************************************************/

INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1001','1','25/11/2019','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1001','2','25/12/2019','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1001','3','25/01/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1001','4','25/02/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1001','5','25/03/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1001','6','25/04/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1001','7','25/05/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1001','8','25/06/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1001','9','25/07/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1001','10','25/08/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1002','1','25/03/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1002','2','25/04/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1002','3','25/05/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1002','4','25/06/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1002','5','25/07/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1002','6','25/08/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1002','7','25/09/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1002','8','25/10/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1002','9','25/11/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1002','10','25/12/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','1','25/03/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','2','25/04/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','3','25/05/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','4','25/06/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','5','25/07/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','6','25/08/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','7','25/09/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','8','25/10/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','9','25/11/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','10','25/12/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','11','25/01/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31021713767','1003','12','25/02/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','1','10/02/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','2','10/03/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','3','10/04/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','4','10/05/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','5','10/06/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','6','10/07/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','7','10/08/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','8','10/09/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','9','10/10/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','10','10/11/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','11','10/12/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','12','10/01/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','13','10/02/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','14','10/03/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','15','10/04/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','16','10/05/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','17','10/06/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','18','10/07/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','19','10/08/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','20','10/09/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','21','10/10/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','22','10/11/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','23','10/12/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1001','24','10/01/2021','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1002','1','10/04/2020','7000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1002','2','10/05/2020','7000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1002','3','10/06/2020','7000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1002','4','10/07/2020','7000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1002','5','10/08/2020','7000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1002','6','10/09/2020','7000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','1','10/04/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','2','10/05/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','3','10/06/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','4','10/07/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','5','10/08/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','6','10/09/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','7','10/10/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','8','10/11/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','9','10/12/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','10','10/01/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','11','10/02/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31121713768','1003','12','10/03/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','1','25/01/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','2','25/02/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','3','25/03/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','4','25/04/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','5','25/05/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','6','25/06/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','7','25/07/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','8','25/08/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','9','25/09/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','10','25/10/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','11','25/11/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1001','12','25/12/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1002','1','25/02/2020','29085');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1002','2','25/03/2020','29085');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1002','3','25/04/2020','29085');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1002','4','25/05/2020','29085');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1002','5','25/06/2020','29085');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1002','6','25/07/2020','29085');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1002','7','25/08/2020','29085');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1002','8','25/09/2020','29085');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1002','9','25/10/2020','29085');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1002','10','25/11/2020','29085');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1003','1','25/02/2020','51282');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1003','2','25/03/2020','51282');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1003','3','25/04/2020','51282');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1003','4','25/05/2020','51282');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1003','5','25/06/2020','51282');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1003','6','25/07/2020','51282');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1003','7','25/08/2020','51282');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1003','8','25/09/2020','51282');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1003','9','25/10/2020','51282');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31221815820','1003','10','25/11/2020','51282');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1001','1','15/01/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1001','2','15/02/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1001','3','15/03/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1001','4','15/04/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1001','5','15/05/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1001','6','15/06/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1001','7','15/07/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1001','8','15/08/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1001','9','15/09/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1001','10','15/10/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1002','1','15/02/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1002','2','15/03/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1002','3','15/04/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1002','4','15/05/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1002','5','15/06/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1002','6','15/07/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1002','7','15/08/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1002','8','15/09/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1002','9','15/10/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1002','10','15/11/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1003','1','15/02/2020','38430');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1003','2','15/03/2020','38430');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1003','3','15/04/2020','38430');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1003','4','15/05/2020','38430');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1003','5','15/06/2020','38430');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1003','6','15/07/2020','38430');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1003','7','15/08/2020','38430');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1003','8','15/09/2020','38430');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1003','9','15/10/2020','38430');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31321815821','1003','10','15/11/2020','38430');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','1','10/12/2019','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','2','10/01/2020','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','3','10/02/2020','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','4','10/03/2020','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','5','10/04/2020','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','6','10/05/2020','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','7','10/06/2020','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','8','10/07/2020','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','9','10/08/2020','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','10','10/09/2020','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','11','10/10/2020','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1001','12','10/11/2020','53069');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1002','1','10/02/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1002','2','10/03/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1002','3','10/04/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1002','4','10/05/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1002','5','10/06/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1002','6','10/07/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1002','7','10/08/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1002','8','10/09/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1002','9','10/10/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1002','10','10/11/2020','31500');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','1','10/03/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','2','10/04/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','3','10/05/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','4','10/06/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','5','10/07/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','6','10/08/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','7','10/09/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','8','10/10/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','9','10/11/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','10','10/12/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','11','10/01/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31422176844','1003','12','10/02/2020','49858');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','1','05/01/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','2','05/02/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','3','05/03/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','4','05/04/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','5','05/05/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','6','05/06/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','7','05/07/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','8','05/08/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','9','05/09/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','10','05/10/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','11','05/11/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1001','12','05/12/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1002','1','05/02/2019','16625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1002','2','05/03/2019','16625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1002','3','05/04/2019','16625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1002','4','05/05/2019','16625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1002','5','05/06/2019','16625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1002','6','05/07/2019','16625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1003','1','05/02/2020','39270');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1003','2','05/03/2020','39270');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1003','3','05/04/2020','39270');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1003','4','05/05/2020','39270');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1003','5','05/06/2020','39270');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1003','6','05/07/2020','39270');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1003','7','05/08/2020','39270');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1003','8','05/09/2020','39270');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1003','9','05/10/2020','39270');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31522176845','1003','10','05/11/2020','39270');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1001','1','30/03/2019','42000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1001','2','28/04/2019','42000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1001','3','28/05/2019','42000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1001','4','28/06/2019','42000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1001','5','28/07/2019','42000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1001','6','28/08/2019','42000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1001','7','28/09/2019','42000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1001','8','28/10/2019','42000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1001','9','28/11/2019','42000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1001','10','28/12/2019','42000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1002','1','28/03/2020','14525');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1002','2','28/04/2020','14525');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1002','3','28/05/2020','14525');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1002','4','28/06/2020','14525');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1002','5','28/07/2020','14525');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1002','6','28/08/2020','14525');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1003','1','28/03/2020','31878');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1003','2','28/04/2020','31878');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1003','3','28/05/2020','31878');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1003','4','28/06/2020','31878');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1003','5','28/07/2020','31878');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1003','6','28/08/2020','31878');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1003','7','28/09/2020','31878');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1003','8','28/10/2020','31878');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1003','9','28/11/2020','31878');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31622424125','1003','10','28/12/2020','31878');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1001','1','25/02/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1001','2','25/03/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1001','3','25/04/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1001','4','25/05/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1001','5','25/06/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1001','6','25/07/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1001','7','25/08/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1001','8','25/09/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1001','9','25/10/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1001','10','25/11/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1002','1','25/03/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1002','2','25/04/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1002','3','25/05/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1002','4','25/06/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1002','5','25/07/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1002','6','25/08/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1002','7','25/09/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1002','8','25/10/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1002','9','25/11/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1002','10','25/12/2020','22785');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1003','1','25/03/2020','28644');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1003','2','25/04/2020','28644');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1003','3','25/05/2020','28644');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1003','4','25/06/2020','28644');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1003','5','25/07/2020','28644');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1003','6','25/08/2020','28644');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1003','7','25/09/2020','28644');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1003','8','25/10/2020','28644');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1003','9','25/11/2020','28644');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31722424126','1003','10','25/12/2020','28644');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1001','1','25/05/2019','21000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1001','2','25/06/2019','21000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1001','3','25/07/2019','21000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1001','4','25/08/2019','21000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1001','5','25/09/2019','21000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1001','6','25/10/2019','21000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','1','25/02/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','2','25/03/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','3','25/04/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','4','25/05/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','5','25/06/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','6','25/07/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','7','25/08/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','8','25/09/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','9','25/10/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','10','25/11/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','11','25/12/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','12','25/01/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','13','25/02/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','14','25/03/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','15','25/04/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','16','25/05/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','17','25/06/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','18','25/07/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','19','25/08/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','20','25/09/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','21','25/10/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','22','25/11/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','23','25/12/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1002','24','25/01/2021','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','1','25/02/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','2','25/03/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','3','25/04/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','4','25/05/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','5','25/06/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','6','25/07/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','7','25/08/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','8','25/09/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','9','25/10/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','10','25/11/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','11','25/12/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31822503814','1003','12','25/01/2020','61600');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1001','1','10/02/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1001','2','10/03/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1001','3','10/04/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1001','4','10/05/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1001','5','10/06/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1001','6','10/07/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1001','7','10/08/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1001','8','10/09/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1001','9','10/10/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1001','10','10/11/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1002','1','10/02/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1002','2','10/03/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1002','3','10/04/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1002','4','10/05/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1002','5','10/06/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1002','6','10/07/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1002','7','10/08/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1002','8','10/09/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1002','9','10/10/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1002','10','10/11/2020','36750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1003','1','10/02/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1003','2','10/03/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1003','3','10/04/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1003','4','10/05/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1003','5','10/06/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1003','6','10/07/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1003','7','10/08/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1003','8','10/09/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1003','9','10/10/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('31922503815','1003','10','10/11/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','1','10/01/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','2','10/02/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','3','10/03/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','4','10/04/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','5','10/05/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','6','10/06/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','7','10/07/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','8','10/08/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','9','10/09/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','10','10/10/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','11','10/11/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','12','10/12/2016','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','13','10/01/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','14','10/02/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','15','10/03/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','16','10/04/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','17','10/05/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','18','10/06/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','19','10/07/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','20','10/08/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','21','10/09/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','22','10/10/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','23','10/11/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1001','24','10/12/2019','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1002','1','10/03/2020','34475');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1002','2','10/04/2020','34475');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1002','3','10/05/2020','34475');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1002','4','10/06/2020','34475');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1002','5','10/07/2020','34475');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1002','6','10/08/2020','34475');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','1','10/03/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','2','10/04/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','3','10/05/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','4','10/06/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','5','10/07/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','6','10/08/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','7','10/09/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','8','10/10/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','9','10/11/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','10','10/12/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','11','10/01/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32022558061','1003','12','10/02/2020','65835');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','1','10/02/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','2','10/03/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','3','10/04/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','4','10/05/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','5','10/06/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','6','10/07/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','7','10/08/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','8','10/09/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','9','10/10/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','10','10/11/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','11','10/12/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','12','10/01/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','13','10/02/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','14','10/03/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','15','10/04/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','16','10/05/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','17','10/06/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','18','10/07/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','19','10/08/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','20','10/09/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','21','10/10/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','22','10/11/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','23','10/12/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1001','24','10/01/2021','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1002','1','10/02/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1002','2','10/03/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1002','3','10/04/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1002','4','10/05/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1002','5','10/06/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1002','6','10/07/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','1','10/02/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','2','10/03/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','3','10/04/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','4','10/05/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','5','10/06/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','6','10/07/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','7','10/08/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','8','10/09/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','9','10/10/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','10','10/11/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','11','10/12/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32122558062','1003','12','10/01/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','1','15/02/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','2','15/03/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','3','15/04/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','4','15/05/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','5','15/06/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','6','15/07/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','7','15/08/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','8','15/09/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','9','15/10/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','10','15/11/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','11','15/12/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','12','15/01/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','13','15/02/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','14','15/03/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','15','15/04/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','16','15/05/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','17','15/06/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','18','15/07/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','19','15/08/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','20','15/09/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','21','15/10/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','22','15/11/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','23','15/12/2020','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1001','24','15/01/2021','39375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1002','1','15/02/2020','10938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1002','2','15/03/2020','10938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1002','3','15/04/2020','10938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1002','4','15/05/2020','10938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1002','5','15/06/2020','10938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1002','6','15/07/2020','10938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','1','15/03/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','2','15/04/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','3','15/05/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','4','15/06/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','5','15/07/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','6','15/08/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','7','15/09/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','8','15/10/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','9','15/11/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','10','15/12/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','11','15/01/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32222725177','1003','12','15/02/2020','52938');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','1','15/02/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','2','15/03/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','3','15/04/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','4','15/05/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','5','15/06/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','6','15/07/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','7','15/08/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','8','15/09/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','9','15/10/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','10','15/11/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','11','15/12/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','12','15/01/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','13','15/02/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','14','15/03/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','15','15/04/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','16','15/05/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','17','15/06/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','18','15/07/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','19','15/08/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','20','15/09/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','21','15/10/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','22','15/11/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','23','15/12/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1001','24','15/01/2021','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1002','1','15/02/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1002','2','15/03/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1002','3','15/04/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1002','4','15/05/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1002','5','15/06/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1002','6','15/07/2020','13125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','1','15/02/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','2','15/03/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','3','15/04/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','4','15/05/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','5','15/06/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','6','15/07/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','7','15/08/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','8','15/09/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','9','15/10/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','10','15/11/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','11','15/12/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32322725178','1003','12','15/01/2020','48125');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','1','15/01/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','2','15/02/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','3','15/03/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','4','15/04/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','5','15/05/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','6','15/06/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','7','15/07/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','8','15/08/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','9','15/09/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','10','15/10/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','11','15/11/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','12','15/12/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','13','15/01/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','14','15/02/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','15','15/03/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','16','15/04/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','17','15/05/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','18','15/06/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','19','15/07/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','20','15/08/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','21','15/09/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','22','15/10/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','23','15/11/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1001','24','15/12/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1002','1','15/03/2020','17325');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1002','2','15/04/2020','17325');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1002','3','15/05/2020','17325');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1002','4','15/06/2020','17325');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1002','5','15/07/2020','17325');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1002','6','15/08/2020','17325');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','1','15/03/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','2','15/04/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','3','15/05/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','4','15/06/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','5','15/07/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','6','15/08/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','7','15/09/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','8','15/10/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','9','15/11/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','10','15/12/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','11','15/01/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32423131860','1003','12','15/02/2020','60445');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','1','15/01/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','2','15/02/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','3','15/03/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','4','15/04/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','5','15/05/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','6','15/06/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','7','15/07/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','8','15/08/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','9','15/09/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','10','15/10/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','11','15/11/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','12','15/12/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','13','15/01/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','14','15/02/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','15','15/03/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','16','15/04/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','17','15/05/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','18','15/06/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','19','15/07/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','20','15/08/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','21','15/09/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','22','15/10/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','23','15/11/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1001','24','15/12/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1002','1','15/02/2020','23625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1002','2','15/03/2020','23625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1002','3','15/04/2020','23625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1002','4','15/05/2020','23625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1002','5','15/06/2020','23625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1002','6','15/07/2020','23625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1002','7','15/08/2020','23625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1002','8','15/09/2020','23625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1002','9','15/10/2020','23625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1002','10','15/11/2020','23625');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','1','15/03/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','2','15/04/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','3','15/05/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','4','15/06/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','5','15/07/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','6','15/08/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','7','15/09/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','8','15/10/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','9','15/11/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','10','15/12/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','11','15/01/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32523309886','1003','12','15/02/2020','67375');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','1','20/02/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','2','20/03/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','3','20/04/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','4','20/05/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','5','20/06/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','6','20/07/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','7','20/08/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','8','20/09/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','9','20/10/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','10','20/11/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','11','20/12/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1001','12','20/01/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1002','1','20/02/2020','15400');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1002','2','20/03/2020','15400');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1002','3','20/04/2020','15400');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1002','4','20/05/2020','15400');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1002','5','20/06/2020','15400');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1002','6','20/07/2020','15400');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1003','1','20/02/2020','38808');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1003','2','20/03/2020','38808');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1003','3','20/04/2020','38808');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1003','4','20/05/2020','38808');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1003','5','20/06/2020','38808');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1003','6','20/07/2020','38808');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1003','7','20/08/2020','38808');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1003','8','20/09/2020','38808');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1003','9','20/10/2020','38808');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32623309887','1003','10','20/11/2020','38808');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','1','20/12/2019','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','2','20/01/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','3','20/02/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','4','20/03/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','5','20/04/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','6','20/05/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','7','20/06/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','8','20/07/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','9','20/08/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','10','20/09/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','11','20/10/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','12','20/11/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','13','20/12/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','14','20/01/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','15','20/02/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','16','20/03/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','17','20/04/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','18','20/05/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','19','20/06/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','20','20/07/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','21','20/08/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','22','20/09/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','23','20/10/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1001','24','20/11/2020','35000');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1002','1','20/03/2020','16800');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1002','2','20/04/2020','16800');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1002','3','20/05/2020','16800');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1002','4','20/06/2020','16800');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1002','5','20/07/2020','16800');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1002','6','20/08/2020','16800');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','1','20/03/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','2','20/04/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','3','20/05/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','4','20/06/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','5','20/07/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','6','20/08/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','7','20/09/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','8','20/10/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','9','20/11/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','10','20/12/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','11','20/01/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32723552593','1003','12','20/02/2020','49280');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1001','1','20/02/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1001','2','20/03/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1001','3','20/04/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1001','4','20/05/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1001','5','20/06/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1001','6','20/07/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1001','7','20/08/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1001','8','20/09/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1001','9','20/10/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1001','10','20/11/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1002','1','20/02/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1002','2','20/03/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1002','3','20/04/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1002','4','20/05/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1002','5','20/06/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1002','6','20/07/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1002','7','20/08/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1002','8','20/09/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1002','9','20/10/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1002','10','20/11/2020','44100');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','1','20/03/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','2','20/04/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','3','20/05/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','4','20/06/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','5','20/07/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','6','20/08/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','7','20/09/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','8','20/10/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','9','20/11/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','10','20/12/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','11','20/01/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32824617340','1003','12','20/02/2020','46200');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','1','20/01/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','2','20/02/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','3','20/03/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','4','20/04/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','5','20/05/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','6','20/06/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','7','20/07/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','8','20/08/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','9','20/09/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','10','20/10/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','11','20/11/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1001','12','20/12/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','1','20/01/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','2','20/02/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','3','20/03/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','4','20/04/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','5','20/05/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','6','20/06/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','7','20/07/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','8','20/08/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','9','20/09/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','10','20/10/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','11','20/11/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1002','12','20/12/2020','43750');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1003','1','20/03/2020','10850');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1003','2','20/04/2020','10850');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1003','3','20/05/2020','10850');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1003','4','20/06/2020','10850');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1003','5','20/07/2020','10850');
INSERT INTO CUOTA_TRANSAC_TARJETA_CLIENTE VALUES('32924617341','1003','6','20/08/2020','10850');

--select * from pago_tarjetas;

INSERT INTO PAGO_TARJETAS VALUES('31422176844','201801','10/01/2020','05/01/2020','53069','53069','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31522176845','201801','05/01/2020','05/01/2020','43750','43750','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32423131860','201801','15/01/2020','14/01/2020','43750','43750','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31321815821','201801','15/01/2020','15/01/2020','31500','31500','0','2');
INSERT INTO PAGO_TARJETAS VALUES('32523309886','201801','15/01/2020','15/01/2020','43750','43750','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32723552593','201801','20/01/2020','17/01/2020','35000','35000','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32924617341','201801','20/01/2020','20/01/2020','87500','87500','0','3');
INSERT INTO PAGO_TARJETAS VALUES('31221815820','201801','25/01/2020','23/01/2020','43750','43750','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31021713767','201801','25/01/2020','25/01/2020','44100','44100','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31522176845','201802','05/02/2020','05/02/2020','83020','83020','0','2');
INSERT INTO PAGO_TARJETAS VALUES('31121713768','201802','10/02/2020','10/02/2020','35000','35000','0','2');
INSERT INTO PAGO_TARJETAS VALUES('31422176844','201802','10/02/2020','10/02/2020','84569','84569','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32423131860','201802','15/02/2020','10/02/2020','43750','43750','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31321815821','201802','15/02/2020','10/02/2020','101430','101430','0','2');
INSERT INTO PAGO_TARJETAS VALUES('32122558062','201802','10/02/2020','10/02/2020','96250','96250','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31922503815','201802','10/02/2020','10/02/2020','119700','119700','0','2');
INSERT INTO PAGO_TARJETAS VALUES('32322725178','201802','15/02/2020','15/02/2020','96250','96250','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32222725177','201802','15/02/2020','15/02/2020','50313','50313','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32523309886','201802','15/02/2020','15/02/2020','67375','67375','0','3');
INSERT INTO PAGO_TARJETAS VALUES('32924617341','201802','20/02/2020','18/02/2020','87500','87500','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32824617340','201802','20/02/2020','20/02/2020','88200','88200','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32723552593','201802','20/02/2020','20/02/2020','35000','35000','0','2');
INSERT INTO PAGO_TARJETAS VALUES('32623309887','201802','20/02/2020','20/02/2020','97958','97958','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31021713767','201802','25/02/2020','22/02/2020','44100','44100','0','2');
INSERT INTO PAGO_TARJETAS VALUES('31722424126','201802','25/02/2020','23/02/2020','22785','22785','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31822503814','201802','25/02/2020','25/02/2020','105350','105350','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31221815820','201802','25/02/2020','25/02/2020','124117','124117','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31522176845','201803','05/03/2020','03/03/2020','83020','83020','0','3');
INSERT INTO PAGO_TARJETAS VALUES('32122558062','201803','10/03/2020','09/03/2020','96250','96250','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31422176844','201803','10/03/2020','10/03/2020','134427','134427','0','2');
INSERT INTO PAGO_TARJETAS VALUES('32022558061','201803','10/03/2020','13/03/2020','100310','0','100310','1');
INSERT INTO PAGO_TARJETAS VALUES('31121713768','201803','10/03/2020','15/03/2020','35000','35000','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32322725178','201803','15/03/2020','15/03/2020','96250','96250','0','2');
INSERT INTO PAGO_TARJETAS VALUES('32824617340','201803','20/03/2020','15/03/2020','134400','134400','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32523309886','201803','15/03/2020','15/03/2020','134750','134750','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32924617341','201803','20/03/2020','18/03/2020','98350','98350','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31321815821','201803','15/03/2020','19/03/2020','101430','80000','21430','1');
INSERT INTO PAGO_TARJETAS VALUES('31922503815','201803','10/03/2020','20/03/2020','119700','54000','65700','1');
INSERT INTO PAGO_TARJETAS VALUES('32623309887','201803','20/03/2020','23/03/2020','97958','30000','67958','1');
INSERT INTO PAGO_TARJETAS VALUES('31021713767','201803','25/03/2020','24/03/2020','134400','134400','0','2');
INSERT INTO PAGO_TARJETAS VALUES('31822503814','201803','25/03/2020','25/03/2020','105350','105350','0','1');
INSERT INTO PAGO_TARJETAS VALUES('31221815820','201803','25/03/2020','25/03/2020','124117','124117','0','2');
INSERT INTO PAGO_TARJETAS VALUES('32222725177','201803','15/03/2020','26/03/2020','103251','0','103251','1');
INSERT INTO PAGO_TARJETAS VALUES('32423131860','201803','15/03/2020','28/03/2020','121520','58000','63520','1');
INSERT INTO PAGO_TARJETAS VALUES('31622424125','201803','28/03/2020','28/03/2020','46403','46403','0','1');
INSERT INTO PAGO_TARJETAS VALUES('32723552593','201803','20/03/2020','29/03/2020','101080','70000','31080','1');
INSERT INTO PAGO_TARJETAS VALUES('31722424126','201803','25/03/2020','30/03/2020','74214','74214','0','2');

INSERT INTO PESOS_PREMIER VALUES(31622424125,45000,'21/01/2020');
INSERT INTO PESOS_PREMIER VALUES(32423131860,12000,'25/01/2020');
INSERT INTO PESOS_PREMIER VALUES(32623309887,64000,'02/02/2020');
INSERT INTO PESOS_PREMIER VALUES(31321815821,28000,'29/01/2020');
INSERT INTO PESOS_PREMIER VALUES(32122558062,107000,'02/02/2020');

--select * from pesos_premier;
COMMIT;


---------------------------------- Requerimientos EFT Consulta base de datos ---------------------------------- 

--**********************************************--
-- INFORME 1  "Resumen de clientes por región"  --
--**********************************************--

-- Crear la vista para el resumen de clientes por región

CREATE OR REPLACE VIEW resumen_clientes_region AS

--EXPLAIN PLAN FOR -- Para pedir el informe del plan 
SELECT
    R.NOMBRE_REGION, -- Selecciona el nombre de la región desde la tabla REGION
    COUNT(CASE WHEN SYSDATE - C.FECHA_INSCRIPCION >= 7300 THEN 1 END) AS CLIENTES_20_AÑOS,    -- Cuenta la cantidad de clientes que llevan 20 o más años inscritos en la tienda
    COUNT(*) AS TOTAL_GENERAL_CLIENTES   -- Cuenta el total general de clientes por región
FROM
    CLIENTE C -- Tabla CLIENTE con alias 'C' para abreviar
    INNER JOIN REGION R ON C.COD_REGION = R.COD_REGION    -- INNER JOIN con la tabla REGION para obtener el nombre de la región correspondiente al código de región

HAVING 
    COUNT(CASE WHEN ADD_MONTHS(SYSDATE, -240) >= c.fecha_inscripcion THEN 1 END) > 0

GROUP BY
    R.NOMBRE_REGION -- Agrupa los resultados por el nombre de la región para poder aplicar las funciones de agregación
ORDER BY
    CLIENTES_20_AÑOS ASC;-- Ordena los resultados por la cantidad de clientes con 20 o más años inscritos, de forma ascendente


--SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);-- Para ver el informe del plan

SELECT * FROM resumen_clientes_region;

--DROP VIEW resumen_clientes_region;


-- Creación de indices--


CREATE INDEX IDX_REGION ON cliente(cod_region); -- Para mejorar el acceso por region 

CREATE INDEX IDX_CLI_REGION ON cliente(cod_region, numrun);-- Para mejorar el acceso entre cliente y región


--*********************************************************************--
-- INFORME 2  "Transacciones con vencimientos en el segundo semestre"  --
--*********************************************************************--


------------------------------------------
-- Alternativa 1: " Usando operador SET"--
------------------------------------------

-- Primera parte de la consulta: Transacciones con código 101 y 102
SELECT 
    TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS FECHA, --  Para la fecha de emisión del informe
    T.COD_TPTRAN_TARJETA AS CODIGO,          -- Código del tipo de transacción
    UPPER(TT.NOMBRE_TPTRAN_TARJETA) AS DESCRIPCION, -- Descripción de la transacción en mayúsculas
    TRUNC(AVG(T.MONTO_TOTAL_TRANSACCION), 0) AS MONTO_PROMEDIO_TRANSACCION -- Promedio del monto total truncado a 0 decimales
FROM 
    TRANSACCION_TARJETA_CLIENTE T
INNER JOIN 
    TIPO_TRANSACCION_TARJETA TT 
    ON T.COD_TPTRAN_TARJETA = TT.COD_TPTRAN_TARJETA -- Union con la tabla de tipos de transacción por el código
INNER JOIN
    CUOTA_TRANSAC_TARJETA_CLIENTE CTT 
    ON T.NRO_TARJETA = CTT.NRO_TARJETA AND T.NRO_TRANSACCION = CTT.NRO_TRANSACCION -- Union con la tabla de cuotas por número de tarjeta y transacción
WHERE 
    EXTRACT(MONTH FROM CTT.FECHA_VENC_CUOTA) BETWEEN 6 AND 12 -- Filtrar cuotas con vencimientos entre junio y diciembre
    AND TT.COD_TPTRAN_TARJETA IN (101, 102) -- Filtrar por códigos de transacción 101 y 102
GROUP BY 
    T.COD_TPTRAN_TARJETA, TT.NOMBRE_TPTRAN_TARJETA -- Agrupar por código y nombre del tipo de transacción

-- Combinación de los resultados de ambas consultas usando UNION para evitar duplicados
UNION

-- Segunda parte de la consulta: Transacciones con código 103
SELECT 
    TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS FECHA, -- fecha de emisión del informe
    T.COD_TPTRAN_TARJETA AS CODIGO,          -- Código del tipo de transacción
    UPPER(TT.NOMBRE_TPTRAN_TARJETA) AS DESCRIPCION, -- Descripción de la transacción en mayúsculas
    TRUNC(AVG(T.MONTO_TOTAL_TRANSACCION), 0) AS MONTO_PROMEDIO_TRANSACCION -- Promedio del monto total truncado a 0 decimales
FROM 
    TRANSACCION_TARJETA_CLIENTE T
INNER JOIN 
    TIPO_TRANSACCION_TARJETA TT 
    ON T.COD_TPTRAN_TARJETA = TT.COD_TPTRAN_TARJETA -- Unión con la tabla de tipos de transacción por el código
INNER JOIN
    CUOTA_TRANSAC_TARJETA_CLIENTE CTT 
    ON T.NRO_TARJETA = CTT.NRO_TARJETA AND T.NRO_TRANSACCION = CTT.NRO_TRANSACCION -- Unión con la tabla de cuotas por número de tarjeta y transacción
WHERE 
    EXTRACT(MONTH FROM CTT.FECHA_VENC_CUOTA) BETWEEN 6 AND 12 -- Filtrar cuotas con vencimientos entre junio y diciembre
    AND TT.COD_TPTRAN_TARJETA = 103 -- Filtrar por código de transacción 103
GROUP BY 
    T.COD_TPTRAN_TARJETA, TT.NOMBRE_TPTRAN_TARJETA -- Agrupar por código y nombre del tipo de transacción

-- Ordenar el resultado final por el promedio de montos de transacciones de forma ascendente
ORDER BY 
    MONTO_PROMEDIO_TRANSACCION ASC;


---------------------------------------
-- ALternativa 2 "Usando Subconsulta"--
---------------------------------------

--DELETE FROM SELECCION_TIPO_TRANSACCION;
--COMMIT;


INSERT INTO SELECCION_TIPO_TRANSACCION (FECHA, COD_TIPO_TRANSAC, NOMBRE_TIPO_TRANSAC, MONTO_PROMEDIO)
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS FECHA,-- Fecha de emisión del informe
       TT.COD_TPTRAN_TARJETA AS COD_TIPO_TRANSAC,-- código del tipo de transacción
       TT.NOMBRE_TPTRAN_TARJETA AS NOMBRE_TIPO_TRANSAC,-- Descripción del tipo de transacción
       TRUNC(AVG(T.MONTO_TOTAL_TRANSACCION),0) AS MONTO_PROMEDIO-- Promedio del monto toal de las transacciones truncada a 0 decimales
  FROM TRANSACCION_TARJETA_CLIENTE T
  INNER JOIN CUOTA_TRANSAC_TARJETA_CLIENTE C
     ON T.NRO_TARJETA = C.NRO_TARJETA
    AND T.NRO_TRANSACCION = C.NRO_TRANSACCION--  Unión a la transacción con sus cuotas
  INNER JOIN TIPO_TRANSACCION_TARJETA TT
     ON T.COD_TPTRAN_TARJETA = TT.COD_TPTRAN_TARJETA -- Se obtiene el tipo de transacción
 WHERE TO_CHAR(C.FECHA_VENC_CUOTA,'MMDD') BETWEEN '0601' AND '1231' 
 -- Se filtran las cuotas con vencimiento entre el 1 de junio y el 31 de diciembre (sin restringir el año)
 GROUP BY TT.COD_TPTRAN_TARJETA, TT.NOMBRE_TPTRAN_TARJETA; 
 -- Se agrupa por tipo de transacción para obtener un promedio por cada tipo

COMMIT; -- Para confirmar la inserción en SELECCION_TIPO_TRANSACCION.

-- Mostramos la información insertada, ordenada por MONTO_PROMEDIO
SELECT FECHA, COD_TIPO_TRANSAC, NOMBRE_TIPO_TRANSAC, MONTO_PROMEDIO
  FROM SELECCION_TIPO_TRANSACCION
 ORDER BY MONTO_PROMEDIO;-- Orden ascendente

-- Actualizamos la tasa de interés en TIPO_TRANSACCION_TARJETA, reduciendo 1%
UPDATE TIPO_TRANSACCION_TARJETA TT
   SET TT.TASAINT_TPTRAN_TARJETA = TT.TASAINT_TPTRAN_TARJETA - 0.01
 WHERE TT.COD_TPTRAN_TARJETA IN (
   SELECT S.COD_TIPO_TRANSAC
     FROM SELECCION_TIPO_TRANSACCION S
);

COMMIT; -- Confirmamos la actualización de la tasa de interés.

-- Verificamos las tasas de interés actualizadas luego de la rebaja del 1%
SELECT COD_TPTRAN_TARJETA, NOMBRE_TPTRAN_TARJETA, TASAINT_TPTRAN_TARJETA
  FROM TIPO_TRANSACCION_TARJETA;

/**                                                                                                                                                                                                                                   
***************************************************************************************************************************************************************************************************************************************
*                                                             RESPUESTAS A LAS PREGUNTAS SOBRE EL DESARROLLO DEL INFORME 2                                                                                                            *
***************************************************************************************************************************************************************************************************************************************
*                                                                                                                                                                                                                                     *   
*                                                                                                                                                                                                                                     * 
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
*  1. ¿Cuál es el problema que se debe resolver?                                                                                                                                                                                      *
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
*  El problema consiste en obtener y presentar información sobre las transacciones que tengan cuotas con vencimientos entre junio y diciembre (segundo semestre), calcular el promedio de los montos de estas transacciones y,        *
*  a partir de dicha información, actualizar la tasa de interés del tipo de transacción en la tabla correspondiente. En otras palabras, se necesita identificar las transacciones del periodo indicado,                               *
*  obtener un resumen estadístico (promedio) y luego aplicar un ajuste en la tasa de interés a los tipos de transacción afectados, usando la información generada.                                                                    *
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
*  2. ¿Cuál es la información significativa que necesita para resolver el problema?                                                                                                                                                   *
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
*  - Las fechas de vencimiento de las cuotas (para filtrar las transacciones entre junio y diciembre).                                                                                                                                *
*  - El tipo de transacción (código y nombre) que identifica cada operación.                                                                                                                                                          *
*  - El monto total de las transacciones, para calcular el promedio.                                                                                                                                                                  *
*  - La tasa de interés asociada al tipo de transacción, que deberá ser modificada en base a los resultados obtenidos.                                                                                                                *
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
*  3. ¿Cuál es el propósito de la solución que se requiere?                                                                                                                                                                           *
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
*  Mostrar un informe con el promedio de los montos de las transacciones correspondientes a cuotas con vencimiento en el segundo semestre del año, ordenadas por el promedio.                                                         *
*  Con esa información, identificar qué tipos de transacción participaron en ese rango y actualizar su tasa de interés, aplicando una rebaja del 1%.                                                                                  *
*  Por lo tanto, la solución busca generar un resumen estadístico de las transacciones y luego ajustar las condiciones comerciales (tasas de interés) en función de los datos obtenidos.                                              *
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
*  4. Detalle los pasos, en lenguaje natural, necesarios para construir la alternativa que usa SUBCONSULTA.                                                                                                                           *
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
* 1. Filtrar las transacciones: Partir revisando las transacciones y sus cuotas, seleccionando únicamente aquellas con vencimiento entre junio y diciembre.                                                                           *
* 2. Calcular el promedio: Agrupar las transacciones por tipo de transacción y calcular el promedio del monto total.                                                                                                                  *
* 3. Insertar los resultados en la tabla de selección: Usar una subconsulta que obtenga estos promedios y resultados, e insertarlos directamente en la tabla SELECCION_TIPO_TRANSACCION.                                              *
* 4. Mostrar la información: Consultar la tabla SELECCION_TIPO_TRANSACCION recién poblada, ordenando los resultados por el monto promedio.                                                                                            *
* 5. Actualizar la tasa de interés: Usar la información de la tabla SELECCION_TIPO_TRANSACCION para identificar los tipos de transacción y actualizar su tasa de interés en la tabla TIPO_TRANSACCION_TARJETA, reduciéndola en 1%.    *
* 6. Confirmar los cambios: Finalmente, verificar los resultados, realizando un SELECT sobre la tabla TIPO_TRANSACCION_TARJETA para comprobar que las tasas se hayan actualizado correctamente.                                       *
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
*  5. Detalle los pasos, en lenguaje natural, necesarios para construir la alternativa que usa OPERADOR SET.                                                                                                                          *
*-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------*
* 1. Generar el primer conjunto de resultados: Construir una primera consulta que filtre las transacciones con cuotas vencidas entre junio y diciembre, calcule el promedio del monto total y agrupe por tipo de transacción.         *
* 2. Generar el segundo conjunto de resultados: Crear una segunda consulta similar, quizá con condiciones ligeramente distintas.                                                                                                      *
* 3. Unir los resultados: Utilizar el operador SET (UNION) para combinar ambos conjuntos, eliminando duplicados y obteniendo un resultado consolidado.                                                                                *
* 4. Ordenar y mostrar la información: Una vez unidos los resultados, ordenarlos por el monto promedio y mostrarlos.                                                                                                                  *
*                                                                                                                                                                                                                                     *   
***************************************************************************************************************************************************************************************************************************************




















