select *
from forestarea.covered_area; 

# Cleaning data. Finding unwanted rows
select *
from forestarea.covered_area
-- WHERE `Forest Area 1990` = 0
order by `Forest Area 1990` asc;

DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Curacao';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Hong Kong SAR, China';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Luxembourg';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Macao SAR, China';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Marshall Islands';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Palau';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Sudan';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'South Sudan';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Sint Maarten (Dutch part)';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Gibraltar';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Monaco';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Nauru';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Qatar';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Micronesia, Fed. Sts.';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Syrian Arab Republic';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Aruba';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Maldives';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Tajikistan';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'United Arab Emirates';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Cabo Verde';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Tunisia';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Kyrgyz Republic';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Uruguay';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Chad';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Iran, Islamic Rep.';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Qatar';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Isle of Man';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Ireland';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Kenya';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Uzbekistan';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Turkenistan';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Mongolia';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Moldova';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Israel';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Pakistan';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Burundi';
DELETE FROM forestarea.covered_area
WHERE `Country Name` = 'Turkmenistan';


# Filling in blank values with nulls
update covered_area set `Forest Area 1990`=if(`Forest Area 1990`='',NULL,`Forest Area 1990`);

SELECT `Country Name`,  `Forest Area 2004`
from forestarea.covered_area
GROUP BY `Country Name`
ORDER BY  `Forest Area 2004` asc;


SELECT `Country Name`, CAST(`Forest Area 1990` as float)
from forestarea.covered_area
ORDER BY `Forest Area 1990`;


update covered_area
    set `Forest Area 1990` = replace(`Forest Area 1990`, ',', '.')
    where `Forest Area 1990` like '%,%';
update covered_area   
    set `Forest Area 1991` = replace(`Forest Area 1991`, ',', '.')
    where `Forest Area 1991` like '%,%';
update covered_area   
    set `Forest Area 1992` = replace(`Forest Area 1992`, ',', '.')
    where `Forest Area 1992` like '%,%';
update covered_area   
    set `Forest Area 1993` = replace(`Forest Area 1993`, ',', '.')
    where `Forest Area 1993` like '%,%';
update covered_area   
    set `Forest Area 1994` = replace(`Forest Area 1994`, ',', '.')
    where `Forest Area 1994` like '%,%';
update covered_area   
    set `Forest Area 1995` = replace(`Forest Area 1995`, ',', '.')
    where `Forest Area 1995` like '%,%';
update covered_area   
    set `Forest Area 1996` = replace(`Forest Area 1996`, ',', '.')
    where `Forest Area 1996` like '%,%';
update covered_area   
    set `Forest Area 1997` = replace(`Forest Area 1997`, ',', '.')
    where `Forest Area 1997` like '%,%';
update covered_area   
    set `Forest Area 1998` = replace(`Forest Area 1998`, ',', '.')
    where `Forest Area 1998` like '%,%';
update covered_area   
    set `Forest Area 1999` = replace(`Forest Area 1999`, ',', '.')
    where `Forest Area 1999` like '%,%';
update covered_area   
    set `Forest Area 2000` = replace(`Forest Area 2000`, ',', '.')
    where `Forest Area 2000` like '%,%';
update covered_area   
    set `Forest Area 2001` = replace(`Forest Area 2001`, ',', '.')
    where `Forest Area 2001` like '%,%';
update covered_area   
    set `Forest Area 2002` = replace(`Forest Area 2002`, ',', '.')
    where `Forest Area 2002` like '%,%';
update covered_area   
    set `Forest Area 2003` = replace(`Forest Area 2003`, ',', '.')
    where `Forest Area 2003` like '%,%';
update covered_area   
    set `Forest Area 2004` = replace(`Forest Area 2004`, ',', '.')
    where `Forest Area 2004` like '%,%';
update covered_area   
    set `Forest Area 2005` = replace(`Forest Area 2005`, ',', '.')
    where `Forest Area 2005` like '%,%';
update covered_area   
    set `Forest Area 2006` = replace(`Forest Area 2006`, ',', '.')
    where `Forest Area 2006` like '%,%';
update covered_area   
    set `Forest Area 2007` = replace(`Forest Area 2007`, ',', '.')
    where `Forest Area 2007` like '%,%';
update covered_area   
    set `Forest Area 2008` = replace(`Forest Area 2008`, ',', '.')
    where `Forest Area 2008` like '%,%';
update covered_area   
    set `Forest Area 2009` = replace(`Forest Area 2009`, ',', '.')
    where `Forest Area 2009` like '%,%';
update covered_area   
    set `Forest Area 2010` = replace(`Forest Area 2010`, ',', '.')
    where `Forest Area 2010` like '%,%';
update covered_area   
    set `Forest Area 2011` = replace(`Forest Area 2011`, ',', '.')
    where `Forest Area 2011` like '%,%';
update covered_area   
    set `Forest Area 2012` = replace(`Forest Area 2012`, ',', '.')
    where `Forest Area 2012` like '%,%';
update covered_area   
    set `Forest Area 2013` = replace(`Forest Area 2013`, ',', '.')
    where `Forest Area 2013` like '%,%';
update covered_area   
    set `Forest Area 2014` = replace(`Forest Area 2014`, ',', '.')
    where `Forest Area 2014` like '%,%';
update covered_area   
    set `Forest Area 2015` = replace(`Forest Area 2015`, ',', '.')
    where `Forest Area 2015` like '%,%';
