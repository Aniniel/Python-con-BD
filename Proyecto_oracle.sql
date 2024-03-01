-- TABLA CLIENTES

CREATE TABLE CLIENTES (
  DNI VARCHAR2(9),
  NOMBRE VARCHAR2(50) NOT NULL,
  APELLIDOS VARCHAR2(50) NOT NULL,
  TELEFONO VARCHAR2(9) NOT NULL,
  CONSTRAINT PK_CLIENTES PRIMARY KEY (DNI)
);

-- TABLA PATROCINADORES

CREATE TABLE PATROCINADORES (
  NOMBRE VARCHAR2(50),	
  TOTAL_CARRERAS_PATROCINADAS NUMBER,
  TEMPORADA VARCHAR2(10) NOT NULL,
  CONSTRAINT PK_PATROCINADORES PRIMARY KEY (NOMBRE)
);

-- TABLA APUESTAS

CREATE TABLE APUESTAS (
  CODIGO VARCHAR2(10),
  IMPORTE_MAXIMO NUMBER,
  IMPORTE_MINIMO NUMBER,
  TANTO_A_UNO NUMBER,
  DNI_CLIENTE VARCHAR2(9) NOT NULL,
  CODIGO_CARRERA NUMBER NOT NULL,
  NOMBRE_CABALLO VARCHAR2(50) NOT NULL,
  CONSTRAINT PK_APUESTAS PRIMARY KEY (CODIGO),
  CONSTRAINT FK_APUESTAS_CLIENTES FOREIGN KEY (DNI_CLIENTE) REFERENCES CLIENTES (DNI),
  CONSTRAINT FK_APUESTAS_CARRERAS FOREIGN KEY (CODIGO_CARRERA) REFERENCES CARRERAS (CODIGO_CARRERA),
  CONSTRAINT FK_APUESTAS_CABALLOS FOREIGN KEY (NOMBRE_CABALLO) REFERENCES CABALLOS (NOMBRE)
);

-- TABLA ABONOS

CREATE TABLE ABONOS (
  DNI_CLIENTE VARCHAR2(9),
  NUMERO_ZONA NUMBER,
  PRECIO NUMBER NOT NULL,
  CONSTRAINT PK_ABONOS PRIMARY KEY (DNI_CLIENTE, NUMERO_ZONA),
  CONSTRAINT FK_ABONOS_CLIENTES FOREIGN KEY (DNI_CLIENTE) REFERENCES CLIENTES (DNI),
  CONSTRAINT FK_ABONOS_ZONAS FOREIGN KEY (NUMERO_ZONA) REFERENCES ZONAS (NUMERO_ZONA)
);

-- TABLA ZONAS

CREATE TABLE ZONAS (
  NUMERO_ZONA NUMBER,
  LOCALIDAD VARCHAR2(50) NOT NULL,
  CONSTRAINT PK_ZONAS PRIMARY KEY (NUMERO_ZONA)
);

-- TABLA ENTRADAS_DIARIAS

CREATE TABLE ENTRADAS_DIARIAS (
  NUMERO_ZONA NUMBER,
  FECHA DATE NOT NULL,
  PRECIO NUMBER NOT NULL,
  NUMERO_VENTAS NUMBER,
  CONSTRAINT PK_ENTRADAS_DIARIAS PRIMARY KEY (NUMERO_ZONA, FECHA),
  CONSTRAINT FK_ENTRADAS_DIARIAS_ZONAS FOREIGN KEY (NUMERO_ZONA) REFERENCES ZONAS (NUMERO_ZONA)
);

-- TABLA CARRERAS

CREATE TABLE CARRERAS (
  CODIGO_CARRERA NUMBER,
  FECHA DATE NOT NULL,
  HORA NUMBER NOT NULL,
  CABALLOS VARCHAR2(50) NOT NULL,
  JOCKEYS VARCHAR2(50) NOT NULL,
  NOMBRE_PATROCINADOR VARCHAR2(50) NOT NULL,
  CONSTRAINT PK_CARRERAS PRIMARY KEY (CODIGO_CARRERA),
  CONSTRAINT FK_CARRERAS_PATROCINADORES FOREIGN KEY (NOMBRE_PATROCINADOR) REFERENCES PATROCINADORES (NOMBRE)
);

-- TABLA CUOTA_PARTICIPACION

