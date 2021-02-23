<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.ArrayList"%>
<%@page import="dictionary.model.DictionaryBean"%>
<jsp:useBean id="mgr" class="dictionary.model.DictionaryMgr"/>
<%
int start = 0;// 리스트 출력할 시작 위치
int cnt = 10;// 리스트 출력 개수
int pageNum = 1;// 현재 페이지
int pagingCnt = 5; // 페이징 출력 개수

if(request.getParameter("pageNum") != null){
	pageNum = Integer.parseInt(request.getParameter("pageNum"));
	}

String search = request.getParameter("search");
ArrayList<DictionaryBean> list = mgr.getAllDictionary(pageNum,search,start,cnt);

//페이징 처리 변수들
int next = 1; //다음 페이지
int back = 1; //이전 페이지
int block = 0;//현재 블럭
int startBlock = 1;//시작 블럭
int pagingSize = mgr.getAllPaging(search, cnt); // 페이징 총 개수
int lastBlock = 0; // 5씩 증감했을때 마지막 숫자 (나머지 페이지 표시하기 위함)

for(int r=1; r<pagingSize+1; r+=pagingCnt){ // 페이징 블록처리 했을때 마지막 숫자 (나머지 페이지의 startBlock 시작 블록)
	lastBlock = r;
}
// 페이징 다음 페이지&이전 페이지&블럭
	for(int j=1; j<pagingSize+1; j+=pagingCnt){
		if(pageNum>=next){ // 다음 페이지 6,11,16
			next=j;
		}
		if(pageNum>=next && pageNum>pagingCnt){ // 이전 페이지 1,6,11
			back= next-pagingCnt;
		}
		if(pageNum>block){ // 페이징 5개씩 출력 1~5,6~10,11~15
			block = j-1;
		}
		if(pageNum >= lastBlock){ // 페이징 나머지 처리 
			block = pagingSize;
		}
		if(pageNum>=startBlock && pageNum>1){ // 페이징블럭 시작 숫자 1,6,11
			startBlock = block-(pagingCnt-1);
		}
		if(pageNum>=lastBlock){ // 마지막 페이징블럭의 시작 숫자
			startBlock = next;
		}
	
	}
%>
<html>
<head>
			<title>deleteDictionary</title>
</head>
<body>
			<jsp:include page="../include/menu.jsp" />
			<div class="container text-center">
				<h1 class="display-3" style="margin-top:30px;">코딩수정</h1>
			</div>
			<div class="container " style="margin-top: 50px">
				<form class="form-inline">
					<input class="form-control border border-success col-sm-10 col-md-11 col-lg-11" type="search"
						placeholder="Search" aria-label="Search" name="search">
					<button class="btn btn-success col-sm-2 col-md-1 col-lg-1" type="submit">검색</button>
				</form>
			</div>
			<div class="container" style="margin-top: 60px;">
				<h1>전체 <%=mgr.getAllCount(search)%>개</h1>
			</div>
			<div style="padding-top: 50px;">
				<table class="table table-hover">
					<tr>
						<th>언어</th>
						<th>코드</th>
						<th>설명</th>
						<th>코드삭제</th>
					</tr>
			
		<%
			for(int i = 0; i<list.size(); i++){
		%>	
					<tr>
						<td><%=list.get(i).getLanguage()%></td>
						<td><%=list.get(i).getCode().replaceAll("<", "&#60;")%></td>
						<td><%=list.get(i).getExplanation().replaceAll(" ", "&nbsp;").replaceAll("<", "&#60;")%></td>
						<td><a href="./deletePage.jsp?num=<%=list.get(i).getNum()%>" class="btn btn-danger" style="height: 25px; padding: 1px; color: white;" >코드삭제 &raquo;</a></td>
					</tr>
		<%
			}
		%>
				</table>
			</div>
			<div class="mt-5" align="center">
		<%
			if(search!=null){
		%>
			<a href="deleteDictionary.jsp?search=<%=search%>&pageNum=<%=back%>" class="btn btn-outline-info mr-2"><b>&laquo;</b></a>
		<%
			} else{
		%>
			<a href="deleteDictionary.jsp?pageNum=<%=back%>" class="btn btn-outline-info mr-2"><b>&laquo;</b></a>
		<%
			}
			for(int p=startBlock; p<=block; p++){
				if(search==null){
					if(pageNum==p){
		%>
			<a href="deleteDictionary.jsp?pageNum=<%=p%>" class="btn btn-info"><%=p%></a>
		<%		
					} else{
						
		%>
			<a href="deleteDictionary.jsp?pageNum=<%=p%>" class="btn btn-outline-info"><%=p%></a>
		<% 				
					}
				} if(search!=null){
					if(pageNum==p){
		%>
			<a href="deleteDictionary.jsp?search=<%=search%>&pageNum=<%=p%>" class="btn btn-info"><%=p%></a>
		<%			
					} else{
		%>
			<a href="deleteDictionary.jsp?search=<%=search%>&pageNum=<%=p%>" class="btn btn-outline-info"><%=p%></a>
		<%
					}
				}
			}
		%>
		<%
			if(search!=null){
		%>
			<a href="deleteDictionary.jsp?search=<%=search%>&pageNum=<%=next%>" class="btn btn-outline-info ml-2"><b>&raquo;</b></a>
		<%
			} else{
		%>
			<a href="deleteDictionary.jsp?pageNum=<%=next%>" class="btn btn-outline-info ml-2"><b>&raquo;</b></a>
		<%
			}
		%>
			</div>		
	<jsp:include page="../include/footer.jsp" />
</body>

</html>