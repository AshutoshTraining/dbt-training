{{
    config(
        materialized='incremental',
        unique_key='orderdate'
    )
}}


select * from {{ source('testdbt', 'orders') }}

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where to_date(orderdate,'YYYY/MM/DD') > (select max(to_date(orderdate,'YYYY/MM/DD')) from {{ this }}) 
{% endif %}