<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
			
			<div class="modal-header">
						<h3 >로그인</h3>
	        </div>
	        <form action="./member/loginAction.jsp" method="post">
	        <div class="modal-body" >
	          <input type="text" class="form-control mb-3 mt-4 col-sm-6" name="userID" placeholder="아이디" maxlength="20" required autofocus> <!-- 최대20글자, 무조건 입력 -->
	          <input type="password" class="form-control mb-3 col-sm-6" name="userPassword" placeholder="패스워드" maxlength="20" required> <!-- 최대20글자, 무조건 입력 -->
	     		<p style="color:red">※ 로그인을 하지 않아도 코딩 사전을 열람하실 수 있습니다.</p>
	     		<hr>
	     		<h4>게시판 이용 안내</h4>
	     		<p>게시판을 이용하시려면 로그인을 해주세요.</p>
	     		<p>추가할 코드나 개선할 사항이 있다면 게시판에 남겨주시면 감사합니다.</p>
	     	</div>
	     	<div class="modal-footer">
	          <input type="submit" class="btn btn-primary form-control col-sm-2" value="로그인">         
					<button type="button" class="btn btn-secondary col-sm-2"
						data-dismiss="modal">닫기</button>
				</div>
	        </form>
</body>
</html>