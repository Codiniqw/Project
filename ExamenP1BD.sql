
drop database TiendaLosJuanes
go
create database TiendaLosJuanes
go
USE TiendaLosJuanes
go
--Abarrotes los juanchos--

-----------------------------------
--CREACION DE UNA VARIABLE GLOBAL
-----------------------------------
exec sp_addtype precio,'MONEY'
go
-------------------------------------
--CREACION DE LA TABLA CATEGORIA
-------------------------------------
create table categoria(idCategoria int identity(1,1) unique,
nombre varchar(30) unique,
descripcion varchar(70),
constraint UK_CATEGORIA primary key clustered (idCategoria)
)

-----------------------------------
--CREACION DE LA TABLA PRODUCTO
-----------------------------------
Create table producto (idProducto int identity(1,1),
nombre varchar (30),
precio precio, 
existencia bit,
idCategoria int ,
constraint FK_categoria  foreign key (idCategoria) references categoria(idCategoria) on update cascade on delete cascade,
constraint UK_PRODUCTO primary key clustered(idProducto),
constraint Producto_precio check (precio>0)
)

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
constraint FK_idProducto foreign key (idProducto) references producto(idProducto)on update cascade on delete cascade 
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


-----------------------------------------------------------------------------------------------------------------
--INSERTAR DATOS--

--CATEGORIA

insert into categoria values ('carros y cestas','De 28,32 y 54 L/kg');
insert into categoria values ('entradas y precocinada','empanadas,ensaladas,guacamole,etc');
insert into categoria values ('cajas','revistas,bebidas,chicles,etc');
insert into categoria values ('agua mineral','En presentacion de 250,500 mL y 1 L');
insert into categoria values ('snacks','se presenta en bolsas de 300 y 500 gr');
insert into categoria values ('conservas','chiles gueros,jamon iberico,mermelada de higos');
insert into categoria values ('pastas','en presentacion de 150 gr,300 gr y 500 gr');
insert into categoria values ('salsas','picosas, botaneras y suaves para cualquier paladar');
insert into categoria values ('condimentos en polvo','cualquier marca que gustes probar');
insert into categoria values ('desechables','vasos,platos y cubiertos en bolsas de 25 piezas');
insert into categoria values ('harinas','refinadas e integrales');
insert into categoria values ('cuidado bucal','para hombres y mujeres de todos los precios');
insert into categoria values ('lacteos','En presentacion de 250 mL,500 mL y 1 L');
insert into categoria values ('shampoos','Para cabello seco, grasoso y con caspa');
insert into categoria values ('alimento para mascotas','pedigree,whiskas,purina,etc');
insert into categoria values ('bebidas alcoholicas','cerveza,tequila,vodka,baileys,whisky');
insert into categoria values ('bolleria industrial','tartas,bollos,galletas,donas');
insert into categoria values ('productos limpieza para casa','esponja,lejia,quitamanchas,cepillo para inodoro');
insert into categoria values ('productos limpieza para ropa','suavisante,activador de color,desengrasante,detergente en polvo');
insert into categoria values ('refrescos','Coca cola,pepsi,Sprite,Squirt');
insert into categoria values ('pizzas congeladas','pepperoni,hawaiana,carnes frias,4 quesos');
insert into categoria values ('verduras','Hojas verde como lechuga,acelgas,endivias');
insert into categoria values ('ibericos y charcuteria','salchicha,chorizo, tocino y demas');
insert into categoria values ('helados','vainilla,chocolate,fresa,limon');
insert into categoria values ('leches vegetales','soya,almendras,nueces de macadamia,avena,arroz');
insert into categoria values ('quesos','Parmesano,Mozzarella,Crema,Gouda');
insert into categoria values ('cafe y chocolate','Nescafe,Coffee Mate,Cafe buen dia,Nestle abuelita,entre otros');
insert into categoria values ('pescaderia','sardina,salmon,merluza,bacalao');
insert into categoria values ('mariscos','mejillon,camaron,cangrejo,langosta');
insert into categoria values ('bebidas energeticas','boost,bang,monster,Red Bull');
insert into categoria values ('frutas','De temporada');
insert into categoria values ('alimentos enlatados','sardinas entomatadas,atun en aceite, chiles en escabeche,elote');
insert into categoria values ('cigarrillos','Marlboro,Chesterfield,Benson & Hedges');
insert into categoria values ('farmaceuticos','antibioticos,antihistaminicos,antiinflamatorios,etc');
insert into categoria values ('productos de bebe','toallitas,pañales,tetina,crema');
insert into categoria values ('aceites','girasol,soya,oliva,maiz');
insert into categoria values ('postres','pay de queso,pay de limon,pastel de chocolate,flan');
insert into categoria values ('cremas para piel','crema colageno nutritiva,ultra facial oil free,entre otras');
insert into categoria values ('desodorantes','nivea,Rexona,Dove');
insert into categoria values ('cuidado facial','hyaluron,antiarrugas,refrescante botanico,entre otras');
insert into categoria values ('infusiones','manzanilla,melisa,tila,salvia');
insert into categoria values ('cuidado intimo','toallitas chilly,exfoliante,balsamo,crema');
insert into categoria values ('multivitaminicos','biometrix,centrum,pharmaton');
insert into categoria values ('complementos nutricionales','probioticos,plantas,fibras,AGPI');
insert into categoria values ('jugos','Jumex,Del Valle,Herdez,Florida 7');
insert into categoria values ('cereales','A granel,lo que guste');
insert into categoria values ('dulces','rises,carlos V,gomitas,bombones,etc');
insert into categoria values ('barra desayunadora','chilaquiles,huevo con jamon,hot cakes,yogur');
insert into categoria values ('barra de ensaladas','zanahoria rallada,col morada rallada,germen alfalfa,pepino en rodajas');
insert into categoria values ('barra de comida','pure de papa,pollo en salsa,sushi,baguettes');

