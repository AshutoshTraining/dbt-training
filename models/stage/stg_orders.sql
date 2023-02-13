select 
 --from raw_orders
  orderid ,
  orderdate,
  shipdate,
  shipmode,
  ordersellingprice - ordercostprice as orderprofit,
  ---from raw_customer
  c.customerid,
  c.customername,
  c.segment,
  c.country,
  --from raw_product
  p.productid,
  p.productname,
  p.category,
  p.subcategory
from {{ ref('raw_orders') }} as o
left join {{ ref('raw_customers') }} as c
on o.customerid=c.customerid
left join {{ ref('raw_products') }} as p
on o.productid=p.productid