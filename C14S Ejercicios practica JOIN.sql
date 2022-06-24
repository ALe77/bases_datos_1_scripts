-- 1) ¿Cuántos clientes existen?
SELECT COUNT(ClienteID)
FROM CLIENTES;
-- 91

-- 2) ¿Cuántos clientes hay por ciudad?
SELECT COUNT(ClienteID), Ciudad
FROM Clientes
GROUP BY ciudad;

-- Facturas
-- 1) ¿Cuál es el total de transporte?
SELECT sum(Transporte)
from facturas;

-- 2) ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?
SELECT sum(Transporte), EnvioVia
from facturas
group by EnvioVia;

-- 3) Calcular la cantidad de facturas por cliente. 
-- Ordenar descendentemente por cantidad de facturas.
SELECT count(FacturaID) as Facturas, ClienteID
from facturas
group by ClienteID
order by Facturas desc;

-- 4) Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.
SELECT count(FacturaID) as Facturas, ClienteID
from facturas
group by ClienteID
order by Facturas desc
limit 5;

-- 5) ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?
SELECT count(FacturaID) as Facturas, PaisEnvio
from facturas
group by PaisEnvio
order by Facturas;

-- 6) Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado
-- realizó más operaciones de ventas?
SELECT count(FacturaID) as Facturas, EmpleadoID
from facturas
group by EmpleadoID
order by Facturas desc
limit 1;

-- Factura detalle
-- 1) ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?
select count(FacturaID) as Facturas, ProductoID
from facturadetalle
group by ProductoID
order by Facturas desc;

-- 2) ¿Cuál es el total facturado? Considerar que el total facturado es la suma de
-- cantidad por precio unitario.
select count(FacturaID) as Facturas, ProductoID, (Cantidad*PrecioUnitario)
from facturadetalle
group by ProductoID
order by Facturas desc;

/*select count(FacturaID) as Facturas, ProductoID, count(Cantidad) AS cantidad , PrecioUnitario ,(cantidad*PrecioUnitario) 
from facturadetalle
group by ProductoID
order by Facturas desc;*/


-- 3) ¿Cuál es el total facturado para los productos ID entre 30 y 50?
select SUM(Cantidad*PrecioUnitario), ProductoID
from facturadetalle
where ProductoID between 30 and 50;

-- 4) ¿Cuál es el precio unitario promedio de cada producto?
SELECT avg(PrecioUnitario), ProductoID
from facturadetalle
group by ProductoID;

-- 5) ¿Cuál es el precio unitario máximo?
SELECT max(PrecioUnitario)
from facturadetalle;

-- JOINS
-- 1) Generar un listado de todas las facturas del empleado 'Buchanan'.
SELECT apellido, nombre, facturaID
from empleados e
inner join facturas f on f.EmpleadoID=e.EmpleadoID 
where apellido = 'Buchanan';

-- 2) Generar un listado con todos los campos de las facturas del correo 'Speedy Express'.
select f.* , c.compania
from facturas f
inner join correos c on c.CorreoID=f.EnvioVia
where c.Compania = 'Speedy Express';

-- 3) Generar un listado de todas las facturas con el nombre y apellido de los empleados.
select f.* , e.Apellido, e.Nombre from facturas f
inner join empleados e on e.EmpleadoID = f.EmpleadoID;

-- 4) Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.
select f.* from facturas f
inner join clientes c on c.ClienteID = f.ClienteID
where c.Titulo = 'Owner' and f.PaisEnvio = 'USA';

-- 5) Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = “42”.
select f.* , e.Apellido, fd.ProductoID from facturas f
inner join empleados e on e.EmpleadoID = f.EmpleadoID
inner join facturadetalle fd on fd.facturaid = f.facturaid
where e.Apellido like '%Leverling%' or fd.productoid = 42;

-- 6) Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” y que incluya los producto id = “80” o ”42”.
select f.* , e.Apellido, fd.ProductoID from facturas f
inner join empleados e on e.EmpleadoID = f.EmpleadoID
inner join facturadetalle fd on fd.facturaid = f.facturaid
where e.Apellido like '%Leverling%' and fd.productoid in (80,42);

-- 7) Generar un listado con los cinco mejores clientes, según sus importes de compras total (PrecioUnitario * Cantidad).
select c.* , (fd.preciounitario*fd.cantidad) as Total from facturas f
inner join clientes c on c.ClienteID =  f.ClienteID
inner join facturadetalle fd on fd.FacturaID = f.FacturaID
order by Total desc
limit 5;

-- 8) Generar un listado de facturas, con los campos id, nombre y apellido del cliente, fecha de factura, país de envío, Total, ordenado de manera descendente por fecha de factura y limitado a 10 filas.
select c.clienteid, c.contacto, f.fechafactura, f.paisenvio, (fd.preciounitario*fd.cantidad) as total  from facturas f
inner join clientes c on c.clienteid = f.ClienteID
inner join facturadetalle fd on fd.FacturaID = f.FacturaID
order by f.fechafactura desc
limit 10


