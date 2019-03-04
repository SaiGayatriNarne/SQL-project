-----------Generate a report to obtain the total number of purchase orders raised from each state------------
select u.uf_state,count(*)
from PURCHASE_ORDER po natural join UNIT_FRANCHISEE u
group by u.uf_state ;


-----------Generate a report to get the summary of most ordered product types------------------------------------
select * from 
(select p.product_type,count(*) as TOTAL_COUNT
from PURCHASE_ORDER po join PRODUCT_PO ppo
on po.order_id=ppo.order_id
join product p
on ppo.product_id=p.product_id
join UNIT_FRANCHISEE uf
on uf.uf_id=po.uf_id
group by p.product_type 
)
where TOTAL_COUNT >= all(select TOTAL_COUNT from
(
select p.product_type,count(*) as TOTAL_COUNT
from PURCHASE_ORDER po join PRODUCT_PO ppo
on po.order_id=ppo.order_id
join product p
on ppo.product_id=p.product_id
join UNIT_FRANCHISEE uf
on uf.uf_id=po.uf_id
group by p.product_type
));


------------------Generate a report to know which unit franchisee has raised the lowest number of purchase orders till date--------------------------
select * from 
(select 
count(*) as MAX_NUM_OF_POs,UF.UF_ID, UF.UF_NAME
from purchase_order PO join UNIT_FRANCHISEE UF
on PO.UF_ID = UF.UF_ID
group by UF.UF_ID,UF.UF_NAME)
              where MAX_NUM_OF_POs >= ALL (select MAX_NUM_OF_POs from
(select 
count(*) as MAX_NUM_OF_POs ,UF.UF_ID
from purchase_order PO join UNIT_FRANCHISEE UF
       on PO.UF_ID = UF.UF_ID
group by UF.UF_ID));


----------------------Generate a report to get the summary of total number of orders received in each month-----------------------------------------
SELECT EXTRACT(month FROM order_date)"Month",
COUNT(order_date) "No. of Orders",sum(i.invoice_amount) as "Total Invoice Amount"
FROM PURCHASE_ORDER po join invoice i
on po.order_id=i.order_id
GROUP BY EXTRACT(month FROM order_date)
ORDER BY "Month";

-----------------------Generate a report to get the summary of the unit franchisee which has the highest consolidated amount for all invoice raised. -----------------
select * from
                 (
                select sum(inv.invoice_amount) max_invoiceamount,UF.UF_NAME
                from invoice inv join purchase_order PO
                on (inv.ORDER_ID = PO.ORDER_ID)
                join UNIT_FRANCHISEE UF
                ON (UF.UF_ID = PO.UF_ID)
                group by UF.UF_NAME
                 )
                 where max_invoiceamount >=  all (select max_invoiceamount from
                (
                select sum(inv.invoice_amount) max_invoiceamount,UF.UF_NAME
                   from invoice inv join purchase_order PO
                   on (inv.ORDER_ID = PO.ORDER_ID)
                   join UNIT_FRANCHISEE UF
                   ON (UF.UF_ID = PO.UF_ID)
                   group by UF.UF_NAME));

