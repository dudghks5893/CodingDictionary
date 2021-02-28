<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../dbconn.jsp" %>
<% 
request.setCharacterEncoding("UTF-8"); // 한글처리

java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy/MM/dd(HH:mm:ss)");

String num = request.getParameter("num");
String id = request.getParameter("id");
String name = request.getParameter("name");
String subject = request.getParameter("subject");
String content = request.getParameter("content");
String regist_day = formatter.format(new java.util.Date());
int hit = 0;
String ip = request.getRemoteAddr();


//AdminBoard 테이블에 새로운 글 삽입히가
		String sql = "insert into adminboard values(?, ?, ?, ?, ?, ?, ?, ?)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, num);
		pstmt.setString(2, id);
		pstmt.setString(3, name);
		pstmt.setString(4, subject);
		pstmt.setString(5, content);
		pstmt.setString(6, regist_day);
		pstmt.setInt(7, hit);
		pstmt.setString(8, ip);
		
		pstmt.executeUpdate();


//DB연결을 닫는다.
if (pstmt != null) pstmt.close();
if (conn != null) conn.close();

//페이지 이동
response.sendRedirect("../dictionary/selectDictionary");


%>