----------------------------------------------------------------------------------------------------------------
--PRODUCTOS
----------------------------------------------------------------------------------------------------------------

INSERT INTO  producto VALUES('Marías',121,1,12)
INSERT INTO  producto VALUES('Emperador ',33,1,15)
INSERT INTO  producto VALUES('Saladitas',56,1,14)
INSERT INTO  producto VALUES('Chokis',69,1,3)
INSERT INTO  producto VALUES('CRACKETS',170,1,2)
INSERT INTO  producto VALUES('Mamut',37,0,14)
INSERT INTO  producto VALUES('HotCakes',28,0,6)
INSERT INTO  producto VALUES('Vualá',68,0,14)
INSERT INTO  producto VALUES('Surtido Rico',182,1,5)
INSERT INTO  producto VALUES('Cremax de Nieve',98,1,10)
INSERT INTO  producto VALUES('arcoíris',178,1,5)
INSERT INTO  producto VALUES('Galletas de Avena',47,0,2)
INSERT INTO  producto VALUES('Canapé',130,0,6)
INSERT INTO  producto VALUES('Chocolatines',176,0,16)
INSERT INTO  producto VALUES('Consen',156,1,16)
INSERT INTO  producto VALUES('Rulecitos',155,1,11)
INSERT INTO  producto VALUES('Aceites comestibles',81,1,2)
INSERT INTO  producto VALUES('Aderezos',38,1,16)
INSERT INTO  producto VALUES('Consomé',115,0,4)
INSERT INTO  producto VALUES('Crema de cacahuate',149,0,2)
INSERT INTO  producto VALUES('Crema para café',164,0,1)
INSERT INTO  producto VALUES('Puré de tomate',82,0,5)
INSERT INTO  producto VALUES('Alimento para bebé',175,0,12)
INSERT INTO  producto VALUES('Alimento para mascotas',126,0,12)
INSERT INTO  producto VALUES('Atole',70,0,16)
INSERT INTO  producto VALUES('Avena',77,0,4)
INSERT INTO  producto VALUES('Azúcar',50,0,12)
INSERT INTO  producto VALUES('Café',43,0,3)
INSERT INTO  producto VALUES('Cereales',153,1,14)
INSERT INTO  producto VALUES('Chile piquín',23,1,13)
INSERT INTO  producto VALUES('Especias',184,1,15)
INSERT INTO  producto VALUES('Flan en polvo',170,1,2)
INSERT INTO  producto VALUES('Fórmulas infantiles',73,1,11)
INSERT INTO  producto VALUES('Gelatinas en polvo',25,0,13)
INSERT INTO  producto VALUES('Harina',199,1,12)
INSERT INTO  producto VALUES('Mole',83,1,1)
INSERT INTO  producto VALUES('Sal',42,0,13)
INSERT INTO  producto VALUES('Salsas envasadas',112,0,12)
INSERT INTO  producto VALUES('Sazonadores',139,1,13)
INSERT INTO  producto VALUES('Sopas en sobre',100,1,6)
INSERT INTO  producto VALUES('Cajeta',105,1,10)
INSERT INTO  producto VALUES('Cátsup',101,1,6)
INSERT INTO  producto VALUES('Mayonesa',27,1,7)
INSERT INTO  producto VALUES('Mermelada',149,1,3)
INSERT INTO  producto VALUES('Miel',179,0,8)
INSERT INTO  producto VALUES('Té',189,1,4)
INSERT INTO  producto VALUES('Vinagre',40,1,5)
INSERT INTO  producto VALUES('Huevo',154,1,1)
INSERT INTO  producto VALUES('Pasta',73,0,16)
INSERT INTO  producto VALUES('Aceitunas',192,0,9)
INSERT INTO  producto VALUES('Champiñones',70,1,1)
INSERT INTO  producto VALUES('Chícharos',194,1,3)
INSERT INTO  producto VALUES('Frijoles',88,1,16)
INSERT INTO  producto VALUES('Frutas en almíbar',142,0,3)
INSERT INTO  producto VALUES('Sardinas',101,1,1)
INSERT INTO  producto VALUES('Atún en agua/aceite',124,0,14)
INSERT INTO  producto VALUES('Chiles',38,1,12)
INSERT INTO  producto VALUES('Ensaladas',188,1,6)
INSERT INTO  producto VALUES('Granos de elote',177,1,11)
INSERT INTO  producto VALUES('Sopa',93,0,9)
INSERT INTO  producto VALUES('Vegetales en conserva',111,0,10)
INSERT INTO  producto VALUES('Leche condesada',55,1,10)
INSERT INTO  producto VALUES('Yogur',55,1,5)
INSERT INTO  producto VALUES('Leche entera',95,0,15)
INSERT INTO  producto VALUES('Crema/media crema',89,1,6)
INSERT INTO  producto VALUES('Leche pasteurizada',189,0,13)
INSERT INTO  producto VALUES('Mantequilla',157,1,5)
INSERT INTO  producto VALUES('Margarina',45,0,10)
INSERT INTO  producto VALUES('Queso',175,0,13)
INSERT INTO  producto VALUES('Papas',112,1,5)
INSERT INTO  producto VALUES('Palomitas',33,1,1)
INSERT INTO  producto VALUES('Frituras de maíz',191,1,12)
INSERT INTO  producto VALUES('Cacahuates',135,0,15)
INSERT INTO  producto VALUES('Botanas saladas',178,0,15)
INSERT INTO  producto VALUES('Barras alimenticias',197,1,8)
INSERT INTO  producto VALUES('Nueces y semillas',123,1,6)
INSERT INTO  producto VALUES('Papas',120,1,2)
INSERT INTO  producto VALUES('Palomitas',117,1,13)
INSERT INTO  producto VALUES('Frituras de maíz',153,1,10)
INSERT INTO  producto VALUES('Cacahuates',22,1,3)
INSERT INTO  producto VALUES('Botanas saladas',95,0,15)
INSERT INTO  producto VALUES('Barras alimenticias',55,1,11)
INSERT INTO  producto VALUES('Nueces y semillas',174,1,5)
INSERT INTO  producto VALUES('Tortillas de harina',199,0,10)
INSERT INTO  producto VALUES('Galletas dulces',127,0,6)
INSERT INTO  producto VALUES('Pastelillos',180,1,2)
INSERT INTO  producto VALUES('Pan de caja',35,1,9)
INSERT INTO  producto VALUES('Pan dulce',115,1,12)
INSERT INTO  producto VALUES('Aguacate',133,1,16)
INSERT INTO  producto VALUES('Ajo',140,1,4)
INSERT INTO  producto VALUES('Cebolla',74,1,13)
INSERT INTO  producto VALUES('Chile',67,0,1)
INSERT INTO  producto VALUES('Cilantro',50,0,9)
INSERT INTO  producto VALUES('Jitomate',134,1,9)
INSERT INTO  producto VALUES('Papas',129,0,12)
INSERT INTO  producto VALUES('Limones',40,0,4)
INSERT INTO  producto VALUES('Manzanas',110,1,9)
INSERT INTO  producto VALUES('Naranjas',22,1,9)
INSERT INTO  producto VALUES('Plátanos',32,0,3)
INSERT INTO  producto VALUES('Agua mineral',168,0,6)
INSERT INTO  producto VALUES('Jarabes',20,0,15)
INSERT INTO  producto VALUES('Jugos',95,0,6)
INSERT INTO  producto VALUES('Naranjadas',106,0,10)
INSERT INTO  producto VALUES('Bebidas de soya',24,1,2)
INSERT INTO  producto VALUES('Energetizantes',84,0,15)
INSERT INTO  producto VALUES('Refrescos',39,0,10)
INSERT INTO  producto VALUES('Bebidas preparadas',31,1,10)
INSERT INTO  producto VALUES('Cerveza',56,0,4)
INSERT INTO  producto VALUES('Anís',138,0,12)
INSERT INTO  producto VALUES('Brandy',117,1,7)
INSERT INTO  producto VALUES('Ginebra',46,1,8)
INSERT INTO  producto VALUES('Cordiales',187,0,11)
INSERT INTO  producto VALUES('Mezcal',145,1,12)
INSERT INTO  producto VALUES('Jerez',41,1,13)
INSERT INTO  producto VALUES('Ron',63,1,12)
INSERT INTO  producto VALUES('Tequila',121,0,3)
INSERT INTO  producto VALUES('Sidra',152,1,13)
INSERT INTO  producto VALUES('Whisky',130,1,8)
INSERT INTO  producto VALUES('Vodka',172,0,16)
INSERT INTO  producto VALUES('Pastas listas para comer',173,0,6)
INSERT INTO  producto VALUES('Sopas en vaso',33,0,9)
INSERT INTO  producto VALUES('Carnes y embutidos',162,1,11)
INSERT INTO  producto VALUES('Salchichas',189,1,6)
INSERT INTO  producto VALUES('Mortadela',130,1,6)
INSERT INTO  producto VALUES('Tocino',49,0,9)
INSERT INTO  producto VALUES('Jamón',196,0,11)
INSERT INTO  producto VALUES('Manteca',168,1,3)
INSERT INTO  producto VALUES('Chorizo',180,0,16)
INSERT INTO  producto VALUES('Carne de puerco',137,0,10)
INSERT INTO  producto VALUES('Pastas listas para comer',157,0,7)
INSERT INTO  producto VALUES('Sopas en vaso',100,0,13)
INSERT INTO  producto VALUES('Carnes y embutidos',196,1,11)
INSERT INTO  producto VALUES('Salchichas',159,1,5)
INSERT INTO  producto VALUES('Mortadela',112,0,10)
INSERT INTO  producto VALUES('Tocino',110,1,11)
INSERT INTO  producto VALUES('Jamón',79,1,4)
INSERT INTO  producto VALUES('Manteca',167,1,5)
INSERT INTO  producto VALUES('Chorizo',110,0,14)
INSERT INTO  producto VALUES('Carne de puerco',175,0,13)
INSERT INTO  producto VALUES('Toallas húmedas',40,1,5)
INSERT INTO  producto VALUES('Aceite para bebé',195,1,2)
INSERT INTO  producto VALUES('Toallas femeninas',176,1,8)
INSERT INTO  producto VALUES('Algodón',76,1,9)
INSERT INTO  producto VALUES('Tinte para el cabello',25,1,7)
INSERT INTO  producto VALUES('Biberones',80,0,2)
INSERT INTO  producto VALUES('Talco',156,0,16)
INSERT INTO  producto VALUES('Cepillo de dientes',178,0,9)
INSERT INTO  producto VALUES('Shampoo',174,0,15)
INSERT INTO  producto VALUES('Cotonetes',114,0,4)
INSERT INTO  producto VALUES('Rastrillos',199,1,3)
INSERT INTO  producto VALUES('Veladoras',35,1,11)
INSERT INTO  producto VALUES('Cepillo de plástico',25,1,11)
INSERT INTO  producto VALUES('Vasos desechables',29,1,15)
INSERT INTO  producto VALUES('Cinta adhesiva',44,1,2)
INSERT INTO  producto VALUES('Cucharas de plástico',44,1,8)
INSERT INTO  producto VALUES('Escobas',30,1,5)
INSERT INTO  producto VALUES('Trampas para ratas',32,1,11)
INSERT INTO  producto VALUES('Tenedores de plástico',23,1,10)
INSERT INTO  producto VALUES('Multicontacto',42,1,12)
INSERT INTO  producto VALUES('Recogedor de metal/plástico',35,1,15)
INSERT INTO  producto VALUES('Popotes',25,1,11)
INSERT INTO  producto VALUES('Platos desechables',39,1,14)
INSERT INTO  producto VALUES('Focos',34,1,3)
INSERT INTO  producto VALUES('Fusibles',40,0,14)
INSERT INTO  producto VALUES('Jergas/Franelas',33,0,7)
INSERT INTO  producto VALUES('Matamoscas',31,0,13)
INSERT INTO  producto VALUES('Pegamento',21,0,3)
INSERT INTO  producto VALUES('Mecate',37,1,10)
INSERT INTO  producto VALUES('Tarjetas telefónicas',20,0,6)
INSERT INTO  producto VALUES('Recargas móviles',47,1,2)
INSERT INTO  producto VALUES('Hielo',41,1,14)
INSERT INTO  producto VALUES('Cigarros',26,1,1)
INSERT INTO  producto VALUES('Tortillas de harina',65,0,11)
INSERT INTO  producto VALUES('Galletas dulces',35,0,1)
INSERT INTO  producto VALUES('Galletas saladas',23,1,4)
INSERT INTO  producto VALUES('Pastelillos',70,1,16)
INSERT INTO  producto VALUES('Pan de caja',24,0,8)
INSERT INTO  producto VALUES('Pan dulce',12,0,6)
INSERT INTO  producto VALUES('Pan molido',34,1,9)
INSERT INTO  producto VALUES('Pan tostado',34,1,11)
INSERT INTO  producto VALUES('Aguacates',30,1,11)
INSERT INTO  producto VALUES('Ajos',56,1,16)
INSERT INTO  producto VALUES('Cebollas',78,0,11)
INSERT INTO  producto VALUES('Chiles',35,0,5)
INSERT INTO  producto VALUES('Cilantro',122,0,2)
INSERT INTO  producto VALUES('Jitomate',134,1,10)
INSERT INTO  producto VALUES('Papas',57,1,2)
INSERT INTO  producto VALUES('Limones',35,0,14)
INSERT INTO  producto VALUES('Manzanas',90,0,13)
INSERT INTO  producto VALUES('Perejil',11,1,5)
INSERT INTO  producto VALUES('Suero',50,1,2)
INSERT INTO  producto VALUES('Agua oxigenada',56,0,5)
INSERT INTO  producto VALUES('Preservativos',75,0,1)
INSERT INTO  producto VALUES('Alcohol',46,1,13)
INSERT INTO  producto VALUES('Gasas',35,1,12)
INSERT INTO  producto VALUES('Analgésicos',34,0,9)
INSERT INTO  producto VALUES('Antigripales',53,0,1)
INSERT INTO  producto VALUES('Antiácidos',24,0,3)
INSERT INTO  producto VALUES('agujas',34,1,15)
INSERT INTO  producto VALUES('Vacuna Contra COVID',1000,1,8)

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
insert into proveedor values ('Amway','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Herbalife Nutrition','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Avon Products Inc.','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Vorwerk','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Natura','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,156)
insert into proveedor values ('Coway','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Nu Skin','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,146)
insert into proveedor values ('Tupperware','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Oriflame','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Ambit Energy','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Pola','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Belcorp','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('PM International','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Jeunesse','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Telecom Plus','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('USANA','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Yanbal','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Medifast/OPTAVIA','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Arbonne','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Team National','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Miki Corp.','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Scentsy','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Plexus Worldwide','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('MONAT Global','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Faberlic','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Nature’s Sunshine','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('WorldVentures','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('For Days','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Hy Cite Enterprises','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Vestige Marketing','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Noevir','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Farmasi','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('New Image Group','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Naturally Plus','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('ARIIX','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('LifeVantage','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Pure Romance','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Color Street','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Menard','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Noni by NewAge Beverages','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Giffarine','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('KK Assuran','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Immunotec','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('ASEA Global','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('MyDailyChoice / HempWorx','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Mannatech','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Southwestern Advantage','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Elepreneurs','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Usborne Books & More','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)
insert into proveedor values ('Xyngular','85575 Schuppe Junction ',1,'Reforma','Queretaro',77985,136)


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
INSERT INTO  cliente VALUES('Manuel','Lopper',37,'Cimatario','Leon',76087,'Manuel@gmail.com')
INSERT INTO  cliente VALUES('Emerik','Porfirio Diaz ',103,'Colonia El Pueblito','Nuevo Leon',76099,'Emerik@gmail.com')
INSERT INTO  cliente VALUES('Mariana','Porfirio Diaz ',75,'Zibatá','Culiacan',76093,'Mariana@gmail.com')
INSERT INTO  cliente VALUES('Eduardo','Schuster Parkways',71,'Zakia','Tampico',76081,'Eduardo@gmail.com')
INSERT INTO  cliente VALUES('Edgar ','Xincluantia',33,'El Refugio','Caderyta',76030,'Edgar @gmail.com')
INSERT INTO  cliente VALUES('Jose','reforma',52,'El Mirador','San Miguel',76042,'Jose@gmail.com')
INSERT INTO  cliente VALUES('Victor','platon',101,'El Mirador','Leon',76009,'Victor@gmail.com')
INSERT INTO  cliente VALUES('Alfonso','Clement Parkways',66,'El Refugio','Queretaro',76067,'Alfonso@gmail.com')
INSERT INTO  cliente VALUES('Gabriel','Porfirio Diaz ',29,'Colonia Cimatario','Mazatlan',76073,'Gabriel@gmail.com')
INSERT INTO  cliente VALUES('Carlos','asente',30,'Colonia El Pueblito','Guanajuato',76025,'Carlos@gmail.com')
INSERT INTO  cliente VALUES('Platon','Burley Views',104,'Juriquilla','Hidalgo',76001,'Platon@gmail.com')
INSERT INTO  cliente VALUES('Ricardo','Ankunding Courts',27,'Zibatá','El Pueblito',76011,'Ricardo@gmail.com')
INSERT INTO  cliente VALUES('Gustavo','Gaston Inlet',108,'Sonterra','San Luis Potosi',76051,'Gustavo@gmail.com')
INSERT INTO  cliente VALUES('Isac','Ila Turnpike',88,'Juriquilla','Monterrey',76066,'Isac@gmail.com')
INSERT INTO  cliente VALUES('Jacobo','santisima',44,'Zibatá','Aguascalientes',76022,'Jacobo@gmail.com')
INSERT INTO  cliente VALUES('Armando','Dickens Fords',100,'Sonterra','Ensenada',76064,'Armando@gmail.com')
INSERT INTO  cliente VALUES('Juan','asente',100,'Zakia','Tijuana',76017,'Juan@gmail.com')
INSERT INTO  cliente VALUES('Akinori','Xincluantia',25,'El Refugio','La paz ',76085,'Akinori@gmail.com')
INSERT INTO  cliente VALUES('Jesus','Altenwerth Crossing',38,'El Mirador','Queretaro',76037,'Jesus@gmail.com')
INSERT INTO  cliente VALUES('Daniel','Clement Parkways',79,'El Mirador','Queretaro',76098,'Daniel@gmail.com')
INSERT INTO  cliente VALUES('Javier','Ila Turnpike',20,'El Mirador','Queretaro',76023,'Javier@gmail.com')
INSERT INTO  cliente VALUES('Fabian','Miller Forge',32,'El Mirador','Queretaro',76024,'Fabian@gmail.com')
INSERT INTO  cliente VALUES('Nadia','Gaston Inlet',35,'Sonterra','Celaya',76010,'Nadia@gmail.com')
INSERT INTO  cliente VALUES('Evelia','Schuster Parkways',99,'Jurica','Pozos',76089,'Evelia@gmail.com')
INSERT INTO  cliente VALUES('Ana','Burley Views',73,'Juriquilla','Villa Carbon',76099,'Ana@gmail.com')
INSERT INTO  cliente VALUES('María',' Isabel Harbors',107,'Zibatá','Hidalgo',76084,'María@gmail.com')
INSERT INTO  cliente VALUES('Frank','Ankunding Courts',59,'Sonterra','Mazatlan',76021,'Frank@gmail.com')
INSERT INTO  cliente VALUES('Castillo','Darrin Loop',103,'Juriquilla','Nuevo Vallarta',76019,'Castillo@gmail.com')
INSERT INTO  cliente VALUES('Javier','Ernser Camp',45,'El Mirador','Nayarith',76061,'Javier@gmail.com')
INSERT INTO  cliente VALUES('Martin','Brad Hills',51,'El Refugio','Monterrey',76054,'Martin@gmail.com')
INSERT INTO  cliente VALUES('Marth','Porfirio Diaz ',42,'Colonia Cimatario','Celaya',76076,'Marth@gmail.com')
INSERT INTO  cliente VALUES('Francisco','Darrin Loop',22,'Agustín Yánez','Guanajuato',76011,'Francisco@gmail.com')
INSERT INTO  cliente VALUES('Dorian','Ankunding Courts',87,'Belisario Domínguez','CDMX',76033,'Dorian@gmail.com')
INSERT INTO  cliente VALUES('Luis','Lopper',32,'mapaBenito Juárez','Leon',76024,'Luis@gmail.com')
INSERT INTO  cliente VALUES('Rodolfo','Porfirio Diaz ',77,'mapaBertha Cuervo de Jaredo','Queretaro',76023,'Rodolfo@gmail.com')
INSERT INTO  cliente VALUES('Megan','asente',16,'mapaBethel','Mazatlan',76071,'Megan@gmail.com')
INSERT INTO  cliente VALUES('Drake',' Isabel Harbors',56,'Rosario','Aguascalientes',76033,'Drake@gmail.com')
INSERT INTO  cliente VALUES('Josh','Ankunding Courts',47,'Alcanfore','Ciudad de México',76080,'Josh@gmail.com')
INSERT INTO  cliente VALUES('Carla','Schuster Parkways',81,'Jurica','Leon',76012,'Carla@gmail.com')
INSERT INTO  cliente VALUES('Venustiani','Xincluantia',93,'Juriquilla','Aguascalientes',76059,'Venustiani@gmail.com')
INSERT INTO  cliente VALUES('Jupiter','Brad Hills',92,'Zibatá','Puebla',76030,'Jupiter@gmail.com')
INSERT INTO  cliente VALUES('Fernanda','Porfirio Diaz ',81,'mapaBethel','Pinal de Amoles',76082,'Fernanda@gmail.com')
INSERT INTO  cliente VALUES('monserrat','Darrin Loop',97,'Rosario','Marques',76094,'monserrat@gmail.com')
INSERT INTO  cliente VALUES('Casimiro','santisima',35,'Alcanfore','Peña Miguel',76066,'Casimiro@gmail.com')
INSERT INTO  cliente VALUES('Robin','Dickens Fords',96,'mapaBenito Juárez','Campeche ',76090,'Robin@gmail.com')
INSERT INTO  cliente VALUES('Julio','Gaston Inlet',31,'mapaBertha Cuervo de Jaredo','Merida',76091,'Julio@gmail.com')
INSERT INTO  cliente VALUES('Cesar','Schuster Parkways',55,'old road','Zapopan',76062,'Cesar@gmail.com')
INSERT INTO  cliente VALUES('Germanio','Burley Views',21,'freelan','Cuernavaca',76095,'Germanio@gmail.com')
INSERT INTO  cliente VALUES('Aron','Berkly Oak',97,'cantera','Monterrey',76002,'Aron@gmail.com')
INSERT INTO  cliente VALUES('Ilda','AV. De la luz',108,'carrera','Queretaro',76046,'Ilda@gmail.com')


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
insert into vendedor values('Juan Cesar','10-10-2020','7-7-2000','Primaria');
insert into vendedor values('Juan Brayan','10-10-2020','6-8-1999','secundaria');
insert into vendedor values('Juan Humberto','10-10-2020','2-2-1995','Primaria');
insert into vendedor values('Juan Mateo','10-10-2020','7-8-2001','secundaria');
insert into vendedor values('Juan Jeronimo','10-10-2020','9-7-1990','Primaria');
insert into vendedor values('Juan Pedro','10-10-2020','7-9-1992','secundaria');
insert into vendedor values('Juan Julian','10-10-2020','7-1-1989','Primaria');
insert into vendedor values('Juan Emerik','10-10-2020','3-7-1978','secundaria');
insert into vendedor values('Juan Omar','10-10-2020','5-1-1982','secundaria');
insert into vendedor values('Juan Escutia','10-10-2020','4-7-1985','Primaria');
insert into vendedor values('Juan Raul','10-10-2020','7-7-2000','Primaria');
insert into vendedor values('Juan Oscar','10-10-2020','6-8-1999','secundaria');
insert into vendedor values('Juan Kilian','10-10-2020','2-2-1995','Primaria');
insert into vendedor values('Juan Brian','10-10-2020','7-8-2001','secundaria');
insert into vendedor values('Juan Aron','10-10-2020','9-7-1990','Primaria');
insert into vendedor values('Juan Abdiel','10-10-2020','7-9-1992','secundaria');
insert into vendedor values('Juan Mario','10-10-2020','7-1-1989','Primaria');
insert into vendedor values('Juan Caesar','10-10-2020','3-7-1978','secundaria');
insert into vendedor values('Juan Alejandro','10-10-2020','5-1-1982','secundaria');
insert into vendedor values('Juan Abel','10-10-2020','4-7-1985','Primaria');
insert into vendedor values('Juan Alan','10-10-2020','7-7-2000','Primaria');
insert into vendedor values('Juan Aldo','10-10-2020','6-8-1999','secundaria');
insert into vendedor values('Juan cristopher','10-10-2020','2-2-1995','Primaria');
insert into vendedor values('Juan Hidam','10-10-2020','7-8-2001','secundaria');
insert into vendedor values('Juan Hiran','10-10-2020','9-7-1990','Primaria');
insert into vendedor values('Juan Himran','10-10-2020','7-9-1992','secundaria');
insert into vendedor values('Juan Agustin','10-10-2020','7-1-1989','Primaria');
insert into vendedor values('Juan jared','10-10-2020','3-7-1978','secundaria');
insert into vendedor values('Juan Armando','10-10-2020','5-1-1982','secundaria');
insert into vendedor values('Juan Shikamaru','10-10-2020','4-7-1985','Primaria');
insert into vendedor values('Juan Sasuke','10-10-2020','7-7-2000','Primaria');
insert into vendedor values('Juan Naruto','10-10-2020','6-8-1999','secundaria');
insert into vendedor values('Juan Meliodas','10-10-2020','2-2-1995','Primaria');
insert into vendedor values('Juan Aramis','10-10-2020','7-8-2001','secundaria');
insert into vendedor values('Juan Angel','10-10-2020','9-7-1990','Primaria');
insert into vendedor values('Juan Armin','10-10-2020','7-9-1992','secundaria');
insert into vendedor values('Juan Eren','10-10-2020','7-1-1989','Primaria');
insert into vendedor values('Juan Zoro','10-10-2020','3-7-1978','secundaria');
insert into vendedor values('Juan Luffy','10-10-2020','5-1-1982','secundaria');
insert into vendedor values('Juan Calazar','10-10-2020','4-7-1985','Primaria');
insert into vendedor values('Juan Porfirio','10-10-2020','7-7-2000','Primaria');
insert into vendedor values('Juan Arquimedes','10-10-2020','6-8-1999','secundaria');
insert into vendedor values('Juan Victor','10-10-2020','2-2-1995','Primaria');
insert into vendedor values('Juan Manuel','10-10-2020','7-8-2001','secundaria');
insert into vendedor values('Juan MIguel','10-10-2020','9-7-1990','Primaria');
insert into vendedor values('Juan Moises','10-10-2020','7-9-1992','secundaria');
insert into vendedor values('Juan Alvaro','10-10-2020','7-1-1989','Primaria');
insert into vendedor values('Juan Alonso','10-10-2020','3-7-1978','secundaria');
insert into vendedor values('Juan Benito','10-10-2020','5-1-1982','secundaria');
insert into vendedor values('Juan Gerardo','10-10-2020','4-7-1985','Primaria');

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
INSERT INTO venta values('2000-01-02',580,'15',1,2,3);
INSERT INTO venta values('2000-02-01',670,'10',2,3,1);
INSERT INTO venta values('2000-03-01',1000,'45',1,1,1);
INSERT INTO venta values('2000-01-03',890,'30',2,2,2);
INSERT INTO venta values('2000-04-02',123,'8',3,3,3);
INSERT INTO venta values('2000-05-04',89,'5',3,2,1);
INSERT INTO venta values('2000-07-03',500,'23',4,5,6);
INSERT INTO venta values('2002-01-01',600,'45',5,6,4);
INSERT INTO venta values('2002-02-05',456,'15',6,3,2);
INSERT INTO venta values('2003-08-02',665,'13',8,12,78);
INSERT INTO venta values('2004-08-05',987,'30',10,18,140);
INSERT INTO venta values('2002-12-01',1500,'78',9,18,98);
INSERT INTO venta values('2009-11-05',8654,'89',7,12,87);
INSERT INTO venta values('2012-01-02',2500,'50',5,15,23);
INSERT INTO venta values('2011-02-09',111,'65',4,16,100);
INSERT INTO venta values('2008-06-04',369,'18',3,18,88);
INSERT INTO venta values('2009-05-02',454,'12',9,17,150);
INSERT INTO venta values('2020-03-01',999,'45',8,33,78);
INSERT INTO venta values('2019-09-09',378,'67',7,7,7);
INSERT INTO venta values('2019-06-03',500,'25',8,8,8);
INSERT INTO venta values('2018-08-09',680,'9',9,9,9);
INSERT INTO venta values('2019-01-24',3789,'80',10,4,92);
INSERT INTO venta values('2020-11-06',444,'23',1,2,55);
INSERT INTO venta values('2015-10-04',1000,'14',10,10,10);
INSERT INTO venta values('2014-09-01',2500,'65',9,12,130);
INSERT INTO venta values('2000-11-25',400,'2',7,15,66);
INSERT INTO venta values('2015-10-01',345,'6',2,14,56);
INSERT INTO venta values('2011-01-27',5677,'15',3,18,75);
INSERT INTO venta values('2004-06-30',918,'12',6,1,68);
INSERT INTO venta values('2001-12-12',5432,'65',1,2,123);
INSERT INTO venta values('2021-03-08',555,'9',2,20,25);
INSERT INTO venta values('2021-02-12',666,'5',1,11,112);
INSERT INTO venta values('2021-01-30',777,'4',2,12,89);
INSERT INTO venta values('2020-06-15',888,'12',3,4,67);
INSERT INTO venta values('2019-04-12',999,'01',4,18,90);
INSERT INTO venta values('2018-08-30',1000,'25',5,15,99);
INSERT INTO venta values('2020-01-18',4567,'32',6,18,105);
INSERT INTO venta values('2015-09-09',1234,'25',6,18,45);
INSERT INTO venta values('2020-02-14',994,'15',5,5,55);
INSERT INTO venta values('2005-02-02',1001,'18',6,6,66);
INSERT INTO venta values('2006-03-23',444,'2',3,13,113);
INSERT INTO venta values('2005-09-28',3333,'56',4,14,102);
INSERT INTO venta values('2007-07-17',2222,'35',5,15,105);
INSERT INTO venta values('2006-06-15',111,'12',6,12,101);
INSERT INTO venta values('2005-05-06',1432,'45',7,17,117);
INSERT INTO venta values('2004-01-23',542,'8',8,16,100);
INSERT INTO venta values('2004-12-30',8765,'45',9,9,97);
INSERT INTO venta values('2003-12-25',4563,'76',10,10,44);
INSERT INTO venta values('2003-12-23',5670,'67',1,12,2);
INSERT INTO venta values('2003-12-12',333,'5',3,12,1);

----------------------------------------------------------------------------------------------------------
--INSERTS PARA REVISAR FUNCIONAMIENTO DE LAS RESTRICCIONES
---------------------------------------------------------------------------------------------------------
INSERT INTO  producto VALUES('Helado de chocolate',-12,1) --no se aceptan precios menores a cero
select*from producto
insert into proveedor values ('Turin','calle 208 ',250,'Reforma','Queretaro',763859,23)--El codigo postal solo puede contener 5digitos
insert into proveedor values ('Gamesa','calle 208 ',250,'Reforma','Queretaro',76385,23)--No debe repetirse el nombre del proveedor
select*from proveedor
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

select p.nombre as Producto,pr.nombre as Proveedor,p.precio from producto as p
cross join proveedor as pr

---------------------------------------------------------------------------
--JOINS MULTIPLES
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

select p.nombre as Producto,pr.nombre as Proveedor, p.precio, c.nombre as cliente, v.fecha as "fecha de venta" from producto as p
 cross join proveedor as pr 
 cross join venta as v 
 cross join cliente as c 

 
 ---------------------------------------------------------------------------
--Todas las tablas juntas
---------------------------------------------------------------------------

 select* from venta,cliente,proveedor,vendedor,categoria



