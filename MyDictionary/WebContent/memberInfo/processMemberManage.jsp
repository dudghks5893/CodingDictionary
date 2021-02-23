<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="../dbconn.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String mail1 = request.getParameter("mail1");
	String mail2 = request.getParameterValues("mail2")[0];
	// mail = mail1+@+mail2
	String mail = mail1 + "@" + mail2;
	
/* 	pageContext.setAttribute("name1", name); */

	
	String names = "";
	String names2 = "";
	
	// 현재 내 아이디의 닉네임
	String sql2 = "SELECT name FROM MEMBER WHERE ID=?";
	pstmt = conn.prepareStatement(sql2);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	if(rs.next()){
		names = rs.getString("name");
	}
	//사용중인 닉네임이 있는지 검색
	String sql3 = "SELECT name FROM MEMBER WHERE NAME=?";
	pstmt = conn.prepareStatement(sql3);
	pstmt.setString(1, name);
	rs = pstmt.executeQuery();
	if(rs.next()){
		names2 = rs.getString("name");
	}
	
	
	
	if (!names.equals(name) && names2.equals(name)){
		out.println("<script>");
		out.println("location.href = './MemberManagePage.jsp?id="+id+"&error=1'"); 
		out.println("</script>");
	} else {
	
	String sql = "UPDATE MEMBER SET PASSWORD=?, NAME=?, MAIL=? WHERE ID=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, password);
	pstmt.setString(2, name);
	pstmt.setString(3, mail);
	pstmt.setString(4, id);
	pstmt.executeUpdate();
	
	out.println("<script>");
	out.println("alert('회원정보를 수정 하였습니다.')");
	out.println("location.href = './MemberManage.jsp'"); 
	out.println("</script>");
	}	
	
	
%>
<%-- 
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/Dictionary?useSSL=false"
	driver="com.mysql.jdbc.Driver" user="root" password="1234" />
	
<!-- 현재 아이디의 닉네임 -->	
<sql:query dataSource="${dataSource}" var="ID">
	SELECT name FROM MEMBER WHERE ID=?
	 <sql:param value="<%=id%>"/>
</sql:query>

<!-- 중복 닉네임 체크 -->
<sql:query dataSource="${dataSource}" var="names">
   SELECT name FROM MEMBER WHERE NAME=?
	<sql:param value="<%=name%>" />
</sql:query>



<!-- 하나를 꺼내온다 결과가 한개라도 있으면 실행이됨 (해당 아이디의 닉네임이면) -->
<c:forEach var="row" items="${ID.rows}" varStatus="status">
<c:if test="${empty names[status.index].name or row.name eq name or not names[status.index].name eq name}">
			<sql:update dataSource="${dataSource}" var="resultSet">
   				UPDATE MEMBER SET PASSWORD=?, NAME=?, MAIL=? WHERE ID=?
				<sql:param value="<%=password%>" />
				<sql:param value="<%=name%>" />
				<sql:param value="<%=mail%>" />
				<sql:param value="<%=id%>" />
			</sql:update>
			<c:if test="${resultSet>=1}">
				<c:redirect url="resultMember.jsp?msg=0" />
			</c:if>
			<c:if test="${not row.name eq name and names[status.index].name eq name}">
				<c:redirect url="updateMember.jsp?error=1" /> <!-- 업데이트 멤버로 이동  -->
			</c:if>
</c:if>
</c:forEach>


<c:forEach var="row2" items="${NAME.rows}">
<c:if test="${row2.name eq name}">
</c:if>		
		<c:if test="${empty name}">
			<sql:update dataSource="${dataSource}" var="resultSet2">
   				UPDATE MEMBER SET PASSWORD=?, NAME=?, MAIL=? WHERE ID=?
				<sql:param value="<%=password%>" />
				<sql:param value="<%=name%>" />
				<sql:param value="<%=mail%>" />
				<sql:param value="<%=id%>" />
			</sql:update>
		</c:if>
			<c:if test="${resultSet2>=1}">
				<c:redirect url="resultMember.jsp?msg=0" />
			</c:if>
</c:forEach>		 --%>

