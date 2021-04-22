/**
 * 
 */

//등록 눌렀을때 적용
	function checkValue() {
		var StartId = /^[a-z|A-Z|0-9]*$/;
		var TextCount = /^[0-9a-zA-Z]{6,14}$/;
		var IdNotType = /^[0-9]*$/; 
		var passwordCount = /^.{4,20}$/
		var nameType = /^[0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]{2,10}$/;
		var mailType = /^[0-9a-zA-Z]{4,20}$/;
		var mailNotType = /^[0-9]*$/; 
		
		
		var form = document.newMember;
		var id = $('#id').val();
		var password = $('#password').val();
		var password_confirm = $('#password_confirm').val();
		var name = $('#name').val();
		var mail1 = $('#mail1').val();
		
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
//아이디 조건
function checkId(){
	var StartId = /^[a-z|A-Z|[0-9]*$/;
	var TextCount = /^[0-9a-zA-Z]{6,14}$/;
	var IdNotType = /^[0-9]*$/; 
    var id = $('#id').val();
    
    $.ajax({
        type:'post',
        url:'checkUserId',
        data:{id:id},
        success:function(result){
        	if(result==0){
                $('#chkIdMsg').html('사용 가능한 아이디입니다');
                $('#chkIdMsg').css("color","#0054FF");
            }
            if(result >=1){
                $('#chkIdMsg').html('중복되는 아이디입니다');
                $('#chkIdMsg').css("color","#FF0000");
            }
            if(!TextCount.test(id)){
    			$('#chkIdMsg').html('아이디는 6~14자로 작성하여 주세요');
                $('#chkIdMsg').css("color","#FF0000");
    		}
            if(IdNotType.test(id)){
    			$('#chkIdMsg').html('아이디는 영문자와 조합하여 사용해 주세요');
                $('#chkIdMsg').css("color","#FF0000");
    		}
    		if(!StartId.test(id)){
    			$('#chkIdMsg').html('아이디는 영문자를 사용하여 주세요');
                $('#chkIdMsg').css("color","#FF0000");
    		}
    		
        }
    })
}
//닉네임 조건
function checkName(){
	var nameType = /^[0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣]{2,10}$/;
    var name = $('#name').val();
    
    $.ajax({
        type:'post',
        url:'checkUserName',
        data:{name:name},
        success:function(result){
        	if(result==0){
                $('#chkNameMsg').html('사용 가능한 닉네임입니다');
                $('#chkNameMsg').css("color","#0054FF");
            }
            if(result >=1){
                $('#chkNameMsg').html('중복되는 닉네임입니다');
                $('#chkNameMsg').css("color","#FF0000");
            }
            if(!nameType.test(name)){
            	$('#chkNameMsg').html("닉네임은 특수문자를 제외한 2~10글자로 작성하여 주세요");
            	$('#chkNameMsg').css("color","#FF0000");
    		}
    		
        }
    })
}	
//비밀번호 조건
function checkPassword(){
	var passwordCount = /^.{4,20}$/
	var password = $('#password').val();
	
	$("#password").on("propertychange change keyup paste input", function() {
	    if(!passwordCount.test(password)){
	        $('#chkPasswordMsg').html("비밀번호는 4~20자로 작성하여 주세요");
	    	$('#chkPasswordMsg').css("color","#FF0000");
	    } else{
	    	$('#chkPasswordMsg').html('사용 가능한 비밀번호입니다');
            $('#chkPasswordMsg').css("color","#0054FF");
	    }
	});
}
//비밀번호 확인 조건
function checkPassword_confirm(){
	var password_confirm = $('#password_confirm').val();
	var password = $('#password').val();
	
	$("#password_confirm").on("propertychange change keyup paste input", function() {
    	if(password != password_confirm){
    		$('#chkPasswordMsg2').html("비밀번호가 일치하지 않습니다");
    		$('#chkPasswordMsg2').css("color","#FF0000");
    	} else{
    		$('#chkPasswordMsg2').html('');
    	}
	});
}
//메일 조건
function checkMail(){
	var mailType = /^[0-9a-zA-Z]{4,20}$/;
	var mailNotType = /^[0-9]*$/; 
	var mail1 = $('#mail1').val();
	var mail2 = $('#mail2').val();
	
	  $.ajax({
	        type:'post',
	        url:'checkUserEmail',
	        data:{mail1:mail1,mail2:mail2},
	        success:function(result){
	        if(result==0){
	        	$('#chkMaileMsg').html('');
	        }
	        if(result>=1){
	        	$('#chkMaileMsg').html("이미 아이디가 있습니다");
    			$('#chkMaileMsg').css("color","#FF0000");
	        }
	        if(!mailType.test(mail1)){
	        	$('#chkMaileMsg').html("올바른 이메일 형태가 아닙니다.");
	        	$('#chkMaileMsg').css("color","#FF0000");
	        }
	        if(mailNotType.test(mail1)){
    			$('#chkMaileMsg').html("올바른 이메일 형태가 아닙니다.");
    			$('#chkMaileMsg').css("color","#FF0000");
    		}
    			
		
    	}
	})
}
