SELECT *
FROM PortfolioProject..CovidDeaths
where continent is not null
ORDER BY 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDER BY 3,4

--Select data to be used
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
where continent is not null
ORDER BY 1,2

--Total cases vs Total deaths
--Likelihood of dying if you contract covid in your country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
where location like '%kenya%'
and continent is not null
ORDER BY 1,2

--Total cases vs Population
--Percentage of population that got covid
SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentofPopulationInfected
FROM PortfolioProject..CovidDeaths
--where location like '%kenya%'
ORDER BY 1,2

--Countries with highest infection rates compared to Population
SELECT location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentofPopulationInfected
FROM PortfolioProject..CovidDeaths
--where location like '%kenya%'
GROUP BY  location, population
ORDER BY PercentofPopulationInfected desc

--Countries with the highest death count per population
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--where location like '%kenya%'
where continent is not null
GROUP BY  location
ORDER BY  TotalDeathCount desc

--Exploring data by continent

--Continents with the highest death count per population
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--where location like '%kenya%'
where continent is not null
GROUP BY  continent
ORDER BY  TotalDeathCount desc

--Global numbers

SELECT date, SUM(new_cases) AS Total_cases, SUM (CAST (new_deaths AS int)) AS Total_deaths, SUM(CAST(new_deaths AS int))/SUM(new_cases) * 100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
--where location like '%kenya%'
where continent is not null
GROUP BY date 
ORDER BY 1,2

--Total global numbers

SELECT SUM(new_cases) AS Total_cases, SUM (CAST (new_deaths AS int)) AS Total_deaths, SUM(CAST(new_deaths AS int))/SUM(new_cases) * 100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
--where location like '%kenya%'
where continent is not null
--GROUP BY date 
ORDER BY 1,2

--Total population vs Vaccinations

SELECT death.continent, death.location, death.date, death.population, vaccine.new_vaccinations, 
SUM(CAST(vaccine.new_vaccinations AS int)) OVER (PARTITION BY death.location ORDER BY death.location,death.date)
AS RollingPeopleVaccinated, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths death
join PortfolioProject..CovidVaccinations vaccine
     on death.location = vaccine.location
	 and death.date = vaccine.date
WHERE death.continent is not null
ORDER BY 2,3

--Use CTE

with PopulationvsVaccination (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as 
(
SELECT death.continent, death.location, death.date, death.population, vaccine.new_vaccinations, 
SUM(CAST(vaccine.new_vaccinations AS int)) OVER (PARTITION BY death.location ORDER BY death.location,death.date)
AS RollingPeopleVaccinated--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths death
join PortfolioProject..CovidVaccinations vaccine
     on death.location = vaccine.location
	 and death.date = vaccine.date
WHERE death.continent is not null
--ORDER BY 2,3
)
select *, (RollingPeopleVaccinated/population)*100
From PopulationvsVaccination

--Temporary table
Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated 
(
Continent nvarchar(255),
Location  nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccinated
SELECT death.continent, death.location, death.date, death.population, vaccine.new_vaccinations, 
SUM(CAST(vaccine.new_vaccinations AS int)) OVER (PARTITION BY death.location ORDER BY death.location,death.date)
AS RollingPeopleVaccinated--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths death
join PortfolioProject..CovidVaccinations vaccine
     on death.location = vaccine.location
	 and death.date = vaccine.date
--WHERE death.continent is not null
--ORDER BY 2,3

select *, (RollingPeopleVaccinated/population)*100
From #PercentPopulationVaccinated

--Creating view to store data for visualizations


Create View PercentPopulationVaccinated as
SELECT death.continent, death.location, death.date, death.population, vaccine.new_vaccinations, 
SUM(CAST(vaccine.new_vaccinations AS int)) OVER (PARTITION BY death.location ORDER BY death.location,death.date)
AS RollingPeopleVaccinated--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths death
join PortfolioProject..CovidVaccinations vaccine
     on death.location = vaccine.location
	 and death.date = vaccine.date
WHERE death.continent is not null
--ORDER BY 2,3

Select *
From PercentPopulationVaccinated