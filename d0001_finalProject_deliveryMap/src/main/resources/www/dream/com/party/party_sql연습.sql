select *
  from s_party;

--카테션 프로덕트. 정보 건수의 곱하기로 건수가 만들어 져서... 가치없는 것이야
select *
  from s_party p, s_contact_point cp;
--join
select *
  from s_party p, s_contact_point cp
 where p.user_id = cp.user_id;
--Outer
select *
  from s_party p, s_contact_point cp
 where p.user_id = cp.user_id(+);
select *
  from s_party p left outer join s_contact_point cp on p.user_id = cp.user_id;
--회장님의 정보와 연락처 정보를 조회
select name, birth_dt, sex, descrim, contact_point_type, info
  from s_party p left outer join s_contact_point cp on p.user_id = cp.user_id
 where p.user_id ='admin';
 
 
 
 
--number (정밀도,배율)
-- 정밀도: 소수점의 오른쪽과 왼쪽 에 저장될 수 있는 전체 자릿수의 최대값
-- 배율 :  소수점의 오른쪽에 저장될 수 있는 최대 자릿수
-- 최대 정수자리 3자리(10-7), 소수자리 7자리를 입력 받을 수 있는 숫자형 데이터 형식
-- 반올림 유의 
create table b_test(
	test_number			number(10,7),
    test_input          varchar2(100)
);

insert into b_test(test_number, test_input)
	values(12.1234567890 , '12.1234567890');
insert into b_test(test_number, test_input)
	values(123.1234567890 , '123.1234567890');
insert into b_test(test_number, test_input)
	values(1234.1234567890 , '1234.1234567890');