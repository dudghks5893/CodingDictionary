<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	//한글 인코딩
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	// 이메일 앞 @ 회사
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameterValues("mail2")[0];
	// 이메일 합치기
	String mail = mail1 + "@" + mail2;
	// 현재 날짜와 시간을 생성한다. (가입한 시간 알기 위해서)
	Date currentDatetime = new Date(System.currentTimeMillis());
	java.sql.Date sqlDate = new java.sql.Date(currentDatetime.getTime());
	java.sql.Timestamp timestamp = new java.sql.Timestamp(currentDatetime.getTime());
%>
<!-- DB 설정 -->
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/Dictionary?useSSL=false"
	driver="com.mysql.jdbc.Driver" user="root" password="1234" />
	
<!-- 쿼리는 select문 실행 결과를 resultSet1에 저장 -->
<sql:query dataSource="${dataSource}" var="resultSet1">
   SELECT * FROM MEMBER WHERE ID=?
	<sql:param value="<%=id%>" />
</sql:query>

<!-- 하나를 꺼내온다 결과가 한개라도 있으면 실행이됨 (아이디가 중복된다면) -->
<c:forEach var="row" items="${resultSet1.rows}">
	<c:redirect url="addMember.jsp?error=1" /> <!-- 에드멤버로 이동  -->
</c:forEach>

<!-- 쿼리는 select문 실행 결과를 resultSet2에 저장 -->
<sql:query dataSource="${dataSource}" var="resultSet2">
   SELECT * FROM MEMBER WHERE NAME=?
	<sql:param value="<%=name%>" />
</sql:query>

<!-- 하나를 꺼내온다 결과가 한개라도 있으면 실행이됨 (닉네임이 중복된다면) -->
<c:forEach var="row" items="${resultSet2.rows}">
	<c:redirect url="addMember.jsp?error=2" /> <!-- 에드멤버로 이동  -->
</c:forEach>

<!-- DB에 새 유저 입력 -->
<sql:update dataSource="${dataSource}" var="resultSet">
   INSERT INTO member VALUES (?, ?, ?, ?, ?)
   <sql:param value="<%=id%>" />
	<sql:param value="<%=password%>" />
	<sql:param value="<%=name%>" />
	<sql:param value="<%=mail%>" />
	<sql:param value="<%=timestamp%>" />
</sql:update>
<!-- 업데이트(수정,삭제,입력)결과는 정수인데 항상 1이상이다.-->
<!-- 결과가 0 이하라면 에러 -->
<c:if test="${resultSet>=1}">
	<!-- 결과가 정상이면 아래 url로 이동 -->
	<c:redirect url="resultMember.jsp?msg=1" />
</c:if>

