SELECT * 
FROM projectalex.muertes_por_covid
WHERE continent is NOT NULL
GROUP BY location
ORDER BY location
;

update muertes_por_covid set continent=if(continent='   ',NULL,continent);

-- income
SELECT Location, population, sum(new_cases) as Total_Cases, sum(new_deaths) as Total_Deaths
FROM projectalex.muertes_por_covid
-- WHERE continent is NOT NULL
WHERE Location like "%income"
GROUP BY Location
ORDER BY location;

-- SELECCION UBICACION, FECHA, CASOS TOTALES, CASOS NUEVOS, MUERTES Y POBLACION
SELECT Location, date, total_cases, new_cases, total_Deaths, population
FROM projectalex.muertes_por_covid
WHERE Location = 'Argentina'
ORDER BY 1,2;

-- DIAS CON MAS CONTAGIOS EN EL MUNDO
SELECT date, sum(new_cases) as nuevos_casos
FROM projectalex.muertes_por_covid
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY nuevos_casos desc;

-- DIAS CON MAS CONTAGIOS EN ARGENTINA
SELECT date, Location, sum(new_cases) as nuevos_casos
FROM projectalex.muertes_por_covid
WHERE continent IS NOT NULL and location = "Argentina"
GROUP BY date
ORDER BY nuevos_casos desc;


-- PROBABILIDAD DE MORIR SI SE CONTRAE COVID EN ARGENTINA
SELECT Location, date, total_cases, total_Deaths, (total_deaths/total_cases)*100 as Porcentaje_de_muertes
FROM projectalex.muertes_por_covid
WHERE Location = "Argentina"
ORDER BY 1,2;


-- MOSTRANDO PORCENTAJE DE POBLACION QUE CONTRAJO COVID EN ARGENTINA
SELECT Location, date, total_cases, population, (total_cases/population)*100 as Porcentaje_de_poblacion_contagiada
FROM projectalex.muertes_por_covid
WHERE Location = "Argentina"
ORDER BY 1,2;
 
 -- PAISES CON MAYOR PORCENTAJE DE CONTAGIOS / POBLACIÓN 
SELECT Location, population, MAX(total_cases) AS contagios_totales, MAX((total_cases/population))*100 as Porcentaje_de_poblacion_contagiada
FROM projectalex.muertes_por_covid
WHERE continent is not null
GROUP BY Location, population
ORDER BY Porcentaje_de_poblacion_contagiada desc;

-- PAISES CON MAS MUERTES
SELECT Location, MAX(cast(Total_deaths AS float)) as Muertes_totales
FROM projectalex.muertes_por_covid
WHERE iso_code NOT LIKE 'OWID%'
GROUP BY Location
ORDER BY Muertes_totales desc;

-- CONTINENTES CON LA MAYOR CANTIDAD DE MUERTES TOTALES
SELECT Continent, MAX(cast(Total_deaths AS float)) as Muertes_totales
FROM projectalex.muertes_por_covid
WHERE continent is not NULL AND Location NOT LIKE "% income"
GROUP BY Continent 
ORDER BY Muertes_totales desc;

-- PORCENTAJE DE MUERTES / CONTAGIOS A NIVEL MUNDIAL POR DÍA
SELECT Date, SUM(new_cases) as Total_cases, SUM(new_deaths) as Total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as Death_percentage
FROM projectalex.muertes_por_covid
WHERE continent is not null
GROUP BY date
ORDER BY 1,2;

-- POBLACION TOTAL / VACUNACIONES: PARA REALIZAR EL PORCENTAJE DE GenteVacunada SE DESARROLLAN
-- DOS POSIBILIDADES ABAJO: UNA TABLA TEMPORAL Y UNA TABLA DE EXPRESIONES COMUNES O CTE
SELECT mue.continent, mue.location, mue.date, mue.population, vac.new_vaccinations,
SUM(new_vaccinations) OVER (PARTITION BY mue.location ORDER BY mue.location, date) as GenteVacunada,
(GenteVacunada/population) * 100
FROM projectalex.muertes_por_covid  mue
JOIN projectalex.vacunacionescovid vac
	ON mue.location = vac.location
    and mue.date = vac.date
