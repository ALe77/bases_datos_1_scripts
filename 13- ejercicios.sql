select count(*) from clientes
where pais = 'Brazil';

select id_genero, count(*) from canciones
group by id_genero
having id_genero = 6;

select sum(total) from facturas;

select id_album, avg(milisegundos) from canciones
group by id_album;

select id, min(bytes) from canciones;

select id_cliente, sum(total) from facturas
group by id_cliente
having sum(total)>45