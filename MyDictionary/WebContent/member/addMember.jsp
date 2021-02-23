<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<script type="text/javascript">
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
		var password_confirm = form.password_confirm.value;
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
		if(form.password.value != form.password_confirm.value){
			alert("비밀번호를 확인 하세요!");
			form.password_confirm.focus();
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


<title>회원 가입</title>
</head>
<body>
	<jsp:include page="../include/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 가입</h1>
		</div>
	</div>
			<%
				String error = request.getParameter("error");
				if ("1".equals(error)) {
					out.println("<div class='alert alert-danger' style='text-align:center'>");
					out.println("<h3>이미 사용 중인 아이디입니다.</h3>");
					out.println("</div>");
				}
				if ("2".equals(error)) {
					out.println("<div class='alert alert-danger' style='text-align:center'>");
					out.println("<h3>이미 사용 중인 닉네임입니다.</h3>");
					out.println("</div>");
				}
			%>	
	<div class="container">
		<form class="form-horizontal"  action="processAddMember.jsp" method="post" name="newMember" onsubmit="return checkValue()" > <!-- onsubmit="return checkForm()" 버튼에 onclick과 비슷 한 효과 -->
			<div class="form-group  row">
				<label class="col-sm-2 ">아이디</label>
				<div class="col-sm-3">
					<input name="id" type="text" class="form-control" placeholder="아이디" required autofocus>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호</label>
				<div class="col-sm-3">
					<input name="password" type="password" class="form-control" placeholder="비밀번호" required>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">비밀번호확인</label>
				<div class="col-sm-3">
					<input name="password_confirm" type="password" class="form-control" placeholder="비밀번호 확인" required>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">닉네임</label>
				<div class="col-sm-3">
					<input name="name" type="text" class="form-control" placeholder="닉네임" required>
				</div>
			</div>
			<div class="form-group  row ">
				<label class="col-sm-2">이메일</label>
				<div class="col-sm-10">
					<input type="text" name="mail1" maxlength="50" required>@ 
					<select name="mail2">
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>nate.com</option>
					</select>
				</div>				
			</div>
			<div class="form-group  row">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary " value="등록 " > 
					<a href="../dictionary/Dictionary.jsp" class="btn btn-primary">취소</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>