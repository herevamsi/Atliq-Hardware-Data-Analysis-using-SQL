with cte3 as
(
with cte2 as
(
with cte1 as
(
select A.customer_code,B.customer,B.market,fiscal_year,pre_invoice_discount_pct
from fact_pre_invoice_deductions as A
left join dim_customer as B
on A.customer_code = B.customer_code
)
select customer_code, customer, fiscal_year,market,
round((avg(pre_invoice_discount_pct) over (partition by fiscal_year,customer order by fiscal_year))*100,1) as Avg_ 
from cte1 
where fiscal_year = '2021' and market = 'india'
)
select *, dense_rank() over (order by Avg_ desc) as _RANK_ from cte2
order by _RANK_ asc
)
select customer_code, customer,fiscal_year,market,Avg_ as average_high_pre_invoice_discount_pct from cte3 limit 10


