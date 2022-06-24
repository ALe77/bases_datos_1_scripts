select * from canciones, generos
where generos.id=canciones.id_genero
and compositor = 'Willie Dixon'
and generos.nombre = 'Blues'
