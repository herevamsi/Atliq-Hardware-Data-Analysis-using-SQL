with cte3 as
(
with cte2 as
(
with cte1 as
(
select product_code,count(product_code) as occurence,cost_year from fact_manufacturing_cost 
group by product_code
)
select * from cte1 where occurence = '1'
)
select B.segment,A.product_code from cte2 as A
left join dim_product as B
on A.product_code = B.product_code
)
select distinct(segment),count(product_code) as No_of_Unique_products  from cte3
group by segment
order by No_of_Unique_products desc