show tables;

create table board (
	idx 		int not null auto_increment, 	/* 게시글 고유번호 */
	nickName 	varchar(20) not null,			/* 게시글을 올린 사람의 닉네임 */
	title		varchar(100) not null,			/* 게시글의 글 제목 */
	email 		varchar(100), 					/* 글쓴이의 이메일 주소 */
	homepage	varchar(100),					/* 글쓴이의 홈페이지(블로그) 주소 */
	content		text not null,					/* 글 내용 */
	wDate		datetime default now(),			/* 글 올린 날짜 */
	readNum		int default 0, 					/* 글 조회수 누적처리 */
	hostIp		varchar(50) not null,			/* client 접속 IP */
	recommendNum		int default 0,			/* '좋아요' 횟수 누적처리 */
	mid			varchar(20) not null,			/* 회원 아이디(게시글 조회시 사용) */
	primary key(idx)							/* 게시판의 기본키 : 고유번호 */
);

desc board;

insert into board values (default, '박김이1', '게시판1', 'pkl1@naver.com', 
'http://naver.com/pkl1', '게시판 테스트1', default, default, 'localhost', default, 'pkl1');
insert into board values (default, '박김이2', '게시판2', 'pkl2@naver.com', 
'http://naver.com/pkl2', '게시판 테스트2', default, default, 'localhost', default, 'pkl2');
insert into board values (default, '박김이3', '게시판3', 'pkl3@naver.com', 
'http://naver.com/pkl3', '게시판 테스트3', default, default, 'localhost', default, 'pkl3');
insert into board values (default, '박김이4', '게시판4', 'pkl4@naver.com', 
'http://naver.com/pkl4', '게시판 테스트4', default, default, 'localhost', default, 'pkl4');
insert into board values (default, '박김이5', '게시판5', 'pkl5@naver.com', 
'http://naver.com/pkl5', '게시판 테스트5', default, default, 'localhost', default, 'pkl5');
insert into board values (default, '박김이6', '게시판6', 'pkl6@naver.com', 
'http://naver.com/pkl6', '게시판 테스트6', default, default, 'localhost', default, 'pkl6');
insert into board values (default, '박김이7', '게시판7', 'pkl7@naver.com', 
'http://naver.com/pkl7', '게시판 테스트7', default, default, 'localhost', default, 'pkl7');
insert into board values (default, '박김이8', '게시판8', 'pkl8@naver.com', 
'http://naver.com/pkl8', '게시판 테스트8', default, default, 'localhost', default, 'pkl8');
insert into board values (default, '박김이9', '게시판9', 'pkl9@naver.com', 
'http://naver.com/pkl9', '게시판 테스트9', default, default, 'localhost', default, 'pkl9');
insert into board values (default, '박김이10', '게시판10', 'pkl10@naver.com', 
'http://naver.com/pkl10', '게시판 테스트10', default, default, 'localhost', default, 'pkl10');
insert into board values (default, '박김이11', '게시판11', 'pkl11@naver.com', 
'http://naver.com/pkl11', '게시판 테스트11', default, default, 'localhost', default, 'pkl11');

select * from board;