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
insert into b_location(user_id,latitude, longitude)
	values('ghostrider7', 37.47909, 126.8782619); 	
insert into b_location(user_id,latitude, longitude)
	values('ghostrider8', 37.4802913, 126.8790519); 	

--	** 테스트를 위해 가상으로 데이터를 입력해야함!!!!!! ghostrider1 ~ ghostrider8 전부다 !! ** 
insert into b_accountability(owner_id, resp_id, acc_type)
	values('ghostrider5', 'BaeNom', 'MEMBER');
insert into b_accountability(owner_id, resp_id, acc_type)
	values('ghostrider5', 'BaeNom', 'RIDER');		

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
 -- 1순위 : 수행건수가 적은사람들 순, 2순위 : 배달팁 적게 번 사람 순 , 3순위 : 추가 예정 등등등등등등등 (21.08.09)
 
 --==============================================================================================================
 
 
2안 - 1km 반경안 rider 탐색
 
-- 1순위 : 배달팁 적게 번 사람 순 , 2순위 : 수행건수가 적은사람들 순 , 3순위 : 해당 매장 기준 가까운 사람
-- 해당 순위를 기준으로 정렬함

-- public List<DeliveryCompleted> getRiderPriority(@Param("storeId") String storeId); --

SELECT rider_id,  SUM(req_delivery_tip) total_tip, count(case when status = 'completed' then rider_id end) cnt, distance distance
  FROM  ( select *
            FROM b_delivery d, ( SELECT distinct rl.*,
            
            								  -- 가게를 중심으로 'RIDER'들이 얼만큼 떨어져 있는지 거리를 계산한다.(distance)
                                        (6371 * acos( cos( sl.latitude * 3.14/180 ) * cos( ( rl.latitude * 3.14/180 ))  
                                              *  cos( ( rl.longitude * 3.14/180 ) - ( sl.longitude * 3.14/180 ) )  
                                              +  sin( sl.latitude * 3.14/180 ) * sin( rl.latitude * 3.14/180 ) ) ) distance  
                                        
                                              -- 배달요청하는 가게 id와 위경도 정보(sl)
                                   FROM (select distinct(d.store_id), l.latitude, l.longitude 
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
 
 --** 이 쿼리엔 심각한 문제가 있다. DATA 테이블과 b_delivery d테이블과 조인을하면서 신생라이더들을 조회하지 못하는 문제가 생겼다. (21.8.11)
 --======================================================================================================================================================

 3안쿼리로 채택 띠 
 
 SELECT user_id,  NVL(SUM(case when status = 'completed' then req_delivery_tip end), 0) total_tip ,  count(case when status = 'completed' then user_id end) cnt, distance distance
   FROM  ( select * 
   			 from
   			 		-- b_delivery (d) 와 가게로부터의 거리가 계산된 라이더데이터(DATA)를 outer join함 (cls)
		 		 ( select *
		 		     from b_delivery d right outer join 
		 		 				( SELECT distinct rl.*,
		            
									  -- 가게를 중심으로 'RIDER'들이 얼만큼 떨어져 있는지 거리를 계산한다.(distance)
		                        (6371 * acos( cos( sl.latitude * 3.14/180 ) * cos( ( rl.latitude * 3.14/180 ))  
		                              *  cos( ( rl.longitude * 3.14/180 ) - ( sl.longitude * 3.14/180 ) )  
		                              +  sin( sl.latitude * 3.14/180 ) * sin( rl.latitude * 3.14/180 ) ) ) distance  
		                    
		                              -- 배달요청하는 가게 id와 위경도 정보(sl)
		                            FROM (select distinct(d.store_id), l.latitude, l.longitude 
		                                       from b_location l left join b_delivery d  on l.user_id = d.store_id 
		                                      where d.store_id = 'storethirsty5') sl, 
		                                      
		                              -- accType이 'RIDER'인 사람의 id와 위경도 정보(rl)
		                        (select distinct l.* 
		                           from b_location l left join b_accountability acc on l.user_id = acc.owner_id  
		                          where acc.acc_type = 'RIDER'
		                          
		                          	  -- 현재 활동중인 라이더들을 조회 (sysdate - 1분) 
		                          	  -- 즉 1분전에 움직임을 보인 라이더들을 조회
		                            and l.reg_dt >= sysdate - 5 ) rl
		           				 ) DATA ON d.rider_id = DATA.user_id
		   		 ) cls
           
               -- 거리 단위는km 이고 1km 반경 내의 있는 DATA들을 조회한다.
            where cls.distance < 1 )
             
 GROUP BY user_id, distance ORDER BY total_tip, cnt, distance 

-- NVL() 함수를 통해 total_tip이 없을 시 null값을 0으로 치환, 
-- DATA테이블을 right outerjoin 하여 b_delivery d 테이블에 등록 되어있지 않는 라이더들도 데이터조회 할 수 있도록 조치 (21.08.12) 
--======================================================================================================================================================	

 4안
 
create index idx_location on b_location
(user_id ,latitude, longitude, latest_dt)
 
select rl.user_id from
(select * 
  from b_location l 
 where l.user_id 
    in ( select store_id 
           from b_delivery
           where id = #{deliveryKey} )) sl,

(select l.user_id, l.latitude, l.longitude from b_location l left join b_accountability acc on l.user_id = acc.owner_id  
		                          where acc.acc_type = 'RIDER'
                                  and latest_dt = '9999.12.31') rl          

where sl.latitude - #{lat} <= rl.latitude
and   sl.longitude + #{lng} >= rl.longitude
and   sl.latitude + #{lat} >= rl.latitude
and   sl.latitude - #{lng} <= rl.longitude;
 
 
--======================================================================================================================================================
 5안 
select l.user_id 
  from (select (l.latitude - 0.00528693508) NW_latitude, (l.longitude + 0.01417241946) NW_longitude, (l.latitude + 0.00528693508) ES_latitude, (l.longitude - 0.01417241946) ES_longitude 
			   from b_delivery b, b_location l 
			  where b.id = #{deliveryKey} 
			    and b.store_id = l.user_id) rect , 
	    b_location l, b_accountability acc
where rect.NW_latitude  <= l.latitude
  and rect.NW_longitude >= l.longitude
  and rect.ES_latitude  >= l.latitude
  and rect.ES_longitude <= l.longitude
  and l.user_id = acc.owner_id  
  and acc.acc_type = 'RIDER'
  and l.latest_dt = '9999.12.31';
--======================================================================================================================================================
 
-- alter table b_location drop primary key cascade;
-- alter table b_location add constraint idx_location_pk primary key(user_id, latest_dt);
-- create index idx_location on b_location (user_id, latitude, longitude)   
-- create index idx_location_default on b_location (latest_dt)  
-- 6안 21.08.18 (성능개선)
  
	select rl.*
		-- 가게 범위 안 rider의 location data
	  from (select (sl.latitude - 0.00528693508) NW_latitude, (sl.longitude + 0.01417241946) NW_longitude, (sl.latitude + 0.00528693508) ES_latitude, (sl.longitude - 0.01417241946) ES_longitude 
			  from b_delivery b, b_location sl 
		     where b.id = '0000L' 
			   and b.store_id = sl.user_id) rect, b_location rl, b_accountability acc
	 where rect.NW_latitude  <= rl.latitude
	   and rect.NW_longitude >= rl.longitude
	   and rect.ES_latitude  >= rl.latitude
	   and rect.ES_longitude <= rl.longitude
	   and rl.user_id = acc.owner_id  
	   and acc.acc_type = 'RIDER'
	   and rl.latest_dt = '9999.12.31';
--======================================================================================================================================================	   
  
	   
	   
  SELECT user_id,  NVL(SUM(case when status = 'completed' then req_delivery_tip end), 0) total_tip ,  count(case when status = 'completed' then user_id end) cnt
    FROM  ( select *
		 	  from b_delivery d right outer join 
		 		 ( select rl.*
				-- 가게 범위 안 rider의 location data
			  from (select (sl.latitude - 0.00528693508) NW_latitude, (sl.longitude + 0.01417241946) NW_longitude, (sl.latitude + 0.00528693508) ES_latitude, (sl.longitude - 0.01417241946) ES_longitude 
					  from b_delivery b, b_location sl 
				     where b.id = '0000L' 
					   and b.store_id = sl.user_id) rect, b_location rl, b_accountability acc
			 where rect.NW_latitude  <= rl.latitude
			   and rect.NW_longitude >= rl.longitude
			   and rect.ES_latitude  >= rl.latitude
			   and rect.ES_longitude <= rl.longitude
			   and rl.user_id = acc.owner_id  
			   and acc.acc_type = 'RIDER'
			   and rl.latest_dt = '9999.12.31' )dt 
	   
	  ON d.rider_id = dt.user_id)
GROUP BY user_id ORDER BY total_tip, cnt
	   
	   
	  
--======================================================================================================================================================
<!-- public List<DeliveryVO> getList(@Param("userId") String userId, @Param("status") String status);-->
	<select id="getList" resultMap="dmDelivery">
		<choose>
		
		<when test="descrim.status.equals('#{status}')">
	   		select d.*, st.*
	          from b_delivery d left join b_delivery_status st on d.status = st.status
		</when>
        
		</choose>
	</select>
	
