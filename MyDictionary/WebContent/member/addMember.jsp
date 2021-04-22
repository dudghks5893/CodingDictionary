<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<jsp:include page="../include/menu.jsp" />
<title>회원 가입</title>
</head>
<body>
	
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
				if ("3".equals(error)) {
					out.println("<div class='alert alert-danger' style='text-align:center'>");
					out.println("<h3>이미 아이디가 있습니다.</h3>");
					out.println("</div>");
				}
			%>	
	<div class="container">
		<form class="form-horizontal" action="insertUser" method="post" name="newMember" onsubmit="return checkValue()" > <!-- onsubmit="return checkForm()" 버튼에 onclick과 비슷 한 효과 -->
			<div class="form-group  row">
				<label class="col-sm-2 pt-2">아이디</label>
				<div class="col-sm-3">
					<input id="id" name="id" type="text" oninput="checkId()" class="form-control"  placeholder="아이디" maxlength="20" required autofocus>
				</div>
				<div class="col-sm-6 pt-1">
					<span id="chkIdMsg"></span>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2 pt-2">비밀번호</label>
				<div class="col-sm-3">
					<input id="password" name="password" type="password" oninput="checkPassword()" class="form-control" placeholder="비밀번호" maxlength="20" required>
				</div>
				<div class="col-sm-6 pt-1">
					<span id="chkPasswordMsg"></span>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2 pt-2">비밀번호확인</label>
				<div class="col-sm-3">
					<input id="password_confirm" name="password_confirm" type="password" oninput="checkPassword_confirm()" class="form-control" placeholder="비밀번호 확인" maxlength="20" required>
				</div>
				<div class="col-sm-6 pt-1">
					<span id="chkPasswordMsg2"></span>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2 pt-2">닉네임</label>
				<div class="col-sm-3">
					<input id="name" name="name" type="text" oninput="checkName()" class="form-control" placeholder="닉네임" maxlength="20" required>
				</div>
				<div class="col-sm-6 pt-1">
					<span id="chkNameMsg"></span>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2 col-md-2 col-lg-2 pt-2">이메일</label>
				<div class="col-sm-3 col-md-3 col-lg-3">
					<input type="text" id="mail1" name="mail1" oninput="checkMail()" class="form-control" placeholder="Email" maxlength="20" required> 
				</div>
				<div class="pt-2">
					@
				</div>
				<div class="col-sm-1 col-md-1 col-lg-1 pt-2">
					<select id="mail2" name="mail2">
						<option>naver.com</option>
						<option>daum.net</option>
						<option>gmail.com</option>
						<option>nate.com</option>
					</select>
				</div>
				<div class="col-sm-5 col-md-5 col-lg-5 pt-2 ml-5">
					<span id="chkMaileMsg"></span>
				</div>				
			</div>
			<div class="form-group row mt-5">
				<div class="col-sm-offset-2 col-sm-10 ">
					<input type="submit" class="btn btn-primary " value="등록 "> 
					<a href="../dictionary/selectDictionary" class="btn btn-primary">취소</a>
				</div>
			</div>
		</form>
	</div>
</body>
	<script src="../resources/js/insertMember.js"></script>
</html>