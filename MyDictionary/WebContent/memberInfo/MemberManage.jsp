<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="user.User"%>
<jsp:useBean id="dao" class="user.UserDAO"/>
<jsp:useBean id="paging" class="my.util.paging.Paging"/>
<%
	final int LISTCOUNT = 12;  // 화면에 표시되는 리스트 개수
	final int PAGECOUNT = 5; // 화면에 표시되는 페이지 개수
	int pageNum = 1; // 최초 시작 페이지
	int start = 0;   // 리스트 출력할 시작 위치
	int	total_record = 0; // 게시글 총 개수
	
	// request 영역
	if(request.getParameter("pageNum") != null){ 
		// 널값이 아니라면 페이지 넘버를 가져온다. 리퀘스트 파라메타는 문자열만 출력하기때문에 문자열로 받아와서 정수형으로 바꿔줌
		pageNum = Integer.parseInt((String) request.getParameter("pageNum"));
	}
	String search = request.getParameter("search"); // Search값을 받아옴
	
	// 회원 리스트
	ArrayList<User> list = dao.getAllMember(pageNum,search,start,LISTCOUNT);
	
	//페이징 블록 처리
	total_record = dao.getAllCount(search);
    paging.getBlockPaging(pageNum, total_record,LISTCOUNT,PAGECOUNT);
	
	//페이징 처리 변수들
    int blockStartNum = paging.getBlockStartNum();
    int blockLastNum = paging.getBlockLastNum();
    int total_page = paging.getTotal_page();
    int next = paging.getNext();
    int back = paging.getBack();
%>
<html>

<head>
			<title>회원정보</title>
</head>
<body>
			<jsp:include page="../include/menu.jsp" />
			<div class="container text-center">
				<h1 class="display-3" style="margin-top:30px;">회원정보</h1>
			</div>
			<div class="container " style="margin-top: 50px">
				<form class="form-inline">
					<input class="form-control border border-success col-sm-10 col-md-11 col-lg-11 " type="search"
						placeholder="Search" aria-label="Search" name="search">
					<button class="btn btn-success col-sm-2 col-md-1 col-lg-1" type="submit">검색</button>
				</form>
			</div>			
			<div class="container" style="margin-top: 60px;">
				<h1>전체 <%=dao.getAllCount(search)%>명</h1>
			</div>
			<div class="row" style="margin-top: 50px;">
		<%
		

			
			for(int i = 0; i<list.size(); i++){
				String day = list.get(i).getregist_day();				
		%>	
			<div class="col-sm-12 col-md-6 col-lg-3 mt-3">
				<div class="card">
					<div class="card-header">
						<div class="row">
							<div class="col-5">
								<%=list.get(i).getUserName()%>
							</div>
							<div class="col-7" align="right">
								<%=day.substring(0,10)%>
							</div>
						</div>
					</div>
					<div class="card-body">
						<p><b>아이디:</b> <%=list.get(i).getUserID()%></p>
						<p><b>비밀번호:</b> <%=list.get(i).getUserPassword()%></p>
						<p><b>이메일:</b> <%=list.get(i).getUserEmail()%></p>
					</div>
					<div class="ml-auto mr-3 mb-3">
						<a href="MemberManagePage.jsp?id=<%=list.get(i).getUserID()%>" class="btn" style="background: #4374D9; color:#EAEAEA;">편집</a>
					</div>	
				</div>
			</div>
		<%
				}
		%>
			</div>
			<div class="mt-5" align="center">
			<%
			if(search!=null && pageNum>PAGECOUNT){
		%>
			<a href="MemberManage.jsp?search=<%=search%>&pageNum=<%=back%>" class="btn btn-outline-info mr-2"><b>&laquo;</b></a>
		<%
			} 
			if(search==null && pageNum>PAGECOUNT){
		%>
			<a href="MemberManage.jsp?pageNum=<%=back%>" class="btn btn-outline-info mr-2"><b>&laquo;</b></a>
		<%
			}
			for(int p=blockStartNum; p<=blockLastNum; p++){
				if(search==null){
					if(pageNum==p){
		%>
			<a href="MemberManage.jsp?pageNum=<%=p%>" class="btn btn-info"><%=p%></a>
		<%		
					} else{
						
		%>
			<a href="MemberManage.jsp?pageNum=<%=p%>" class="btn btn-outline-info"><%=p%></a>
		<% 				
					}
				} if(search!=null){
					if(pageNum==p){
		%>
			<a href="MemberManage.jsp?search=<%=search%>&pageNum=<%=p%>" class="btn btn-info"><%=p%></a>
		<%			
					} else{
		%>
			<a href="MemberManage.jsp?search=<%=search%>&pageNum=<%=p%>" class="btn btn-outline-info"><%=p%></a>
		<%
					}
				}
			}
		%>
		<%
			if(search!=null && total_page > blockLastNum){
		%>
			<a href="MemberManage.jsp?search=<%=search%>&pageNum=<%=next%>" class="btn btn-outline-info ml-2"><b>&raquo;</b></a>
		<%
			} 
			if(search==null && total_page > blockLastNum){
		%>
			<a href="MemberManage.jsp?pageNum=<%=next%>" class="btn btn-outline-info ml-2"><b>&raquo;</b></a>
		<%
			}
		%>
			</div>
	<jsp:include page="../include/footer.jsp" />
</body>

</html>
