drop table b_product

--order_id, member_id, store_id, order_msg, detail_order_id
create table b_orderList(
	order_id			varchar2(20)	primary key,
	member_id			varchar2(20),
	store_id			varchar2(20),
	order_msg			varchar2(100),
	detail_order_id		varchar2(300)
);

--detail_order_id, product_name, product_cnt, product_price
create table b_detail_order(
	detail_order_id		varchar2(20)	primary key,
	product_name		varchar2(20),
	product_cnt			varchar2(20),
	product_price		varchar2(50)
);

insert into b_detail_order(detail_order_id, product_name, product_cnt, product_price)
	values('ㅇㅇㅇ', 'ㄴㄴ', 'ㄴㄴㄴ', 'ㄴㄴㄴㄴ');

create table b_payment(
	id				varchar(20) 	primary key,
	total_price		varchar(20)
);
