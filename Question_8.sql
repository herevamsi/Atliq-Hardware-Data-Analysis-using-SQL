with cte2 As
(
with cte1 as
(
SELECT A.date,A.product_code,A.sold_quantity,date_add(date,INTERVAL 4 month) as future_date FROM c4db.fact_sales_monthly as A where fiscal_year = '2020'
)
select date,ceil(month(future_date)/3) as Quarter_det,product_code,sold_quantity from cte1
)
select 
Case
when Quarter_det ='1' then 'Q1'
when Quarter_det ='2' then 'Q2'
when Quarter_det ='3' then 'Q3'
when Quarter_det ='4' then 'Q4'
end as Quarter_num,
sum(sold_quantity) as total_sold_quantity
from cte2
group by Quarter_num
order by total_sold_quantity desc