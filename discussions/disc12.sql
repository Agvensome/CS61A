-- disc12

CREATE TABLE pizzas AS
  SELECT "Artichoke" AS name, 12 AS open, 15 AS close UNION
  SELECT "La Val's"         , 11        , 22          UNION
  SELECT "Sliver"           , 11        , 20          UNION
  SELECT "Cheeseboard"      , 16        , 23          UNION
  SELECT "Emilia's"         , 13        , 18;

CREATE TABLE meals AS
  SELECT "breakfast" AS meal, 11 AS time UNION
  SELECT "lunch"            , 13         UNION
  SELECT "dinner"           , 19         UNION
  SELECT "snack"            , 22;


-- Q1: Open Early
-- You'd like to have pizza before 13 o'clock (1pm). 
-- Create a opening table with the names of all pizza places that 
-- open before 13 o'clock, listed in reverse alphabetical order.
-- Hint: Use an expression of the form MAX(_, 0) to 
-- make sure a result is not below 0.

    -- opening table:

    -- name
    -- Sliver
    -- La Val's
    -- Artichoke

CREATE TABLE opening AS
    SELECT name FROM pizzas WHERE open < 13 ORDER BY name DESC;

SELECT * FROM opening;

SELECT "";

-- Q2: Study Session
-- You're planning to study at a pizza place from the moment it opens until 14 o'clock (2pm). 
-- Create a table study with two columns, the name of each pizza place and 
-- the duration of the study session you would have if you studied there (the difference between when it opens and 14 o'clock). 
-- For pizza places that are not open before 2pm, the duration should be zero. 
-- Order the rows by decreasing duration.
-- Hints: Hint: Use an expression of the form MAX(_, 0) to make sure a result is not below 0.
-- To order by decreasing duration, first name the column with SELECT ..., 
--                          ... AS duration ..., then ORDER BY duration DESC.

    -- study table:

    -- name	        duration
    -- La Val's	    3
    -- Sliver	    3
    -- Artichoke	2
    -- Emilia's	    1
    -- Cheeseboard	0

CREATE TABLE study AS
    SELECT name, MAX(14 - open, 0) AS duration 
    FROM pizzas ORDER BY duration DESC;

SELECT * FROM study;

SELECT "";

-- Q3: Late Night Snack
-- What's still open for a late night snack? Create a late table with one column 
-- named status that has a sentence describing the closing time of each pizza place that closes at or after snack time. 
-- Important: Don't use any numbers in your SQL query! Instead, use a join to compare each restaurant's closing time to the time of a snack. 
-- The rows may appear in any order.

    -- late table:

    -- status
    -- Cheeseboard closes at 23
    -- La Val's closes at 22


CREATE TABLE late AS
    SELECT name || " closes at " || close AS status
    FROM pizzas, meals as ms
    WHERE ms.meal = "snack" AND ms.time <= close;

SELECT * FROM late;

SELECT "";

-- Q4: Double Pizza
-- If two meals are more than 6 hours apart, then there's nothing wrong with going to the same pizza place for both, right? 
-- Create a double table with three columns. 
-- The first column is the earlier meal, the second column is the later meal, and the name column is the name of a pizza place. 
-- Only include rows that describe two meals that are more than 6 hours apart and a pizza place that is open for both of the meals. 
-- The rows may appear in any order.

    -- double table:

    -- first	    second	name
    -- breakfast	dinner	La Val's
    -- breakfast	dinner	Sliver
    -- breakfast	snack	La Val's
    -- lunch	    snack	La Val's

-- Two meals at the same place
CREATE TABLE double AS
    SELECT a.meal AS first, b.meal AS second, name
    FROM meals AS a, meals AS b, pizzas
    WHERE b.time - a.time > 6 AND open <= a.time AND b.time <= close;

SELECT * FROM double;

SELECT "";