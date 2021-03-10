
drop database TiendaLosJuanes
create database TiendaLosJuanes
go
USE TiendaLosJuanes

--Abarrotes los juanchos--

-----------------------------------
--CREACION DE LA TABLA PROVEEDOR
-----------------------------------
create table proveedor (
idProveedor int identity(1,1), 
nombre varchar (30),
calle varchar(30) default 'Sin calle', 
numero int default 0, 
colonia varchar (30),
ciudad varchar(30) default 'Consultar al proveedor',
cp int,
idProducto int,
constraint UK_PROVEDOR primary key (idProveedor),
constraint CK_proveedor_CP check (cp like '[0-9][0-9][0-9][0-9][0-9]'),
CONSTRAINT UQ_nombre UNIQUE (nombre),
constraint FK_idProducto foreign key (idProducto) references producto(idProducto)on update cascade on delete cascade --SE EJECUTA UNA VEZ CREADA LA TABLA PRODUCTO
)

-----------------------------------
--CREACION DE LA TABLA PRODUCTO
-----------------------------------
Create table producto (idProducto int identity(1,1),
nombre varchar (30),
precio money, 
existencia bit,
constraint UK_PRODUCTO primary key clustered(idProducto),
constraint Producto_precio check (precio>0)
)
-------------------------------------
--CREACION DE LA TABLA CATEGORIA
-------------------------------------
create table categoria(IdCategoria int identity(1,1) unique,
nombre varchar(30) unique,
descripcion varchar(70),
constraint UK_CATEGORIA primary key clustered (idCategoria)
)
-------------------------------------------------------
--CREACION DE LA TABLA CLIENTE
-------------------------------------------------------
create table cliente (idCliente int identity(1,1),
nombre varchar (30), 
calle varchar(30), 
numero int,
colonia varchar (30),
ciudad varchar(30),
cp int,
mail varchar(30),
constraint UK_CLIENTE primary key clustered(idCliente),
constraint CK_cliente_CP check (cp like '[0-9][0-9][0-9][0-9][0-9]'))
----------------------------------------------------------
--CREACION DE LA TABLA VENDEDOR
----------------------------------------------------------

create table vendedor(
idVendedor int identity(1,1),
Nombre varchar(30),
FehaContrato date,
FechaNacimiento date,
Escolaridad Varchar(30),
constraint UK_VENDEDOR primary key clustered (idVendedor),
constraint CK_vendedor_Escolaridad check (escolaridad like 'primaria' or escolaridad like 'secundaria'),
constraint RG_nombre_juan check (nombre like 'juan%')
)
------------------------------------------
--CREACION DE LA TABLA VENTA
------------------------------------------
create table venta(
idVenta int identity(1,1),
fecha datetime,
total int, 
descuento varchar(4),
idVendedor int,
idCliente int,
idProducto int,
constraint UK_VENTA primary key clustered(idVenta),
constraint FK_idVendedor foreign key (idVendedor) references vendedor(idVendedor) on update cascade on delete cascade,
constraint FK_idCliente foreign key (idCliente) references cliente(idCliente) on update cascade on delete cascade,
constraint FK_idproducto1 foreign key (idProducto) references producto(idProducto) on update cascade on delete cascade,
constraint CK_fecha_mayorHOY check (fecha<getdate()),
constraint RG_venta_mayor0 check (total >0)
)
---------------------------------------------------------------------------------------------------------
--SE REVISA LA CORRECTA CREACION DE LAS TABLAS
-------------------------------------------------------------------------------------------------
select*from producto
select*from proveedor
select*from categoria
select*from cliente
select*from vendedor
select*from venta
----------------------------------------------------------------------------------------------------------
--INSERTS PARA REVISAR FUNCIONAMIENTO DE LAS RESTRICCIONES
---------------------------------------------------------------------------------------------------------
INSERT INTO  producto VALUES('Helado de chocolate',-12,1) --no se aceptan precios menores a cero
select*from producto
insert into proveedor values ('Turin','calle 208 ',250,'Reforma','Queretaro',763859,23)--El codigo postal solo puede contener 5digitos
insert into proveedor values ('Gamesa','calle 208 ',250,'Reforma','Queretaro',76385,23)--No debe repetirse el nombre del proveedor
select*from proveedor
insert into categoria values ('embutidos','salchicha,chorizo, tocino y demas') --El indice evita valores repetidos en la columna nombreCategoria
select*from categoria
INSERT INTO cliente VALUES('Eduardo','Altenwerth Crossing',13,'Cimatario','Queretaro',7616,'ed@gmail.com')--El codigo postal solo puede contener 5digitos
select*from cliente
insert into vendedor values('Carlos','10-10-2020','7-7-2000','Primaria')--El vendedor debe llevar Juan como primer nombre 
insert into vendedor values('Juan Ignacio','10-9-2020','7-8-2000','Preparatoria')--Solo se contrata a personas con primaria o secundaria
select*from vendedor
INSERT INTO venta Values ('2021-05-06',342,'4',6,10,50)--la fecha de la venta no debe ser mayor a hoy
INSERT INTO venta Values ('2020-05-06',-30,'4',6,10,50)--La venta no debe ser menor a cero
select*from venta
-------------------------------------------
--CHECAR QUE LOS DEFAULTS FUNCIONEN
-------------------------------------------
insert into proveedor (nombre,numero,colonia,ciudad,cp,idProducto) values ('Corona',250,'Reforma','Queretaro',76385,23)--calle puesto como SIN CALLE
insert into proveedor (nombre,calle,colonia,ciudad,cp,idProducto) values ('Carnes del centro','Zafiro','Reforma','Queretaro',76258,89)--Numero puesto como 0
insert into proveedor (nombre,numero,calle,colonia,cp,idProducto) values ('Bonafont',125,'Zafiro','Reforma',76258,89) -- ciudad puesta como Consultar al proveedor
select*from proveedor

