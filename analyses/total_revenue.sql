with payments as (
    select * from {{ ref('stg_payments') }}
),

aggregated as (
    select 
        sum(amount) as total_revenue
    from payments
)

select * from aggregated