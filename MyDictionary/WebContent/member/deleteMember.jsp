<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/Dictionary?useSSL=false"
	driver="com.mysql.jdbc.Driver" user="root" password="1234" />
<!-- sql:query는 셀렉트 문 실행 결과는 resultSet 지정 -->
<sql:query dataSource="${dataSource}" var="resultSet">
   SELECT * FROM MEMBER WHERE ID=?
   <sql:param value="<%=sessionId%>" />
</sql:query>


	
	<title>회원 탈퇴</title>
</head>
<body>
	<jsp:include page="../include/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 탈퇴</h1>
		</div>
	</div>
	<!-- rows 객체가 여러개일때 -->
	<!-- split('나눌기준') -->
	<c:forEach var="row" items="${resultSet.rows}">
	<c:set var="mail" value="${row.mail}" />
	<c:set var="mail1" value="${mail.split('@')[0]}" />
	<c:set var="mail2" value="${mail.split('@')[1]}" />
			<%
				String error = request.getParameter("error");
				if (error != null) {
					out.println("<div class='alert alert-danger' style='text-align:center'>");
					out.println("<h3>비밀번호를 확인해 주세요</h3>");
					out.println("</div>");
				}
			%>	
	<div class="container">
		<form name="newMember" class="form-horizontal"
			action="processDeleteMember.jsp" method="post"
			onsubmit="return checkForm()">
			<div class="form-group  row">
				<label class="col-sm-2 ">아이디</label>
				<div class="col-sm-3">
					<label class="form-control"><c:out value='${row.id }'/></label>
					<input name="id" type="hidden" class="form-control" placeholder="아이디"
						value="<c:out value='${row.id }'/>" />
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input name="password" type="password" class="form-control"
							placeholder="비밀번호" required autofocus/>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호확인</label>
				<div class="col-sm-3">
					<input name="password_confirm" type="password" class="form-control"
						placeholder="비밀번호 확인" required/>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">닉네임</label>
				<div class="col-sm-3">
					<label class="form-control"><c:out value='${row.name }'/></label>
				</div>
			</div>
			<div class="form-group  row ">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-5">
					<label class="form-control">${mail1}@${mail2}</label>
				</div>
			</div>
			<div class="form-group  row mt-5">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-danger" value="회원탈퇴"> 
					<a href="../dictionary/selectDictionary" class="btn btn-primary">취소</a>
				</div>
			</div>
		</form>	
	</div>
	</c:forEach>
</body>
</html>
<script type="text/javascript">
	function checkForm() {
		if (!document.newMember.id.value) {
			alert("아이디를 입력하세요.");
			return false;
		}
		if (!document.newMember.password.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if (document.newMember.password.value != document.newMember.password_confirm.value) {
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}

	}
</script>