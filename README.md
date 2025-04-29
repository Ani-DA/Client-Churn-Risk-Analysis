# Client-Churn-Risk-Analysis

## 1. Project Overview / Purpose
The objective of this project is to analyze client churn / retention patterns, operational efficiency, and revenue performance using a simulated fiduciary services dataset which has a multi-jurisdiction operations. The project aims to identify potential churn risks, segment clients by behavior and performance indicators, and provide clear, data-driven insights to support strategic decisions—particularly in compliance, client experience, and growth initiatives.


## 2. Dataset Overview
A synthetic dataset of 30,000 client records of a fictional financial services business structure across Guernsey, Jersey, Isle of Man, Mauritius, and The Bahamas. The dataset includes the following categories:

**Client Attributes: Client_ID, Join_Date, Jurisdiction, Client_Type, Status**

**Operational Metrics: Onboarding_Time_Days, Compliance_Time_Days, Exit_Date**

**Financial Metrics: Revenue_USD**

Using these columns the below columns were created to transform raw operational and financial data into interpretable segments that support faster, more strategic decision-making.
Raw metrics like revenue amounts or compliance days are continuous and hard to compare across thousands of clients. By converting these into categories (e.g., Revenue_Band, Compliance_Band), we enable quick comparison, pattern detection, and dashboard visualizations. 
**Engineered Features: Tenure_Months, Churn_Risk_Label,Complaiance_Band, Revenue_Band, Onboarding_Speed_Band**

Also business metrices that help to quickly make sense of the data like ARPU, Churn Rate, Total_Revenue were created.

![table_structure](https://github.com/user-attachments/assets/75582576-e59c-4433-b575-3152cfe9dce4)


## 3. Executive Summary
This analysis uses feature engineering and visual analytics to identify trends and behavioral patterns that influence client churn. 

![KPI](https://github.com/user-attachments/assets/e634f939-cf61-410b-8a7d-5495172e9413)

With 30000 client base amoung which churned customers being 4551 , the churn rate currently stands at nearly 15%. Corporate clients in the Mauritius Jurisdiction has the highest Churn Rate of 16.8% , whereas the same client type in Jersey has the lowest Churn Rate of 13.42% . Highest Churned Clients are in Mauritius with 3.14% of the overall client base, whereas Jersey has the least Churned Customers, with 2.91% of overall client base.

![KP!_1](https://github.com/user-attachments/assets/92ecbe97-e6b6-4569-80cd-fccbaf061dbc)


There has been a 51% growth in the active clients numbers from 2020 to 2021, but decline from there, most steeply in the late 2024 to march 2025 at 78%. The Churned clients numbers also follow a similar pattern.

The total Revenue(in USD) is 360 million and average revenue per user is around 12000.The Average Revenue Per User across the Jurisdictions varied across the Client almost similar. hence APRU not playing a differentiating factor in decision making.

![KPI_2](https://github.com/user-attachments/assets/9cb3f55b-dbae-4df8-a303-41c44d8dba96)

Using feature engineering, Churn_Risk_Label has been created in order to identify potential Risk level of clients,juridiction etc.

![risk_2](https://github.com/user-attachments/assets/59324980-1634-4030-b8f2-f410c4b00e3e)

Clients flagged as High Risk tend to have significantly lower average revenue compared to those in the Medium and Low Risk categories.

![risk_3](https://github.com/user-attachments/assets/42f4d25c-b911-4ae1-b961-2c8aa8295d08)


The Bahamas, Isle of Man, and Guernsey have the highest number of potential high-risk clients, despite Jersey having a larger overall client base. Notably, Jersey also has the fewest high-risk clients, positioning it as a strong jurisdiction for sustainable growth.

Since the Churn Risk Level is based on metrics like Revenue Band, Onboarding Speed, and Compliance Delays, these high-risk jurisdictions warrant deeper investigation. Enhancing onboarding and compliance efficiency, attracting higher-value clients, and improving early retention efforts can help mitigate churn risks—especially as long-tenure clients are more likely to stay and contribute to growth.

## 4. Code Analysis
Key business KPIs such as ARPU, churn rate, compliance delays, and onboarding time were computed using SQL and visualized in Power BI dashboards. Without implementing machine learning, logical thresholds and segmentation rules were applied to create a Churn_Risk_Label based on revenue levels, compliance label, onboarding label, and tenure.Findings indicate specific client types and jurisdictions that are more vulnerable to churn, offering clear opportunities for targeted retention strategies.

**Key SQL Features: Feature Engineering:**

Tenure_Months from Join_Date

Churn_Risk_Label based on rules combining Revenue, Compliance_Delay, Support_Tickets, and Tenure

![sql vw](https://github.com/user-attachments/assets/0303a6e3-2478-4554-b165-bb611b673cdf)


Year-over-Year (YoY) metrics using LAG() and EXTRACT() functions

KPI Queries:

ARPU = Revenue / Distinct Clients

Churn Rate = Exited Clients / Total Clients

Operational KPIs: Average onboarding time, support ticket analysis

![sql kpi](https://github.com/user-attachments/assets/75edb280-a7ec-42ce-91cf-73d3815f1ffc)


The sql file containing the queries are attached in the repository.

DAX Measures:
Churn Rate %, ARPU, Avg Compliance Delay, and segment-specific aggregations (e.g., ARPU by jurisdiction, churn rate by risk level)

Filters and slicers for dynamic dashboard interactivity

## 5. Insights


Clients flagged as High Risk tend to have significantly lower average revenue compared to those in the Medium and Low Risk categories.

The Bahamas, Isle of Man, and Guernsey have the highest number of potential high-risk clients, despite Jersey having a larger overall client base. Notably, Jersey also has the fewest high-risk clients, positioning it as a strong jurisdiction for sustainable growth.

Since the Churn Risk Level is based on metrics like Revenue Band, Onboarding Speed, and Compliance Delays, these high-risk jurisdictions warrant deeper investigation. Enhancing onboarding and compliance efficiency, attracting higher-value clients, and improving early retention efforts can help mitigate churn risks—especially as long-tenure clients are more likely to stay and contribute to growth.



## 6. Recommendations
**Proactive Retention Focus:** Engage high-risk clients (e.g., low revenue, high delay, high ticket volume) early, especially **within the first 6 months**.

**Jurisdiction-Specific Strategy:** Invest in operational efficiency in high-churn regions like **The Bahamas,Isle of Man, and Guernsey**; replicate **high-performing strategies from Jersey**.

**Compliance Optimization:** Streamline onboarding and compliance pipelines to improve early-stage client experience.

**Monitor ARPU Segments:** Use ARPU tiers to tailor relationship management and upsell strategies. As seen, higher revenue clients tend to be of lower churn risk, much targeted efforts and appropriate strategies should be adopted for attraching high value clients.
