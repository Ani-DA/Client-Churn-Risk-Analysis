
select count(*) from dbo.client_data

select * from dbo.client_data

---check for duplicate data
select * 
from client_data
group by
	Client_ID,
	Join_Date,
	Jurisdiction,
	Client_Type,
	Revenue_USD,
	Onboarding_Time_Days,
	Compliance_Time_Days,
	Status,
	Exit_Date
having count(*)>1

---checking for null values
select * 
from client_data
where
	Client_ID IS NULL
	OR Join_Date IS NULL
	OR Jurisdiction IS NULL
	OR Client_Type IS NULL
	OR Revenue_USD IS NULL
	OR Onboarding_Time_Days IS NULL
	OR Compliance_Time_Days IS NULL
	OR Status IS NULL
	OR Exit_Date IS NULL


select * from client_data
where Exit_Date IS NULL;


---creating columns 'client_status' and 'tenure'
alter table client_data
add Tenure int

---populating values in those columns
update client_data
set Tenure =
	DATEDIFF(day, Join_Date,COALESCE(Exit_Date,getdate()))


---YOY Revenue growth
select
    Revenue_Year,
    Total_Revenue,
    lag(Total_Revenue) over (order by Revenue_Year) as Last_Year_Revenue,
    round(
        (Total_Revenue - lag(Total_Revenue) over (order by Revenue_Year)) 
        / nullif(lag(Total_Revenue) over (order by Revenue_Year), 0) * 100,
        2
    ) as YOY_Growth_Percent
from
    (
        select
            year(Join_Date) as Revenue_Year,
            sum(Revenue_USD) as Total_Revenue
        from
            client_data
        group by
            year(Join_Date)
    ) Yearly_Revenue
order by
    Revenue_Year;

---YOY growth in no of clients
SELECT
    Client_Join_Year,
    Num_Clients,
    LAG(Num_Clients) OVER (ORDER BY Client_Join_Year) AS Last_Year_Num_Clients,
    ROUND(
        (Num_Clients - LAG(Num_Clients) OVER (ORDER BY Client_Join_Year)) * 1.0 
        / NULLIF(LAG(Num_Clients) OVER (ORDER BY Client_Join_Year), 0) * 100,
        2
    ) AS YOY_Client_Growth_Percent
FROM
    (
        SELECT
            YEAR(Join_Date) AS Client_Join_Year,
            COUNT(Client_ID) AS Num_Clients
        FROM
            client_data
        GROUP BY
            YEAR(Join_Date)
    ) Yearly_Client_Count
ORDER BY
    Client_Join_Year;




---creating some features for further analysis, into a view
create view v_feature_risk 
as
select
	Client_ID,
	Join_Date,
	Jurisdiction,
	Client_Type,
	Revenue_USD,
	Onboarding_Time_Days,
	Compliance_Time_Days,
	Tenure ,
	Status,
	case
		when Revenue_USD < 5000 then 'Low'
		when Revenue_USD > 5000 and Revenue_USD < 15000 then 'Medium'
		else 'High'
	end as Revenue_Band,
	case
		when Compliance_Time_Days < 10 then 'Fast'
		when Compliance_Time_Days > 10 and Compliance_Time_Days < 20 then 'Medium'
		else 'Slow'
	end as Complaiance_Band,
	case
		when Onboarding_Time_Days < 5 then 'Very Fast'
		when Onboarding_Time_Days > 5 and Onboarding_Time_Days < 10 then 'Fast'
		else 'Slow'
	end as Onboarding_Speed_Band,
	case 
        when Revenue_USD < 5000 AND Compliance_Time_Days > 20 AND Onboarding_Time_Days > 10 then 'High Risk'
        when Revenue_USD BETWEEN 5000 AND 15000 AND Compliance_Time_Days BETWEEN 10 AND 20 then 'Medium Risk'
        else 'Low Risk'
    end as Churn_Risk_Level
from client_data

---checking the view
select * from v_feature_risk


---aggregating KPIs for summery 
select 
	COUNT(distinct case when Status = 'Active' then Client_ID end) as No_of_Active_clients,
	COUNT(distinct case when Status = 'Exited' then Client_ID end) as No_of_Churned_clients,
	round(avg(Onboarding_Time_Days),1) as Avg_Onboarding_Days,
	round(avg(Compliance_Time_Days),1) as Avg_Complaince_Days,
	round(sum(Revenue_USD),2) as Total_Revenue,
	round(avg(Revenue_USD),2) as ARPU,
	round(avg(Tenure),1) as Avg_Tenure_Days,
	round(
			count(distinct case when Status='Exited' then Client_ID end)*100/
			count(distinct Client_ID)			
			,2
	) as Churn_Rate_Percent
from client_data


---churn risk level per juradiction
select
	Jurisdiction,
	count(case when Churn_Risk_Level = 'High Risk' then Client_ID end) as 'High_Risk_Clients' ,
	count(case when Churn_Risk_Level = 'Medium Risk' then Client_ID end) as 'Medium_Risk_Clients' ,
	count(case when Churn_Risk_Level = 'Low Risk' then Client_ID end) as 'Low_Risk_Clients',
	count(Client_ID) as Total_Clients
from v_feature_risk
group by Jurisdiction
order by Jurisdiction

---average revenue by churn risk label
select
	round(avg(Revenue_USD),2) as Average_Revenue,
	count(Client_ID) as Total_Clients,
	Churn_Risk_Level
from v_feature_risk
group by Churn_Risk_Level
order by Churn_Risk_Level

