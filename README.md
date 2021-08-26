# Fetch_Reward_Exercise
Demonstrate how I reason about data and communicate my understanding of a specific data set to others.

## Question 1: 

For the way of converting unstructure data into a simplified, structured, relational tables, please refer to [this file](https://github.com/chengwuw/Fetch_Reward_Exercise/blob/8bce0c709721d1ca2d7277e02e18083663cfa137/Q1_data_clean.ipynb).

I used Python to convert json.gz to json, and json to csv. I also created a new table `Rewards Receipt Item List` which comes from `receipts` because there is no field that can merge the tables of receipts and brands. With the table `Rewards Receipt Item List`, I can use the field of `barcode` to join `brands` and `Item List`, and use `receipt id` to join `receipts` and `Item List`. Thus, we can connect the tables of receipts and brands together. Additionally, I formatted the variables of date. 

For the ER Diagram which is drawn in MySQL:
![alt text](https://github.com/chengwuw/Fetch_Reward_Exercise/blob/8bce0c709721d1ca2d7277e02e18083663cfa137/Q1_ERD.png?raw=true) 

## Question 2:

Queries to answer question: 

**When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?**

Here is the answer:

```mysql
SELECT
CASE
	WHEN 
		( SELECT avg( totalSpent ) FROM receipts WHERE rewardsReceiptStatus = 'FINISHED' ) 
		> 
		( SELECT avg( totalSpent ) FROM receipts WHERE rewardsReceiptStatus = 'REJECTED' )
	THEN "Average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ is greater"
        WHEN 
		( SELECT avg( totalSpent ) FROM receipts WHERE rewardsReceiptStatus = 'FINISHED' ) 
		< 
		( SELECT avg( totalSpent ) FROM receipts WHERE rewardsReceiptStatus = 'REJECTED' )
        THEN "Average spend from receipts with 'rewardsReceiptStatus’ of ‘Rejected’ is greater"
	ELSE "They are the same"
	END AS COMPARING
;
```

More queries are shown in this [file](https://github.com/chengwuw/Fetch_Reward_Exercise/blob/a90aa31522b7c8e0cf01c0806ec0ec677f03795a/Q2_queries.sql).

## Question 3:

I utilized Python to detect data quality issues (null/missing values, duplicate values, data inconsistency).

Please refer to [this file](https://github.com/chengwuw/Fetch_Reward_Exercise/blob/e658512919b946340750f0f64a6823edbed10274/Q3_data_quality_issue.ipynb) for the detailed codes and results.

## Question 4:

Construct an [email](https://github.com/chengwuw/Fetch_Reward_Exercise/blob/e658512919b946340750f0f64a6823edbed10274/Q4_Email.pdf) to a product/business leader on several topics.


Thanks for watching.
