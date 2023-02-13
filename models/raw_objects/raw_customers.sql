{{
    config(
        materialized='table'
    )
}}
select * from testdbt.test.customer