select
    {{ dbt_utils.generate_surrogate_key(["o.orderid", "c.customerid", "p.productid"]) }}
    as surr_key,
    {# from raw_orders -- -- {{limit_data_in_dev('orderdate')}} #}
    o.orderid,
    o.orderdate,
    o.shipdate,
    o.shipmode,
    ordersellingprice - ordercostprice as orderprofit,
    -- from raw_customer
    c.customerid,
    c.customername,
    c.segment,
    c.country,
    -- from raw_product
    p.productid,
    p.productname,
    p.category,
    p.subcategory,
    {{ markup("ordersellingprice", "ordercostprice") }} as profitperct,
    d.delivery_team
from {{ ref("raw_orders") }} as o
left join {{ ref("raw_customers") }} as c on o.customerid = c.customerid
left join {{ ref("raw_products") }} as p on o.productid = p.productid
left join {{ ref("delivery_team") }} as d on o.shipmode = d.shipmode
