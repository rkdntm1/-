drop SEQUENCE seq_reply_id;
drop table b_reply;
drop table b_board;

--id, name, description
create table b_category_board(
	id				varchar2(10) 		primary key,
	name			varchar2(100),
	description		varchar2(100),
	reg_dt			timestamp		default sysdate not null,	--등록시점
	upt_dt			timestamp		default sysdate not null
);

insert into b_category_board(id, name, description)
	values('kFood', '한식', 'Store');
insert into b_category_board(id, name, description)
	values('jFood', '일식', 'Store');	
insert into b_category_board(id, name, description)
	values('cFood', '중식', 'Store');
insert into b_category_board(id, name, description)
	values('wFood', '양식', 'Store');
insert into b_category_board(id, name, description)
	values('snack', '분식', 'Store');	
insert into b_category_board(id, name, description)
	values('dessert', '디저트', 'Store');


CREATE SEQUENCE seq_reply_id;
--id, writer_id, content, reg_dt, upt_dt, descrim, board_id, title, read_cnt, like_cnt, dislike_cnt
create table b_reply(
	id				varchar2(4000)	primary key,
	writer_id		varchar2(10),
	content			varchar2(4000),
	reg_dt			timestamp		default sysdate not null,	--등록시점
	upt_dt			timestamp		default sysdate not null,
	descrim			varchar2(10)	not null,	--reply, post
	--descrim이 post일 경우 사용되는 정보들
	board_id		varchar2(10)	,
	title			varchar2(100),
	read_cnt		number(9)		default 0,
	like_cnt		number(9)		default 0,
	dislike_cnt		number(9)		default 0
);


create index index_reply_board_id on b_reply(board_id, id);
drop index index_reply_board_id;
