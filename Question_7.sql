with cte2 as
(
with cte1 as
(
select fiscal_year,monthname(date) as month,month(date_add(date, interval 4 month)) as fiscal_month_num,A.customer_code,B.customer,product_code,sold_quantity from fact_sales_monthly as A
left join dim_customer as B
on A.customer_code=B.customer_code
where customer = "Atliq Exclusive"
)
select C.fiscal_year,month,fiscal_month_num,customer,C.product_code,C.sold_quantity,D.gross_price,round((sold_quantity*gross_price),2) as gross_sales from cte1 as C
left join fact_gross_price as D
on C.product_code = D.product_code and C.fiscal_year = D.fiscal_year
)
select fiscal_year,month,fiscal_month_num,customer,sum(gross_sales)/1000000 as gross_sales_in_millions from cte2
group by fiscal_year,month