CREATE TABLE CUOTA_PARTICIPACION (
  NUMERO_FACTURA NUMBER,
  IMPORTE NUMBER,
  DNI_PARTICIPANTE VARCHAR2(9) NOT NULL,
  CONSTRAINT PK_CUOTA_PARTICIPACION PRIMARY KEY (NUMERO_FACTURA),
  CONSTRAINT FK_CUOTA_PARt_PARTICI FOREIGN KEY (DNI_PARTICIPANTE) REFERENCES PARTICIPANTES (DNI)
);

-- TABLA PARTICIPANTES

CREATE TABLE participantes (
  DNI VARCHAR2(10),
  nombre VARCHAR2(50) NOT NULL,
  apellido VARCHAR2(50) NOT NULL,
  posicion NUMBER(1) NOT NULL,
  dorsal NUMBER(2) NOT NULL,
  CONSTRAINT PK_PARTICIPANTES PRIMARY KEY (DNI)
);


-- TABLA CABALLOS

CREATE TABLE caballos (
  nombre VARCHAR2(50),
  peso NUMBER(3,2) NOT NULL,
  propietario VARCHAR2(50) NOT NULL,
  nacionalidad VARCHAR2(50) NOT NULL,
  ID_trabajador NUMBER(5) NOT NULL,
  CONSTRAINT PK_CABALLOS PRIMARY KEY (nombre),
  CONSTRAINT FK_CABALLOS_PARTICIPANTES FOREIGN KEY (propietario) REFERENCES participantes (DNI),
  CONSTRAINT FK_CABALLOS_CUIDADORES FOREIGN KEY (ID_trabajador) REFERENCES cuidadores (ID)
);

-- TABLA CORREDORES

CREATE TABLE corredores (
  nombre VARCHAR2(50),
  DNI_participante VARCHAR2(10) NOT NULL,
  CONSTRAINT pk_corredores PRIMARY KEY (nombre),
  CONSTRAINT fk_corredores_participantes FOREIGN KEY (DNI_participante) REFERENCES participantes(DNI)
);

-- TABLA CUIDADORES

CREATE TABLE cuidadores (
  ID NUMBER(5),
  nombre VARCHAR2(50) NOT NULL,
  apellido VARCHAR2(50) NOT NULL,
  direccion VARCHAR2(100) NOT NULL,
  telefono VARCHAR2(9) NOT NULL,
  CONSTRAINT PK_CUIDADORES PRIMARY KEY (ID)
);

-- TABLA BOXES

CREATE TABLE boxes (
  numero_del_box NUMBER(2),
  ubicacion VARCHAR2(50) NOT NULL,
  superficie NUMBER(3,2) NOT NULL,
  nombre_del_caballo VARCHAR2(50) NOT NULL,
  CONSTRAINT pk_boxes PRIMARY KEY (numero_del_box),
  CONSTRAINT fk_boxes_caballos FOREIGN KEY (nombre_del_caballo) REFERENCES caballos(nombre)
);

-- TABLA PISTAS

CREATE TABLE pistas (
  numero_de_pista NUMBER(2),
  ubicacion VARCHAR2(50) NOT NULL,
  superficie NUMBER(3,2) NOT NULL,
  CONSTRAINT pk_pistas PRIMARY KEY (numero_de_pista)
);



-- TABLA USO DE PISTAS

CREATE TABLE uso_pistas (
  nombre_del_caballo VARCHAR2(50),
  numero_de_pista NUMBER(2) NOT NULL,
  cuadrante VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_uso_pistas PRIMARY KEY (nombre_del_caballo, numero_de_pista),
  CONSTRAINT fk_uso_pistas_pistas FOREIGN KEY (numero_de_pista) REFERENCES pistas(numero_de_pista),
  CONSTRAINT fk_uso_pistas_caballos FOREIGN KEY (nombre_del_caballo) REFERENCES caballos(nombre)
);

-- TABLA ALIMENTOS

CREATE TABLE alimentos (
  tipo VARCHAR2(50),
  cantidad NUMBER(3,2) NOT NULL,
  fecha_caducidad DATE NOT NULL,
  precio NUMBER(5,2) NOT NULL,
  CONSTRAINT pk_alimentos PRIMARY KEY (tipo)
);


-- TABLA MEDICINAS

CREATE TABLE medicinas (
  nombre VARCHAR2(50),
  dosis NUMBER(3,2) NOT NULL,
  precio NUMBER(5,2) NOT NULL,
  CONSTRAINT pk_medicinas PRIMARY KEY (nombre)
);


-- TABLA GENERAN GASTOS

