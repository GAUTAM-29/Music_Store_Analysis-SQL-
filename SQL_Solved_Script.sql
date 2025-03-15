use music_database;
-- Question set 1 - Moderate

-- Q1. Who is the senior most employee based on job title?

SELECT employee_id,last_name,title FROM employee ORDER BY levels DESC LIMIT 1;

-- Q2. Which countries have the most Invoices?

SELECT COUNT(*) AS invoice_count,billing_country FROM invoice 
group by billing_country order by invoice_count desc;

-- Q3. What are top 3 values of total invoice?

SELECT TOTAL  FROM invoice ORDER BY total desc LIMIT 3;

/* Q4. Which city has the best customers? We would like to throw a promotional Music
Festival in the city we made the most money. Write a query that returns one city that
has the highest sum of invoice totals. Return both the city name & sum of all invoice
totals. */

SELECT billing_city,SUM(total) AS invoice_total FROM invoice 
group by billing_city order by invoice_total desc limit 1;

/* Q5. Who is the best customer? The customer who has spent the most money will be
declared the best customer. Write a query that returns the person who has spent the
most money. */

SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent FROM customer c 
JOIN invoice i ON c.customer_id = i.customer_id GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC LIMIT 1;

-- Question set 2 - Moderate

/* Q1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
Return your list ordered alphabetically by email starting with A.  */
 
 SELECT DISTINCT c.email, c.first_name, c.last_name, g.name AS genre FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id        -- customer ⋈ invoice 
JOIN invoice_line il ON i.invoice_id = il.invoice_id   -- invoice ⋈ invoice_line_id
JOIN track t ON il.track_id = t.track_id               -- invoice_line ⋈ track 
JOIN genre g ON t.genre_id = g.genre_id                -- track ⋈ genre
WHERE g.name = 'Rock'
ORDER BY c.email Asc;

/* Q2. Let's invite the artists who have written the most rock music in our dataset. Write a
query that returns the Artist name and total track count of the top 10 rock bands.  */ 

SELECT a.name AS artist_name, COUNT(t.track_id) AS rock_track_count
FROM artist a
JOIN album al ON a.artist_id = al.artist_id      -- artist ⋈ album
JOIN track t ON al.album_id = t.album_id         -- album ⋈ track
JOIN genre g ON t.genre_id = g.genre_id          -- track ⋈ genre
WHERE g.name = 'Rock'
GROUP BY a.artist_id, a.name
ORDER BY rock_track_count DESC
LIMIT 10;

/* Q3. Return all the track names that have a song length longer than the average song length.
Return the Name and Milliseconds for each track. Order by the song length with the
longest songs listed first. */ 

SELECT name, milliseconds FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track) -- AVG(milliseconds) = 251177.7431
ORDER BY milliseconds DESC;

-- Question set 3 - Advance

/* Q1. Find how much amount spent by each customer on artists? Write a query to return
customer name, artist name and total spent. */


WITH CustomerSpending AS ( -- Creating a CTE to calculates the total amount each customer has spent on each artist.
SELECT c.first_name,last_name, a.name AS artist_name, 
SUM(il.unit_price * il.quantity) AS total_spent 
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id            -- customer ⋈ invoice
JOIN invoice_line il ON i.invoice_id = il.invoice_id       -- invoice ⋈ invoice_line_id
JOIN track t ON il.track_id = t.track_id                   -- invoice_line ⋈ track
JOIN album al ON t.album_id = al.album_id                  -- track ⋈ album
JOIN artist a ON al.artist_id = a.artist_id                -- album ⋈ artist
GROUP BY c.customer_id, c.first_name, c.last_name, a.artist_id, a.name
)
SELECT * FROM CustomerSpending
ORDER BY total_spent DESC;

/* Q2. We want to find out the most popular music Genre for each country. We determine the
most popular genre as the genre with the highest amount of purchases. Write a query
that returns each country along with the top Genre. For countries where the maximum
number of purchases is shared return all Genres. */

WITH GenrePurchase AS (                -- creating CTE for counts purchases per genre per country.
    SELECT cu.country, g.name AS genre_name, COUNT(il.invoice_line_id) AS purchase_count
    FROM customer cu
    JOIN invoice i ON cu.customer_id = i.customer_id       -- customer ⋈ invoice
    JOIN invoice_line il ON i.invoice_id = il.invoice_id   -- invoice ⋈ invoice_line_id
    JOIN track t ON il.track_id = t.track_id               -- invoice_line ⋈ track
    JOIN genre g ON t.genre_id = g.genre_id                -- track ⋈ genre
    GROUP BY cu.country, g.genre_id, g.name
),
MaxGenre AS (        -- creating CTE to find the maximum purchase count per country
    SELECT country, MAX(purchase_count) AS max_purchases
    FROM GenrePurchase
    GROUP BY country
)
SELECT gp.country, gp.genre_name, gp.purchase_count
FROM GenrePurchase gp
JOIN MaxGenre mg ON gp.country = mg.country AND gp.purchase_count = mg.max_purchases
ORDER BY gp.country;

/* Q3. Write a query that determines the customer that has spent the most on music for each
country. Write a query that returns the country along with the top customer and how
much they spent. For countries where the top amount spent is shared, provide all
customers who spent this amount. */

WITH CustomerSpending AS (  -- CTE to Calculates the total amount spent by each customer in their respective country
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        c.country, 
        SUM(il.unit_price * il.quantity) AS total_spent
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id           -- customer ⋈ invoice
    JOIN invoice_line il ON i.invoice_id = il.invoice_id      -- invoice ⋈ invoice_line_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.country
),
MaxSpending AS (               -- CTE to find the highest spending amount for each country.
    SELECT country, MAX(total_spent) AS max_spent
    FROM CustomerSpending
    GROUP BY country
)
SELECT cs.country, cs.first_name, cs.last_name, cs.total_spent
FROM CustomerSpending cs
JOIN MaxSpending ms ON cs.country = ms.country AND cs.total_spent = ms.max_spent
ORDER BY cs.total_spent DESC;


/* --------------------------------------------------   This Project Ends Here   -------------------------------------------------- */

