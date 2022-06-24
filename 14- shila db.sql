/*5. Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental),
 la cantidad de alquileres  y la suma total pagada (amount de tabla payment) 
 para el año de alquiler 2005 (rental_date de tabla rental). */

select monthname(rental.rental_date),count(rental.rental_id), sum(payment.amount) from rental
inner join payment on payment.rental_id=rental.rental_id
where YEAR(rental_date)=2005
group by monthname(rental.rental_date);
