drop table b_request
drop SEQUENCE seq_req_id;

alter table b_contact_point modify info varchar2(100)

create SEQUENCE seq_req_id;
--어디서 배달시작, 무엇을 배달, 어디로배달, 언제까지배달, 배달비용, 주의사항
create table b_request(
	req_id					varchar2(20),
	store_id				varchar2(20),
	member_id				varchar2(20),
	req_state				varchar2(10),
	req_start_lat 			number(10,7), 	--어디서 배달시작(위도)
	req_start_lng			number(10,7), 	--어디서 배달시작(경도)
	req_start_addr			varchar2(50),	--시작 주소
	req_end_lat				number(10,7), 	--어디로 배달(위도)
	req_end_lng				number(10,7),	--어디로 배달(경도)
	req_end_addr			varchar2(50),	--도착 주소
	req_order1				varchar2(300)
	--primary key (req_id, user_id)
);

--req_id, user_id, ,req_state, req_start_lat, req_start_lng, req_start_addr, req_end_lat, req_end_lng, req_end_addr, req_order1
insert into b_request(req_id, store_id, member_id, req_state, req_start_lat, req_start_lng, req_start_addr, req_end_lat, req_end_lng, req_end_addr, req_order1)
	values('10000', 'storethirsty', 'memberthirsty', 'pending', 36.3184136, 127.4525489, '판교', 36.3201174, 127.4523088, '경주', '주문상세1');

insert into b_request(req_id, store_id, member_id, req_state, req_start_lat, req_start_lng, req_start_addr, req_end_lat, req_end_lng, req_end_addr, req_order1)
	values('20000', 'storethirsty2', 'memberthirsty', 'pending', 37.2465749, 126.9669530, '판교', 36.3201174, 127.4523088, '경주', '주문상세2');

