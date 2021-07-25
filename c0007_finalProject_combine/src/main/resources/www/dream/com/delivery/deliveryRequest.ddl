drop table b_request
drop SEQUENCE seq_req_id;

alter table b_contact_point modify info varchar2(100)

create SEQUENCE seq_req_id;
--어디서 배달시작, 무엇을 배달, 어디로배달, 언제까지배달, 배달비용, 주의사항
--(req_id, store_id, member_id, rider_id, req_state, req_start_lat, req_start_lng, req_start_addr, req_end_lat, req_end_lng, req_end_addr, order_id)
create table b_request(
	req_id					varchar2(20),
	store_id				varchar2(20),
	member_id				varchar2(20),
	rider_id				varchar2(20),
	req_state				varchar2(10),	-- cancelled : 주문 취소 , delivered : 발송 완료, pending : 주문 대기, in transit : 배송 중
	req_start_lat 			number(10,7), 	--어디서 배달시작(위도)
	req_start_lng			number(10,7), 	--어디서 배달시작(경도)
	req_start_addr			varchar2(100),	--시작 주소
	req_end_lat				number(10,7), 	--어디로 배달(위도)
	req_end_lng				number(10,7),	--어디로 배달(경도)
	req_end_addr			varchar2(100),	--도착 주소
	order_id				varchar2(20)
	reg_dt			timestamp		default sysdate not null,	--등록시점
	upt_dt			timestamp		default sysdate not null
	--primary key (req_id, user_id)
);

--req_id, store_id, member_id, req_state, req_start_lat, req_start_lng, req_start_addr, req_end_lat, req_end_lng, req_end_addr, req_order1
insert into b_request(req_id, store_id, member_id, req_state, req_start_lat, req_start_lng, req_start_addr, req_end_lat, req_end_lng, req_end_addr)
	values('10000', 'storethirsty', 'memberthirsty', 'pending', 36.3184136, 127.4525489, '판교', 37.2455310, 126.9659178, '오목천동 하우스토리 1단지');

insert into b_request(req_id, store_id, member_id, req_state, req_start_lat, req_start_lng, req_start_addr, req_end_lat, req_end_lng, req_end_addr)
	values('20000', 'storethirsty2', 'memberthirsty', 'pending', 37.2465749, 126.9669530, '오목천동 푸르지오 1단지',  37.2455310, 126.9659178, '오목천동 하우스토리 1단지');

insert into b_request(req_id, store_id, member_id, req_state, req_start_lat, req_start_lng, req_start_addr, req_end_lat, req_end_lng, req_end_addr)
	values('30000', 'storethirsty3', 'memberthirsty', 'pending', 37.2455310, 126.9659178, '오목천동 하우스토리 1단지', 37.2522674, 126.9614299, '수원여자대학교');