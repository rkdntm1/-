select distinct l.info
  from b_orderList o, b_party p, b_location l, b_contact_point c
 where o.member_id = 'member1'
   and o.member_id = p.user_id
   and p.user_id = l.user_id
   and p.user_id = c.user_id
   and c.contact_point_type = 'address'
