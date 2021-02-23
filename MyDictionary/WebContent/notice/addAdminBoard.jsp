<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../dbconn.jsp" %>

<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<title>Board</title>
</head>
<script type="text/javascript">
	function checkForm() {
		if (!document.newWrite.name.value) {
			alert("성명을 입력하세요.");
			return false;
		}
		if (!document.newWrite.subject.value) {
			alert("제목을 입력하세요.");
			return false;
		}
		if (!document.newWrite.content.value) {
			alert("내용을 입력하세요.");
			return false;
		}
	}
</script>
<body>
	<jsp:include page="../include/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">공지 등록</h1>
		</div>
	</div>
<%
	String sessionId = (String) session.getAttribute("sessionId");
	String sql = "SELECT * FROM member where id=?";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, sessionId);
	rs = pstmt.executeQuery();
	if(rs.next()){
%>
	<div class="container">
		<form name="newWrite" action="./processAddAdminBoard.jsp" class="form-horizontal" method="post" onsubmit="return checkForm()">
			<input name="id" type="hidden" class="form-control"
				value="<%=sessionId%>">
			<div class="card">
				<div class="card-header">
					<input name="name" type="hidden" class="form-control" value="<%=rs.getString("name")%>"
						placeholder="이름">
						<%=rs.getString("name")%>
				</div>
	<%
		}
		//DB연결을 닫는다.
		if (rs != null) rs.close();
		if (pstmt != null) pstmt.close();
		if (conn != null) conn.close();
	%>	
				<div class="card-body">
					<input name="subject" type="text" class="form-control mb-3"
						placeholder="제목" required autofocus>
					<textarea name="content" cols="50" rows="15" class="form-control"
						placeholder="내용" required></textarea>
					<div class="form-group row mt-3">
						<div class="col-sm-offset-2 col-sm-10 ">
				 			<input type="submit" class="btn btn-primary " value="등록 ">				
					 		<a href="javascript:window.history.back();" class="btn btn-primary">취소</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<jsp:include page="../include/footer.jsp" />
</body>
</html>



