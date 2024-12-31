#-------------------Easy--------------------
-- Q1. Who is the senior most employee based on job title?

SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1;

-- Q2. Which countries have the most invoices?

SELECT COUNT(*) AS c,billing_country 
FROM invoice
GROUP BY billing_country
ORDER BY c DESC;

-- Q3. What are the top 3 values of total invoice?

SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

-- Q4. WAQ which returns one city that has the highest sum of total invoice (return from both city name & sum of invoice).

SELECT billing_city , SUM(total) as sum_of_invoices
FROM invoice 
Group BY billing_city 
ORDER BY sum_of_invoices DESC 
LIMIT 1;

-- Q5. WAQ that returns the person who has spent most money.

SELECT customer.customer_id, customer.first_name, customer.last_name, 
sum(invoice.total) as total
from customer
JOIN invoice ON customer.customer_id= invoice.customer_id
Group by customer.customer_id
Order by total Desc
Limit 1;

-- Q6.WAQ to return the songs name having length longer than avg.song length (Return name and milliseconds and oredr by song length)

Select name , milliseconds From track
Where milliseconds > (
    Select AVG(milliseconds) AS avg_track_len
	From track)
ORDER BY milliseconds DESC;

#-------------------Moderate--------------------

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */


SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoiceline ON invoice.invoice_id = invoiceline.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;


/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT name,miliseconds
FROM track
WHERE miliseconds > (
	SELECT AVG(miliseconds) AS avg_track_length
	FROM track )
ORDER BY miliseconds DESC;