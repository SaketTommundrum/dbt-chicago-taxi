select *
from {{ ref('fct_taxi_trips') }}
where total_trips<0