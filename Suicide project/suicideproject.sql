SELECT *
FROM suicide_project.suicide_stats;

-- First I need to change the name of some columns
ALTER TABLE suicide_project.suicide_stats 
RENAME COLUMN ï»¿country TO country;

 -- There we go. Let's see if it worked.
SELECT country
FROM suicide_project.suicide_stats;

-- Perfect! Now...
-- As a first query, I thought it would be interesting to know the percentage of male and female suicides since 1987.
SELECT sex, 
       SUM(suicides_no) total_suicides_per_gender, 
       (SELECT SUM(suicides_no) FROM suicide_project.suicide_stats) total_suicides,
       ROUND((SELECT SUM(suicides_no)/total_suicides*100 HAVING sex = 'male' OR sex = 'female'), 2) percent_suicides
       							
FROM suicide_project.suicide_stats
GROUP BY sex;

-- Now i would like to know the countries with the most suicides.
SELECT country,
       SUM(suicides_no) total_suicides_per_country
FROM suicide_project.suicide_stats
GROUP BY country
ORDER BY total_suicides_per_country desc;

-- Interesting... but let's divided by the population to see the highest averages.
SELECT country,
       SUM(suicides_no) total_suicides_per_country,
       SUM(population),
       SUM(suicides_no)/SUM(population) avg_suicides_per_country
FROM suicide_project.suicide_stats
GROUP BY country
ORDER BY avg_suicides_per_country desc;

-- I would now like to know the age-range with in which suicide is most common.
SELECT age, 
       SUM(suicides_no) total_suicides_per_age_range
FROM suicide_project.suicide_stats
GROUP BY age
ORDER BY total_suicides_per_age_range desc;

-- Now let's see the years in which the most suicides where commited.
SELECT  year,
		SUM(suicides_no) total_suicides_per_year
FROM suicide_project.suicide_stats
GROUP BY year
ORDER BY total_suicides_per_year desc;

-- Let's what generations show the highest counts of suicides.
SELECT generation,
	   SUM(suicides_no) total_suicides_per_generation 
FROM suicide_project.suicide_stats
GROUP BY generation
ORDER BY total_suicides_per_generation desc;

-- One of the elements that I found really interesting of this dataset is the economic factor. Let's dig a little into that.
SELECT country,
	   SUM(suicides_no) total_suicides_per_country,
       AVG(gdp_per_capita)
FROM suicide_project.suicide_stats
GROUP BY country
ORDER BY total_suicides_per_country desc;

-- Years in which the most suicides where commited in Argentina. 
SELECT year,	   
	   SUM(suicides_no) total_suicides_per_year       
FROM suicide_project.suicide_stats
WHERE country = 'Argentina'
GROUP BY year
ORDER BY total_suicides_per_year desc;

-- Age group with the most avg suicides. 75+ years old, followed by 55-74 years old.
SELECT age,
	   SUM(suicides_no) total_suicides_per_age_range,
       AVG(population),
       SUM(suicides_no)/population avg_suicides
FROM suicide_project.suicide_stats
WHERE country = 'Argentina'
GROUP BY age
ORDER BY avg_suicides desc;

-- Generation with the most avg suicides. G.I. Generation (1901-1927)
SELECT generation,
	   SUM(suicides_no) total_suicides_per_generation,
       AVG(population),
       SUM(suicides_no)/population avg_suicides
FROM suicide_project.suicide_stats
WHERE country = 'Argentina'
GROUP BY generation
ORDER BY avg_suicides desc;












