<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
%>
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/Dictionary?useSSL=false"
	driver="com.mysql.jdbc.Driver" user="root" password="1234" />

<!-- 쿼리는 select문 실행 결과를 resultSet1에 저장 -->
<sql:query dataSource="${dataSource}" var="resultSet1">
   SELECT * FROM MEMBER WHERE ID=? and password=?
	<sql:param value="<%=id%>" />
	<sql:param value="<%=password%>" />
</sql:query>
<!-- 하나를 꺼내온다 결과가 한개라도 있으면 실행이됨 (아이디를 참조하여 해당 인덱스를 삭제) -->
<c:forEach var="row" items="${resultSet1.rows}">
	<sql:update dataSource="${dataSource}" var="resultSet">
  		DELETE FROM member WHERE id = ?
   		<sql:param value="<%=id%>" />
	</sql:update>

	<c:if test="${resultSet>=1}">
		<c:import var="url" url="logoutMember.jsp" />
		<c:redirect url="resultMember.jsp" />
	</c:if>
</c:forEach>
<!-- 회원정보가 없을경우 아래 주소로 이동 -->
<c:redirect url="deleteMember.jsp?error=1" />


