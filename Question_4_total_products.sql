with cte3 as
(
with cte2 as
(
with cte1 as
(
select B.segment,A.product_code,cost_year  from fact_manufacturing_cost as A
left join dim_product as B
on A.product_code = B.product_code
)
select distinct(segment),cost_year as year, count(product_code) over (partition by cost_year, segment order by cost_year)  as product_count from cte1
)
select segment,year,product_count as product_count_2021,lag(product_count) over ( partition by segment order by year) as product_count_2020 from cte2
)
select segment,product_count_2021,product_count_2020,(product_count_2021-product_count_2020) as difference from cte3 where product_count_2020 is not null
order by difference desc