update covered_area   
    set `Forest Area 2016` = replace(`Forest Area 2016`, ',', '.')
    where `Forest Area 2016` like '%,%';
update covered_area   
    set `Forest Area 2017` = replace(`Forest Area 2017`, ',', '.')
    where `Forest Area 2017` like '%,%';
update covered_area   
    set `Forest Area 2018` = replace(`Forest Area 2018`, ',', '.')
    where `Forest Area 2018` like '%,%';
update covered_area   
    set `Forest Area 2019` = replace(`Forest Area 2019`, ',', '.')
    where `Forest Area 2019` like '%,%';
update covered_area   
    set `Forest Area 2020` = replace(`Forest Area 2020`, ',', '.')
    where `Forest Area 2020` like '%,%';
update covered_area   
    set `Population Density (per kmÂ²)` = replace(`Forest Area 2020`, ',', '.')
    where `Forest Area 2020` like '%,%';
update covered_area   
    set `Population Density (per kmÂ²)` = replace(`Population Density (per kmÂ²)`, ',', '.')
    where `Population Density (per kmÂ²)` like '%,%';
update covered_area   
    set `Population Growth Rate` = replace(`Population Growth Rate`, ',', '.')
    where `Population Growth Rate` like '%,%';
update covered_area   
    set `World Population Percentage` = replace(`World Population Percentage`, ',', '.')
    where `World Population Percentage` like '%,%';


-- Average forest area per country
SELECT `Country Name`, 
AVG(`Forest Area 1990`+
	`Forest Area 1991`+
	`Forest Area 1991`+
	`Forest Area 1992`+
	`Forest Area 1993`+
	`Forest Area 1994`+
	`Forest Area 1995`+
	`Forest Area 1996`+
	`Forest Area 1997`+
	`Forest Area 1998`+
	`Forest Area 1999`+
	`Forest Area 2000`+
	`Forest Area 2001`+
	`Forest Area 2002`+
	`Forest Area 2003`+
	`Forest Area 2004`+
	`Forest Area 2005`+
	`Forest Area 2005`+
	`Forest Area 2007`+
	`Forest Area 2008`+
	`Forest Area 2009`+
	`Forest Area 2010`+
	`Forest Area 2011`+
	`Forest Area 2012`+
	`Forest Area 2013`+
	`Forest Area 2014`+
	`Forest Area 2015`+
	`Forest Area 2016`+
	`Forest Area 2017`+
	`Forest Area 2018`+
	`Forest Area 2019`+
	`Forest Area 2020`) / 31 as Avg_forest_area
from forestarea.covered_area
GROUP BY `Country Name`
;

-- How many countries had more forest in 1990 than in 2020
select `Country Name` 
from forestarea.covered_area
WHERE `Forest Area 1990` > `Forest Area 2020`
GROUP BY `Country Name`;

-- Here we can see that 87/179 countries had more area of forests in 1990 than in 2020
select COUNT(`Country Name`)  
from forestarea.covered_area
-- WHERE `Forest Area 1990` > `Forest Area 2020`
;
select COUNT(`Country Name`)  
from forestarea.covered_area
WHERE `Forest Area 1990` > `Forest Area 2020`;

-- How many countries had less forest in 1990 than in 2020? 72/179
select COUNT(`Country Name`)  
from forestarea.covered_area
WHERE `Forest Area 1990` < `Forest Area 2020`;

-- So how many have the same area of forest in 1990 and in 2020? 20/179
select COUNT(`Country Name`)  
from forestarea.covered_area
WHERE `Forest Area 1990` = `Forest Area 2020`;

-- What is the average difference between area of forest in 1990 and in 2020
select AVG(`Forest Area 1990` - `Forest Area 2020`) AS Avg_global_forest_loss  
from forestarea.covered_area;
-- GROUP BY `Country Name`;

-- Which countries lost the most area of forests?
select `Country Name`, (`Forest Area 1990` - `Forest Area 2020`) AS Forest_loss 
from forestarea.covered_area
ORDER BY Forest_loss desc
LIMIT 20;

-- What was the decade with the most forest cutting? 
SELECT (SUM(`Forest Area 1990` * `Area (kmÂ²)`/ 100)-SUM(`Forest Area 1999` * `Area (kmÂ²)`/ 100)) as Deforestation_90s,
	   (SUM(`Forest Area 2000` * `Area (kmÂ²)`/ 100)-SUM(`Forest Area 2009` * `Area (kmÂ²)`/ 100)) as Deforestation_00s,
       (SUM(`Forest Area 2010` * `Area (kmÂ²)`/ 100)-SUM(`Forest Area 2019` * `Area (kmÂ²)`/ 100)) as Deforestation_10s
from forestarea.covered_area
;

-- Countries with the most percentage of forests over territory in 2020
SELECT `Country Name`, `Forest Area 2020`, `Population rank`
from forestarea.covered_area
GROUP BY `Country Name`
ORDER BY `Forest Area 2020` desc
LIMIT 20;

-- Countries with the biggest areas of forest
SELECT `Country Name`, (`Forest Area 2020` * `Area (kmÂ²)`/ 100) as Surface_with_forest, `Population rank`
from forestarea.covered_area
GROUP BY `Country Name`
ORDER BY Surface_with_forest desc
LIMIT 20;

-- Now let's check the global temperature data

select * 
from globaltemp1;

-- The "Value" column is the temperature change with respect to a baseline climatology, corresponding to the period 1951–1980
SELECT Area, Months, Year, Value 
FROM globaltemp1
ORDER BY Area, Year, Months;


