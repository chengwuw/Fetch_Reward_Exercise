# Fetch_Reward_Exercise
Demonstrate how I reason about data and communicate my understanding of a specific data set to others.

## Question 1: 

For the way of converting unstructure data into a simplified, structured, relational tables, please refer to [this file](https://github.com/chengwuw/Fetch_Reward_Exercise/blob/8bce0c709721d1ca2d7277e02e18083663cfa137/Q1_data_clean.ipynb).

For the ER Diagram:
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

## Question 3:

I utilized Python to detect data quality issues (null/missing values, duplicate values, data inconsistency).

Please refer to [this file](https://github.com/chengwuw/Fetch_Reward_Exercise/blob/e658512919b946340750f0f64a6823edbed10274/Q3_data_quality_issue.ipynb) for the detailed codes.

## Question 4:

Construct an [email](https://github.com/chengwuw/Fetch_Reward_Exercise/blob/e658512919b946340750f0f64a6823edbed10274/Q4_Email.pdf) to a product/business leader on several topics.