ORDER BY 2,3;

 -- 1. TABLA TEMPORAL
DROP table if exists Porcentaje_de_poblacion_vacunada;

CREATE TEMPORARY TABLE Porcentaje_de_poblacion_vacunada
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric, 
new_vaccinations text, 
GenteVacunada numeric
);

INSERT INTO Porcentaje_de_poblacion_vacunada
SELECT mue.continent, mue.location, mue.date, mue.population, vac.new_vaccinations,
SUM(new_vaccinations) OVER (PARTITION BY mue.location ORDER BY mue.location, date) as GenteVacunada
-- (GenteVacunada/population) * 100
FROM projectalex.muertes_por_covid  mue
JOIN projectalex.vacunacionescovid vac
	ON mue.location = vac.location
    and mue.date = vac.date;
    
SELECT *, (GenteVacunada/population) * 100
FROM Porcentaje_de_poblacion_vacunada;


-- 2. CTE O TABLA DE EXPRESIONES COMUNES
With PobVsVac(Continent, location, date, population, New_vaccinations, GenteVacunada)
as 
(
SELECT mue.continent, mue.location, mue.date, mue.population, vac.new_vaccinations,
SUM(new_vaccinations) OVER (PARTITION BY mue.location ORDER BY mue.location, date) as GenteVacunada
-- (GenteVacunada/population) * 100
FROM projectalex.muertes_por_covid  mue
JOIN projectalex.vacunacionescovid vac
	ON mue.location = vac.location
    and mue.date = vac.date
)
SELECT *, (GenteVacunada/population) * 100
 FROM pobVsVac;
 
 
 -- CREANDO VIEWS PARA ALMACENAR DATOS PARA FUTURAS VISUALIZACIONES
 
-- PORCENTAJE DE POBLACION VACUNADA VIEW 
CREATE VIEW View_porcentaje_de_poblacion_vacunada AS 
 SELECT mue.continent, mue.location, mue.date, mue.population, vac.new_vaccinations,
SUM(new_vaccinations) OVER (PARTITION BY mue.location ORDER BY mue.location, date) as GenteVacunada
-- (GenteVacunada/population) * 100 
FROM projectalex.muertes_por_covid  mue
JOIN projectalex.vacunacionescovid vac
	ON mue.location = vac.location
    and mue.date = vac.date
WHERE mue.continent is NOT NULL;
-- ORDER BY 2,3;
SELECT * 
FROM View_porcentaje_de_poblacion_vacunada;

-- PROBABILIDAD DE MORIR EN ARGENTINA VIEW
CREATE VIEW View_probabilidad_de_morir_Argentina as
SELECT Location, date, total_cases, total_Deaths, (total_deaths/total_cases)*100 as Porcentaje_de_muertes
FROM projectalex.muertes_por_covid
WHERE Location = "Argentina";
-- ORDER BY 1,2;
SELECT * 
FROM View_probabilidad_de_morir_Argentina;

-- PORCENTAJE DE POBLACION CONTAGIADA VIEW
CREATE VIEW View_porcentaje_de_poblacion_contagiada as 
SELECT Location, date, total_cases, population, (total_cases/population)*100 as Porcentaje_de_poblacion_contagiada
FROM projectalex.muertes_por_covid
WHERE Location = "Argentina";
-- ORDER BY 1,2;
SELECT * 
FROM View_porcentaje_de_poblacion_contagiada;

-- 20 PAISES CON PORCENTAJE DE CONTAGIOS/POBLACION MAS ALTOS VIEW
CREATE VIEW View_paises_con_mayores_indices_de_contagios as
SELECT Location, population, MAX(total_cases) AS contagios_totales, MAX((total_cases/population))*100 as Porcentaje_de_poblacion_contagiada
FROM projectalex.muertes_por_covid
WHERE continent is not null
GROUP BY Location, population
ORDER BY Porcentaje_de_poblacion_contagiada desc
LIMIT 20;

