rm(list = ls())

if ("rfm" %in% rownames(installed.packages())==TRUE ) { require ('rfm')} else {install.packages("rfm")}
if ("dplyr" %in% rownames(installed.packages())==TRUE ) { require ('dplyr')} else {install.packages("dplyr")}


library("rfm")
library("dplyr")


file_path<-"C:/Users/vasileios.ouranos/OneDrive - Accenture/Desktop/Main Assessement/Orders.csv"



Orders<-read.csv(file_path,encoding = 'UTF-8' )
Orders$date<-as.Date(Orders$date)
Orders$user_id<-as.character(Orders$user_id)
analysis_date <- lubridate::as_date("2021-02-01", tz = "UTC")

rfm_score <- rfm_table_order(Orders, user_id, date, basket, analysis_date,recency_bins = 4,frequency_bins =4, monetary_bins = 4)


#Customer Segmentation

champions <- c(444)
loyal_customers <- c(334, 342, 343, 344, 433, 434, 443)
potential_loyalist <- c(332,333,341,412,413,414,431,432,441,442,421,422,423,424)
recent_customers <- c(411)
promising <- c(311, 312, 313, 331)
needing_attention <- c(212,213,214,231,232,233,241,314,321,322,323,324)
about_to_sleep <- c(211)
at_risk <- c(112,113,114,131,132,133,142,124,123,122,121,224,223,222,221)
cant_lose <- c(134,143,144,234,242,243,244)
hibernating <- c(141)
lost <- c(111)


rfm_scores<-as.vector(rfm_score$rfm$rfm_score)
rfm_scores[which(rfm_score$rfm$rfm_score %in% champions)]="Champions"
rfm_scores[which(rfm_scores %in% potential_loyalist)] = "Potential Loyalist"
rfm_scores[which(rfm_scores %in% loyal_customers)] = "Loyal Customers"
rfm_scores[which(rfm_scores %in% recent_customers)] = "Recent Customers"
rfm_scores[which(rfm_scores %in% promising)] = "Promising"
rfm_scores[which(rfm_scores %in% needing_attention)] = "Customer Needing Attention"
rfm_scores[which(rfm_scores %in% about_to_sleep)] = "About to Sleep"
rfm_scores[which(rfm_scores %in% at_risk)] = "At Risk"
rfm_scores[which(rfm_scores %in% cant_lose)] = "Can't Lose Them"
rfm_scores[which(rfm_scores %in% hibernating)] = "Hibernating"
rfm_scores[which(rfm_scores %in% lost)] = "Lost"

customer_segment<-data.frame(cus_seg=rfm_scores)


customer_segment%>%count(cus_seg)%>%arrange(desc(n))%>%rename(cus_seg = cus_seg, Count = n)


customers<-rfm_score$rfm

customers<-customers%>%mutate(Segment_name=customer_segment$cus_seg)

write.csv(customers, "C:/Users/vasileios.ouranos/OneDrive - Accenture/Desktop/Main Assessement/customers.csv", row.names=FALSE )

