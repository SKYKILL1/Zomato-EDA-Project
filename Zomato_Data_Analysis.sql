SELECT * FROM Zomato;

SELECT * FROM Zomato 
WHERE cuisines LIKE '%Mugh%';

--Calculate the total number of restaurants, average rating, and average cost for two people.

SELECT COUNT(*) AS TOTAL_RESTAURANTS, AVG(rating_Out_of_5) AS AVG_RATING , AVG(approx_cost_for_two_people) AS AVERAGE_COST_FOR_TWO_PEOPLE
FROM Zomato;

--Top 10 Most Popular Cuisines

SELECT TOP 10 cuisines,COUNT(*) as RESTAURANT_COUNT FROM Zomato
GROUP BY cuisines
ORDER BY RESTAURANT_COUNT DESC


SELECT TOP 10 cuisines,COUNT(*) as RESTAURANT_COUNT,rating_Out_of_5 AS RATING FROM Zomato
WHERE rating_Out_of_5 >= 4.9
GROUP BY cuisines,rating_Out_of_5
ORDER BY 2 DESC

--High-Rating Restaurants

SELECT name,cuisines,location,rating_Out_of_5 FROM ZOMATO
WHERE rating_Out_of_5>4.5
ORDER BY rating_Out_of_5 DESC

--Costly (AVG_COST > 1000) vs Affordable Areas (AVG_COST<1000)

SELECT location,avg(approx_cost_for_two_people) AS AVERAGE_COST FROM Zomato
GROUP BY location


--Cuisine Distribution by Area

SELECT * FROM Zomato;

SELECT cuisines , count(*) as RESTAURANT_COUNT FROM Zomato
WHERE location = 'Jayanagar'
GROUP BY cuisines
ORDER BY 2 DESC

--Restaurant Ratings Distribution

SELECT rating_Out_of_5 , count(*) as RESTAURANT_COUNT FROM Zomato
WHERE location = 'Jayanagar'
GROUP BY rating_Out_of_5
ORDER BY 1 DESC;

--Average Cost by Cuisine

WITH AVG_COST_BY_CUISINE AS(SELECT cuisines , AVG(approx_cost_for_two_people) AS AVERAGE_COST, COUNT(*) as RESTAURANT_COUNT FROM Zomato
--WHERE location = 'Jayanagar'
GROUP BY cuisines
--ORDER BY 2
)
SELECT * FROM AVG_COST_BY_CUISINE
WHERE AVERAGE_COST>100
ORDER BY 2


--Restaurant Density by Location

SELECT location , count(*) as RESTAURANT_COUNT FROM Zomato
GROUP BY location
ORDER BY 2 DESC;

--Top 10 Restaurant Chains

SELECT TOP 10 name , count(*) as OUTLET_COUNT FROM Zomato
GROUP BY name
ORDER BY 2 DESC;

--Cuisine Popularity by Rating

SELECT TOP 50 cuisines , AVG(rating_Out_of_5) as RATING FROM Zomato
GROUP BY cuisines
HAVING COUNT(*) >10
ORDER BY 2 DESC;

--Top Rated Restaurants in Popular Areas



--Affordable and High-Rated Restaurants

SELECT TOP 50 name , AVG(approx_cost_for_two_people) as AVG_COST FROM Zomato
WHERE rating_Out_of_5>4.5
GROUP BY name
ORDER BY 2 DESC;


SELECT TOP 50 name , AVG(approx_cost_for_two_people) as AVG_COST FROM Zomato
WHERE rating_Out_of_5>4.5
GROUP BY name
ORDER BY 2;

--Distribution of Restaurant Types

SELECT TOP 50 location , REST_TYPE , COUNT(*) AS COUNT_RESTAURANT FROM Zomato
GROUP BY location,rest_type
ORDER BY 3 DESC

--Most Liked Dishes by Location

SELECT location , dish_liked , COUNT(DISH_LIKED) AS POPULARITY FROM Zomato
GROUP BY location , dish_liked
ORDER BY 3 DESC

--Most Common Menu Items

DROP TABLE IF EXISTS #MENU_ITEM_FREQUENCY
CREATE TABLE #MENU_ITEM_FREQUENCY(
menu_item VARCHAR(MAX),
FREQUENCY INT);

INSERT INTO #MENU_ITEM_FREQUENCY
SELECT menu_item ,COUNT(*) AS FREQUENCY FROM Zomato
WHERE menu_item IS NOT NULL
GROUP BY menu_item
ORDER BY 2 DESC

SELECT TOP 20 * FROM #MENU_ITEM_FREQUENCY
ORDER BY FREQUENCY DESC

--Restaurant Variety by Location

SELECT location  , COUNT(DISTINCT cuisines) AS CUISINES_AVAILABLE FROM Zomato
GROUP BY location
ORDER BY 2 DESC

--Price Range Analysis


WITH Price_Range AS (SELECT * , CASE
			WHEN approx_cost_for_two_people BETWEEN 100 AND 500 THEN 'HIGHLY AFFORDABLE RESTAURANTS'
			WHEN approx_cost_for_two_people BETWEEN 500 AND 1200 THEN 'AFFORDABLE RESTAURANTS'
			WHEN approx_cost_for_two_people BETWEEN 1200 AND 3000 THEN 'COSTLY RESTAURANTS'
			WHEN approx_cost_for_two_people >3000 THEN 'VERY COSTLY RESTAURANTS'
		END AS PRICE_RANGE
		FROM Zomato)
SELECT PRICE_RANGE , AVG(rating_Out_of_5) AS AVG_RATING FROM Price_Range
WHERE Price_Range IS NOT NULL
GROUP BY PRICE_RANGE
ORDER BY 2 DESC

--Best Locations for Food Lovers
WITH CTE AS (SELECT location , AVG(rating_Out_of_5) AS AVG_RATING , COUNT(DISTINCT cuisines) AS CUISINE_COUNT FROM Zomato
GROUP BY location
)
SELECT * FROM CTE WHERE AVG_RATING>4.1
ORDER BY 3 DESC

