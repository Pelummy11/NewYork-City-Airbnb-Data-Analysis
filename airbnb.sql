---Preparing the data
SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  ---Processing the data
  --- Renaming columns
  sp_rename 'ab_nyc.neighbourhood_group', 'Borough'

sp_rename 'ab_nyc.Borough', 'borough'

sp_rename 'ab_nyc.Neighbourhood', 'neighbourhood'


sp_rename 'ab_nyc.host_name', 'Name_of_host'

sp_rename 'ab_nyc.Name_of_host', 'name_of_host'

sp_rename 'ab_nyc.Name_of_listing', 'listing_name'

sp_rename 'ab_nyc.room_type', 'Listing-space_type'

sp_rename 'ab_nyc.Listing-space_type', 'Listing_space_type'

sp_rename 'ab_nyc.Listing_space_type', 'listing__type'
sp_rename 'ab_nyc.listing__type', 'listing_type'

-- Check for Null values
SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE listing_name IS NULL
 DELETE
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE listing_name IS NULL
  SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE host_id IS NULL
  SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE name_of_host IS NULL
  DELETE 
   FROM [airbnb].[dbo].[ab_nyc]
  WHERE name_of_host IS NULL
   SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE neighbourhood IS NULL
   SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE neighbourhood IS NULL
   SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE latitude IS NULL
   SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE longitude IS NULL
   SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE listing_type IS NULL
   SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE price IS NULL
   SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE minimum_nights IS NULL
  SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE number_of_reviews IS NULL
  SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE last_review IS NULL
  SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE reviews_per_month IS NULL
  SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE calculated_host_listings_count IS NULL
  SELECT *
  FROM [airbnb].[dbo].[ab_nyc]
  WHERE availability_365 IS NULL

 DELETE
FROM [airbnb].[dbo].[ab_nyc]
WHERE price =0

  --Checking for duplicate values
  SELECT listing_name
  FROM [airbnb].[dbo].[ab_nyc]
  GROUP BY listing_name
  HAVING COUNT(listing_name) >1
 ---removing the duplicate values
 WITH CTE AS
(SELECT * ,Rank() over (partition by name order by id DESC) AS Rank
 FROM [airbnb].[dbo].[ab_nyc])
  DELETE FROM CTE WHERE Rank >1

  ---Checking for distinct values
  SELECT DISTINCT(listing_name)
   FROM [airbnb].[dbo].[ab_nyc]

   SELECT DISTINCT(borough)
   FROM [airbnb].[dbo].[ab_nyc]

   SELECT DISTINCT(neighbourhood)
   FROM [airbnb].[dbo].[ab_nyc]

   SELECT DISTINCT(Name_of_host)
   FROM [airbnb].[dbo].[ab_nyc]

SELECT DISTINCT(reviews_per_month)
   FROM [airbnb].[dbo].[ab_nyc]


---Exploratory Analysis
--Borough with highest number of listing
SELECT Borough, COUNT(listing_name) AS listing
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY Borough
ORDER BY listing DESC

--- Borough with the the highest number of reviews per month
SELECT Borough, COUNT(reviews_per_month) AS reviews
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY Borough
ORDER BY reviews DESC

SELECT Borough, COUNT(number_of_reviews) AS num_reviews
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY Borough
ORDER BY num_reviews DESC

--- Each borough with the highest review per month
SELECT Borough,MAX(reviews_per_month) AS max_review
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY Borough


---Max & Min price and all neccessary information about it
SELECT MAX(price)
FROM [airbnb].[dbo].[ab_nyc]

SELECT MIN(price)
FROM [airbnb].[dbo].[ab_nyc]

SELECT price,borough,neighbourhood,number_of_reviews, name_of_host, listing_name, listing_type,minimum_nights
FROM [airbnb].[dbo].[ab_nyc]
WHERE price = 10000

SELECT price,borough,neighbourhood,number_of_reviews, name_of_host, listing_name, listing_type,minimum_nights
FROM [airbnb].[dbo].[ab_nyc]
WHERE price = 10

