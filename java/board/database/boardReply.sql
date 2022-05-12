drop table boardReply

/*댓글테이블*/
create table boardReply (
	idx 		int not null auto_increment, 	/* 게시글 고유번호 */
	boardIdx 		int not null , 				/* 원본게시글 고유번호(외래키) */
	mid			varchar(20) not null,			/* 회원 아이디(게시글 조회시 사용) */
	nickName 	varchar(20) not null,			/* 게시글을 올린 사람의 닉네임 */
	content		text not null,					/* 글 내용 */
	wDate		datetime default now(),			/* 댓글 쓴날짜 */
	hostIp		varchar(50) not null,			/* client 접속 IP */
	
	primary key(idx)							/* 게시판의 기본키 : 고유번호 */
	foreign key(boardIdx) references board(idx) /* board테이블의 idx를 boardReply테이블의 외래키로 설정 */
	on update cascade							/* board테이블의 pk변경에 영향받음 */
	on delete restrict							/* board테이블의 pk삭제금지 */
);