---------------------------------------------------------------------------
--JOINS SIMPLES
---------------------------------------------------------------------------
--PROVEEDOR <-> PRODUCTO
select p.nombre as Producto,pr.nombre as Proveedor,p.precio from producto as p
inner join proveedor as pr on pr.idProveedor=p.idProducto

select p.nombre as Producto,pr.nombre as Proveedor,p.precio from producto as p
left join proveedor as pr on pr.idProveedor=p.idProducto

select p.nombre as Producto,pr.nombre as Proveedor,p.precio from producto as p
right join proveedor as pr on pr.idProveedor=p.idProducto

select p.nombre as Producto,pr.nombre as Proveedor,p.precio from producto as p
full join proveedor as pr on pr.idProveedor=p.idProducto


-----------------------------------------------------------------------------------------------------------------
--INSERTAR DATOS--
----------------------------------------------------------------------------------------------------------------
--PRODUCTOS
INSERT INTO  producto VALUES('Marias',121,1)
INSERT INTO  producto VALUES('Emperador ',33,1)
INSERT INTO  producto VALUES('Saladitas',56,1)
INSERT INTO  producto VALUES('Chokis',69,1)
INSERT INTO  producto VALUES('CRACKETS',170,1)
INSERT INTO  producto VALUES('Mamut',37,0)
INSERT INTO  producto VALUES('HotCakes',28,0)
INSERT INTO  producto VALUES('Vuala',68,0)
INSERT INTO  producto VALUES('Surtido Rico',182,1)
INSERT INTO  producto VALUES('Cremax de Nieve',98,1)
INSERT INTO  producto VALUES('arcoiris',178,1)
INSERT INTO  producto VALUES('Galletas de Avena',47,0)
INSERT INTO  producto VALUES('Canap�',130,0)
INSERT INTO  producto VALUES('Chocolatines',176,0)
INSERT INTO  producto VALUES('Consen',156,1)
INSERT INTO  producto VALUES('Rulecitos',155,1)
INSERT INTO  producto VALUES('Aceites comestibles',81,1)
INSERT INTO  producto VALUES('Aderezos',38,1)
INSERT INTO  producto VALUES('Consom�',115,0)
INSERT INTO  producto VALUES('Crema de cacahuate',149,0)
INSERT INTO  producto VALUES('Crema para caf�',164,0)
INSERT INTO  producto VALUES('Pur� de tomate',82,0)
INSERT INTO  producto VALUES('Alimento para beb�',175,0)
INSERT INTO  producto VALUES('Alimento para mascotas',126,0)
INSERT INTO  producto VALUES('Atole',70,0)
INSERT INTO  producto VALUES('Avena',77,0)
INSERT INTO  producto VALUES('Az�car',50,0)
INSERT INTO  producto VALUES('Caf�',43,0)
INSERT INTO  producto VALUES('Cereales',153,1)
INSERT INTO  producto VALUES('Chile piqu�n',23,1)
INSERT INTO  producto VALUES('Especias',184,1)
INSERT INTO  producto VALUES('Flan en polvo',170,1)
INSERT INTO  producto VALUES('F�rmulas infantiles',73,1)
INSERT INTO  producto VALUES('Gelatinas en polvo',25,0)
INSERT INTO  producto VALUES('Harina',199,1)
INSERT INTO  producto VALUES('Mole',83,1)
INSERT INTO  producto VALUES('Sal',42,0)
INSERT INTO  producto VALUES('Salsas envasadas',112,0)
INSERT INTO  producto VALUES('Sazonadores',139,1)
INSERT INTO  producto VALUES('Sopas en sobre',100,1)
INSERT INTO  producto VALUES('Cajeta',105,1)
INSERT INTO  producto VALUES('C�tsup',101,1)
INSERT INTO  producto VALUES('Mayonesa',27,1)
INSERT INTO  producto VALUES('Mermelada',149,1)
INSERT INTO  producto VALUES('Miel',179,0)
INSERT INTO  producto VALUES('T�',189,1)
INSERT INTO  producto VALUES('Vinagre',40,1)
INSERT INTO  producto VALUES('Huevo',154,1)
INSERT INTO  producto VALUES('Pasta',73,0)
INSERT INTO  producto VALUES('Aceitunas',192,0)
INSERT INTO  producto VALUES('Champi�ones',70,1)
INSERT INTO  producto VALUES('Ch�charos',194,1)
INSERT INTO  producto VALUES('Frijoles',88,1)
INSERT INTO  producto VALUES('Frutas en alm�bar',142,0)
INSERT INTO  producto VALUES('Sardinas',101,1)
INSERT INTO  producto VALUES('At�n en agua/aceite',124,0)
INSERT INTO  producto VALUES('Chiles',38,1)
INSERT INTO  producto VALUES('Ensaladas',188,1)
INSERT INTO  producto VALUES('Granos de elote',177,1)
INSERT INTO  producto VALUES('Sopa',93,0)
INSERT INTO  producto VALUES('Vegetales en conserva',111,0)
INSERT INTO  producto VALUES('Leche condesada',55,1)
INSERT INTO  producto VALUES('Yogur',55,1)
INSERT INTO  producto VALUES('Leche entera',95,0)
INSERT INTO  producto VALUES('Crema/media crema',89,1)
INSERT INTO  producto VALUES('Leche pasteurizada',189,0)
INSERT INTO  producto VALUES('Mantequilla',157,1)
INSERT INTO  producto VALUES('Margarina',45,0)
INSERT INTO  producto VALUES('Queso',175,0)
INSERT INTO  producto VALUES('Papas',112,1)
INSERT INTO  producto VALUES('Palomitas',33,1)
INSERT INTO  producto VALUES('Frituras de ma�z',191,1)
INSERT INTO  producto VALUES('Cacahuates',135,0)
INSERT INTO  producto VALUES('Botanas saladas',178,0)
INSERT INTO  producto VALUES('Barras alimenticias',197,1)
INSERT INTO  producto VALUES('Nueces y semillas',123,1)
INSERT INTO  producto VALUES('Papas',120,1)
INSERT INTO  producto VALUES('Palomitas',117,1)
INSERT INTO  producto VALUES('Frituras de ma�z',153,1)
INSERT INTO  producto VALUES('Cacahuates',22,1)
INSERT INTO  producto VALUES('Botanas saladas',95,0)
INSERT INTO  producto VALUES('Barras alimenticias',55,1)
INSERT INTO  producto VALUES('Nueces y semillas',174,1)
INSERT INTO  producto VALUES('Tortillas de harina',199,0)
INSERT INTO  producto VALUES('Galletas dulces',127,0)
INSERT INTO  producto VALUES('Pastelillos',180,1)
INSERT INTO  producto VALUES('Pan de caja',35,1)
INSERT INTO  producto VALUES('Pan dulce',115,1)
INSERT INTO  producto VALUES('Aguacate',133,1)
INSERT INTO  producto VALUES('Ajo',140,1)
INSERT INTO  producto VALUES('Cebolla',74,1)
INSERT INTO  producto VALUES('Chile',67,0)
INSERT INTO  producto VALUES('Cilantro',50,0)
INSERT INTO  producto VALUES('Jitomate',134,1)
INSERT INTO  producto VALUES('Papas',129,0)
INSERT INTO  producto VALUES('Limones',40,0)
INSERT INTO  producto VALUES('Manzanas',110,1)
INSERT INTO  producto VALUES('Naranjas',22,1)
INSERT INTO  producto VALUES('Pl�tanos',32,0)
INSERT INTO  producto VALUES('Agua mineral',168,0)
INSERT INTO  producto VALUES('Jarabes',20,0)
INSERT INTO  producto VALUES('Jugos',95,0)
INSERT INTO  producto VALUES('Naranjadas',106,0)
INSERT INTO  producto VALUES('Bebidas de soya',24,1)
INSERT INTO  producto VALUES('Energetizantes',84,0)
INSERT INTO  producto VALUES('Refrescos',39,0)
INSERT INTO  producto VALUES('Bebidas preparadas',31,1)
INSERT INTO  producto VALUES('Cerveza',56,0)
INSERT INTO  producto VALUES('An�s',138,0)
INSERT INTO  producto VALUES('Brandy',117,1)
INSERT INTO  producto VALUES('Ginebra',46,1)
INSERT INTO  producto VALUES('Cordiales',187,0)
INSERT INTO  producto VALUES('Mezcal',145,1)
INSERT INTO  producto VALUES('Jerez',41,1)
INSERT INTO  producto VALUES('Ron',63,1)
INSERT INTO  producto VALUES('Tequila',121,0)
INSERT INTO  producto VALUES('Sidra',152,1)
INSERT INTO  producto VALUES('Whisky',130,1)
INSERT INTO  producto VALUES('Vodka',172,0)
INSERT INTO  producto VALUES('Pastas listas para comer',173,0)
INSERT INTO  producto VALUES('Sopas en vaso',33,0)
INSERT INTO  producto VALUES('Carnes y embutidos',162,1)
INSERT INTO  producto VALUES('Salchichas',189,1)
INSERT INTO  producto VALUES('Mortadela',130,1)
INSERT INTO  producto VALUES('Tocino',49,0)
INSERT INTO  producto VALUES('Jam�n',196,0)
INSERT INTO  producto VALUES('Manteca',168,1)
INSERT INTO  producto VALUES('Chorizo',180,0)
INSERT INTO  producto VALUES('Carne de puerco',137,0)
INSERT INTO  producto VALUES('Pastas listas para comer',157,0)
INSERT INTO  producto VALUES('Sopas en vaso',100,0)
INSERT INTO  producto VALUES('Carnes y embutidos',196,1)
INSERT INTO  producto VALUES('Salchichas',159,1)
INSERT INTO  producto VALUES('Mortadela',112,0)
INSERT INTO  producto VALUES('Tocino',110,1)
INSERT INTO  producto VALUES('Jam�n',79,1)
INSERT INTO  producto VALUES('Manteca',167,1)
INSERT INTO  producto VALUES('Chorizo',110,0)
INSERT INTO  producto VALUES('Carne de puerco',175,0)
INSERT INTO  producto VALUES('Toallas h�medas',40,1)
INSERT INTO  producto VALUES('Aceite para beb�',195,1)
INSERT INTO  producto VALUES('Toallas femeninas',176,1)
INSERT INTO  producto VALUES('Algod�n',76,1)
INSERT INTO  producto VALUES('Tinte para el cabello',25,1)
INSERT INTO  producto VALUES('Biberones',80,0)
INSERT INTO  producto VALUES('Talco',156,0)
INSERT INTO  producto VALUES('Cepillo de dientes',178,0)
INSERT INTO  producto VALUES('Shampoo',174,0)
INSERT INTO  producto VALUES('Cotonetes',114,0)
INSERT INTO  producto VALUES('Rastrillos',199,1)

