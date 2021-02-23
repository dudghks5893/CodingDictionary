<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>

<%request.setCharacterEncoding("UTF-8"); %>
<!-- User클래스의 객체를 생성하여 이페이지에서 사용할수 있게 한다. -->
<jsp:useBean id="user" class="user.User" scope="page"/>
<!-- form으로부터 전달된 파라메터들을 User객체의 set메소드를 사용 -->
<jsp:setProperty name="user" property="userID"/>    
<jsp:setProperty name="user" property="userPassword"/>    

<!-- 위에 있는 jsp: 태그를 자바 코드로 했을 경우
	User user = new User();
	user.setUserID(rquest.getParameter("userID"));
	user.setUserPassword(rquest.getParameter("userPassword"));
 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
// 		세션에 userID를 얻어와서 현재 로그인 상태인지 확인한다.
		String userID = null;
		if(session.getAttribute("userID") != null){ 
			// 널값이 아니라면 아이디를 가져온다.
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null){ // 이미 로그인이 되어 있으면
			out.println("<script>");
			out.println("alert('이미 로그인이 되어있습니다.')");
			out.println("location.href = '../dictionary/Dictionary.jsp'"); // 메인페이지로 이동
			out.println("</script>");
		}
		
		//DB연결 메소드를 사용하기 위해 dao 객체 생성
		UserDAO dao = new UserDAO();
		// DB연결과 동시에 login(아이디,비번) 메소드 결과값을 정수로 받아서 상황에 따라 분기
		int result = dao.login(user.getUserID(), user.getUserPassword());
		if(result == 1){ //정상 (로그인)
			session.setAttribute("sessionId", user.getUserID()); // 파라메터로 유저 아이디를 받아와 세션으로 보냄
			out.println("<script>");
			out.println("location.href = '../dictionary/Dictionary.jsp'");
			out.println("</script>");
		} else if (result == 0){ //비번이 틀리다
			out.println("<script>");
			out.println("alert('비밀번호가 틀립니다.')");
			out.println("javascript:window.history.back();"); //이전으로 돌아감
			out.println("</script>");
		} else if (result == -1){ // 아이디가 DB에 없다
			out.println("<script>");
			out.println("alert('존재하지 않는 아이디입니다.')");
			out.println("javascript:window.history.back();"); //이전으로 돌아감
			out.println("</script>");
		} else if (result == -2){// 오류
			out.println("<script>");
			out.println("alert('데이터베이스 오류발생.')");
			out.println("javascript:window.history.back();"); //이전으로 돌아감
			out.println("</script>");
		}
	%>

</body>
</html>