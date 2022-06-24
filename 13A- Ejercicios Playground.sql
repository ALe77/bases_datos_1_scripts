select count(*) from movies;

select count(*) as peliculas_con_entre_3_y_7_premios from movies
where awards between 3 and 7;

select count(*) from movies
where awards between 3 and 7 
	  and rating > 7;
      
select genre_id, sum(awards),count(*) from movies
group by genre_id
having sum(awards) > 5
