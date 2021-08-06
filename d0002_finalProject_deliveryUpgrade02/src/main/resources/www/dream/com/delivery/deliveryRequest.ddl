drop table b_delivery_request
drop table b_delivery
drop SEQUENCE seq_req_id;

create SEQUENCE seq_req_id;

--배달
-- id, reg_dt, upt_dt, , status_id, descrim, member_id, store_id, order_contents, req_end_lat, req_end_lng, req_end_addr, req_delivery_tip, req_cooked_time, req_id, rider_id, pickup_dt
create table b_delivery(
	
	--공통속성
	id						varchar2(20) 			primary key,
	reg_dt					timestamp				default sysdate not null,	
	upt_dt					timestamp				,--default sysdate not null,
	descrim					varchar2(15),   		-- 요청, 수행, 배달중,  배달완료, 취소 
	
	-- 요청건
	member_id				varchar2(20), 
	store_id				varchar2(20),
	order_contents			varchar2(100),	--주문내용
	req_end_lat				number(10,7), 	--어디로 배달(위도)
	req_end_lng				number(10,7),	--어디로 배달(경도)
	req_end_addr			varchar2(100),	--도착 주소

	req_delivery_tip		varchar2(10),	--배달팁
	req_cooked_time			varchar2(10),	--조리완료예정시간
	
	--수행건
	req_id					varchar2(20),   --요청건을 참조(id) 
	rider_id				varchar2(20)
	--pickup_dt				timestamp		--등록시점
	
);


-- request("배차대기"), perform("배차완료"), inTransit("배송중"), completed("배송완료"), exception("예외"), cancel("취소");

--요청건 데이터
--용훈이가 김가네에서 김밥을 주문해서 배달요청 등록 
insert into b_delivery(id, descrim, member_id, store_id, order_contents, req_end_lat, req_end_lng, req_end_addr, req_delivery_tip, req_cooked_time)
	values('10000', 'request', 'member2', 'store1', '김밥', 37.48159487027457, 126.8825609998327, '서울특별시 구로구 가리봉동 42-2 가산디지털단지역 1호선', '3000', '20분');

--수행건 데이터 
--한슬이한테 그 주문이 할당됨
-- (id, status_id, descrim, req_id, rider_id) 	req_id는 요청건에 대한 id와 일치시켜야함
insert into b_delivery (id, descrim, req_id, rider_id)
	values ('10001', 'perform', '10000', 'rider2')

--한슬이가 가게로부터 물건을 받았음을 알림 - 배달중 
insert into b_delivery (id, descrim, req_id, rider_id)
	values ('10002', 'inTransit', '10001', 'rider2')

 

create table b_delivery_status(
	status			varchar2(10), 
	description		varchar2(100)	
);

--상태
--요청, 수행, 배달중,  배달완료, 취소 
insert into b_delivery_status(status, description)
	values('request', '배달요청');
insert into b_delivery_status(status, description)
	values('perform', '수행 할당완료');
insert into b_delivery_status(status, description)
	values('inTransit', '배달중 가게로부터 물건을 픽업함');
insert into b_delivery_status(status, description)
	values('completed', '배달임무를 마침');
insert into b_delivery_status(status, description)
	values('exception', '예외');	
insert into b_delivery_status(status, description)
	values('cancel', '취소');	
	
	
create table b_exception(
	id				varchar2(20) 			primary key, 
	exception_type	varchar2(50),
	description		varchar2(100)
);

create table b_period(
	exception_type			varchar2(50)			primary key,
	reg_dt					timestamp				default sysdate not null,	
	upt_dt					timestamp				default sysdate not null
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