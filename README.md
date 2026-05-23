# Case-Study-with-Cyclistic
Google Data Analytics Capstone Project

Topic: Cyclistic Case Study directed by Lily Moreno
Date: 05/21/2026

I, Mark Jackson, worked between SQL(BigQuery), R, EXCEL/Sheets, and TABLEAU for visualizations here. 

<https://public.tableau.com/app/profile/mark.jackson8218/viz/CaseStudyCyclisticGoogleDataAnalysis/Dashboard7#1>

## INTRODUCTION
Initially, I was assigned a fictional role from CYCLISTIC, a bike-sharing company based in Chicaco, IL. Since 2016, they have been a successful bike-sharing company. Lily Moreno is the director, and my upper management. At this point, I am 6 months into the role, and they are known for having over 5,000 bikes with various cool features while serving over 600 stations in Chicago. We provide various pricing plans for membership including, but not limited to their annual memberships. Thankfully, the data is retrieved from a reliable source. <https://divvybikes.com/data-license-agreement> 
License is for free, and public use sourced from DIVVY, and LYFT.
To ensure practical protocols of data privacy, no PII (personal identifying information) is found within these documents.

Nevertheless, The first 3 months (January 2026 to March 2026) of Cyclistic trip data was downloaded and stored locally as .csv files in a YYYYMM-CompanyName-TripData format. My current computer could not process a larger workload-- so this excercise will focus on the practicality of
manipulating complex data structures in a short time frame, and reconfiguring them into meaningful insights. 

## ASK
The data is determined to be comprehensive, but contains some flaws. Most notably nulls, and outliers as seen in Process Report.sql
Since the massd of data in each .csv file is large I will provide an access link here as an example of what can also be intergrated with this analysis.
(<https://divvy-tripdata.s3.amazonaws.com/index.html>)


Next, I would ask myself what relates to eachother within the schemas of data, and how they can be viewed in correlation to eachother. After review, there were ample empty station values that represents the potential outliers in the data. Complex data cleaning must be arranged in order to manage outstanding file sizes, and provide clear insights for stakeholders. (Lily, the marketing team, and the executive team)

## PREPARE

My business task is to analyze how annual members, and casual riders use their Cyclistic bikes differently. In addition, we added the scope of the entire Case Study. Further, why would casual riders buy Cyclistic annual memberships? Plus, how digital media could be valued to influence more conversions from data-driven decision making to bring additional revenue. We begin with Preclean.sql

## PROCESS

In short, we will primarily focus on 2026 to reflect on the current estimated goals within a presumed week's given deadline, and aim to fully comprehend the dataset with the additional help of mentors in order to empathize the critical relationships of complex datasets as a junior data analyst.

Below, the code is made to provide instantenous output of each table based on the conditional logic of nulls. First, I separated nulls with various mentioned conditional formatting(outliers), and then dove into the largest recommended dataset.

Then I focused on the largest dataset by including stations with only one station listed at start or end of ride.

## ANALYZE
(<https://public.tableau.com/app/profile/mark.jackson8218/viz/CaseStudyCyclisticGoogleDataAnalysis/Dashboard7#1>)

.
.
.
After analysis, we learned casual members do not share clear conversion metrics within the dataset. On the weekends, casual member's ride times nearly doubles compared to annual members partly due to electric bikes on the average week. (1.8x) More data would be required to effectively answer the other questions, and be demonstrated within consideration of a review within new deadlines.

In conclusion, we should integrate more qualitative, and quantitative data for analysis for the rest of 2026.  We could attain more essential, and unique data metrics of the current year. Moreover, there is room to improve how we approach our optimal impact on consumers of our product. As a service for the people we should have an understanding where our digital footprint currently was, and is as it will help us continue to grow.

I would suggest to SHARE:

1) An application where riders can track their overall progress

2) Discounted memberships as a promotional campaign for longtime casual riders from Cyclistic, and also

3) Build a community that reminds riders of their redeeming qualities of being a customer, and/or share positive experiences of the community converting to annual within CYCLISTIC.

Why? To show our consumers we care about their overall experience with us! 

Thanks for reviewing this, and if you have any feedback, would like to connect, and/or need mentorship I am also looking for experiences with connecting to other Data Analysts, Data Scientists, or Engineers as well. You can find me via my portfolio here on Kaggle, as well as other DMRs like Github, and potentially soon to Youtube!

Potential business inquiries, and networking opportunites can contact me at: majackson412@yahoo.com

Thanks for making it this far! Have a great year. To my fellow analysts, keep going! You got this. :)

Please consider following me on socials for project updates, my professional and personal businesses, as well as technical, and adaptive data insights.

LinkedIn: (<https://www.linkedin.com/in/mjanalysis/>)
Kaggle:   (<https://www.kaggle.com/code/sainticarus/google-data-analytics-capstone-project-a>)
