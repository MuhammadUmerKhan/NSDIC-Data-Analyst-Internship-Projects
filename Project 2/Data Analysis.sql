-- Project Objective: 
	-- Determine the headcount for each job role.
	-- Analyze the gender distribution among staff.
	-- Assess salary discrepancies across various positions.
	-- Identify the highest earners in each role.
	-- Examine the relationship between qualifications and salaries.
	-- Conduct an analysis of leave balances.
	-- Create a streamlined HR dashboard for quick insights.

select * from hr_data_analysis;

-- Determine the headcount for each job role.
select Job_Title, count(Job_Title) as Head_count from hr_data_analysis group by Job_Title order by Head_count desc;

-- Analyze the gender distribution among staff.
select Job_Title, Gender, count(Gender) as Gender_Count from hr_data_analysis group by Job_Title, Gender order by Gender, Gender_Count desc;

SELECT Gender, COUNT(Gender) AS count
FROM hr_data_analysis
GROUP BY Gender;


-- Assess salary discrepancies across various positions.
select Job_Title, sum(Salary_digit) as Salary from hr_data_analysis group by Job_Title order by Salary desc;
select Job_Title, avg(Salary_digit) as avg_salary, max(Salary_digit) - min(Salary_digit) as salary_range from hr_data_analysis group by Job_Title;


-- Identify the highest earners in each role.
select hr.Job_Title, hr.Name, hr.Salary_digit from hr_data_analysis hr 
where
hr.Salary_digit = (select max(Salary_digit) from hr_data_analysis where Job_Title = hr.Job_Title) order by hr.Job_Title;

with max_salaries as (
	select Job_Title, max(Salary_digit) as Highest_earnings from hr_data_analysis group by Job_Title
)
select hr.Job_Title, hr.Name, hr.Salary_digit from hr_data_analysis hr 
join max_salaries max on hr.Job_Title = max.Job_Title and hr.Salary_digit = max.Highest_earnings
 order by hr.Job_Title;

-- Examine the relationship between qualifications and salaries.
select Education_Qualification, avg(Salary_digit) as Average_Salaries from hr_data_analysis group by Education_Qualification; 

-- Conduct an analysis of leave balances.
select Job_Title, avg(Leave_Balance) as Average_Leave_Balance from hr_data_analysis group by Job_Title;

select Job_Title, sum(Leave_Balance) as Total_Leave_Balance from hr_data_analysis group by Job_Title;

select Name, Job_Title, Leave_Balance from hr_data_analysis order by Leave_Balance desc limit 5;

select Name, Job_Title, Leave_Balance as Leave_left from hr_data_analysis order by Leave_Balance asc limit 5;