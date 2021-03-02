<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="./resources/css/main.css"/>
<title>Insert title here</title>
</head>
<script type="text/javascript">
	function next()
	{location = "./dictionary/selectDictionary";}
</script>
	
<script type="text/javascript">
	var count = 6;
	var counter = setInterval(timer,1000);
	
	function timer() {
		if(count>=0){
			count--;
		}
		if(count <=0){
			clearInterval(counter);
			
			document.getElementById("timer").innerHTML = "";
			return;
		}
		document.getElementById("timer").innerHTML = count+"초 후에 사전을 열람 합니다.";
	}
</script>
<body class="main-img" onLoad="setTimeout('next()', 6000)" >
	<span class="flex-container" id="timer" style="color:white;"></span>
</body>
</html>