CREATE TABLE generan_gastos (
  nombre_del_caballo VARCHAR2(50) NOT NULL,
  numero_de_factura NUMBER(8),
  nombre_de_los_propietarios VARCHAR2(50) NOT NULL,
  fecha DATE NOT NULL,
  CONSTRAINT pk_generan_gastos PRIMARY KEY (nombre_del_caballo, numero_de_factura),
  CONSTRAINT fk_gen_ga_cab FOREIGN KEY (nombre_del_caballo) REFERENCES caballos(nombre),
  CONSTRAINT fk_gen_gas_part FOREIGN KEY (nombre_de_los_propietarios) REFERENCES participantes(DNI)
);

-- Inserciones para la tabla CLIENTES
INSERT INTO CLIENTES (DNI, NOMBRE, APELLIDOS, TELEFONO) VALUES ('123456789', 'Juan', 'Pérez', '123456789');
INSERT INTO CLIENTES (DNI, NOMBRE, APELLIDOS, TELEFONO) VALUES ('987654321', 'María', 'López', '987654321');
INSERT INTO CLIENTES (DNI, NOMBRE, APELLIDOS, TELEFONO) VALUES ('456789123', 'Pedro', 'García', '456789123');
INSERT INTO CLIENTES (DNI, NOMBRE, APELLIDOS, TELEFONO) VALUES ('789123456', 'Ana', 'Martínez', '789123456');
INSERT INTO CLIENTES (DNI, NOMBRE, APELLIDOS, TELEFONO) VALUES ('321654987', 'Laura', 'Rodríguez', '321654987');

-- Inserciones para la tabla PATROCINADORES
INSERT INTO PATROCINADORES (NOMBRE, TOTAL_CARRERAS_PATROCINADAS, TEMPORADA) VALUES ('Empresa A', 10, '2024');
INSERT INTO PATROCINADORES (NOMBRE, TOTAL_CARRERAS_PATROCINADAS, TEMPORADA) VALUES ('Empresa B', 8, '2024');
INSERT INTO PATROCINADORES (NOMBRE, TOTAL_CARRERAS_PATROCINADAS, TEMPORADA) VALUES ('Empresa C', 12, '2024');
INSERT INTO PATROCINADORES (NOMBRE, TOTAL_CARRERAS_PATROCINADAS, TEMPORADA) VALUES ('Empresa D', 6, '2024');
INSERT INTO PATROCINADORES (NOMBRE, TOTAL_CARRERAS_PATROCINADAS, TEMPORADA) VALUES ('Empresa E', 9, '2024');

-- Inserciones para la tabla APUESTAS
INSERT INTO APUESTAS (CODIGO, IMPORTE_MAXIMO, IMPORTE_MINIMO, TANTO_A_UNO, DNI_CLIENTE, CODIGO_CARRERA, NOMBRE_CABALLO) VALUES ('AP001', 100, 10, 2.5, '123456789', 1, 'Caballo1');
INSERT INTO APUESTAS (CODIGO, IMPORTE_MAXIMO, IMPORTE_MINIMO, TANTO_A_UNO, DNI_CLIENTE, CODIGO_CARRERA, NOMBRE_CABALLO) VALUES ('AP002', 150, 20, 3.0, '987654321', 2, 'Caballo2');
INSERT INTO APUESTAS (CODIGO, IMPORTE_MAXIMO, IMPORTE_MINIMO, TANTO_A_UNO, DNI_CLIENTE, CODIGO_CARRERA, NOMBRE_CABALLO) VALUES ('AP003', 200, 30, 4.0, '456789123', 3, 'Caballo3');
INSERT INTO APUESTAS (CODIGO, IMPORTE_MAXIMO, IMPORTE_MINIMO, TANTO_A_UNO, DNI_CLIENTE, CODIGO_CARRERA, NOMBRE_CABALLO) VALUES ('AP004', 120, 15, 2.0, '789123456', 4, 'Caballo4');
INSERT INTO APUESTAS (CODIGO, IMPORTE_MAXIMO, IMPORTE_MINIMO, TANTO_A_UNO, DNI_CLIENTE, CODIGO_CARRERA, NOMBRE_CABALLO) VALUES ('AP005', 180, 25, 3.5, '321654987', 5, 'Caballo5');

