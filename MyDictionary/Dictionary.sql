create database Dictionary;

-- 언어 테이블- 코딩사전 테이블 삭제 후 삭제가능
drop table language;
create table language (
	language varchar(20) not null,
    primary key (language)
)default CHARSET=utf8;

select * from language;


-- 코딩사전 테이블- 즐겨찾기 테이블 삭제 후 삭제가능
-- 코딩사전 테이블- language 테이블 참조 중
drop table CodingDictionary;

CREATE TABLE CodingDictionary (
	   Num int not null auto_increment,
       Language varchar(20) not null,
       Code varchar(40) not null,
       Abbreviation varchar(20) not null,
       Meaning varchar(20) not null,
       Type varchar(20),
       Explanation varchar(300),
       Ex text not null,
       PRIMARY KEY (Num),
       foreign key (Language)references language (language)on update cascade on delete cascade
)default CHARSET=utf8;


-- 멤버 테이블- board 테이블 , 즐겨찾기 테이블 삭제시 삭제가능
drop table member;

create table member ( 
    id varchar(30) not null,
    password varchar(30) not null,
    name varchar(30) not null,
    mail  varchar(30),
    regist_day varchar(50),    
    primary key(name)
) default CHARSET=utf8;

select * from member;
select id from member where mail = 'dudghks2814@naver.com';
insert into member values('admin','1234','운영자','dudghks2814@naver.com','2021-00-00 20:32:15.425');



-- 즐겨 찾기 테이블- 코딩사전 테이블, 멤버테이블 참조중
drop table bookmark;
create table bookmark (
		UserName varchar(30) not null,
        CDnum int not null,
		foreign key (UserName)references member (name)on update cascade on delete cascade,
        foreign key (CDnum)references CodingDictionary (Num)on update cascade on delete cascade
        )default CHARSET=utf8;
        
select * from bookmark;


-- 게시판 유저 테이블- member테이블 참조중
drop table board;
CREATE TABLE board (
       num int not null auto_increment,
       id varchar(30)not null,
       name varchar(30) not null,
       subject varchar(100) not null,
       content text not null,
       regist_day varchar(30),
       hit int,
       ip varchar(20),
       PRIMARY KEY (num),
       foreign key (name)references member (name)on update cascade on delete cascade
)default CHARSET=utf8;

-- 컬럼 수정
alter table board modify name varchar(30) not null;

select * from board;

-- 댓글 테이블
drop table comments;
create table comments (
       num int auto_increment,
	   board_num int not null,
       name varchar(30) not null,
       content text not null,
       regist_day varchar(30),
       primary key (num),
       foreign key (board_num)references board (num)on update cascade on delete cascade,
       foreign key (name)references member (name)on update cascade on delete cascade
)default CHARSET=utf8;

select * from comments;


-- 댓글 좋아요
drop table good;
create table good(
	commentsNum int not null,
    userName varchar(30) not null,
    foreign key (commentsNum)references comments (num)on update cascade on delete cascade,
    foreign key (userName)references member (name)on update cascade on delete cascade
)default CHARSET=utf8;

select * from good;


-- 게시판 관리자 테이블 (공지사항)
drop table adminboard;
CREATE TABLE adminboard (
       num int not null auto_increment,
       id varchar(10) not null,
       name varchar(10) not null,
       subject varchar(100) not null,
       content text not null,
       regist_day varchar(30),
       hit int,
       ip varchar(20),
       PRIMARY KEY (num)
)default CHARSET=utf8;

select * from adminboard;






        
        
        
        
        
        
        
        
