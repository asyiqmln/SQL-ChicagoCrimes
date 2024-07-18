## How many total crime incidents are recorded in the chicago_crime table?
select count(primary_type) as total_crime from chicago_crime;

## What are the different types of crimes recorded in the chicago_crime table?
select distinct primary_type from chicago_crime;

## How many crime incidents occurred each year?
select year, count(primary_type) as Count_of_Crimes from chicago_crime group by year order by year asc;

## Calculate the total number of crimes in each location of crimes
select location_description as Crime_Locations, count(PRIMARY_TYPE) as Total_Crimes from chicago_crime group by LOCATION_DESCRIPTION order by Total_Crimes desc;

##List the crime type along with their average per capita income 
select c.PRIMARY_TYPE, avg(cs.PER_CAPITA_INCOME) as Average_Income
from chicago_crime c
left join chicago_socioeconomic_data cs
on c.COMMUNITY_AREA_NUMBER = cs.COMMUNITY_AREA_NUMBER
group by c.PRIMARY_TYPE
order by Average_Income desc;

##List the crime type along with the every type percentage to total crimes
DECLARE @total INT;
set @total = (select count(PRIMARY_TYPE) from chicago_crime);

select PRIMARY_TYPE, concat(round(count(PRIMARY_TYPE)/@total*100,2),'%') as Percentage_from_Total
from chicago_crime
group by PRIMARY_TYPE; 

##Find the locations with the highest crime rates and their corresponding average income.
select
	cs.COMMUNITY_AREA_NAME, concat(round(count(c.PRIMARY_TYPE)/@total*100,2),'%') as Crime_Percentage,
	round(avg(cs.PER_CAPITA_INCOME),0) as Average_Income
from chicago_socioeconomic_data cs 
left join chicago_crime c
on cs.COMMUNITY_AREA_NUMBER = c.COMMUNITY_AREA_NUMBER
group by cs.COMMUNITY_AREA_NAME 
order by Crime_Percentage desc;

##Identify the locations with high unemployment rates and the number of crimes in those areas.
select cs.COMMUNITY_AREA_NAME, concat(cs.PERCENT_AGED_16__UNEMPLOYED,'%') as Unemployment_Rates, count(c.PRIMARY_TYPE) as Number_of_Crimes
from chicago_socioeconomic_data cs 
left join chicago_crime c
on cs.COMMUNITY_AREA_NUMBER = c.COMMUNITY_AREA_NUMBER
group by cs.COMMUNITY_AREA_NAME, Unemployment_Rates
order by Number_of_Crimes desc;

##Find the relationship between the number of crime incidents and the education level in each location.
select cs.COMMUNITY_AREA_NAME, concat(cs.PERCENT_AGED_25__WITHOUT_HIGH_SCHOOL_DIPLOMA,'%') as No_Diploma_Rates, count(c.PRIMARY_TYPE) as Number_of_Crimes
from chicago_socioeconomic_data cs 
left join chicago_crime c
on cs.COMMUNITY_AREA_NUMBER = c.COMMUNITY_AREA_NUMBER
group by cs.COMMUNITY_AREA_NAME, No_Diploma_Rates
order by Number_of_Crimes desc