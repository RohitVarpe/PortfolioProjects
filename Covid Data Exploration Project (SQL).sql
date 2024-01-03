

UPDATE [SQL Portfolio Project 1]..CovidDeaths SET continent = ISNULL(NULLIF(continent, ''), NULL);


SELECT location,date, total_cases,new_cases,total_deaths,new_deaths,population
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null



--ANALYSIS OF CASES VS DEATH

SELECT
  location,
  date,
  total_cases AS 'CASES',
  total_deaths AS 'DEATHS',
   CASE
    WHEN total_cases = 0 THEN 0  -- To avoid division by zero
    ELSE (total_deaths * 100.0 / NULLIF(total_cases, 0))  -- Use 100.0 to ensure decimal division
  END AS 'DeathPercent'
 
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
ORDER BY location


SELECT
  location,
  date,
  new_cases AS 'CASES',
  new_deaths AS 'DEATHS',
  CASE
    WHEN new_cases = 0 THEN 0  -- To avoid division by zero
    ELSE (new_deaths * 100.0 / NULLIF(new_cases, 0))  -- Use 100.0 to ensure decimal division
  END AS 'DeathPercent'
FROM
  [SQL Portfolio Project 1]..CovidDeaths
  WHERE continent is not null
ORDER BY location


SELECT location, MAX(total_cases) AS 'TotalCases' , MAX(total_deaths) AS 'TotalDeaths',
CASE
   WHEN MAX(total_cases) = 0 THEN NULL
   ELSE MAX(total_deaths)*100.0/NULLIF(MAX(total_cases),0)
END AS 'PercentDeaths'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY 'PercentDeaths' DESC



--ANALYSIS OF CASES VS POPULATION

SELECT location,date, total_cases,population,total_cases*100/population AS 'CasePercentage'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
ORDER BY 1,2



--ANALYSIS OF DEATHS VS POPULATION

SELECT location,date,new_deaths,population,
(new_deaths*100/population) AS 'DeathToPopulationPercentage'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
ORDER BY location


SELECT location,SUM(new_deaths) AS 'Deaths',MAX(population) AS 'Population',
(SUM(new_deaths)*100/MAX(population)) AS 'DeathToPopulationPercentage'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY 'DeathToPopulationPercentage' DESC

--Highest Case count per Country

SELECT location, SUM(new_cases) AS 'TotalCases'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalCases DESC


--Highest Infection Count Percentage Per Country

SELECT location, MAX(total_cases) AS 'CASES' ,AVG(population) AS 'Population',
      MAX(total_cases)*100.00/AVG(population) AS 'Cases/Population'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY 'Cases/Population' DESC





-- CONTINENT with Highest Deaths to Cases Percentage

SELECT continent, SUM(new_cases) AS 'TotalCases' , SUM(new_deaths) AS 'TotalDeaths',
CASE
   WHEN SUM(new_cases) = 0 THEN NULL
   ELSE SUM(new_deaths)*100/NULLIF(SUM(new_cases),0)
END AS 'PercentDeaths'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY 'PercentDeaths' DESC


-- Country with Highest Deaths

SELECT location, SUM(new_deaths) AS 'TotalDeaths'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeaths DESC

-- Country with Highest Deaths to Cases Percentage

SELECT location, SUM(new_cases) AS 'TotalCases' , SUM(new_deaths) AS 'TotalDeaths',
CASE
   WHEN SUM(new_cases) = 0 THEN NULL
   ELSE SUM(new_deaths)*100/NULLIF(SUM(new_cases),0)
END AS 'PercentDeaths'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY location
ORDER BY 'PercentDeaths' DESC

--Highest Case count per Continent

SELECT continent, SUM(new_cases) AS 'TotalCases'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalCases DESC

-- Continent with Highest Deaths
SELECT continent, SUM(new_deaths) AS 'TotalDeaths'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeaths DESC


-- CONTINENT with Highest Deaths to Cases Percentage

SELECT continent, SUM(new_cases) AS 'TotalCases' , SUM(new_deaths) AS 'TotalDeaths',
CASE
   WHEN SUM(new_cases) = 0 THEN NULL
   ELSE SUM(new_deaths)*100/NULLIF(SUM(new_cases),0)
END AS 'PercentDeaths'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY 'PercentDeaths' DESC

--Global Case count per Day

SELECT date, SUM(new_cases) AS 'TotalCases'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY TotalCases DESC

-- Number of Global Deaths per Day

SELECT date, SUM(new_deaths) AS 'TotalDeaths'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY TotalDeaths DESC


-- DEATH TO CASE PERCENTAGE PER DAY
SELECT date, SUM(total_cases) AS 'TotalCases' , SUM(total_deaths) AS 'TotalDeaths',
CASE
   WHEN SUM(total_cases) = 0 THEN NULL
   ELSE SUM(total_deaths)*100.0/NULLIF(SUM(total_cases),0)
