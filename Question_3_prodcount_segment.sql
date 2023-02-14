with cte1 as
(
select distinct(segment), count(product_code) over (partition by segment order by segment) as product_count from c4db.dim_product
)
select * from cte1 
order by product_count desc
