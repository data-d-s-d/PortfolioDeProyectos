-- This project is commented on each of the queries made, so it is a bit more clear for you to read.
-- If you have any doubts, comments, suggestions or questions please contact me:
-- diego.saintdenis@gmail.com

SELECT *
FROM suicide_project.suicide_stats
GROUP BY country_name
;

-- First I need to change the name of some columns
ALTER TABLE suicide_project.suicide_stats 
RENAME COLUMN country TO country_name;

 -- There we go. Let's see if it worked.
SELECT country_name
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
SELECT country_name,
       SUM(suicides_no) total_suicides_per_country
FROM suicide_project.suicide_stats
GROUP BY country_name
ORDER BY total_suicides_per_country desc;

-- I used another population dataset to make the data easier to manipulate.
SELECT *
FROM suicide_project.population;

-- What about the percentage of suicides per country?.
SELECT suicide_stats.country_name,
       SUM(suicide_stats.suicides_no) total_suicides_per_country,
       population.avg avg_population,  
       ROUND(SUM(suicide_stats.suicides_no)/population.avg, 5) as avg_suicides_per_country
FROM suicide_project.suicide_stats
JOIN population ON suicide_stats.country_name = population.country_name
GROUP BY country_name
ORDER BY avg_suicides_per_country desc;


-- I would now like to know the age-group in which suicide is most common.
SELECT age, 
       SUM(suicides_no) total_suicides_per_age_range
FROM suicide_project.suicide_stats
GROUP BY age
ORDER BY total_suicides_per_age_range desc;

-- Age group with the most % of suicides.
SELECT age,
	   SUM(suicides_no) total_suicides_per_age_range,
       SUM(population),
       SUM(suicide_stats.suicides_no)/SUM(population) *100 percent_suicides_per_age_range
FROM suicide_project.suicide_stats
GROUP BY age
ORDER BY percent_suicides_per_age_range desc;

-- Now let's see the years in which the most suicides where commited.
SELECT  year,
		SUM(suicides_no) total_suicides_per_year
FROM suicide_project.suicide_stats
GROUP BY year
ORDER BY total_suicides_per_year desc;

-- Years in which the most suicides where commited in Argentina. 
SELECT year,	   
	   SUM(suicides_no) total_suicides_per_year       
FROM suicide_project.suicide_stats
WHERE country_name = 'Argentina'
GROUP BY year
ORDER BY total_suicides_per_year desc;

-- Let's see what generations show the highest counts of suicides.
SELECT generation,
	   SUM(suicides_no) total_suicides_per_generation 
FROM suicide_project.suicide_stats
GROUP BY generation
ORDER BY total_suicides_per_generation desc;

-- Generation with the most % suicides. G.I. Generation (1901-1927)
SELECT generation,
	   SUM(suicides_no) total_suicides_per_generation,
       SUM(population),
       SUM(suicides_no)/SUM(population) *100 percent_suicides_per_generation
FROM suicide_project.suicide_stats
GROUP BY generation
ORDER BY percent_suicides_per_generation desc;


-- One of the elements that I found really interesting of this dataset is the economic factor. Let's dig a little into that.
SELECT country_name,
	   SUM(suicide_stats.suicides_no)/SUM(population) *100 percentage_suicides_per_country,
       ROUND(AVG(gdp_per_capita), 2) as average_gdp_per_capita
FROM suicide_project.suicide_stats
GROUP BY country_name
ORDER BY percentage_suicides_per_country desc;

SELECT * 
FROM suicide_project.suicide_stats
WHERE country_name = 'China'






