END AS 'PercentDeaths'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 'PercentDeaths' DESC


--PERCENTAGE OF POPULATION THAT GOT INFECTED TODAY

SELECT date, SUM(total_cases) AS 'CASES' ,SUM(population) AS 'Population',
      SUM(total_cases)*100.00/SUM(population) AS 'Cases/Population'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 'Cases/Population' DESC


-- DEATH TO POPULATION PERCENTAGE PER DAY

SELECT date,SUM(new_deaths) AS 'Deaths',SUM(population) AS 'Population',
(SUM(new_deaths)*100/SUM(population)) AS 'DeathToPopulationPercentage'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 'DeathToPopulationPercentage' DESC

--Daily Numbers

SELECT date, SUM(new_cases) AS 'CASES', SUM(new_deaths) AS 'DEATHS'
FROM [SQL Portfolio Project 1]..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY date,CASES

SELECT *
FROM [SQL Portfolio Project 1]..CovidVaccinations

SELECT *
FROM [SQL Portfolio Project 1]..CovidDeaths AS CODE
	JOIN [SQL Portfolio Project 1]..CovidVaccinations AS COVAC
		ON CODE.location = COVAC.location
		AND 
		CODE.date = COVAC.DATE

-- World Vaccination

SELECT CODE.location,CODE.population,(MAX(COVAC.total_vaccinations)/2) AS 'Total Vaccination',
(MAX(COVAC.total_vaccinations)/2) * 100/ CODE.population as 'Full Vaccination Percentage'
FROM [SQL Portfolio Project 1]..CovidDeaths AS CODE
	JOIN [SQL Portfolio Project 1]..CovidVaccinations AS COVAC
		ON CODE.location = COVAC.location
		AND 
		CODE.date = COVAC.DATE
WHERE CODE.location = 'WORLD'
GROUP BY CODE.location,CODE.population

-- Looking at Total Population vs Vaccination

SELECT CODE.continent,CODE.location,CODE.date,CODE.population,COVAC.new_vaccinations
FROM [SQL Portfolio Project 1]..CovidDeaths AS CODE
	JOIN [SQL Portfolio Project 1]..CovidVaccinations AS COVAC
		ON CODE.location = COVAC.location
		AND 
		CODE.date = COVAC.DATE
WHERE CODE.continent IS NOT NULL
ORDER BY 1,2,3

--View Creation

Create View TotalVaccinationToDate as
SELECT CODE.continent,CODE.location,CODE.date,CODE.population,COVAC.new_vaccinations,
SUM(COVAC.new_vaccinations) OVER (Partition by CODE.location ORDER BY CODE.date) AS 'TotalVaccinationToDate'
FROM [SQL Portfolio Project 1]..CovidDeaths AS CODE
	JOIN [SQL Portfolio Project 1]..CovidVaccinations AS COVAC
		ON CODE.location = COVAC.location
		AND 
		CODE.date = COVAC.DATE
WHERE CODE.continent IS NOT NULL
--ORDER BY 2,3;

-- USE CTE


WITH PopvsVac AS
(
    SELECT
        CODE.continent,
        CODE.location,
        CODE.date,
        CODE.population,
        COVAC.new_vaccinations,
        SUM(COVAC.new_vaccinations) OVER (PARTITION BY CODE.location ORDER BY CODE.date) AS TotalVaccinationToDate
    FROM
        [SQL Portfolio Project 1]..CovidDeaths AS CODE
    JOIN
        [SQL Portfolio Project 1]..CovidVaccinations AS COVAC
            ON CODE.location = COVAC.location
            AND CODE.date = COVAC.DATE
    WHERE
        CODE.continent IS NOT NULL
)
SELECT
    *,
    (TotalVaccinationToDate *100 / population) AS VaccinationPercentage
FROM
    PopvsVac;



--Temp Table

DROP Table if exists #TotalVaccinationToDate

Create Table #TotalVaccinationToDate
(
Continent nvarchar(255),
Location  nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
TotalVaccinationToDate numeric
)



Insert into #TotalVaccinationToDate

SELECT
        CODE.continent,
        CODE.location,
        CODE.date,
        CODE.population,
        COVAC.new_vaccinations,
        SUM(COVAC.new_vaccinations) OVER (PARTITION BY CODE.location ORDER BY CODE.date) AS 'TotalVaccinationToDate'
    FROM
        [SQL Portfolio Project 1]..CovidDeaths AS CODE
    JOIN
        [SQL Portfolio Project 1]..CovidVaccinations AS COVAC
            ON CODE.location = COVAC.location
            AND CODE.date = COVAC.DATE
    WHERE
        CODE.continent IS NOT NULL
SELECT *,(TotalVaccinationToDate*100/Population)
FROM #TotalVaccinationToDate