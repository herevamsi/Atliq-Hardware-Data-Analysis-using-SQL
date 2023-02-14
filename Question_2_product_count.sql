with cte2 as
(
with cte1 as
(
select count(product_code) as product_count, cost_year as year from fact_manufacturing_cost
group by year
)
select product_count as product_count_2021, lag(product_count) over (order by year) as product_count_2020 from cte1
)
select product_count_2021,product_count_2020,((product_count_2021-product_count_2020)/product_count_2020)*100 as percentage_change from cte2 where product_count_2020 is not null