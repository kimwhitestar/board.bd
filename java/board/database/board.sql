show tables;

--drop table board;
create table board (
	idx 			int not null auto_increment, /* 게시글 고유번호 */
	nickName 		varchar(20) not null,		/* 게시글을 올린 사람의 닉네임 */
	title			varchar(100) not null,		/* 게시글의 글 제목 */
	email 			varchar(100), 				/* 글쓴이의 이메일 주소 */
	homepage		varchar(100),				/* 글쓴이의 홈페이지(블로그) 주소 */
	content			text not null,				/* 글 내용 */
	wDate			datetime default now(),		/* 글 올린 날짜 */
	mid				varchar(20) not null,		/* 회원 아이디(게시글 조회시 사용) */
	hostIp			varchar(50) not null,		/* client 접속 IP */
	readNum			int default 0, 				/* 글 조회수 누적처리 */
	recommendNum	int default 0,				/* '좋아요' 횟수 누적처리 */
	noRecommendNum	int default 0,				/* '싫어요' 횟수 누적처리 */
	replyNum		int default 0,				/* 댓글수 */	
	primary key(idx)							/* 게시판의 기본키 : 고유번호 */
);
--alter table board add column noRecommendNum	int default 0;
desc board;

--delete from board;
insert into board values (default, '박김이1', '게시판1', 'pkl1@naver.com', 
'http://naver.com/pkl1', '게시판 테스트1', '2022-01-11','pkl1', 'localhost', default, default, default, default);
insert into board values (default, '박김이2', '게시판2', 'pkl2@naver.com',                   
'http://naver.com/pkl2', '게시판 테스트2', '2022-02-11', 'pkl2', 'localhost', default, default, default, default);
insert into board values (default, '박김이3', '게시판3', 'pkl3@naver.com',                   
'http://naver.com/pkl3', '게시판 테스트3', '2022-03-01', 'pkl3', 'localhost', default, default, default, default);
insert into board values (default, '박김이4', '게시판4', 'pkl4@naver.com',                   
'http://naver.com/pkl4', '게시판 테스트4', '2022-03-11', 'pkl4', 'localhost', default, default, default, default);
insert into board values (default, '박김이5', '게시판5', 'pkl5@naver.com',                   
'http://naver.com/pkl5', '게시판 테스트5', '2022-03-12', 'pkl5', 'localhost', default, default, default, default);
insert into board values (default, '박김이6', '게시판6', 'pkl6@naver.com',                   
'http://naver.com/pkl6', '게시판 테스트6', '2022-04-11', 'pkl6', 'localhost', default, default, default, default);
insert into board values (default, '박김이7', '게시판7', 'pkl7@naver.com',                   
'http://naver.com/pkl7', '게시판 테스트7', '2022-04-11', 'pkl7', 'localhost', default, default, default, default);
insert into board values (default, '박김이8', '게시판8', 'pkl8@naver.com',                   
'http://naver.com/pkl8', '게시판 테스트8', '2022-05-01', 'pkl8', 'localhost', default, default, default, default);
insert into board values (default, '박김이9', '게시판9', 'pkl9@naver.com',                   
'http://naver.com/pkl9', '게시판 테스트9', '2022-05-05', 'pkl9', 'localhost', default, default, default, default);
insert into board values (default, '박김이10', '게시판10', 'pkl10@naver.com', 
'http://naver.com/pkl10', '게시판 테스트10', '2022-05-05', 'pkl10', 'localhost', default, default, default, default);
insert into board values (default, '박김이11', '게시판11', 'pkl11@naver.com',                
'http://naver.com/pkl11', '게시판 테스트11', '2022-05-11', 'pkl11', 'localhost', default, default, default, default);
insert into board values (default, '박김이12', '게시판12', 'pkl12@naver.com',                
'http://naver.com/pkl12', '게시판 테스트12', '2022-05-12', 'pkl12', 'localhost', default, default, default, default);
insert into board values (default, '박김이13', '게시판13', 'pkl13@naver.com',                
'http://naver.com/pkl13', '게시판 테스트13', '2022-05-13', 'pkl13', 'localhost', default, default, default, default);
insert into board values (default, '박김이15', '게시판15', 'pkl15@naver.com',                
'http://naver.com/pkl15', '게시판 테스트15', '2022-05-15', 'pkl15', 'localhost', default, default, default, default);

select * from board order by idx desc
/*
 * interval 1 day
 * interval 1 month
 * interval 1 year
 */
select wDate as cnt from board where date_sub(now() , interval 2 year) <= wDate and wDate <= now()
select date_sub(now() , interval 1 day)
select if('하나', '1', '하나')
select case recommendNum when 0 then 0 else recommendNum -1 end from board
select case noRecommendNum when 0 then 0 else noRecommendNum -1 end from board


