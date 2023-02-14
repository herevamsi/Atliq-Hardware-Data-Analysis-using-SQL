select  customer_code,
        customer,
        channel,
        market, 
        region 
        from dim_customer 
        where customer = 'Atliq Exclusive' and region ='APAC'
        order by market
