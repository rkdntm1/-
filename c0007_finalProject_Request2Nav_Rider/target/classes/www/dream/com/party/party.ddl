--Oracle 자료형 선택 시... 고민거리...
--int, long -> number(9), 19
--date -> 년월일(date), 일시(timestamp)
--boolean -> char(1)
drop table b_contact_point;
drop table b_party;
drop table b_contact_point_type;
--Sequence
drop SEQUENCE seq_party_id;

CREATE SEQUENCE seq_party_id START WITH -990000000 MINVALUE -990000000;

--party_type, description
create table b_party_type(
	party_type		varchar2(10),
	description		varchar2(100)
);
insert into b_party_type(party_type, description)
	values('Admin', '관리자');
insert into b_party_type(party_type, description)
	values('Rider', '배달기사');
insert into b_party_type(party_type, description)
	values('Member', '사용자');
insert into b_party_type(party_type, description)
	values('Store', '가게');

--user_id, user_pwd, name, birth_dt, sex, enabled, reg_dt, upt_dt, descrim
create table b_party(
	user_id 		varchar2(20)	primary key,
	user_pwd 		varchar2(100) 	not null,	--100 : 암호화된 결과물까지 고려함
	name 			varchar2(100) 	not null,	--100 : 전지구적인 사람의 이름 길이까지 고려함
	birth_dt 		Date,						--생일 년월일
	sex 			char(1) 		default 1 not null,	--true male, false female
	enabled 		char(1)			default 1,
	reg_dt			timestamp		default sysdate not null,	--등록시점
	upt_dt			timestamp		default sysdate not null,	--수정시점
	location		varchar2(100),
	descrim			varchar2(10)		not null,
	--Store용 속성 정의함
	store_name		varchar2(50),
	store_info		varchar2(50),
	store_rating	varchar2(50),
	store_dibs		varchar2(50)
	--Rider용 속성 정의함
	--User용 속성 정의함
);
create table b_cart(
	user_id					varchar2(20)	 primary key,
	store_id				varchar2(20),
	reg_dt					timestamp		default sysdate not null,	--등록시점
	upt_dt					timestamp		default sysdate not null	--수정시점
);

insert into b_party(user_id, user_pwd, name, birth_dt, sex, enabled, descrim)
	values('admin', '1234', '김이박', '1999-01-30', '1', '1', 'Admin');

create table b_contact_point(
	user_id				varchar2(20),
	contact_point_type	varchar2(10),
	info				varchar2(100),	--연락처 정보
	reg_dt				timestamp		default sysdate not null,	--등록시점
	upt_dt				timestamp		default sysdate not null,	--수정시점
	primary key (user_id, contact_point_type)
);	
	
--가게 카테고리 정보관리
create table b_category_point(
	user_id					varchar2(20),
	category_type			varchar2(10),
	category_name			varchar2(10),
	reg_dt					timestamp		default sysdate not null,	--등록시점
	upt_dt					timestamp		default sysdate not null,	--수정시점
	primary key (user_id, category_type)
);

	
-- 각 행위자별 여러 연락처 정보 관리
--contact_point_type, description
create table b_contact_point_type(
	contact_point_type	varchar2(10),
	description			varchar2(100)
);

insert into b_contact_point_type(contact_point_type, description)
	values('address', '주소지');
insert into b_contact_point_type(contact_point_type, description)
	values('addressNum', '전화번호');
insert into b_contact_point_type(contact_point_type, description)
	values('mobileNum', '핸드폰번호');
insert into b_contact_point_type(contact_point_type, description)
	values('email', '이메일주소');	

--각 행위자별 위치정보(경도 위도) 관리
create table b_location_type(
	location_type		varchar2(10),
	description			varchar2(100)
);

insert into b_location_type(location_type, description)
	values('logitude', '경도');
insert into b_location_type(location_type, description)
	values('latitude', '위도');

create table b_location(
	user_id				varchar2(20),
	location_type		varchar2(10),
	info				varchar2(50),	--위치 정보(경도 위도)
	reg_dt				timestamp		default sysdate not null,	--등록시점
	upt_dt				timestamp		default sysdate not null,	--수정시점
	primary key (user_id, location_type)
);
