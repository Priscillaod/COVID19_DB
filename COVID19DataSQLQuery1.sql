-- Preview both tables

SELECT*
FROM COVID19Database.dbo.CovidDeaths
order by 3,4

SELECT*
FROM COVID19Database.dbo.CovidVaccinations
order by 3,4

--- EXPLORE COVID DEATH TABLE

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM COVID19Database.dbo.CovidDeaths
ORDER BY 1,2


-- Looking at total cases vs total deaths in percentage


SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM COVID19Database.dbo.CovidDeaths
ORDER BY 1,2


--Looking at countries total cases vs total deaths in percentage for countries in Africa


SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM COVID19Database.dbo.CovidDeaths
WHERE location = 'Nigeria'
ORDER BY 1,2


-- Looking at other countries

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM COVID19Database.dbo.CovidDeaths
WHERE location like '%states%'
ORDER BY 1,2

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM COVID19Database.dbo.CovidDeaths
WHERE location like '%kingdom%'
ORDER BY 1,2


--Looking at total cases Vs Population (What percentage of the population was affected by Covid)


SELECT location, date, population, total_cases, (total_cases/population)*100 as CasesPercentage
FROM COVID19Database.dbo.CovidDeaths
WHERE location like 'india'
ORDER BY 1,2


-- Countries with highest infection rate compared to population


SELECT location, population, MAX(total_cases) as HighestInfectionCount, Max(total_cases/population)*100 as PercentofPopulationInfected
FROM COVID19Database.dbo.CovidDeaths
--WHERE location like 'india'
Group by Population, Location
ORDER BY PercentofPopulationInfected Desc


-- Countries with highst deaths 


SELECT location,  MAX(cast(total_deaths as int)) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent is not NULL
Group by Location
ORDER BY TotalDeathCount Desc


-- Explore continents with highest deaths counts


SELECT continent,  MAX(cast(total_deaths as int)) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent is not NULL
Group by continent
ORDER BY TotalDeathCount Desc


-- Explore countries in each continent with highest deaths counts (Africa)


SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'Africa'
Group by Location, continent
ORDER BY TotalDeathCount Desc


-- Explore countries in each continent with highest deaths counts (North America)


SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'North America'
Group by Location, continent
ORDER BY TotalDeathCount Desc


-- Explore countries in each continent with highest deaths counts (South America)


SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'South America'
Group by Location, continent
ORDER BY TotalDeathCount Desc



-- Explore countries in each continent with highest deaths counts (Asia)


SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'Asia'
Group by Location, continent
ORDER BY TotalDeathCount Desc




-- Explore countries in each continent with highest deaths counts (Europe)


SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'Europe'
Group by Location, continent
ORDER BY TotalDeathCount Desc



-- Explore countries in each continent with highest deaths counts (Oceania)


SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'Oceania'
Group by Location, continent
ORDER BY TotalDeathCount Desc


--GLOBAL NUMBERS

-- Daily total cases, total deaths and death percentages globaly.

SELECT date, SUM(new_cases) as GlobalDailyCases, SUM(cast(new_deaths as int)) as GlobalDailyDeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM COVID19Database.dbo.CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

-- Overall total cases, total deaths and death percentage

SELECT SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM COVID19Database.dbo.CovidDeaths
WHERE continent is not null
ORDER BY 1,2




-- Explore Covid Vaccination table
SELECT*
FROM COVID19Database.dbo.CovidVaccinations
order by 3,4


-- Joining the Covid deaths and Covid Vaccinations table

SELECT*
FROM COVID19Database.dbo.CovidDeaths Deaths
JOIN COVID19Database.dbo.CovidVaccinations Vaccine
	ON Deaths.location = Vaccine.location
	AND Deaths.date = Vaccine.date


-- Exploring Total Population vs new vaccinations


SELECT Deaths.continent, Deaths.location, Deaths.date, Deaths.population, Vaccine.new_vaccinations
FROM COVID19Database.dbo.CovidDeaths Deaths
JOIN COVID19Database.dbo.CovidVaccinations Vaccine
	ON Deaths.location = Vaccine.location
	AND Deaths.date = Vaccine.date
WHERE Deaths.continent is not NULL
ORDER BY 2,3


-- Exploring Total Population vs total vaccinations


SELECT Deaths.continent, Deaths.location, Deaths.date, Deaths.population, Vaccine.new_vaccinations,
SUM (Cast(Vaccine.new_vaccinations as int)) OVER (Partition by Deaths.location ORDER BY Deaths.location, Deaths.date) as RollingVaccinations
FROM COVID19Database.dbo.CovidDeaths Deaths
JOIN COVID19Database.dbo.CovidVaccinations Vaccine
	ON Deaths.location = Vaccine.location
	AND Deaths.date = Vaccine.date
WHERE Deaths.continent is not NULL
ORDER BY 2,3



--USING a CTE

-- Exploring Total Population that are vaccinated