-- 20 PAISES CON MAS MUERTES VIEW
CREATE VIEW View_paises_con_mas_muertes as
SELECT Location, MAX(cast(Total_deaths AS float)) as Muertes_totales
FROM projectalex.muertes_por_covid
WHERE iso_code NOT LIKE 'OWID%'
GROUP BY Location
ORDER BY Muertes_totales desc
LIMIT 20;

-- 20 PAISES CON MAS PORCENTAJE MUERTES/POBLACION VIEW
CREATE VIEW View_paises_con_porcentaje_de_muertes_mas_altos as
SELECT Location, population, sum(new_deaths) as Muertes_totales, (sum(new_deaths)/population)*100 as Porcentaje_de_muertes_por_pais
FROM projectalex.muertes_por_covid
WHERE continent is not null
GROUP BY Location, population
ORDER BY Porcentaje_de_muertes_por_pais desc
LIMIT 20;

-- CONTINENTES CON MAYOR CANTIDAD DE MUERTES VIEW 
CREATE VIEW View_continentes_con_mas_muertes as
SELECT Continent, SUM(new_deaths) as Muertes_totales
FROM projectalex.muertes_por_covid
WHERE continent is not NULL AND Location NOT LIKE "% income"
GROUP BY Continent 
ORDER BY Muertes_totales desc;

-- PORCENTAJE DE MUERTES / CONTAGIOS A NIVEL MUNDIAL POR DÍA VIEW
CREATE VIEW View_porcentaje_mundial_muertes_sobre_contagios_por_dia as
SELECT Date, SUM(new_cases) as Total_cases, SUM(new_deaths) as Total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as Death_percentage
FROM projectalex.muertes_por_covid
WHERE continent is not null
GROUP BY date
ORDER BY 1,2;

-- DIAS CON MAS CONTAGIOS EN ARGENTINA VIEW
CREATE VIEW View_dias_con_mas_contagios_argentina as
SELECT date, Location, sum(new_cases) as nuevos_casos
FROM projectalex.muertes_por_covid
WHERE continent IS NOT NULL and location = "Argentina"
GROUP BY date
ORDER BY nuevos_casos desc;

-- MAP VIEW
Select Location, Population, MAX(total_cases) as MaxContagios,  Max((total_cases/population))*100 as PorcentajePoblacionInfectada
From projectalex.muertes_por_covid

Group by Location, Population
order by PorcentajePoblacionInfectada desc;

-- TIMELINE VIEW
Select Location, Population, date, MAX(total_cases) as MaximoDeContagios,  Max((total_cases/population))*100 as PorcentajePoblacionInfectada
From projectalex.muertes_por_covid

Group by Location, Population, date
order by PorcentajePoblacionInfectada desc;

-- viz income
SELECT Location, population, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths
FROM projectalex.muertes_por_covid
-- WHERE continent is NOT NULL
WHERE Location like "%income"
GROUP BY Location
ORDER BY location;

-- viz interactive dashboard 1
Select mue.continent, mue.location, mue.date, mue.population, MAX(vac.total_vaccinations),
(MAX(vac.total_vaccinations)/population)*100 as Porcentaje_poblacion_vacunada
From projectalex.muertes_por_covid mue
Join projectalex.vacunacionescovid vac
	On mue.location = vac.location
	and mue.date = vac.date
where mue.continent is not null 
group by mue.continent, mue.location, mue.date, mue.population 
order by 1, 2;

SELECT location, sum(new_deaths) AS Muertes, sum(new_cases) as CasosPositivos,
(sum(new_deaths)/sum(new_cases)) as PorcentajeDeContagiadosMuertos

FROM projectalex.muertes_por_covid
WHERE continent is NOT NULL
group by location;

Select Location,sum(new_deaths) as Muertes, sum(new_cases) as CasosPositivos, (sum(new_deaths)/sum(new_cases)) as PorcentajeDeContagiadosMuertos
FROM projectalex.muertes_por_covid
WHERE Location = "World";

select location FROM projectalex.vacunaciones_covid;