--PROVEEDORES--
insert into proveedor values ('Gamesa','calle 204 #110 ',25,'Reforma','Queretaro',76385,23)
insert into proveedor values ('Oro','189 OConnell Orchard',15,'Reforma','Veracruz',75385,100)
insert into proveedor values ('Colgate','96097 Libbie Fall ',69,'Reforma','Guanajuato',75385,120)
insert into proveedor values ('Sabritas','05586 Leonard Flats ',66,'Reforma','Jalisco',78365,90)
insert into proveedor values ('Lara','612 Hartmann Knoll',56,'Reforma','',74385,80)
insert into proveedor values ('Alpura','4564 Lolita Circles',70,'Reforma','Queretaro',75365,66)
insert into proveedor values ('Coca-cola','103 Klocko Freeway ',1200,'Reforma','Queretaro',75385,53)
insert into proveedor values ('Pepsi','560 Warren Wall ',23,'Reforma','Queretaro',75385,81)
insert into proveedor values ('Nescafe','160 Walker Ramp ',59,'Reforma','Queretaro',75385,75)
insert into proveedor values ('La coste�a','8997 Noelia Green ',58,'Reforma','Queretaro',75385,29)
insert into proveedor values ('Moderna','90701 Murl Green ',60,'Reforma','Queretaro',75385,71)
insert into proveedor values ('Jumex','12800 Hassan Route ',569,'Reforma','Queretaro',75385,31)
insert into proveedor values ('Pedigri','95275 Rowe Forge ',200,'Reforma','Queretaro',75385,65)
insert into proveedor values ('Truper','98674 Wolf Parkway',27,'Reforma','Queretaro',72885,24)
insert into proveedor values ('HP','751 Brendon Prairie ',78,'Reforma','Queretaro',75385,18)
insert into proveedor values ('Brother','01285 Brandy Drive ',98,'Reforma','Queretaro',75396,2)
insert into proveedor values ('FOOD','2468 Green Road ',256,'Reforma','Queretaro',75385,36)
insert into proveedor values ('Gnorm','6135 Nicolette Union ',230,'Reforma','Queretaro',75765,75)
insert into proveedor values ('Addidas','384 Erdman Trail ',1258,'Reforma','Queretaro',76685,52)
insert into proveedor values ('Nike','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)

--CATEGORIA
insert into categoria values ('embutidos','salchicha,chorizo, tocino y demas')
insert into categoria values ('vegetales','hojas verde como lechuga,acelgas,endivias,etc')
insert into categoria values ('aceites comestibles','girasol,oliva,canola,maiz y soya')
insert into categoria values ('botanas','fritos,sabritas,cheetos,cacahuates')
insert into categoria values ('cereales','se presenta en bolsas de 500 gr')
insert into categoria values ('bebidas concentradas','en presentacion de 250 mL y 500 mL')
insert into categoria values ('pastas','en presentacion de 150 gr,300 gr y 500 gr')
insert into categoria values ('salsas','picosas, botaneras y suaves para cualquier paladar')
insert into categoria values ('condimentos en polvo','cualquier marca que gustes probar')
insert into categoria values ('desechables','vasos,platos y cubietos en bolsas de 25 piezas')
insert into categoria values ('harinas y postres','refinados e integrales')
insert into categoria values ('cuidado bucal y piel','para hombres y mujeres de todos los precios')
insert into categoria values ('lacteos','en presentacion de 250 mL,500 mL y 1 L')
insert into categoria values ('shampoos','para cabello seco, grasoso y con caspa')
insert into categoria values ('alimento para mascotas','a granel,lo que guste')

--CLIENTE
INSERT INTO  cliente VALUES('�scar','Altenwerth Crossing',13,'Cimatario','Aguascalientes',76093,'�scar@gmail.com')
INSERT INTO  cliente VALUES('Ernesto','Koepp Highway',71,'Colonia El Pueblito','Ensenada',76034,'Ernesto@gmail.com')
INSERT INTO  cliente VALUES('Carlos','Dickens Fords',62,'Zibat�','Ciudad de M�xico',76097,'Carlos@gmail.com')
INSERT INTO  cliente VALUES('Ada','Christiansen Lodge',14,'Zakia','Monterrey',76080,'Ada@gmail.com')
INSERT INTO  cliente VALUES('Luis','Gaylord Park',38,'El Mirador','Celaya',76001,'Luis@gmail.com')
INSERT INTO  cliente VALUES('Aleyda','Clement Parkways',13,'Sonterra','Guanajuato',76072,'Aleyda@gmail.com')
INSERT INTO  cliente VALUES('Adalia','Ila Turnpike',82,'Jurica','Queretaro',76005,'Adalia@gmail.com')
INSERT INTO  cliente VALUES('Adolfa','Miller Forge',50,'Juriquilla','Queretaro',76097,'Adolfa@gmail.com')
INSERT INTO  cliente VALUES('Delmira','Gaston Inlet',84,'Zibat�','Monterrey',76044,'Delmira@gmail.com')
INSERT INTO  cliente VALUES('Delmiro','Schuster Parkways',73,'Sonterra','Aguascalientes',76001,'Delmiro@gmail.com')
INSERT INTO  cliente VALUES('Eadmunda','Burley Views',90,'Milenio III','Acapulco',76025,'Eadmunda@gmail.com')
INSERT INTO  cliente VALUES('Bianca',' Isabel Harbors',53,'Juriquilla','Tijuana',76008,'Bianca@gmail.com')
INSERT INTO  cliente VALUES('Bertr�n','Ankunding Courts',28,'El Mirador','Guadalajara',76049,'Bertr�n@gmail.com')
INSERT INTO  cliente VALUES('Berto','Darrin Loop',76,'El Refugio','Queretaro',76082,'Berto@gmail.com')
INSERT INTO  cliente VALUES('Bernarda','Ernser Camp',103,'Colonia Cimatario','Monterrey',76063,'Bernarda@gmail.com')
INSERT INTO  cliente VALUES('Bernardino','Brad Hills',33,'Colonia El Pueblito','Celaya',76005,'Bernardino@gmail.com')
INSERT INTO  cliente VALUES('Beltrando','Porfirio Diaz ',67,'Zakia','Guanajuato',76048,'Beltrando@gmail.com')
INSERT INTO  cliente VALUES('Beltrana','Darrin Loop',4,'El Refugio','Aguascalientes',76082,'Beltrana@gmail.com')
INSERT INTO  cliente VALUES('Hermelanda','Ankunding Courts',87,'El Mirador','Ciudad de M�xico',76025,'Hermelanda@gmail.com')

--VENDEDOR
insert into vendedor values('Juan Carlos','10-10-2020','7-7-2000','Primaria');
insert into vendedor values('Juan Jesus','10-10-2020','6-8-1999','secundaria');
insert into vendedor values('Juan Alberto','10-10-2020','2-2-1995','Primaria');
insert into vendedor values('Juan Edgar','10-10-2020','7-8-2001','secundaria');
insert into vendedor values('Juan Gabril','10-10-2020','9-7-1990','Primaria');
insert into vendedor values('Juan Pablo','10-10-2020','7-9-1992','secundaria');
insert into vendedor values('Juan Jose','10-10-2020','7-1-1989','Primaria');
insert into vendedor values('Juan Emilio','10-10-2020','3-7-1978','secundaria');
insert into vendedor values('Juan Iker','10-10-2020','5-1-1982','secundaria');
insert into vendedor values('Juan Axel','10-10-2020','4-7-1985','Primaria');

--VENTA
INSERT INTO venta Values ('2019-02-01',40,'0',1,1,1);
INSERT INTO venta Values ('2017-01-02',20,'15',2,2,2);
INSERT INTO venta Values ('2017-05-04',50,'10',3,3,3);
INSERT INTO venta Values ('2012-01-08',80,'5',4,4,4);
INSERT INTO venta Values ('2010-07-01',120,'6',5,5,5);
INSERT INTO venta Values ('2009-02-02',230,'2',6,6,6);
INSERT INTO venta Values ('2020-02-03',500,'8',7,7,7);
INSERT INTO venta Values ('2020-03-04',123,'9',8,8,8);
INSERT INTO venta Values ('2011-05-01',124,'4',9,9,9);
INSERT INTO venta Values ('2000-12-01',600,'2',10,10,10);
INSERT INTO venta Values ('2021-02-09',780,'2',9,11,11);
INSERT INTO venta Values ('2015-12-12',123,'6',8,12,12);
INSERT INTO venta Values ('2020-09-06',980,'0',7,13,13);
INSERT INTO venta Values ('2012-11-11',1456,'0',6,14,14);
INSERT INTO venta Values ('2013-01-10',45,'10',5,15,15);
INSERT INTO venta Values ('2013-01-12',783,'09',4,16,16);
INSERT INTO venta Values ('2016-08-08',67,'12',3,17,17);
INSERT INTO venta Values ('2015-03-02',7854,'6',2,18,18);
INSERT INTO venta Values ('2018-01-02',567,'8',1,19,19);
INSERT INTO venta Values ('2018-02-02',5674,'3',9,19,20);
INSERT INTO venta Values ('2019-02-01',40,'3',6,19,21);
INSERT INTO venta Values ('2011-01-02',150,'2',4,18,22);
INSERT INTO venta Values ('1999-08-09',45,'8',2,17,23);
INSERT INTO venta Values ('2010-09-04',56,'2',1,16,24);
INSERT INTO venta Values ('1999-01-01',999,'0',10,15,25);
INSERT INTO venta Values ('2015-06-02',456,'10',9,14,26);
INSERT INTO venta Values ('2003-09-09',1000,'3',8,13,27);
INSERT INTO venta Values ('2003-06-08',6798,'2',6,12,28);
INSERT INTO venta Values ('2003-08-09',7890,'2',2,11,29);
INSERT INTO venta Values ('2004-01-02',9007,'0',10,10,30);
INSERT INTO venta Values ('2009-10-01',40,'0',10,9,31);
INSERT INTO venta Values ('2002-01-02',6432,'7',9,8,32);
INSERT INTO venta Values ('2002-11-12',453,'7',8,7,33);
INSERT INTO venta Values ('2005-07-11',888,'8',7,6,34);
INSERT INTO venta Values ('1998-06-07',8976,'3',6,5,35);
INSERT INTO venta Values ('2000-03-06',784,'2',5,4,36);
INSERT INTO venta Values ('2000-09-12',999,'5',4,3,37);
INSERT INTO venta Values ('1989-11-11',123,'5',2,2,38);
INSERT INTO venta Values ('2011-06-06',876,'5',1,1,39);
INSERT INTO venta Values ('1998-11-12',910,'4',9,15,40);
INSERT INTO venta Values ('1999-12-11',40,'3',10,19,41);
INSERT INTO venta Values ('2020-01-09',555,'4',4,10,42);
INSERT INTO venta Values ('2020-03-03',444,'0',9,11,43);
INSERT INTO venta Values ('1999-07-03',4567,'0',5,14,44);
INSERT INTO venta Values ('2004-01-02',12343,'8',3,16,45);
INSERT INTO venta Values ('1999-04-03',321,'3',2,18,46);
INSERT INTO venta Values ('2004-12-02',4353,'7',6,19,47);
INSERT INTO venta Values ('2005-05-05',543,'0',10,15,48);
INSERT INTO venta Values ('2015-12-04',222,'0',8,8,49);
INSERT INTO venta Values ('2015-05-06',342,'4',6,10,50);


---------------------------------------------------------------------------
--JOINS COMPLEJOS
---------------------------------------------------------------------------
 --PROVEEDOR <-> PRODUCTO <-> VENTA <-> CLIENTE
 select p.nombre as Producto,pr.nombre as Proveedor, p.precio, c.nombre as cliente, v.fecha as "fecha de venta" from producto as p
 inner join proveedor as pr on pr.idProveedor=p.idProducto
 inner join venta as v on pr.idProducto=v.idProducto
 inner join cliente as c on v.idCliente=c.idCliente 
 
 select p.nombre as Producto,pr.nombre as Proveedor, p.precio, c.nombre as cliente, v.fecha as "fecha de venta" from producto as p
 left join proveedor as pr on pr.idProveedor=p.idProducto
 left join venta as v on pr.idProducto=v.idProducto
 left join cliente as c on v.idCliente=c.idCliente 
 
 select p.nombre as Producto,pr.nombre as Proveedor, p.precio, c.nombre as cliente, v.fecha as "fecha de venta" from producto as p
 right join proveedor as pr on pr.idProveedor=p.idProducto
 right join venta as v on pr.idProducto=v.idProducto
 right join cliente as c on v.idCliente=c.idCliente 
 
 select p.nombre as Producto,pr.nombre as Proveedor, p.precio, c.nombre as cliente, v.fecha as "fecha de venta" from producto as p
 full join proveedor as pr on pr.idProveedor=p.idProducto
 full join venta as v on pr.idProducto=v.idProducto
 full join cliente as c on v.idCliente=c.idCliente 
 