-- Inserciones para la tabla ABONOS
INSERT INTO ABONOS (DNI_CLIENTE, NUMERO_ZONA, PRECIO) VALUES ('123456789', 1, 150);
INSERT INTO ABONOS (DNI_CLIENTE, NUMERO_ZONA, PRECIO) VALUES ('987654321', 2, 200);
INSERT INTO ABONOS (DNI_CLIENTE, NUMERO_ZONA, PRECIO) VALUES ('456789123', 3, 250);
INSERT INTO ABONOS (DNI_CLIENTE, NUMERO_ZONA, PRECIO) VALUES ('789123456', 4, 180);
INSERT INTO ABONOS (DNI_CLIENTE, NUMERO_ZONA, PRECIO) VALUES ('321654987', 5, 220);

-- Inserciones para la tabla ZONAS
INSERT INTO ZONAS (NUMERO_ZONA, LOCALIDAD) VALUES (1, 'Localidad A');
INSERT INTO ZONAS (NUMERO_ZONA, LOCALIDAD) VALUES (2, 'Localidad B');
INSERT INTO ZONAS (NUMERO_ZONA, LOCALIDAD) VALUES (3, 'Localidad C');
INSERT INTO ZONAS (NUMERO_ZONA, LOCALIDAD) VALUES (4, 'Localidad D');
INSERT INTO ZONAS (NUMERO_ZONA, LOCALIDAD) VALUES (5, 'Localidad E');

-- Inserciones para la tabla ENTRADAS_DIARIAS
INSERT INTO ENTRADAS_DIARIAS (NUMERO_ZONA, FECHA, PRECIO, NUMERO_VENTAS) VALUES (1, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 50, 100);
INSERT INTO ENTRADAS_DIARIAS (NUMERO_ZONA, FECHA, PRECIO, NUMERO_VENTAS) VALUES (2, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 40, 80);
INSERT INTO ENTRADAS_DIARIAS (NUMERO_ZONA, FECHA, PRECIO, NUMERO_VENTAS) VALUES (3, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 30, 60);
INSERT INTO ENTRADAS_DIARIAS (NUMERO_ZONA, FECHA, PRECIO, NUMERO_VENTAS) VALUES (4, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 20, 40);
INSERT INTO ENTRADAS_DIARIAS (NUMERO_ZONA, FECHA, PRECIO, NUMERO_VENTAS) VALUES (5, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 10, 20);

-- Inserciones para la tabla CARRERAS
INSERT INTO CARRERAS (CODIGO_CARRERA, FECHA, HORA, CABALLOS, JOCKEYS, NOMBRE_PATROCINADOR) VALUES (1, TO_DATE('2024-02-20', 'YYYY-MM-DD'), 14, 'Caballo1, Caballo2', 'Jockey1, Jockey2', 'Empresa A');
INSERT INTO CARRERAS (CODIGO_CARRERA, FECHA, HORA, CABALLOS, JOCKEYS, NOMBRE_PATROCINADOR) VALUES (2, TO_DATE('2024-02-21', 'YYYY-MM-DD'), 15, 'Caballo3, Caballo4', 'Jockey3, Jockey4', 'Empresa B');
INSERT INTO CARRERAS (CODIGO_CARRERA, FECHA, HORA, CABALLOS, JOCKEYS, NOMBRE_PATROCINADOR) VALUES (3, TO_DATE('2024-02-22', 'YYYY-MM-DD'), 16, 'Caballo5, Caballo6', 'Jockey5, Jockey6', 'Empresa C');
INSERT INTO CARRERAS (CODIGO_CARRERA, FECHA, HORA, CABALLOS, JOCKEYS, NOMBRE_PATROCINADOR) VALUES (4, TO_DATE('2024-02-23', 'YYYY-MM-DD'), 17, 'Caballo7, Caballo8', 'Jockey7, Jockey8', 'Empresa D');
INSERT INTO CARRERAS (CODIGO_CARRERA, FECHA, HORA, CABALLOS, JOCKEYS, NOMBRE_PATROCINADOR) VALUES (5, TO_DATE('2024-02-24', 'YYYY-MM-DD'), 18, 'Caballo9, Caballo10', 'Jockey9, Jockey10', 'Empresa E');

-- Inserciones para la tabla CUOTA_PARTICIPACION
INSERT INTO CUOTA_PARTICIPACION (NUMERO_FACTURA, IMPORTE, DNI_PARTICIPANTE) VALUES (1, 100, '123456789');
INSERT INTO CUOTA_PARTICIPACION (NUMERO_FACTURA, IMPORTE, DNI_PARTICIPANTE) VALUES (2, 150, '987654321');
INSERT INTO CUOTA_PARTICIPACION (NUMERO_FACTURA, IMPORTE, DNI_PARTICIPANTE) VALUES (3, 200, '456789123');
INSERT INTO CUOTA_PARTICIPACION (NUMERO_FACTURA, IMPORTE, DNI_PARTICIPANTE) VALUES (4, 120, '789123456');
INSERT INTO CUOTA_PARTICIPACION (NUMERO_FACTURA, IMPORTE, DNI_PARTICIPANTE) VALUES (5, 180, '321654987');

