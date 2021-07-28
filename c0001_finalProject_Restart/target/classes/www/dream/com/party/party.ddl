--Oracle 자료형 선택 시... 고민거리...
--int, long -> number(9), 19
--date -> 년월일(date), 일시(timestamp)
--boolean -> char(1)
drop table b_contact_point;
drop table b_contact_point_type;
drop table b_party;
drop table b_party_type;
drop table b_location;
drop table b_accountability;
drop table b_accountability_type;

--Sequence
drop SEQUENCE seq_party_id;

CREATE SEQUENCE seq_party_id START WITH -990000000 MINVALUE -990000000;

--party_type, description
create table b_party_type(
	party_type		varchar2(10),
	description		varchar2(100)
);
insert into b_party_type(party_type, description)
	values('Person', '자연인');
insert into b_party_type(party_type, description)
	values('Organization', '조직');
insert into b_party_type(party_type, description)
	values('Post', '직위');

--user_id, user_pwd, name, birth_dt, sex, enabled, reg_dt, upt_dt, descrim
create table b_party(
	--Person과 Organization의 공통 속성 정의 
	user_id 		varchar2(20)	primary key,
	user_name		varchar2(50), --닉네임	
	birth_dt 		Date			default sysdate not null,	--탄생일
	reg_dt			timestamp		default sysdate not null,	--등록시점
	upt_dt			timestamp		default sysdate not null,	--수정시점
	descrim			varchar2(10)	not null,
	--Person용 속성 정의함
	sex 			char(1) 		default 1 not null,	--true male, false female
	user_pwd 		varchar2(100),	--100 : 암호화된 결과물까지 고려함
	state			varchar2(10),
	--Organization(Store용) 속성 정의
	store_info		varchar2(100) --가게 소개
	--Organization(Rider용) 속성 정의
	
	--Post
	
);

--Post 정의
insert into b_party(user_id, user_name, descrim)
	values('0', 'Admin', 'Post');
insert into b_party(user_id, user_name, descrim)
	values('1', 'Rider', 'Post');
insert into b_party(user_id, user_name, descrim)
	values('2', 'Store', 'Post');
insert into b_party(user_id, user_name, descrim)
	values('3', 'Client', 'Post');

--Person 정의
insert into b_party(user_id, user_name, descrim, user_pwd)
	values('ceo', 'Bae병우', 'Person','1234');
insert into b_party(user_id, user_name, descrim, user_pwd)
	values('member2','Bae용훈', 'Person','1234');
insert into b_party(user_id, user_name, descrim, user_pwd)
	values('rider1','Bae강민', 'Person','1234');
insert into b_party(user_id, user_name, descrim, user_pwd)
	values('rider2','Bae한슬', 'Person','1234');
insert into b_party(user_id, user_name, descrim, user_pwd)
	values('rider3','Bae영권', 'Person','1234');
	
--Organization 정의
insert into b_party(user_id, user_name, store_info, descrim)
	values('store0', 'BaeNom', '빠른사람급구', 'Organization');
insert into b_party(user_id, user_name, store_info, descrim)
	values('store1', '김가네', '맛나용', 'Organization');
insert into b_party(user_id, user_name, store_info, descrim)
	values('store2', '김치뚝딱', '김치뚝딱 뚝딱', 'Organization');
insert into b_party(user_id, user_name, store_info, descrim)
	values('store3', '메가커피', '아메리카노가 맛나요', 'Organization');
	
	
	
create table b_accountability_type(
	acc_type		varchar2(100), --행위
	description		varchar2(100)	not null
);
--멤버
insert into b_accountability_type(acc_type, description)
	values('회원가입', '멤버 회원가입');
--라이더
insert into b_accountability_type(acc_type, description)
	values('배달역할수행자 가입하다', '배달부 가입');
--사장
insert into b_accountability_type(acc_type, description)
	values('사장 가입하다', '사장님 납시오');

create table b_accountability(
	--Person과 Organization의 공통 속성 정의 
	owner_id 		varchar2(20), -- 주체가게
	resp_id 		varchar2(20), -- 객체라이더
	acc_type		varchar2(100), --행위 배달요청
	from_date		timestamp		default sysdate not null,
	thru_date		timestamp		default '9999.12.31', --0이 활동x 9999가 진행중 1이 완료
	primary key(owner_id, resp_id)
);

--멤버
insert into b_accountability(owner_id, resp_id, acc_type)
	values('member2', '3', '회원가입');
--라이더
insert into b_accountability(owner_id, resp_id, acc_type)
	values('rider1', '1', '배달역할수행자 가입하다');
insert into b_accountability(owner_id, resp_id, acc_type)
	values('rider2', '1', '배달역할수행자 가입하다');
insert into b_accountability(owner_id, resp_id, acc_type)
	values('rider3', '1', '배달역할수행자 가입하다');
--사장
insert into b_accountability(owner_id, resp_id, acc_type)
	values('ceo', '2', '사장 가입하다');
	


--각 행위자별 위치정보(경도 위도) 관리 -> 동선관리
--user_id, longitude, latitude, reg_dt, latest_dt
create table b_location(
	user_id				varchar2(20) primary key,
	longitude			varchar2(100), --위치 정보(경도 위도)
	latitude			varchar2(100),
	--언제부터
	reg_dt				timestamp		default sysdate not null,
	--언제까지
	latest_dt 			timestamp		default '9999.12.31'
);

insert into b_location(user_id,latitude, longitude)
	values('store0', 37.484015, 126.928856);
insert into b_location(user_id,latitude, longitude)
	values('store1', 37.480380, 126.877203);
insert into b_location(user_id,latitude, longitude)
	values('store2',37.4803199,126.8779695);
insert into b_location(user_id,latitude, longitude)
	values('store3', 37.480744, 126.880937);

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

create table b_contact_point(
	user_id				varchar2(20),
	contact_point_type	varchar2(10),
	info				varchar2(100),	--연락처 정보
	reg_dt				timestamp		default sysdate not null,	--등록시점
	upt_dt				timestamp		default sysdate not null,	--수정시점
	primary key (user_id, contact_point_type)
);

--Organization
insert into b_contact_point(user_id, contact_point_type, info)
	values('store0', 'address', '서울특별시 금천구 가산동 가산디지털2로 123 월드메르디앙 2차 310호 배놈프로젝트');
insert into b_contact_point(user_id, contact_point_type, info)
	values('store1', 'address', '서울특별시 금천구 대성디폴리스 A동1511-3호 김가네');
insert into b_contact_point(user_id, contact_point_type, info)
	values('store2', 'address', '가산동 458-18번지 금천구 서울특별시 KR 김치뚝딱');
insert into b_contact_point(user_id, contact_point_type, info)
	values('store3', 'address', '서울특별시 금천구 가산동 가산디지털1로 171 1층 104호 메거커피');




















--가게 카테고리 정보관리
create table b_category_point(
	user_id					varchar2(20),
	category_type			varchar2(10),
	category_name			varchar2(10),
	reg_dt					timestamp		default sysdate not null,	--등록시점
	upt_dt					timestamp		default sysdate not null,	--수정시점
	primary key (user_id, category_type)
);

	

create table b_cart(
	user_id					varchar2(20)	 primary key,
	store_id				varchar2(20),
	reg_dt					timestamp		default sysdate not null,	--등록시점
	upt_dt					timestamp		default sysdate not null	--수정시점
);