-- ===================================================================
-- SQL Sample Queries: Sakila Database
-- ===================================================================
-- Demonstrates SQL fundamentals using the Sakila sample database.
-- Skills: SELECT, JOINs, Aggregations, Subqueries, Data Analysis
-- ===================================================================

-- ===================================================================
-- 1. BASIC SELECT QUERIES
-- ===================================================================

-- Find all customers with their contact information
SELECT 
    FirstName,
    LastName,
    EmailAddress
FROM Person.Person
ORDER BY LastName, FirstName;

-- Get films longer than 2 hours
SELECT 
    title AS FilmTitle,
    length AS DurationMinutes
FROM film
WHERE length > 120
ORDER BY length DESC;

-- Find customers in a specific city
SELECT 
    c.first_name AS FirstName,
    c.last_name AS LastName,
    ci.city AS City
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
WHERE ci.city = 'London';

-- ===================================================================
-- 2. JOIN QUERIES
-- ===================================================================

-- List films with their categories
SELECT 
    f.title AS FilmTitle,
    c.name AS Category
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON fc.category_id = c.category_id
ORDER BY c.name, f.title;

-- Find all actors in a specific film
SELECT 
    f.title AS FilmTitle,
    a.first_name AS ActorFirstName,
    a.last_name AS ActorLastName
FROM film f
INNER JOIN film_actor fa ON f.film_id = fa.film_id
INNER JOIN actor a ON fa.actor_id = a.actor_id
WHERE f.title = 'ACADEMY DINOSAUR'
ORDER BY a.last_name;

-- Customer rental history with film details
SELECT 
    c.first_name || ' ' || c.last_name AS CustomerName,
    f.title AS FilmRented,
    r.rental_date AS RentalDate,
    r.return_date AS ReturnDate
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
WHERE c.customer_id = 1
ORDER BY r.rental_date DESC;

-- ===================================================================
-- 3. AGGREGATE FUNCTIONS & GROUP BY
-- ===================================================================

-- Count films per category
SELECT 
    c.name AS Category,
    COUNT(fc.film_id) AS TotalFilms
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
ORDER BY TotalFilms DESC;

-- Calculate total revenue by customer (Top 10)
SELECT 
    c.first_name || ' ' || c.last_name AS CustomerName,
    COUNT(p.payment_id) AS TotalRentals,
    SUM(p.amount) AS TotalRevenue
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY TotalRevenue DESC
LIMIT 10;

-- Average film length by category
SELECT 
    c.name AS Category,
    ROUND(AVG(f.length), 2) AS AvgLength,
    MIN(f.length) AS ShortestFilm,
    MAX(f.length) AS LongestFilm
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY AvgLength DESC;

-- Monthly revenue analysis
SELECT 
    DATE_TRUNC('month', payment_date) AS Month,
    COUNT(payment_id) AS Transactions,
    SUM(amount) AS Revenue
FROM payment
GROUP BY DATE_TRUNC('month', payment_date)
ORDER BY Month;

-- ===================================================================
-- 4. SUBQUERIES
-- ===================================================================

-- Films with above-average rental rates
SELECT 
    title AS FilmTitle,
    rental_rate AS RentalRate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film
)
ORDER BY rental_rate DESC;

-- Find the most active customer's rentals
SELECT 
    f.title AS FilmTitle,
    f.rental_rate AS RentalRate
FROM film f
WHERE f.film_id IN (
    SELECT DISTINCT i.film_id
    FROM rental r
    INNER JOIN inventory i ON r.inventory_id = i.inventory_id
    WHERE r.customer_id = (
        SELECT customer_id
        FROM rental
        GROUP BY customer_id
        ORDER BY COUNT(rental_id) DESC
        LIMIT 1
    )
)
ORDER BY f.title;

-- Customers who have never rented
SELECT 
    c.first_name || ' ' || c.last_name AS CustomerName,
    c.email AS Email
FROM customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM rental r
    WHERE r.customer_id = c.customer_id
);

-- ===================================================================
-- 5. ADVANCED QUERIES
-- ===================================================================

-- Top 5 most popular actors by rental count
SELECT 
    a.first_name || ' ' || a.last_name AS ActorName,
    COUNT(r.rental_id) AS TimesRented
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY TimesRented DESC
LIMIT 5;

-- Store performance comparison
SELECT 
    s.store_id AS StoreID,
    COUNT(r.rental_id) AS TotalRentals,
    SUM(p.amount) AS TotalRevenue,
    CASE 
        WHEN SUM(p.amount) > 30000 THEN 'High Performer'
        WHEN SUM(p.amount) > 20000 THEN 'Medium Performer'
        ELSE 'Low Performer'
    END AS PerformanceCategory
FROM store s
INNER JOIN staff st ON s.store_id = st.store_id
INNER JOIN rental r ON st.staff_id = r.staff_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY s.store_id;

-- Customer lifetime value with ranking
SELECT 
    c.customer_id AS CustomerID,
    c.first_name || ' ' || c.last_name AS CustomerName,
    COUNT(r.rental_id) AS TotalRentals,
    SUM(p.amount) AS LifetimeValue,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS ValueRank
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY LifetimeValue DESC
LIMIT 10;

-- Inventory turnover rate analysis
SELECT 
    f.title AS FilmTitle,
    COUNT(DISTINCT i.inventory_id) AS TotalCopies,
    COUNT(r.rental_id) AS TimesRented,
    ROUND(
        COUNT(r.rental_id)::numeric / 
        NULLIF(COUNT(DISTINCT i.inventory_id), 0), 
        2
    ) AS TurnoverRate
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(DISTINCT i.inventory_id) > 0
ORDER BY TurnoverRate DESC
LIMIT 20;

-- ===================================================================
-- 6. DATA MODIFICATION
-- ===================================================================

-- Insert new customer
INSERT INTO customer (
    store_id,
    first_name,
    last_name,
    email,
    address_id,
    active,
    create_date
) VALUES (
    1,
    'John',
    'Doe',
    'john.doe@example.com',
    1,
    1,
    CURRENT_DATE
);

-- Update customer email
UPDATE customer
SET email = 'newemail@example.com'
WHERE customer_id = 1;

-- Delete inactive customers with no rental history
DELETE FROM customer
WHERE active = 0 
AND customer_id NOT IN (
    SELECT DISTINCT customer_id 
    FROM rental
);

-- ===================================================================
-- END OF SAMPLE QUERIES
-- ===================================================================