-- Inserciones para la tabla PARTICIPANTES
INSERT INTO participantes (DNI, nombre, apellido, posicion, dorsal) VALUES ('123456789', 'Nombre1', 'Apellido1', 1, 10);
INSERT INTO participantes (DNI, nombre, apellido, posicion, dorsal) VALUES ('987654321', 'Nombre2', 'Apellido2', 2, 20);
INSERT INTO participantes (DNI, nombre, apellido, posicion, dorsal) VALUES ('456789123', 'Nombre3', 'Apellido3', 3, 30);
INSERT INTO participantes (DNI, nombre, apellido, posicion, dorsal) VALUES ('789123456', 'Nombre4', 'Apellido4', 4, 40);
INSERT INTO participantes (DNI, nombre, apellido, posicion, dorsal) VALUES ('321654987', 'Nombre5', 'Apellido5', 5, 50);

-- Inserciones para la tabla CABALLOS
INSERT INTO caballos (nombre, peso, propietario, nacionalidad, ID_trabajador) VALUES ('Caballo1', 400.5, '123456789', 'Española', 10001);
INSERT INTO caballos (nombre, peso, propietario, nacionalidad, ID_trabajador) VALUES ('Caballo2', 420.7, '987654321', 'Inglesa', 10002);
INSERT INTO caballos (nombre, peso, propietario, nacionalidad, ID_trabajador) VALUES ('Caballo3', 380.3, '456789123', 'Argentina', 10003);
INSERT INTO caballos (nombre, peso, propietario, nacionalidad, ID_trabajador) VALUES ('Caballo4', 410.2, '789123456', 'Francesa', 10004);
INSERT INTO caballos (nombre, peso, propietario, nacionalidad, ID_trabajador) VALUES ('Caballo5', 390.8, '321654987', 'Alemana', 10005);

-- Inserciones para la tabla CORREDORES
INSERT INTO corredores (nombre, DNI_participante) VALUES ('Corredor1', '123456789');
INSERT INTO corredores (nombre, DNI_participante) VALUES ('Corredor2', '987654321');
INSERT INTO corredores (nombre, DNI_participante) VALUES ('Corredor3', '456789123');
INSERT INTO corredores (nombre, DNI_participante) VALUES ('Corredor4', '789123456');
INSERT INTO corredores (nombre, DNI_participante) VALUES ('Corredor5', '321654987');

-- Inserciones para la tabla CUIDADORES
INSERT INTO cuidadores (ID, nombre, apellido, direccion, telefono) VALUES (10001, 'Cuidador1', 'ApellidoC1', 'Dirección1', '123456789');
INSERT INTO cuidadores (ID, nombre, apellido, direccion, telefono) VALUES (10002, 'Cuidador2', 'ApellidoC2', 'Dirección2', '987654321');
INSERT INTO cuidadores (ID, nombre, apellido, direccion, telefono) VALUES (10003, 'Cuidador3', 'ApellidoC3', 'Dirección3', '456789123');
INSERT INTO cuidadores (ID, nombre, apellido, direccion, telefono) VALUES (10004, 'Cuidador4', 'ApellidoC4', 'Dirección4', '789123456');
INSERT INTO cuidadores (ID, nombre, apellido, direccion, telefono) VALUES (10005, 'Cuidador5', 'ApellidoC5', 'Dirección5', '321654987');

-- Inserciones para la tabla BOXES
INSERT INTO boxes (numero_del_box, ubicacion, superficie, nombre_del_caballo) VALUES (1, 'Ubicación1', 30.5, 'Caballo1');
INSERT INTO boxes (numero_del_box, ubicacion, superficie, nombre_del_caballo) VALUES (2, 'Ubicación2', 35.2, 'Caballo2');
INSERT INTO boxes (numero_del_box, ubicacion, superficie, nombre_del_caballo) VALUES (3, 'Ubicación3', 40.7, 'Caballo3');
INSERT INTO boxes (numero_del_box, ubicacion, superficie, nombre_del_caballo) VALUES (4, 'Ubicación4', 38.1, 'Caballo4');
INSERT INTO boxes (numero_del_box, ubicacion, superficie, nombre_del_caballo) VALUES (5, 'Ubicación5', 45.3, 'Caballo5');

