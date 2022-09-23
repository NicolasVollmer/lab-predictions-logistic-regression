
USE sakila;

# I would want film + category id
SELECT f.film_id, f.title, f.release_year, f.rental_duration, f.rental_rate, f.length, f.rating, 
c.name AS category, count(i.film_id) AS stock, count(r.inventory_id) AS times_rented FROM sakila.film f 
	JOIN sakila.film_category fc ON f.film_id = fc.film_id 
	JOIN sakila.category c ON fc.category_id = c.category_id
	JOIN sakila.inventory i ON f.film_id = i.film_id  
	JOIN sakila.rental r ON i.inventory_id = r.inventory_id
	GROUP BY f.film_id, f.title, f.release_year, f.rental_duration, f.rental_rate, f.length, f.rating, category
	ORDER BY f.film_id;


SELECT f.film_id, COUNT(r.rental_id) AS rented_times, f.length, f.rental_rate, f.rental_duration, c.name as category, f.length,
f.rating, f.rental_rate,
CASE
    WHEN r.rental_date BETWEEN '2005-05-01' AND '2005-05-31' THEN True
    ELSE False END AS may
FROM sakila.film f
Left JOIN inventory i
    ON f.film_id = i.film_id
JOIN sakila.rental r
    ON i.inventory_id = r.inventory_id
Join sakila.film_category fc
    On fc.film_id = f.film_id
Join sakila.category c
    On c.category_id = fc.category_id
Where r.rental_date Between '2005-01-01' AND '2005-12-31'
GROUP BY f.film_id,f.length,f.rental_rate,f.rental_duration, category, f.length,f.rating, f.rental_rate;


SELECT i.film_id, COUNT(*) AS rental_count, f.title
FROM rental r
JOIN inventory i
USING (inventory_id)
JOIN film f
USING (film_id)
WHERE rental_date NOT BETWEEN '2005-05-01 00:00:00' AND '2005-05-31 23:23:59'
GROUP BY film_id;

SELECT f.film_id, COUNT(r.rental_id) rented_times,f.rental_duration, c.name as category, f.length,
f.rating, f.special_features, f.rental_rate, l.name AS language,
CASE
    WHEN r.rental_date BETWEEN '2005-05-01' AND '2005-05-31' THEN True
    ELSE False END AS may
FROM sakila.film f
Left JOIN inventory i
    ON f.film_id = i.film_id
JOIN sakila.rental r
    ON i.inventory_id = r.inventory_id
Join sakila.film_category fc
    On fc.film_id = f.film_id
Join sakila.category c
    On c.category_id = fc.category_id
Join sakila.language l
    On l.language_id = f.language_id
Where r.rental_date Between '2005-01-01' AND '2005-12-31'
GROUP BY film_id, rental_duration,category, f.length, f.rating, may, f.special_features,f.rental_rate, language;