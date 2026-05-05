{{
    config(
        materialized='incremental',
        unique_key=['trip_date','payment_type'],
        on_schema_change='fail')
}}

with 
fact_taxi as (
    select * from
    {{ ref('stg_chicago_taxi') }}
),

final as (
    select DATE(trip_start_timestamp) AS trip_date,
    payment_type,
    COUNT(*) AS total_trips,
    SUM(fare) AS total_fare,
    SUM(tips) AS total_tips,
    SUM(trip_total) AS total_revenue
    from fact_taxi
    where 1=1
    {% if is_incremental() %}
    and DATE(trip_start_timestamp) > (
        select coalesce(max(trip_date), '2000-01-01') 
        from {{ this }}
    )
    {% endif %}
    group by 1,2
)

select * from final

