SELECT f.film_id, COUNT(r.rental_id) AS times_rented, f.rental_duration, f.length,
f.rating, c.name AS category, COUNT(DISTINCT i.inventory_id) AS stock, f.rental_rate, 
	CASE
    WHEN r.rental_date BETWEEN '2005-05-01' AND '2005-05-31' THEN TRUE
    ELSE FALSE END AS may  
FROM sakila.film f
LEFT JOIN sakila.inventory i
    ON f.film_id = i.film_id
LEFT JOIN sakila.rental r
    ON i.inventory_id = r.inventory_id
JOIN sakila.film_category fc
    ON fc.film_id = f.film_id
JOIN sakila.category c
    ON c.category_id = fc.category_id
GROUP BY film_id;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT f.film_id, CASE
    WHEN r.rental_date BETWEEN '2005-05-01' AND '2005-05-31' THEN True
    ELSE False END AS may  
FROM sakila.film f
JOIN sakila.inventory i
    ON f.film_id = i.film_id
JOIN sakila.rental r
    ON i.inventory_id = r.inventory_id
GROUP BY f.film_id;
