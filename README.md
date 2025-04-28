**COVID19-DATA-EXPLORATION BY PRISCILLA LATINWO**




**PROJECT OVERVIEW**

This project focuses on exploratory data analysis of COVID-19 case and vaccination data spanning the height of the global pandemic (2020–2021).
Using SQL for data transformation and exploration, and Tableau for visualization, the objective was to uncover key patterns and insights related to infection rates, death rates, and geographic trends across continents and countries.



**BUSINESS OBJECTIVES**

The core goal of this project was to support data-driven decision making by answering critical questions, including:
- What was the total number of COVID-19 deaths during the selected period?
- Which continents recorded the highest death rates relative to cases?
- Which countries had the highest infection rates relative to their populations?
- How did average case numbers evolve over time across different countries?



**DATA SOURCE**

- Source: Our World in Data COVID-19 Dataset
- Access: Public dataset compiled by the University of Oxford and other partners, professionally maintained and updated.
- Scope: Global data covering confirmed cases, deaths, population metrics, and vaccination statistics for 2020–2021.

**METHODOLOGY**

**1. Data Acquisition and Preparation**

- Downloaded COVID-19 case and vaccination datasets from Our World in Data.
- Cleaned raw datasets using Microsoft Excel:
-   Removed irrelevant columns and standardized date formats.
-   Separated COVID-19 case data and vaccination data into two distinct Excel workbooks for clarity.



**2. Data Transformation**

- Imported the cleaned Excel files into SQL Server.
- Established relationships between COVID-19 cases and vaccination datasets using SQL joins.
- Handled missing values and ensured referential integrity.



**3. Exploratory Data Analysis (EDA)**

Used SQL queries to extract key metrics:
-   Aggregated total cases, deaths, and vaccination numbers.
-   Calculated death rates relative to total confirmed cases.
-   Analyzed infection rates based on population sizes.
-   Grouped data by continent and country for comparative analysis.



**4. Data Visualization**

- Exported transformed data into Tableau.
- Built interactive dashboards to highlight major insights visually:
-   Heatmaps by continent and country.
-   Trend lines showing case evolution over time.
-   Bar charts comparing infection and death rates.

**KEY FINDINGS**

Global Mortality Rate:
- Approximately 2% of confirmed global COVID-19 cases resulted in death during the selected period.

Continent-Level Analysis:
- North America and South America recorded the highest COVID-19 death rates relative to case numbers.
- These continents accounted for a disproportionately high share of global deaths compared to others.

Country-Level Analysis:
- The United States had the highest number of confirmed infections relative to its total population, with infection rates affecting approximately 10% of its residents.
- The U.S. also reported the highest number of COVID-19 deaths globally during this time frame.

Trends Over Time:
- Case numbers exhibited several distinct spikes, often correlating with known waves of the pandemic.
- Vaccination efforts, while impactful, showed varied uptake rates across continents and countries.

**RECOMMENDATIONS**

For Policy Makers:
- Focus on early detection and proactive management of infection surges, especially in high-risk regions.
- Tailor public health interventions geographically based on continent and country-specific trends.

For Healthcare Systems:
- Analyze spikes in case numbers to ensure adequate resource allocation during future health crises.
- Use population-adjusted infection rates rather than raw case counts for more equitable healthcare responses.

For Data Analysts:
- Continually integrate vaccination data alongside case data for holistic analysis.
- Prioritise real-time data updates to allow faster, more informed decision-making during pandemics or similar crises.

**VISUALISATION**

An interactive Tableau dashboard was developed to visually represent key findings.

![image](https://user-images.githubusercontent.com/93530232/214538037-d7b3c713-2e28-4753-8b0d-cc8490b9a1b3.png)


Explore the Dashboard ➔ https://public.tableau.com/views/COVID19VIZ_16745976485330/Covid19Viz?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link 