-- Inserciones para la tabla PISTAS
INSERT INTO pistas (numero_de_pista, ubicacion, superficie) VALUES (1, 'UbicaciónPista1', 100.5);
INSERT INTO pistas (numero_de_pista, ubicacion, superficie) VALUES (2, 'UbicaciónPista2', 110.3);
INSERT INTO pistas (numero_de_pista, ubicacion, superficie) VALUES (3, 'UbicaciónPista3', 95.7);
INSERT INTO pistas (numero_de_pista, ubicacion, superficie) VALUES (4, 'UbicaciónPista4', 105.8);
INSERT INTO pistas (numero_de_pista, ubicacion, superficie) VALUES (5, 'UbicaciónPista5', 120.6);

-- Inserciones para la tabla USO DE PISTAS
INSERT INTO uso_pistas (nombre_del_caballo, numero_de_pista, cuadrante) VALUES ('Caballo1', 1, 'Cuadrante1');
INSERT INTO uso_pistas (nombre_del_caballo, numero_de_pista, cuadrante) VALUES ('Caballo2', 2, 'Cuadrante2');
INSERT INTO uso_pistas (nombre_del_caballo, numero_de_pista, cuadrante) VALUES ('Caballo3', 3, 'Cuadrante3');
INSERT INTO uso_pistas (nombre_del_caballo, numero_de_pista, cuadrante) VALUES ('Caballo4', 4, 'Cuadrante4');
INSERT INTO uso_pistas (nombre_del_caballo, numero_de_pista, cuadrante) VALUES ('Caballo5', 5, 'Cuadrante5');

-- Inserciones para la tabla ALIMENTOS
INSERT INTO alimentos (tipo, cantidad, fecha_caducidad, precio) VALUES ('TipoAlimento1', 50.5, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 30.5);
INSERT INTO alimentos (tipo, cantidad, fecha_caducidad, precio) VALUES ('TipoAlimento2', 45.2, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 35.2);
INSERT INTO alimentos (tipo, cantidad, fecha_caducidad, precio) VALUES ('TipoAlimento3', 60.7, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 40.7);
INSERT INTO alimentos (tipo, cantidad, fecha_caducidad, precio) VALUES ('TipoAlimento4', 55.1, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 38.1);
INSERT INTO alimentos (tipo, cantidad, fecha_caducidad, precio) VALUES ('TipoAlimento5', 70.3, TO_DATE('2024-03-20', 'YYYY-MM-DD'), 45.3);

-- Inserciones para la tabla MEDICINAS
INSERT INTO medicinas (nombre, dosis, precio) VALUES ('Medicina1', 5.5, 30.5);
INSERT INTO medicinas (nombre, dosis, precio) VALUES ('Medicina2', 6.2, 35.2);
INSERT INTO medicinas (nombre, dosis, precio) VALUES ('Medicina3', 7.7, 40.7);
INSERT INTO medicinas (nombre, dosis, precio) VALUES ('Medicina4', 6.1, 38.1);
INSERT INTO medicinas (nombre, dosis, precio) VALUES ('Medicina5', 8.3, 45.3);

-- Inserciones para la tabla GENERAN GASTOS
INSERT INTO generan_gastos (nombre_del_caballo, numero_de_factura, nombre_de_los_propietarios, fecha) VALUES ('Caballo1', 1, '123456789', TO_DATE('2024-02-20', 'YYYY-MM-DD'));
INSERT INTO generan_gastos (nombre_del_caballo, numero_de_factura, nombre_de_los_propietarios, fecha) VALUES ('Caballo2', 2, '987654321', TO_DATE('2024-02-21', 'YYYY-MM-DD'));
INSERT INTO generan_gastos (nombre_del_caballo, numero_de_factura, nombre_de_los_propietarios, fecha) VALUES ('Caballo3', 3, '456789123', TO_DATE('2024-02-22', 'YYYY-MM-DD'));
INSERT INTO generan_gastos (nombre_del_caballo, numero_de_factura, nombre_de_los_propietarios, fecha) VALUES ('Caballo4', 4, '789123456', TO_DATE('2024-02-23', 'YYYY-MM-DD'));
INSERT INTO generan_gastos (nombre_del_caballo, numero_de_factura, nombre_de_los_propietarios, fecha) VALUES ('Caballo5', 5, '321654987', TO_DATE('2024-02-24', 'YYYY-MM-DD'));

