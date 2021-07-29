drop table b_delivery_request
drop table b_delivery
drop SEQUENCE seq_req_id;

create SEQUENCE seq_req_id;

--배달
-- id, reg_dt, upt_dt, descrim, member_id, store_id, order_contents, req_end_lat, req_end_lng, req_end_addr, req_delivery_tip, req_cooked_time, req_id, rider_id, pickup_dt
create table b_delivery(
	
	--공통속성
	id						varchar2(20) 			primary key
	reg_dt					timestamp				default sysdate not null,	
	upt_dt					timestamp				default sysdate not null,
	descrim					varchar2(15),   		-- 요청, 수행, 취소
	
	-- 요청건
	member_id				varchar2(20), 
	store_id				varchar2(20),
	order_contents			varchar2(100),
	req_end_lat				number(10,7), 	--어디로 배달(위도)
	req_end_lng				number(10,7),	--어디로 배달(경도)
	req_end_addr			varchar2(100),	--도착 주소

	req_delivery_tip		varchar2(10),	--배달팁
	req_cooked_time			varchar2(10),	--조리완료예정시간
	
	--수행건
	req_id					varchar2(20),   --요청건을 참조(id) 
	rider_id				varchar2(20),
	pickup_dt				timestamp,	--등록시점
	
);

create table b_delivery_status(
	id				varchar2(20) 			primary key,
	status			varchar2(10), 
	description		varchar2(100)			not null
);

--상태
insert into b_delivery_status(id, status, description)
	values('', 'pending', '배차대기');
insert into b_delivery_status(id, status, description)
	values('', 'matched', '배차완료');
insert into b_delivery_status(id, status, description)
	values('', 'inTransit', '배송중');
insert into b_delivery_status(id, status, description)
	values('', 'completed', '배송완료');
insert into b_delivery_status(id, status, description)
	values('', 'exception', '예외');	
insert into b_delivery_status(id, status, description)
	values('', 'cancel', '취소');	

	
	
create table b_exception(
	id				varchar2(20) 			primary key, 
	exception_type	varchar2(50),
	description		varchar2(100)
);

create table b_period(
	exception_type	varchar2(50)			primary key,
	reg_dt					timestamp		default sysdate not null,	
	upt_dt					timestamp		default sysdate not null
);
	
	
	
--===============================================================================================================================	
	
	
	
--배달 요청건
--어디서 배달시작(store_id), 무엇을 배달(order_id), 어디로배달(end), 배달비용, 언제까지배달
--req_id,member_id, store_id, order_contents, req_end_lat, req_end_lng, req_end_addr, req_delivery_tip, req_cooked_time
create table b_delivery_request(
	req_id					varchar2(20),
	member_id				varchar2(20), 
	store_id				varchar2(20),
	order_contents			varchar2(100),
	req_end_lat				number(10,7), 	--어디로 배달(위도)
	req_end_lng				number(10,7),	--어디로 배달(경도)
	req_end_addr			varchar2(100),	--도착 주소

	--배달완료요청시점
	
	req_delivery_tip		varchar2(10),	--배달팁
	req_cooked_time			varchar2(10),	--조리완료예정시간
	
	reg_dt					timestamp		default sysdate not null,	--등록시점
	upt_dt					timestamp		default sysdate not null
);

--req_id, store_id, member_id, req_state, req_start_lat, req_start_lng, req_start_addr, req_end_lat, req_end_lng, req_end_addr, req_order1
insert into b_delivery_request(req_id,member_id, store_id, order_contents, req_end_lat, req_end_lng, req_end_addr, req_delivery_tip, req_cooked_time)
	values('10000', 'store1', 'member2', '김 1장 밥 2알 간장 1 스포이드',37.485491, 126.883681, '서울특별시 구로구 가리봉동 남부순환로105길 218 영일초등학교', 3000, 40);
insert into b_delivery_request(req_id,member_id, store_id, order_contents, req_end_lat, req_end_lng, req_end_addr, req_delivery_tip, req_cooked_time)
	values('20000', 'store2', 'member2', '김뚝 2개',37.473255, 126.884222, '서울특별시 금천구 가산동 가산디지털1로 83 1104-1호', 3000, 40);	
insert into b_delivery_request(req_id,member_id, store_id, order_contents, req_end_lat, req_end_lng, req_end_addr, req_delivery_tip, req_cooked_time)
	values('30000', 'store3', 'member2', '아메리카노 1개 바닐라라떼 1개',37.484799, 126.885010, '서울특별시 구로구 가리봉동 25 202호', 3000, 40);	

--배달수행건
create table b_delivery(
	req_id			varchar2(20),
	rider_id		varchar2(20),
	--배달시작시간예측
	--배달완료시간예측
	--배달상태
	del_state		varchar2(10),
	--실수령시점
	pickup_dt		timestamp,	--등록시점
	reg_dt			timestamp		default sysdate not null,	--등록시점
	upt_dt			timestamp		default sysdate not null
);