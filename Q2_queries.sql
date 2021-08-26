-- What are the top 5 brands by receipts scanned for most recent month?
WITH temp AS (
	SELECT
		R._ID,
		b.NAME AS BRAND_NAME,
		b._ID AS BRAND_ID,
		r.dateScanned 
	FROM
		receipts r
		INNER JOIN rewardsReceiptItemList rl ON r._id = rl.receiptid
		INNER JOIN brands b ON rl.barcode = b.barcode
	WHERE
		DATE_FORMAT( r.dateScanned, '%Y/%m' ) = '2021/01' 
	GROUP BY
		1, 3, 4 
	ORDER BY
		R._ID 
	) SELECT
	UPPER( BRAND_NAME ) AS BRAND_NAME,
	COUNT(*) AS COUNT_BRAND 
FROM
	temp t 
GROUP BY
	UPPER( BRAND_NAME ) 
ORDER BY
	COUNT( BRAND_ID ) DESC
LIMIT 5;


-- How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
WITH temp AS (
	SELECT
		R._ID,
		b.NAME AS BRAND_NAME,
		b._ID AS BRAND_ID,
		r.dateScanned 
	FROM
		receipts r
		INNER JOIN rewardsreceiptitemlist rl ON r._id = rl.receiptid
		INNER JOIN brands b ON rl.barcode = b.barcode 
	WHERE
		DATE_FORMAT( r.dateScanned, '%Y/%m' ) = '2020/12' 
	GROUP BY
		1, 3, 4 
	ORDER BY
		R._ID 
	) SELECT
	UPPER( BRAND_NAME ) AS BRAND_NAME,
	COUNT(*) AS COUNT_BRAND 
FROM
	temp t 
GROUP BY
	UPPER( BRAND_NAME ) 
ORDER BY
	COUNT( BRAND_ID ) DESC;

-- When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
SELECT
	CASE 
		WHEN ( SELECT avg( totalSpent ) FROM receipts WHERE rewardsReceiptStatus = 'FINISHED' ) > ( SELECT avg( totalSpent ) FROM receipts WHERE rewardsReceiptStatus = 'REJECTED' )
		THEN "Average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ is greater"
        WHEN ( SELECT avg( totalSpent ) FROM receipts WHERE rewardsReceiptStatus = 'FINISHED' ) < ( SELECT avg( totalSpent ) FROM receipts WHERE rewardsReceiptStatus = 'REJECTED' )
        THEN "Average spend from receipts with 'rewardsReceiptStatus’ of ‘Rejected’ is greater"
		ELSE "They are the same"
	END AS COMPARING
;

-- When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
SELECT
	CASE 
		WHEN ( SELECT count( rl.receiptid ) AS total_items FROM rewardsreceiptitemlist rl JOIN receipts r ON rl.receiptid = r._id WHERE rewardsReceiptStatus = 'FINISHED' )
			>
			 ( SELECT count( rl.receiptid ) AS total_items FROM rewardsreceiptitemlist rl JOIN receipts r ON rl.receiptid = r._id WHERE rewardsReceiptStatus = 'REJECTED' ) 
		THEN "Total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ is greater"
		WHEN ( SELECT count( rl.receiptid ) AS total_items FROM rewardsreceiptitemlist rl JOIN receipts r ON rl.receiptid = r._id WHERE rewardsReceiptStatus = 'FINISHED' )
			<
			 ( SELECT count( rl.receiptid ) AS total_items FROM rewardsreceiptitemlist rl JOIN receipts r ON rl.receiptid = r._id WHERE rewardsReceiptStatus = 'REJECTED' ) 
		THEN "Total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Rejected’ is greater"
		ELSE " They are the same"
	END AS COMPARING;

-- Which brand has the most spend among users who were created within the past 6 months?
SELECT
	sum( rl.itemPrice ) AS total,
	b.NAME,
	b.brandCode 
FROM
	rewardsreceiptitemlist rl
	JOIN brands b ON rl.brandCode = b.brandCode 
WHERE
	rl.receiptid IN (
	SELECT DISTINCT r._id  
	FROM
		users u
		JOIN receipts r ON u._id = r.userId 
	WHERE
		u.createdDate > curdate() - INTERVAL ( dayofmonth( curdate()) - 1 ) DAY - INTERVAL 6 MONTH 
	) 
	AND b.brandCode != '' 
GROUP BY
	b.NAME,
	b.brandCode 
ORDER BY
	total DESC 
	LIMIT 1;

-- Which brand has the most transactions among users who were created within the past 6 months?

select count(rl.receiptid) as Most_transactions, b.name, b.brandCode
from rewardsreceiptitemlist rl join brands b 
on rl.brandCode = b.brandCode
where rl.receiptid in (
	select distinct(r._id) from users u join receipts r on u._id = r.userId
	where str_to_date(u.createdDate, '%Y-%m-%d %H:%i:%s') > curdate() - interval (dayofmonth(curdate()) - 1) day - interval 6 month
)
and b.brandCode != ''
group by b.name, b.brandCode
order by Most_transactions desc
limit 1;

