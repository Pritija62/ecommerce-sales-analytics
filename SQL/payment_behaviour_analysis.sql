-- Payment Behaviour Analaysis

select count(*)
from payments


-- most frequently used payment method is credit card ie 76795
select
payment_type,
count(payment_type) as counts
from payments
group by payment_type
order by counts desc
limit 1

-- credit cards accounts for the most payment value 12542084
select
payment_type,
sum(payment_value) as payment_value
from payments
group by payment_type
order by payment_value desc
limit 1


-- average payment value by payment types
select
payment_type,
avg(payment_value) as avg_payment_value
from payments
group by payment_type
order by avg_payment_value desc


-- average payment installments = 2.85
select
avg(payment_installments)
from payments


--number of orders using multiple payment records = 2961
select count(*) as multiple_payment_orders
from(
select 
order_id 
from payments
group by  order_id
having count(*)>1
) AS multiple_payments;






