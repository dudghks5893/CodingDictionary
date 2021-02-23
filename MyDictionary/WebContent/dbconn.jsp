<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<%
	//연결 객체들을 선언 (pstmt)
	Connection conn = null;	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//mysql-connector-java-5.1.46.jar라이브러리 필요
	try {
		String url = "jdbc:mysql://localhost:3306/Dictionary?useSSL=false"; //?useSSL=false있어야 워닝이 안남
		String user = "root";
		String password = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);
		//out.println("DB연결 성공!");
		//연결 성공
		
	} catch (SQLException ex) {
		out.println("데이터베이스 연결이 실패되었습니다.<br>");
		out.println("SQLException: " + ex.getMessage());
	}
		
%>