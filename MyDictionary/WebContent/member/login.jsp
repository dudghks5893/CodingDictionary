<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- <script type="text/javascript">
	var minute = 1;
	var count = 2;
	var counter = setInterval(timer,1000);
	
	function timer() {
		if(${authenticationKey}!=null && count>=0){
			count--;
			if(count==0 && minute>0){
				minute--;
				count = 59;
			}
		}
		if(count <=0 && minute <=0){
			clearInterval(counter);
			
			document.getElementById("timer").innerHTML = "";
			return;
		}
		document.getElementById("timer").innerHTML = minute+"분"+count+"초 후 인증번호가 사라집니다.";
	}
</script> --> 
</head>
<body>
			
			<div class="modal-header">
						<h3 >로그인</h3>
	        </div>
	        <form action="../member/loginAction.jsp" method="post">
	        <div class="modal-body" >
	          <input type="text" class="form-control mb-3 mt-4 col-sm-6" name="userID" placeholder="아이디" maxlength="20" required autofocus> <!-- 최대20글자, 무조건 입력 -->
	          <input type="password" class="form-control mb-2 col-sm-6" name="userPassword" placeholder="패스워드" maxlength="20" required> <!-- 최대20글자, 무조건 입력 -->
	          <a href="#" data-toggle="modal" data-target="#findUserId"><span class="ml-3"style="font-size: 14px;">아이디 찾기</span></a> ㅣ
	          <a href="#" data-toggle="modal" data-target="#checkKeyModal"><span style="font-size: 14px;">비밀번호 찾기</span></a>
	     		<p class="mt-3" style="color:red">※ 로그인을 하지 않아도 코딩 사전을 열람하실 수 있습니다.</p>
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
	
	<!-- 아이디 찾기 모달 --> 
        <div class="modal fade" id="findUserId" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-Dark">
						<h3 class="text-light">아이디 찾기</h3>
	        		</div>
					<div class="modal-body bg-Dark" >
						<label class="text-light" >가입하신 E-mail을 입력해 주세요</label>
						<div class="row">
							<input id="email" name="email" type="text" class="form-control col-sm-5 ml-3" placeholder="E-mail" maxlength="50" required autofocus>
							<button class="btn btn-outline-info ml-1" onclick="findUserId();">전송</button>
							<span id="chkEmailMsg" class="ml-3 pt-2"></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	
	<!-- 인증번호 확인 모달 --> 	
        <div class="modal fade" id="checkKeyModal" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-Dark">
						<h3 class="text-light">비밀번호 찾기</h3>
	        		</div>
					<div class="modal-body bg-Dark" >
						<label class="text-light" >아이디를 입력해 주세요</label>
						<div class="row">
							<input id="userId" type="text" class="form-control col-sm-5 ml-3" placeholder="아이디" maxlength="50" required autofocus>
						</div>
						<label class="text-light mt-3" >E-mail을 입력해 주세요</label>
						<div class="row">
							<input id="userEmail" type="text" class="form-control col-sm-5 ml-3" placeholder="E-mail" maxlength="50" required autofocus>
						</div>
						<div class="row">
							<span id="chkCertifiedMsg" class="ml-3 mt-2"></span>
						</div>
							<button class="btn btn-outline-info mt-2" onclick="findAuthenticationKey();">인증번호 전송</button>
						<div class="row mt-3">
							<input id="checkKey" type="text" class="form-control col-sm-5 ml-3" placeholder="인증번호 입력" maxlength="50" required autofocus>
							<button class="btn btn-outline-info ml-1" onclick="checkKey();">확인</button>
						</div>
							<span class="flex-container" id="timer" style="color:white;"></span>
						<div class="row">
							<span id="chkKeyMsg" class="ml-3 mt-2"></span>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		<!-- 비밀번호 변경 모달 -->
		<div class="modal fade" id="updatePwd" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header bg-Dark">
						<h3 class="text-light">비밀번호 변경</h3>
	        		</div>
					<div class="modal-body bg-Dark" >
						<label class="text-light" >변경할 비밀번호를 입력해 주세요</label>
							<form action="../member/updatePwd" method="post">
						<div class="row">
							<input id="pwd" name="pwd" type="password" oninput="checkPassword()" class="form-control col-sm-5 ml-3" placeholder="비밀번호(4자 이상)"  maxlength="20" required autofocus>
							<span id="chkpwdMsg1" class="ml-3 pt-2"></span>
						</div>
							
						<div class="row mt-3">
							
							<input id="checkPwd" type="password" oninput="checkPassword_confirm()" class="form-control col-sm-5 ml-3" placeholder="비밀번호 확인"  maxlength="20" required>
							<span id="chkpwdMsg2" class="ml-3 pt-2"></span>
						</div>
							<input id="changeBtn" type="submit" class="btn btn-outline-info mt-5" disabled value="변경">
							</form>
					</div>
				</div>
			</div>
		</div>
		
</body>
	<script src="../resources/js/login.js"></script>
</html>