---Listinggs with the naximum number of reviews
SELECT MAX(number_of_reviews)
FROM [airbnb].[dbo].[ab_nyc]

SELECT number_of_reviews, price,borough,neighbourhood,name_of_host, listing_name, listing_type,minimum_nights
FROM [airbnb].[dbo].[ab_nyc]
WHERE number_of_reviews = 629

--- Listing type by listing name
SELECT listing_type, COUNT(listing_name) AS listing_type_count
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY listing_type
ORDER BY listing_type_count DESC
--- Busiest hosts by the number of listing
SELECT name_of_host, COUNT(listing_name) AS host_count
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY name_of_host
ORDER BY host_count DESC

--- Borough with the most listing, the highest and the lowest price
SELECT borough,
COUNT(listing_name) AS listing, 
MAX(price) AS max_price,  
MIN(price) AS min_price
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY borough
ORDER BY listing DESC

--- Information about the busiest host
SELECT  name_of_host,borough, 
COUNT(listing_name) AS listing_count, 
MAX(number_of_reviews) AS max_review,
MAX(price) AS max_price,
MIN(price) AS min_price
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY borough,name_of_host
HAVING name_of_host = 'Michael'
ORDER BY listing_count DESC

--- Most expensive listings and their hosts in each borough
SELECT borough,
listing_name,
price,
name_of_host,
neighbourhood,
COUNT(number_of_reviews) AS review_count
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY listing_name,price,borough,name_of_host,neighbourhood
HAVING price = 10000 AND
borough = 'Manhattan'

SELECT borough,
listing_name,
price,
name_of_host,
neighbourhood,
COUNT(number_of_reviews) AS review_count
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY listing_name,price,borough,name_of_host,neighbourhood
HAVING price = 10000 AND
borough = 'Queens'

SELECT borough,
listing_name,
price,
name_of_host,
neighbourhood,
COUNT(number_of_reviews) AS review_count
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY listing_name,price,borough,name_of_host,neighbourhood
HAVING price = 10000 AND
borough = 'Brooklyn'

SELECT MAX(price),
borough
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY borough
HAVING borough = 'Staten Island'

SELECT borough,
listing_name,
price,
name_of_host,
neighbourhood,
COUNT(number_of_reviews) AS review_count
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY listing_name,price,borough,name_of_host,neighbourhood
HAVING price = 5000 AND
borough = 'Staten Island'

SELECT MAX(price),
borough
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY borough
HAVING borough = 'Bronx'

SELECT borough,
listing_name,
price,
name_of_host,
neighbourhood,
COUNT(number_of_reviews) AS review_count
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY listing_name,price,borough,name_of_host,neighbourhood
HAVING price = 2500 AND
borough = 'Bronx'

---Neighourhood by borough
SELECT borough, COUNT(DISTINCT(neighbourhood)) AS borough_neig
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY borough
ORDER BY borough_neig DESC

--- Most expensive areain each neighbourhood
SELECT borough, listing_name, neighbourhood, MAX(price) AS max_neig 
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY borough, listing_name, neighbourhood
HAVING borough = 'Manhattan'
ORDER BY max_neig DESC

SELECT borough, listing_name, neighbourhood, MAX(price) AS max_neig 
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY borough, listing_name, neighbourhood
HAVING borough = 'Bronx'
ORDER BY max_neig DESC

SELECT borough, listing_name, neighbourhood, MAX(price) AS max_neig 
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY borough, listing_name, neighbourhood
HAVING borough = 'Queens'
ORDER BY max_neig DESC

SELECT borough, listing_name, neighbourhood, MAX(price) AS max_neig 
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY borough, listing_name, neighbourhood
HAVING borough = 'Staten Island'
ORDER BY max_neig DESC

SELECT borough, listing_name, neighbourhood, MAX(price) AS max_neig 
FROM [airbnb].[dbo].[ab_nyc]
GROUP BY borough, listing_name, neighbourhood
HAVING borough = 'Brooklyn'
ORDER BY max_neig DESC