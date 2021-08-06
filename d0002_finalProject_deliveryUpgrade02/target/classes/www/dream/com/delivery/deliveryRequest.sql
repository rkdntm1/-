
   
select * from b_delivery


insert into b_delivery (id, reg_dt, status_id, descrim, req_id, rider_id)
	values ('10001', sysdate, 1, '수행', '10000', 'rider2')


UPDATE b_delivery 
   SET upt_dt = SYSTIMESTAMP, status_id = '3'
 WHERE req_id = '10000'
 
 ;

   
   
 -- 특정 라이더가 배달 한 건   
   select * 
     from b_delivery a, b_delivery b, b_location l, b_contact_point p
    where a.id = b.req_id
      and a.store_id = l.user_id 
      and l.user_id = p.user_id
      and b.rider_id = 'rider2'
      ;
        