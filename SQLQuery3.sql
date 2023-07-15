Select *
From [portflio project]..covid_death
where continent is not null
order by 3,4

--Select *
--From [portflio project]..covid_vaccine
--order by 3,4

Select location, date, total_cases, new_cases, total_deaths, population
From [portflio project]..covid_death
order by 1,2


-- looking at total cases vs total death
-- show likelihood of dying if you contract covid in your country
Select location, date, total_cases, total_deaths,(CAST(total_deaths AS decimal(12,2))/CAST(total_cases AS decimal(12,2)))*100 as deathpercentage
From [portflio project]..covid_death
order by 1,2


--looking at total cases vs population
-- showing what percentage of population got covid

Select location, date,population,total_cases, (CAST(total_cases AS decimal(12,2))/CAST(population AS decimal(12,2)))*100 as populationpercentage
From [portflio project]..covid_death
where location like '%nigeria%'
order by 1,2
 
 
 -- Looking at Countries with Higest Infection rate compared to Population

 Select location, population,  MAX(total_cases) as HighestInfectionCount, Max(CAST(total_cases AS decimal(12,2))/CAST(population AS decimal(12,2)))*100 as populationpercentageinfected
From [portflio project]..covid_death
Group by location, population
order by populationpercentageinfected desc

-- showing countries  with Highest Death Count per population

Select location, MAX(cast(total_deaths as int)) as TotaldeathCount
From [portflio project]..covid_death
where continent is not null
Group by location
order by TotaldeathCount desc

-- LET'S BREAK THINGS DOWN BY CONTINENT
Select continent, MAX(cast(total_deaths as int)) as TotaldeathCount
From [portflio project]..covid_death
where continent is not null
Group by continent
order by TotaldeathCount desc

-- GLOBAL  NUMBER

SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_cases)*100 as DEathPercentage
from [portflio project]..covid_death
where continent is not null
Group by date
order by 1,2 

-- looking at total population vs vaccinations

select *
from [portflio project]..covid_death dea
join [portflio project]..covid_vaccine vac
      on dea.location = vac.location
	  and dea.date = vac.date


select  dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from [portflio project]..covid_death dea
join [portflio project]..covid_vaccine vac
      on dea.location = vac.location
	  and dea.date = vac.date
where dea.continent is not null
order by 2,3

 
 -- creating view to store data for later visualizations

 create view populationvaccinated as
 select  dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from [portflio project]..covid_death dea
join [portflio project]..covid_vaccine vac
      on dea.location = vac.location
	  and dea.date = vac.date
where dea.continent is not null
--order by 2,3


select *
from populationvaccinated