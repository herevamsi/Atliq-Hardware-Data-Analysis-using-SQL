with cte4 as
(
with cte3 as
(
with cte2 as
(
with cte1 as
(
select product_code,count(product_code) as occurence,cost_year from fact_manufacturing_cost 
group by product_code
)
select cost_year,B.segment,A.product_code,occurence from cte1 as A 
left join dim_product as B
on A.product_code = B.product_code
where occurence ='1'
)
select cost_year as year, segment,count(product_code) as no_of_unique_products from cte2
group by cost_year,segment
)
select year,segment,no_of_unique_products as no_of_unique_products_2021, lag(no_of_unique_products) over (partition by segment order by year) as no_of_unique_products_2020 from cte3
)
select segment,no_of_unique_products_2021,coalesce(no_of_unique_products_2020,'0') as no_of_unique_products_2020,(no_of_unique_products_2021-no_of_unique_products_2020) as difference from cte4 where year = '2021'
order by difference desc