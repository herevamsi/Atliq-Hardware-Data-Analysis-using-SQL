with cte1 as
(
SELECT A.fiscal_year,B.division,A.product_code,B.product,sum(sold_quantity) as total_sold_quantity FROM c4db.fact_sales_monthly as A 
left join dim_product as B
on A.product_code=B.product_code
group by fiscal_year,product_code
)
select *, dense_rank() over (order by total_sold_quantity desc) as Rank_order from cte1 where fiscal_year ='2021'  limit 5
