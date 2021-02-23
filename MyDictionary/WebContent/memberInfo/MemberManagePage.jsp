<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<%
	String id = request.getParameter("id");
%>
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/Dictionary?useSSL=false"
	driver="com.mysql.jdbc.Driver" user="root" password="1234" />
<!-- sql:query는 셀렉트 문 실행 결과는 resultSet 지정 -->
<sql:query dataSource="${dataSource}" var="resultSet">
   SELECT * FROM MEMBER WHERE ID=?
   <sql:param value="<%=id%>" />
</sql:query>


	
	<title>회원 수정</title>
</head>
<body onload="init()">
	<jsp:include page="../include/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 수정</h1>
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
		if ("1".equals(error)) {
		out.println("<div class='alert alert-danger' style='text-align:center'>");
		out.println("<h3>이미 사용 중인 닉네임입니다.</h3>");
		out.println("</div>");
	}
	%>
	
	<div class="container">
		<form name="newMember" class="form-horizontal"
			action="processMemberManage.jsp" method="post"
			onsubmit="return checkValue()">
			<div class="form-group  row">
				<label class="col-sm-2 ">아이디</label>
				<div class="col-sm-3">
					<input name="id" type="hidden" class="form-control" placeholder="아이디"
						value="<c:out value='${row.id }'/>" />
					<label class="form-control"><c:out value='${row.id }'/></label>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input name="password" type="password" class="form-control"
						placeholder="비밀번호" value="<c:out value='${row.password }'/>" required>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">닉네임</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control"
						placeholder="name" value="<c:out value='${row.name}'/>" required>
				</div>
			</div>
			<div class="form-group  row ">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<input type="text" name="mail1" maxlength="50" value="${mail1}"required>@
					<select name="mail2" id="mail2">
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>nate.com</option>
					</select>
				</div>
			</div>
			<div class="form-group row mt-5">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="submit" class="btn btn-primary" value="회원수정 "> 
					<a href="processDeleteMemberManage.jsp?id=${row.id}" class="btn btn-danger">회원추방</a>
					<a href="MemberManage.jsp" class="btn btn-primary">취소</a>
				</div>
			</div>
		</form>	
	</div>
	</c:forEach>
</body>
</html>
<script type="text/javascript">
	function init() {
		setComboMailValue("${mail2}");
	}

	function setComboMailValue(val) {
		var selectMail = document.getElementById('mail2');
		for (i = 0, j = selectMail.length; i < j; i++) {
			if (selectMail.options[i].value == val) {
				selectMail.options[i].selected = true; 
				break;
			}
		}
	}
	function checkValue() {
		var StartId = /^[a-z|A-Z|[0-9]*$/;
		var TextCount = /^[0-9a-zA-Z]{6,14}$/;
		var IdNotType = /^[0-9]*$/; 
		var passwordCount = /^.{4,20}$/
		var nameType = /^[0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]{2,10}$/;
		var mailType = /^[0-9a-zA-Z]{4,20}$/;
		var mailNotType = /^[0-9]*$/; 
		
		
		var form = document.newMember;
		var id = form.id.value;
		var password = form.password.value;
		var name = form.name.value;
		var mail1 = form.mail1.value;
		
		if(IdNotType.test(id)){
			alert("아이디는 영문자와 조합하여 사용해 주세요!");
			form.id.select();
			return false;
		}
		if(!StartId.test(id)){
			alert("아이디는 영문자를 사용하여 주세요!");
			form.id.select();
			return false;
		}
		if(!TextCount.test(id)){
			alert("아이디는 6~14자로 작성하여 주세요!");
			form.id.select();
			return false;
		}
		if(!passwordCount.test(password)){
			alert("비밀번호는 4~20자로 작성하여 주세요!");
			form.password.select();
			return false;
		}
		if(!nameType.test(name)){
			alert("닉네임은 특수문자를 제외한 2~10글자로 작성하여 주세요.");
			form.name.select();
			return false;
		}
		if(mailNotType.test(mail1)){
			alert("올바른 이메일 형태가 아닙니다.");
			form.mail1.select();
			return false;
		}
		if(!mailType.test(mail1)){
			alert("올바른 이메일 형태가 아닙니다.");
			form.mail1.select();
			return false;
		}
		
	}
</script>