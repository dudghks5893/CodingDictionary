/**
 * 
 */

//아이디 찾기
function findUserId(){
    var email = $('#email').val();
    
    $.ajax({
        type:'post',
        url:'../member/findUserId',
        data:{email:email},
        success:function(result){
        	if(result == 0){
        		$('#chkEmailMsg').html('아이디가 없습니다');
            	$('#chkEmailMsg').css("color","#FF5A5A");
        	} 
        	if(result >= 1) {
        		$('#chkEmailMsg').html('메일을 전송하였습니다');
            	$('#chkEmailMsg').css("color","#D5D5D5");
        	}

        }
    })
}
//인증번호 받기
function findAuthenticationKey(){
    var userId = $('#userId').val();
    var userEmail = $('#userEmail').val();
    
    $.ajax({
        type:'post',
        url:'../member/findAuthenticationKey',
        data:{userId:userId,userEmail:userEmail},
        success:function(result){
        	if(result == 0){
        		$('#chkCertifiedMsg').html('아이디와 이메일 정보가 일치하지 않습니다');
            	$('#chkCertifiedMsg').css("color","#FF5A5A");
        	} 
        	if(result >= 1) {
        		$('#chkCertifiedMsg').html('인증번호를 전송하였습니다');
            	$('#chkCertifiedMsg').css("color","#D5D5D5");
            	
        	}

        }
    })
}
//인증번호 확인
function checkKey(){
    var checkKey = $('#checkKey').val();
    
    $.ajax({
        type:'post',
        url:'../member/checkKey',
        data:{checkKey:checkKey},
        success:function(result){
        	if(result == 0){
        		$('#chkKeyMsg').html('유효하지 않은 인증번호입니다');
            	$('#chkKeyMsg').css("color","#FF5A5A");
        	} 
        	if(result == 1){
        		$('#checkKeyModal').modal('hide');
        		$('#updatePwd').modal('show');
        	} 

        }
    })
}
//비밀번호 조건
function checkPassword(){
		var passwordCount = /^.{4,20}$/
	    var pwd = $('#pwd').val();
		var changeBtn = document.getElementById('changeBtn');

	
	$("#pwd").on("propertychange change keyup paste input", function() {
	    if(!passwordCount.test(pwd)){
	    	changeBtn.disabled = true;
	        $('#chkpwdMsg1').html("4자 이상으로 입력하세요");
	    	$('#chkpwdMsg1').css("color","#FF5A5A");
	    } else{
	    	changeBtn.disabled = true;
	    	$('#chkpwdMsg1').html('사용 가능한 비밀번호입니다');
            $('#chkpwdMsg1').css("color","#D5D5D5");
	    }
	});
}
//비밀번호 확인 조건
function checkPassword_confirm(){
		var passwordCount = /^.{4,20}$/
	    var pwd = $('#pwd').val();
	    var checkPwd = $('#checkPwd').val();
	    var changeBtn = document.getElementById('changeBtn');
	
	$("#checkPwd").on("propertychange change keyup paste input", function() {
    	if(pwd != checkPwd){
    		changeBtn.disabled = true;
    		$('#chkpwdMsg2').html("비밀번호가 일치하지 않습니다");
    		$('#chkpwdMsg2').css("color","#FF5A5A");
    	} 
	    if(!passwordCount.test(checkPwd)){
	    	changeBtn.disabled = true;
	        $('#chkpwdMsg2').html("4자 이상으로 입력하세요");
	    	$('#chkpwdMsg2').css("color","#FF5A5A");
	    }
    	if(pwd == checkPwd && passwordCount.test(checkPwd)){
    		changeBtn.disabled = false;
    		$('#chkpwdMsg2').html('');
    	}
	});
}
