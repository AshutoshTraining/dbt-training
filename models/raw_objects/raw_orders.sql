{{
    config(
        materialized='table'
    )
}}


select * from {{ source('testdbt', 'orders') }}