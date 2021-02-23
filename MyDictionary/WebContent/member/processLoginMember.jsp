<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	request.setCharacterEncoding("UTF-8");
	//로그인 창으로부터 id password를 입력받아 변수저장
	String id = request.getParameter("id");
	String password = request.getParameter("password");
%>

<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/Dictionary?useSSL=false"
	driver="com.mysql.jdbc.Driver" user="root" password="1234" />

<!-- 쿼리는 select문 실행 결과를 resultSet에 저장 -->
<sql:query dataSource="${dataSource}" var="resultSet">
   SELECT * FROM MEMBER WHERE ID=? and password=?
	<sql:param value="<%=id%>" />
	<sql:param value="<%=password%>" />
</sql:query>
<!-- 하나를 꺼내온다 결과가 한개라도 있으면 실행이됨 -->
<c:forEach var="row" items="${resultSet.rows}">
	<%
		//여기서 로그인 정보의 회원이 있으면 그 아이디를 세션에 저장
		session.setAttribute("sessionId", id);	

	%>
	<c:redirect url="./dictionary/Dictionary.jsp" /> <!-- 홈으로 이동 -->
</c:forEach>
<!-- 회원정보가 없을경우 아래 주소로 이동 -->
<c:redirect url="loginMember.jsp?error=1" />