WITH PopvsVac (continent, location, date, population, new_vaccinations, RollingVaccinations)
as
(
SELECT Deaths.continent, Deaths.location, Deaths.date, Deaths.population, Vaccine.new_vaccinations,
SUM (Cast(Vaccine.new_vaccinations as int)) OVER (Partition by Deaths.location ORDER BY Deaths.location, Deaths.date) as RollingVaccinations
FROM COVID19Database.dbo.CovidDeaths Deaths
JOIN COVID19Database.dbo.CovidVaccinations Vaccine
	ON Deaths.location = Vaccine.location
	AND Deaths.date = Vaccine.date
WHERE Deaths.continent is not NULL
)
SELECT*
FROM PopvsVac 




SELECT*, (RollingVaccinations/population)*100
FROM PopvsVac




--USING a TEMP TABLE

-- Exploring Total Population that are vaccinated

Drop Table if exists #PercentPopulationVacinnated
CREATE TABLE #PercentPopulationVacinnated
(
continent nvarchar (255),
location nvarchar (255),
date datetime, 
population numeric, 
new_vaccinations numeric, 
RollingVaccinations numeric
)

INSERT INTO #PercentPopulationVacinnated
SELECT Deaths.continent, Deaths.location, Deaths.date, Deaths.population, Vaccine.new_vaccinations,
SUM (Cast(Vaccine.new_vaccinations as int)) OVER (Partition by Deaths.location ORDER BY Deaths.location, Deaths.date) as RollingVaccinations
FROM COVID19Database.dbo.CovidDeaths Deaths
JOIN COVID19Database.dbo.CovidVaccinations Vaccine
	ON Deaths.location = Vaccine.location
	AND Deaths.date = Vaccine.date
WHERE Deaths.continent is not NULL

SELECT*, (RollingVaccinations/population)*100
FROM #PercentPopulationVacinnated



-- CREATING VIEWS FOR VISUALIZATION


-- View for totaldeaths by continent
CREATE VIEW TotalDeathsbyContinents as
SELECT continent,  MAX(cast(total_deaths as int)) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent is not NULL
Group by continent
--ORDER BY TotalDeathCount Desc


-- View for death percentages per country per day

CREATE VIEW DeathPercentagesDaily as
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM COVID19Database.dbo.CovidDeaths
--ORDER BY 1,2




--View for percentage of the population affected by Covid)

CREATE VIEW CovidPercentage as
SELECT location, date, population, total_cases, (total_cases/population)*100 as CasesPercentage
FROM COVID19Database.dbo.CovidDeaths
WHERE location like 'india'
--ORDER BY 1,2


-- View for Countries with highest infection rate compared to population

CREATE VIEW PercentofPopulationInfected as
SELECT location, population, MAX(total_cases) as HighestInfectionCount, Max(total_cases/population)*100 as PercentofPopulationInfected
FROM COVID19Database.dbo.CovidDeaths
Group by Population, Location
--ORDER BY PercentofPopulationInfected Desc


--View for Countries with highst deaths 

CREATE VIEW TotalDeathCountByCountry as
SELECT location,  MAX(cast(total_deaths as int)) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent is not NULL
Group by Location
--ORDER BY TotalDeathCount Desc


-- View for continents with highest deaths counts

CREATE VIEW TotalDeathCountByContinent as
SELECT continent,  MAX(cast(total_deaths as int)) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent is not NULL
Group by continent
--ORDER BY TotalDeathCount Desc




-- View for countries in each continent with highest deaths counts (Africa)

CREATE VIEW TotalDeathCountInAfrica as
SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'Africa'
Group by Location, continent
--ORDER BY TotalDeathCount Desc


--View for countries in each continent with highest deaths counts (North America)

CREATE VIEW TotalDeathCountInNorthAmerica as
SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'North America'
Group by Location, continent
--ORDER BY TotalDeathCount Desc



-- Views for countries in each continent with highest deaths counts (South America)

CREATE VIEW TotalDeathCountInSouthAmerica as
SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'South America'
Group by Location, continent
--ORDER BY TotalDeathCount Desc



-- View for countries in each continent with highest deaths counts (Asia)

CREATE VIEW TotalDeathCountInAsia as
SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'Asia'
Group by Location, continent
--ORDER BY TotalDeathCount Desc




--View for countries in each continent with highest deaths counts (Europe)

CREATE VIEW TotalDeathCountInEurope as
SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'Europe'
Group by Location, continent
--ORDER BY TotalDeathCount Desc



-- View for countries in each continent with highest deaths counts (Oceania)

CREATE VIEW TotalDeathCountInOceania as
SELECT location, continent, MAX(total_deaths) as TotalDeathCount
FROM COVID19Database.dbo.CovidDeaths
WHERE continent = 'Oceania'
Group by Location, continent
--ORDER BY TotalDeathCount Desc


--GLOBAL NUMBERS (VIEWS)

--Views for Daily total cases, total deaths and death percentages globaly.

CREATE VIEW DailyTotalCasesDeathPercentages as
SELECT date, SUM(new_cases) as GlobalDailyCases, SUM(cast(new_deaths as int)) as GlobalDailyDeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM COVID19Database.dbo.CovidDeaths
WHERE continent is not null
GROUP BY date
--ORDER BY 1,2

-- Views for Overall total cases, total deaths and death percentage


CREATE VIEW OverallTotalCasesDeathPercentages as
SELECT SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM COVID19Database.dbo.CovidDeaths
WHERE continent is not null
--ORDER BY 1,2







