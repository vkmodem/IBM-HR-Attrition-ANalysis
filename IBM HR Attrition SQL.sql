
with total_employees as 
(select department, count(*) as total_count
 from hr_attrition
 group by department),
 employees_left as ( select department, 
 count(*) as total_left  from hr_attrition
 where attrition = "yes"
 group by department)
 select  ( 100 *( sum(l.total_left) / sum(e.total_count) )) as attrition_rate  from total_employees e join employees_left l
 on e.department = l.department;

select 
    100 * sum(case when attrition = 'Yes' then 1 else 0 end) 
        / count(*) as attrition_rate
from hr_attrition;

 
 
 
## 1. What is our overall employee attrition rate?
  select department, count(*) as employees_left 
  
 from hr_attrition
 where attrition = "Yes"
 group by department;
 
## 2.  Which departments are experiencing the highest attrition?
 select department, count(*) as employees_left
 from hr_attrition
 where attrition = "Yes"
 group by department
 order by employees_left desc;
 
## 3. Which job roles have the highest and lowest attrition rates?

 WITH attrition_count AS (
    SELECT job_role,
           COUNT(*) AS employees_left
    FROM hr_attrition
    WHERE attrition = 'Yes'
    group by job_role
),
 minmax as (select 
 min(employees_left) as min_attrition,
max(employees_left) as max_attrition
from attrition_count)
select a.job_role,
a.employees_left 
from attrition_count a join minmax m
on a.employees_left = m.min_attrition 
or  a.employees_left = m.max_attrition;


## 4. How does attrition vary by demographic and career factors (Gender, Marital Status, Education Field, and Job Level)?

select 
    gender,
    marital_status,
    education_field,
    job_level,
    100 * sum(case when attrition = 'Yes' then 1 else 0 end) / count(*) as attrition_rate
from hr_attrition
group by 
    gender,
    marital_status,
    education_field,
    job_level;

## 5. Are compensation and rewards linked to attrition? Analyze attrition by Monthly Income bands, Percent Salary Hike, and Stock Option Level.

select 
   case 
        when monthly_income < 3000 then 'Low Income'
        when monthly_income between 3000 and 6000 then 'Mid Income'
        else 'High Income'
    end as income_band,
  percent_salary_hike,stock_option_level,
    100 * sum(case when attrition = 'Yes' then 1 else 0 end) / count(*) as attrition_rate
from hr_attrition
group by 
  income_band,
  percent_salary_hike,
  stock_option_level
  order by stock_option_level;
  
##6.  What characteristics distinguish employees who leave versus those who stay? Compare Age, Distance From Home, Total Working Years, Years At Company, Training Times Last Year, and Work-Life Balance.

select
    case 
        when age < 30 then 'Below 30'
        when age between 30 and 40 then '30-40'
        else 'Over 40'
    end as age_band,
    distance_from_home,
    total_working_years,
    years_at_company,
    training_times_last_year,
    work_life_balance,
    100 * sum(case when attrition = 'Yes' then 1 else 0 end) / count(*) as attrition_rate
from hr_attrition
group by
    case 
        when age < 30 then 'Below 30'
        when age between 30 and 40 then '30-40'
        else 'Over 40'
    end,
    distance_from_home,
    total_working_years,
    years_at_company,
    training_times_last_year,
    work_life_balance
order by
    age_band,
    distance_from_home;


## Which combinations of factors create the highest attrition risk (e.g., Department + Job Role, Job Role + Overtime, Job Level + Work-Life Balance)?
select
    department,
    job_role,
    over_time,
    job_level,
    work_life_balance,
    100 * sum(case when attrition = 'Yes' then 1 else 0 end) / count(*) as attrition_rate
from hr_attrition
group by
    department,
    job_role,
    over_time,
    job_level,
    work_life_balance
order by attrition_rate desc;




## Rank job roles by attrition rate within each department.
with role_attrition as (
    select
        department,
        job_role,
        100 * sum(case when attrition = 'Yes' then 1 else 0 end) / count(*) as attrition_rate
    from hr_attrition
    group by department, job_role
),
ranked as (
    select
        department,
        job_role,
        attrition_rate,
        dense_rank() over (
            partition by department
            order by attrition_rate desc
        ) as attrition_rank
    from role_attrition
)
select *
from ranked
order by department, attrition_rank;




