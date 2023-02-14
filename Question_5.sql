with cte2 as
(
with cte1 as
(
SELECT min(manufacturing_cost) as manufacturing_cost FROM c4db.fact_manufacturing_cost
union
SELECT max(manufacturing_cost) as manufacturing_cost FROM c4db.fact_manufacturing_cost
)
select product_code,B.manufacturing_cost from fact_manufacturing_cost as A
inner join cte1 as B
on A.manufacturing_cost = B.manufacturing_cost
)
select A.product_code,B.product,manufacturing_cost from cte2 as A
left join dim_product as B
on A.product_code = B.product_code

