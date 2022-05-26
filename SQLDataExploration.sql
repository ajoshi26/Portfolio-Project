--SELECT * 
--FROM Portfolio_Project..[covid _vaccinations]
--ORDER BY 3,4

SELECT * 
FROM Portfolio_Project..[covid _deaths]
Where continent is not null
ORDER BY 3,4


--Selecting Data
SELECT Location, date, total_cases, total_deaths, population
FROM Portfolio_Project..[covid _deaths]
Where continent is not null
ORDER BY 1,2

-- Total Cases vs Total Deaths in the United States and 
-- likeilhood of getting COVID
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
FROM Portfolio_Project..[covid _deaths]
WHERE location like '%states%' and continent is not null
ORDER BY 1,2

--Total Cases vs Population
--Percentage of population of COVID cases
SELECT Location, date, total_cases, population, (total_cases/population) * 100 as PercentageOfCases
FROM Portfolio_Project..[covid _deaths]
WHERE location like '%states%' and continent is not null
ORDER BY 1,2

--Countries with highest infection rate compared to population
SELECT Location, MAX(total_cases) as highestInfectionCount, population, MAX((total_cases/population)) * 100 as PercentageOfInfected
FROM Portfolio_Project..[covid _deaths]
Where continent is not null
GROUP BY Location, Population
ORDER BY PercentageOfInfected DESC

--Showing Countries with the Highest Death Count per Population
SELECT Location, MAX(cast(total_deaths as int))  as TotalDeathCount
FROM Portfolio_Project..[covid _deaths]
Where continent is not null
GROUP BY Location
ORDER BY TotalDeathCount DESC

--Showing the continents with the highest death count
SELECT continent, MAX(cast(total_deaths as int))  as TotalDeathCount
FROM Portfolio_Project..[covid _deaths]
Where continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- Global Numbers

SELECT date, SUM(new_cases) as global_cases, SUM(cast(new_deaths as int)) as global_deaths, SUM(cast(new_deaths as int))/SUM(new_cases) * 100 as DeathPercentage
FROM Portfolio_Project..[covid _deaths]
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

--Total Population that have been Vaccinated
SELECT deaths.continent,deaths.location,deaths.date,vac.new_vaccinations,
SUM(cast(vac.new_vaccinations as bigint)) OVER (PARTITION BY deaths.location ORDER BY deaths.location, deaths.Date) as rolling_total_vaccinated
FROM Portfolio_Project..[covid _deaths] deaths
JOIN Portfolio_Project..[covid _vaccinations] vac
	ON deaths.location = vac.location
	AND deaths.date = vac.date
WHERE deaths.continent is not null
ORDER BY 1,2,3














