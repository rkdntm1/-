select * from b_delivery;
select * from b_party;
select * from b_location;
select * from b_accountability;

 
select * 
  from b_location
 where reg_dt >= sysdate - (1/1440);
          
--=================================================================================================================

--가상의 라이더 데이터  ** 테스트를 위해 가상으로 데이터를 입력함 ** 
insert into b_location(user_id,latitude, longitude)
	values('ghostrider1', 37.481174483290395, 126.86667795974303);
insert into b_location(user_id,latitude, longitude)
	values('ghostrider2', 37.48627173866138, 126.8802107183174); 
insert into b_location(user_id,latitude, longitude)
	values('ghostrider3', 37.47581912695776, 126.8845412010612); 
insert into b_location(user_id,latitude, longitude)
	values('ghostrider4', 37.47126534027258, 126.87266846087194); 
insert into b_location(user_id,latitude, longitude)
	values('ghostrider5', 37.48191904789774, 126.8777206907397); 
insert into b_location(user_id,latitude, longitude)
	values('ghostrider6', 37.478781, 126.878990); 	
	
insert into b_delivery (id, reg_dt, status, req_id, rider_id)
	values ('10010', sysdate, 'completed', 'storethirsty5', 'ghostrider1');
insert into b_delivery (id, reg_dt, status, req_id, rider_id)
	values ('10011', sysdate, 'completed', 'storethirsty5', 'ghostrider2');
insert into b_delivery (id, reg_dt, status, req_id, rider_id)
	values ('10012', sysdate, 'completed', 'storethirsty5', 'ghostrider2');
insert into b_delivery (id, reg_dt, status, req_id, rider_id)
	values ('10013', sysdate, 'perform', 'storethirsty5', 'ghostrider3');
insert into b_delivery (id, reg_dt, status, req_id, rider_id)
	values ('10014', sysdate, 'inTransit', 'storethirsty5', 'ghostrider4');	
insert into b_delivery (id, reg_dt, status, req_id, rider_id)
	values ('10014', sysdate, 'cancel', 'storethirsty5', 'ghostrider5');		
insert into b_delivery (id, reg_dt, status, req_id, rider_id, req_delivery_tip)
	values ('10015', sysdate, 'completed', 'storethirsty5', 'ghostrider6', 2000);		

ghostrider1 는 1건 완료 ,  ghostrider2 는 2건 완료,  ghostrider3은 배차완료 ghostrider4 배달중 ghostrider5는 취소건
--==============================================================================================================	
         


1안 - 1km 사각형 범위안 rider 탐색 

select rider_id, count(case when status = 'completed' then rider_id end) cnt,  SUM(req_delivery_tip) total_tip
  from b_delivery d
   where rider_id in (
                        select distinct l.user_id  from 
                                                    (select p.user_id, p.user_name, l.latitude, l.longitude 
                                                      from b_party p 
                                                      left join b_location l on p.user_id = l.user_id
                                                     where p.user_id = 'storethirsty5') aa, (select distinct * 
                                                                                              from b_location 
                                                                                             where reg_dt >= sysdate - (1000/1440)) l
                                                     where l.latitude >= aa.latitude - 0.00909434103
                                                       and l.latitude <= aa.latitude + 0.00909434103
                                                       and l.longitude >= aa.longitude - 0.01126887536
                                                       and l.longitude <= aa.longitude + 0.01126887536
                                                             )                                                   
 group by rider_id order by cnt , total_tip ; 

 
 -- 1순위 : 수행건수가 적은사람들 순, 2순위 : 배달팁 적게 번 사람 순 , 3순위 : 추가 예정 등등등등등등등 
 
 
 --==============================================================================================================
 
 
2안 - 1km 반경안 rider 탐색
 

-- 1순위 : 배달팁 적게 번 사람 순 , 2순위 : 수행건수가 적은사람들 순 , 3순위 : 해당 매장 기준 가까운 사람
-- 해당 순위를 기준으로 정렬함

-- public List<DeliveryCompleted> getRiderPriority(@Param("storeId") String storeId); --

SELECT rider_id,  SUM(req_delivery_tip) total_tip, count(case when status = 'completed' then rider_id end) cnt, distance distance
  FROM  ( select *
            FROM b_delivery d, ( SELECT distinct rl.*,
            
            								  -- 가게를 중심으로 'RIDER'들이 얼만큼 떨어져 있는지 거리를 계산한다.(distance)
                                        (6371 * acos( cos( sl.latitude * 3.14/180 ) * cos( ( l.latitude * 3.14/180 ))  
                                              *  cos( ( rl.longitude * 3.14/180 ) - ( sl.longitude * 3.14/180 ) )  
                                              +  sin( sl.latitude * 3.14/180 ) * sin( rl.latitude * 3.14/180 ) ) ) distance  
                                        
                                              -- 배달요청하는 가게 id와 위경도 정보(sl)
                                   FROM (select d.store_id, l.latitude, l.longitude 
                                               from b_location l left join b_delivery d  on l.user_id = d.store_id 
                                              where d.store_id = #{storeId}) sl, 
                                              
                                              -- accType이 'RIDER'인 사람의 id와 위경도 정보(rl)
                                        (select distinct l.* 
                                           from b_location l left join b_accountability acc on l.user_id = acc.owner_id  
                                          where acc.acc_type = 'RIDER'
                                          
                                          	  -- 현재  활동중인 라이더들을 조회 (sysdate - 1분) 
                                          	  -- 즉 1분전에 움직임을 보인 라이더들을 조회
                                            and l.reg_dt >= sysdate - (1/1440) ) rl
                                ) DATA
           WHERE d.rider_id = DATA.user_id
           
           		-- 거리 단위는km 이고 1km 반경 내의 있는 DATA들을 조회한다.
             AND DATA.distance < 1)  
             
 group by rider_id, distance order by total_tip , cnt , distance 
 
 
 --======================================================================================================================================================
      
      