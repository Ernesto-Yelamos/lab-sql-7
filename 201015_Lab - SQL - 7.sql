-- Lab | SQL Queries 7
USE sakila;

### Instructions
	-- 1. Which last names are not repeated?
-- Checking names of actors
SELECT last_name , COUNT(*) AS 'Count' from sakila.actor
GROUP BY last_name
HAVING COUNT(*) = 1;

	-- 2. Which last names appear more than once?
SELECT last_name , COUNT(*) AS 'Count' from sakila.actor
GROUP BY last_name
HAVING COUNT(*) > 1;

	-- 3. Rentals by employee.
SELECT staff_id, count(rental_id) AS 'Rentals' FROM sakila.rental
GROUP BY staff_id
ORDER BY staff_id;

	-- 4. Films by year.
SELECT release_year, title FROM sakila.film
ORDER BY release_year;

SELECT release_year, count(title) AS 'Amount' FROM sakila.film
GROUP BY release_year
ORDER BY release_year;	-- This will give me the count of movies per year.

	-- 5. Films by rating.
SELECT rating, title FROM sakila.film
ORDER BY rating;

SELECT rating, count(title) AS 'Amount' FROM sakila.film
GROUP BY rating
ORDER BY rating; 	-- This returns the amount of films in each rating category.

	-- 6. Mean length by rating.
SELECT rating, AVG(length) AS 'Average_length'
FROM sakila.film
GROUP BY rating;

	-- 7. Which kind of movies (rating) have a mean duration of more than two hours?
SELECT rating, AVG(length) AS 'Average_length'
FROM sakila.film
GROUP BY rating
HAVING Average_length > 120;

	-- 8. List movies and add information of average duration for their rating and original language.
SELECT title, language_id, rating, length, 
AVG(length) OVER (partition by rating) AS "Average_Duration"
FROM sakila.film
order by rating, length, language_id;

	-- 9. Which rentals are longer than expected?
SELECT rental_id, DATEDIFF(return_date, rental_date) AS 'Rental Length' FROM sakila.rental;

SELECT inventory_id, rental_id, DATEDIFF(return_date, rental_date) AS 'Rental Length', 
AVG(DATEDIFF(return_date, rental_date)) OVER (partition by inventory_id) AS "Average_Duration"
FROM sakila.rental
WHERE DATEDIFF(return_date, rental_date) > "Average_Duration"
ORDER BY inventory_id; 	-- Each movie is linked to an inventory ID, so we check the average duration grouped (PARTITION) by inventory ID
