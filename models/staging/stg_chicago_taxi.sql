{{ config(materialized='view') }}

with source as (

    select
        unique_key,
        taxi_id,
        trip_start_timestamp,
        trip_end_timestamp,
        trip_seconds,
        trip_miles,
        fare,
        tips,
        tolls,
        extras,
        trip_total,
        payment_type,
        company,
        pickup_community_area,
        dropoff_community_area
    from {{ source('chicago_taxi', 'taxi_trips') }}
    where trip_start_timestamp is not null
      and trip_total is not null
      and trip_total > 0

)

select * from source