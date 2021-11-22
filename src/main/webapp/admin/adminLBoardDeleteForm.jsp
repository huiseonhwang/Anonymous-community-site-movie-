<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LocalBoardDTO" %>
<%@ page import="team03.bean.LocalBoardDAO" %>
<%@page import="team03.bean.AdminDAO" %>
    
   
<style>
   	table {
		margin: 0 auto;
		border: 2px solid black;
		border-collapse: collapse;
	}
	tr, td, th {
		border: 2px solid black;
		padding: 10px;
	}
	#center{
		text-align: center;
	}
</style>

<%
String admin = (String)session.getAttribute("admin");
if(admin == null){ 
%>	<script>
		alert("잘못된 접근입니다.");
		window.location="/team03/main.jsp";
	</script>
<%	}else{

	SimpleDateFormat sdf = 
			new SimpleDateFormat("yy-MM-dd HH:mm");
	
	String pageNum = request.getParameter("pageNum");
	int pageSize = 10;
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1; // 결과 = 11
	int end = currentPage * pageSize; // 결과 = 20
	int count = 0;
	int number = 0;
	
	List<LocalBoardDTO> list = null;
	LocalBoardDAO dao = LocalBoardDAO.getInstance();

	count = dao.LgetCount();
	list=dao.LgetAllList(start, end);
	
	number = count - (currentPage-1)*pageSize;
	
%>

<h1 style="text-align: center;">
	<a href="adminLBoardDeleteForm.jsp">관리자용 지역 게시판</a>
</h1>

<table style="width: 90%;">
	<tr style="text-align: right;">
			<td colspan="6">
					<input type="button" value="메인으로 돌아가기"
					onclick="window.location='/team03/main.jsp'" />
					<input type="button" value="관리자페이지로 돌아가기"
					onclick="window.location='/team03/admin/adminMain.jsp'" />
			</td>
	</tr>
	<tr>
		<th>글 번호</th>
		<th>지역</th>
		<th>작성자</th>
		<th>제목</th>
		<th>작성일</th>
		<th>삭제여부</th>
	</tr>
<%	if(count == 0){ %>
		<tr>
			<td colspan="6">작성된 글이 없습니다...</td>
		</tr>
<%	}else{ %>

	<%	for(LocalBoardDTO dto : list) { %>
			<tr>
				<td id="center">
					<%= number-- %>
					<input type="hidden" name="num" value="<%=dto.getNum() %>" />
				</td>
				<td id="center"> <%=dto.getLocal() %> </td>
				<td style="width: 20%;"> 
					<% if(!dto.getWriter().contains("익")){ %>
						<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>">
								<%= dto.getWriter() %>
						</a>
						
						
					<%} else { %>
						<%= dto.getWriter() %>
					<%}%>
				</td>
				<td style="width: 40%;">
					<a href="/team03/localBoard/localContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
						<%= dto.getSubject() %>
					</a>
				</td>
				<td> <%= sdf.format(dto.getReg()) %> </td>
				<td> <input type="button" value="게시글 삭제" onclick="window.location='adminDeleteContentConfirm.jsp?Lnum=<%=dto.getNum()%>&pageNum=<%=pageNum%>'"/></td>
			</tr>
	<%	} %>
<%	} %>
	
</table>
<div id="center">
<%
	// 페이지 정렬
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = (currentPage / 10) * 10 + 1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock-1;
		if(endPage > pageCount){
			endPage = pageCount;
		}	
		if(startPage > 10){%>
			<a href="adminLBoardDeleteForm.jsp?pageNum=<%=startPage-10%>">[이전]</a>
		<%}
		for(int i = startPage ; i <= endPage ; i++){
		%>	<a href="adminLBoardDeleteForm.jsp?pageNum=<%=i%>">[<%=i%>]</a> 	
	  <%}
		if(endPage < pageCount){%>
		<a href="adminLBoardDeleteForm.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
	  <%}	
	}
%>
</div>

<div id="center">
	<form action="adminLSearch.jsp"  method="post" >
		<select name="colum">
			<option value="local">지역</option>
			<option value="writer">작성자</option>
			<option value="subject">제목</option>
			<option value="content">내용</option>
		</select>
		<input type="text" name="search" />
		<input type="submit" value="검색" />
	</form>
</div>

<%}%>