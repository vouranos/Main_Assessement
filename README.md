# Main_Assessement


1) Run the below query in Big Query table:
SELECT 
*,
datetime(submit_dt, "UTC") as datetime,
date(submit_dt,"UTC" ) as date,
time(submit_dt,"UTC") as time
FROM `bi-2019-test.ad_hoc.orders_jan2021`;

2)Save Results (select option CSV Google Drive)

3)Download Results from Google Drive locally and rename the file to Orders.csv

4)Open the R code and set the input file path (Orders.csv from previous step) 
and  output file path (name the output file path customers.csv)

5)Run the R code
