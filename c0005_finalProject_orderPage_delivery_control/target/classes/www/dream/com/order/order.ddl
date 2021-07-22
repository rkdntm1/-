drop table b_orderList
drop table b_detail_order
drop SEQUENCE seq_order_id;

--order_id, member_id, store_id, order_msg
create SEQUENCE seq_order_id;
create table b_orderList(
	order_id			varchar2(20),
	member_id			varchar2(20),
	store_id			varchar2(20),
	order_msg			varchar2(100),
	reg_dt				timestamp		default sysdate not null,	--등록시점
	upt_dt				timestamp		default sysdate not null	--수정시점
);
	
--id, order_id,	pdt_name, pdt_cnt, pdt_price
create SEQUENCE seq_detailOrder_id;
create table b_detail_order(
	id				varchar2(20),
	order_id		varchar2(20),
	pdt_name		varchar2(50),
	pdt_cnt			varchar2(50),
	pdt_price		varchar2(50)
);

create table b_payment(
	id				varchar2(20) 	primary key,
	order_id		varchar2(20),
	total_price		varchar2(20)
);
