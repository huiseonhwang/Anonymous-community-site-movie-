<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="team03.bean.BoardDAO"%>
<%@ page import="team03.bean.BoardDTO" %>
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
	*{
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
	
	List<BoardDTO> list = null;
	BoardDAO dao = BoardDAO.getInstance();

	count = dao.getCount();
	list=dao.getAllList(start, end);
	
	number = count - (currentPage-1)*pageSize;
	
%>

<h1 style="text-align: center;">
	<a href="adminBoardDeleteForm.jsp">관리자 확인용 게시판</a>
</h1>

<table>
	<tr>
		<th> 글 번호 </th>
		<th> 제목 </th>
		<th> 작성자 </th>
		<th> 작성일 </th>
		<th> 삭제여부 </th>
		
	</tr>
<%	if(count == 0){ %>
		<tr>
			<td colspan="5">작성된 글이 없습니다...</td>
		</tr>
<%	}else{ %>

	<%	for(BoardDTO dto : list) { %>
			<tr>
				<td>
					<%= number-- %>
					<input type="hidden" name="num" value="<%=dto.getNum() %>" />
				</td>
				<td>
					<a href="/team03/freeBoard/content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
						<%= dto.getSubject() %>
					</a>
				</td>
				<td> 
					<% if(!dto.getWriter().contains("익")){ %>
						<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>">
								<%= dto.getWriter() %>
						</a>
						
						
					<%} else { %>
						<%= dto.getWriter() %>
					<%}%>
				</td>
				<td> <%= dto.getReg() %> </td>
				<td> <input type="button" value="게시글 삭제" onclick="window.location='adminDeleteContentConfirm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'"/></td>

			</tr>
	<%	} %>
<%	} %>
</table>

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
			<a href="adminBoardDeleteForm.jsp?pageNum=<%=startPage-10%>">[이전]</a>
		<%}
		for(int i = startPage ; i <= endPage ; i++){
		%>	<a href="adminBoardDeleteForm.jsp?pageNum=<%=i%>">[<%=i%>]</a> 	
	  <%}
		if(endPage < pageCount){%>
		<a href="adminBoardDeleteForm.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
	  <%}	
	}
%>

<form action="adminSearch.jsp"  method="post" >
	<select name="colum">
		<option value="writer">작성자</option>
		<option value="subject">제목</option>
		<option value="content">내용</option>
	</select>
	<input type="text" name="search" />
	<input type="submit" value="검색" />
</form>

<%}%>