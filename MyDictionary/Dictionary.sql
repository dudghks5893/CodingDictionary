create database Dictionary;

-- 언어 테이블- 코딩사전 테이블 삭제 후 삭제가능
drop table language;
create table language (
	language varchar(20) not null,
    primary key (language)
)default CHARSET=utf8;

select * from language;

insert language values('JAVA');
insert language values('CSS');
insert language values('HTML');
insert language values('JavaScript');
insert language values('JSTL');
insert language values('XML');

update language set language='AAAA' where language='JAVA';

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

insert into CodingDictionary values('1','JAVA','if(){}','x','만일','조건문','()안속 조건이 참일때만 {}안속 코드를 실행','if(1==1){\n     System.out.println("참이라서 출력됨");\n}');
insert into CodingDictionary values('2','CSS','width','x','너비의','요소의 가로길이 지정','값을 정의하는 방법은 숫자 뒤에 단위를 적으면 됩니다.','<div style="width:200px;">여백의미</div>');
insert into CodingDictionary values('3','HTML','<p>','paragraph','단락','문단을 정의','브라우저는 자동으로 <p> 요소의 위쪽과 아래쪽에 약간의 여백을 추가합니다.','<p>첫번째 문단</p>\n<p>두번째 문단</p>');
insert into CodingDictionary values('4','JavaScript','function','x','기능을 하다','함수()','하나의 특별한 목적의 작업을 수행하도록 설계된 독립적인 블록을 의미합니다. 이러한 함수는 필요할 때마다 호출하여 해당 작업을 반복해서 수행할 수 있습니다.','function A(number){\n     return number * number;\n}');
insert into CodingDictionary values('5','XML','404','404 Not Found','찾을 수 없음','오류','서버가 요청한 페이지를 찾을 수 없다. 예를 들어 서버에 존재하지 않는 페이지에 대한 요청이 있을 경우 서버는 이 코드를 제공한다.','<error-page>\n     <error-code>404</error-code>\n     <location>/보여줄에러페이지.jsp</location>\n</error-page>');
insert into CodingDictionary values('6','JSTL','<c:out>','x','출력','출력 태그','이 태그는 변수 내용을 출력할 때 사용되는 태그이다. EL태그로도 출력할 수 있지만, 아래와 같이 태그가 포함된 변수를 escapeXml 항목을 true/false 지정해서 태그를 포함해서 출력할지 적용해서 출력할지 결정할 수 있다.','1. JSTL변수 SJP에서 사용\n- JSP에서는 태그가 적용되어 출력이 되기 때문에 escapeXml 값을 안 줌.\n\n     <c:set var="변수이름" value="값"/>\n     <%\n        String test = (String)pageContext.getAttribute("JSTL에서 받아올 변수이름");\n     %>\n\n\n\n2.JSP 변수 JSTL에서 사용\n- escapeXml 항목을 true/false 지정해서 태그를 포함해서 출력할지 적용해서 출력할지 결정할 수 있다.\n\n     <%\n      String b = "<b>YH</b>";\n      pageContext.setAttribute("변수이름",b);\n     %>\n\n     <c:out value="${JSP에서 받아올 변수이름}" escapeXml="false"/>\n\n\n- 기본적으로 escapeXml 이라는 값을 입력 안하면 true로 처리가 되고, 이 속성은 <, > 와 같은 특수문자 값들을\nHTML 특수 문자표로 변경하여 문자열로 화면에 뿌려주게 된다.\n하지만,태그를 원하는 대로 적용시켜야 할 경우도 존재하니 이럴 경우 escapeXml="false" 처리를 해주면 된다.');

select  * from CodingDictionary order by num desc;
SELECT * FROM CodingDictionary order by Num desc limit 30,5;
SELECT * FROM CodingDictionary where Language='CSS';

update codingdictionary set ex='하이' where num=6;

 -- 컬럼 합침 검색창에 이용
SELECT * FROM CodingDictionary where concat(Num,Language,Code,Abbreviation,Meaning,Type,Explanation,Ex) like '%i%' and Language like 'JAVA';

delete from CodingDictionary where Num = 3;



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

insert into member values('admin','1234','운영자','dudghks2814@naver.com','2021-01-11 20:32:15.425');



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
       id varchar(10)not null,
       name varchar(10) not null,
       subject varchar(100) not null,
       content text not null,
       regist_day varchar(30),
       hit int,
       ip varchar(20),
       PRIMARY KEY (num),
       foreign key (name)references member (name)on update cascade on delete cascade
)default CHARSET=utf8;

select * from board; 
desc board;
select * from board where name not in('운영자') ORDER BY num DESC;
SELECT * FROM board where name='채영환';
insert into board values('7', 'dud', '펭수', 'DB로입력', 'DB로입력해봄', '2021/01/22(21:35:20)', '0', '0:0:0:0:0:0:0:1');


-- 게시판 관리자 테이블
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
insert into adminboard values('1', 'admin', '운영자', '공지합니다.', '공지사항1', '2021/01/22(21:35:20)', '0', '0:0:0:0:0:0:0:1');

desc adminboard;






        
        
        
        
        
        
        
        
