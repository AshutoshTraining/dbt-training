{{
    config(
        materialized='table'
    )
}}


select * from testdbt.test.orders