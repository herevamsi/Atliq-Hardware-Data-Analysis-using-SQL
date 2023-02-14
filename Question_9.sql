with cte4 as
(
with cte3 as
(
with cte2 as
(
with cte1 as
(
SELECT A.date,A.product_code,A.customer_code,B.channel,fiscal_year,sold_quantity FROM c4db.fact_sales_monthly as A
left join dim_customer as B
on A.customer_code=B.customer_code
)
select channel,C.product_code,C.fiscal_year,sold_quantity,D.gross_price,(sold_quantity*D.gross_price) as Gross_sales from cte1 as C
left join fact_gross_price as D
on C.product_code = D.product_code and C.fiscal_year = D.fiscal_year
)
select channel,sum(Gross_sales) as Total_sales from cte2
where fiscal_year = '2021'
group by channel
)
select channel,Total_sales,sum(Total_sales) over (order by channel rows between unbounded preceding and unbounded following) as Grand_total from cte3
)
select channel,Total_sales as gross_sales,Grand_total,round(((Total_sales/Grand_total)*100),2) as Perc  from cte4





