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
select * from cte1 where occurence = '1'
)
select distinct(cost_year),count(product_code) over (partition by cost_year order by cost_year) as Unique_products from cte2
)
select cost_year as year, Unique_products as Unique_products_2021, lag(Unique_products) over (order by cost_year) as Unique_products_2020 from cte3
)
select Unique_products_2021,Unique_products_2020,concat(round((((Unique_products_2021-Unique_products_2020)/Unique_products_2020)*100),2),'%') as percentage_chg from cte4 where Unique_products_2020 is not null