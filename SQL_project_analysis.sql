select * from df_orders;

#find top 10 highest revenue generating products
select product_id,sum(sale_price)  as revenue from df_orders group by 1 order by 2 desc limit 10;
#select top 10 product_id,sum(sale_price)  as revenue from df_orders group by 1 order by 2 desc limit 10;

#find top 5 highest selling products in each region
select * from df_orders;
select distinct region  from df_orders;
with cte as(select region,product_id,sum(sale_price) as sales,row_number()over(partition by region order by sum(sale_price) desc) rm from df_orders group by 1,2)
select region,product_id,sales from cte where rm < 6;
#find month over month growth compaision for 2022 and 2023 eg jan 2022 vs jan 2023
select distinct year(order_date) from df_orders;
WITH cte as(select year(order_date) ORDER_YEAR,month(order_date) ORDER_MONTH,sum(sale_price) SALES from df_orders group by 1,2 order by 1,2)
select ORDER_MONTH,
case when order_year = 2022 then sales else 0 end,
case when order_year = 2023 then sales else 0 end
from cte GROUP BY 1;

