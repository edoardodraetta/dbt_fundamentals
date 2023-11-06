with payments as (
    select * from {{ ref('stg_payments') }}
),

pivoted as (
    select 
        order_id
        {%- set payment_methods = ['bank_transfer', 'coupon', 'credit_card', 'gift_card'] -%}
        {%- for method in payment_methods -%}     
        , sum( case when payment_method = '{{ method }}' then amount else 0 end) as {{ method }}_amount
        {% endfor -%}
    from payments
    where 1=1
        and status = 'success'
    group by order_id
)

select * from pivoted
