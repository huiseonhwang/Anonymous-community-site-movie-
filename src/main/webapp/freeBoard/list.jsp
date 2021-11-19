<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.BoardDTO" %>
<%@ page import="team03.bean.BoardDAO" %>

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
	SimpleDateFormat sdf = 
		new SimpleDateFormat("yy-MM-dd HH:mm");

	String kid = (String)session.getAttribute("kid");
	
	String id = (String)session.getAttribute("id");
	String pageNum = request.getParameter("pageNum"); // null 값 대입
	String my = request.getParameter("my");
	
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
	
	if(my == null){
		count = dao.getCount();
		if(count > 0){
			list = dao.getAllList(start, end);
		}
	} else {
		
		if(id != null){
			count = dao.getMyCount(id);
			if(count > 0){
				list = dao.getMyList(id, start, end);
			}
		}
		
		if(kid != null){
			count = dao.getMyCount("카카오"+kid);
			if(count > 0){
				list = dao.getMyList("카카오"+kid, start, end);
			}
		}
	}
	
	number = count-(currentPage-1)*pageSize;
%>

<h1 style="text-align: center;">
	<a href="list.jsp">자유게시판</a>
</h1>

<table style="width: 90%;">
	<tr style="text-align: right;">
		<% if(id != null || kid != null){ %>
			<td colspan="7"> 
				<input type="button" value="글쓰기"
					onclick="window.location='writeForm.jsp'" />
				<input type="button" value="내 작성글"
					onclick="window.location='list.jsp?my=1'" />
					<input type="button" value="메인으로 돌아가기"
					onclick="window.location='/team03/main.jsp'" />
			</td>
		<%} else { %>
			<td colspan="7">
				<input type="button" value="글쓰기"
					onclick="window.location='writeForm.jsp'" />
					<input type="button" value="메인으로 돌아가기"
					onclick="window.location='/team03/main.jsp'" />
			</td>
	 <%	 } %>
	</tr>
	<tr>
		<th> 글 번호 </th>
		<th> 작성자 </th>
		<th> 제목 </th>
		<th> 작성일 </th>
		<th> 조회 </th>
		<th> 공감 </th>
		<th> 비공감 </th>
	</tr>
<%	if(count == 0){ %>
		<tr>
			<td colspan="7">작성된 글이 없습니다...</td>
		</tr>
<%	}else{ %>

	<%	for(BoardDTO dto : list) { %>
			<tr>
				<td id="center">
					<%= number-- %>
					<input type="hidden" name="num" value="<%=dto.getNum() %>" />
				</td>
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
					<a href="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
						<%= dto.getSubject() %>
					</a>
				</td>
				<td> <%= sdf.format(dto.getReg()) %> </td>
				<td> <%= dto.getReadcount() %> </td>
				<td> <%= dto.getGood() %> </td>
				<td> <%= dto.getBad() %> </td>
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
				<a href="list.jsp?pageNum=<%=startPage-10%>">[이전]</a>
			<%}
			for(int i = startPage ; i <= endPage ; i++){
			%>	<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a> 	
		  <%}
			if(endPage < pageCount){%>
			<a href="list.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
		  <%}	
		}
	%>
</div>

<div id="center">
	<form action="slist.jsp"  method="post">
		<select name="colum">
			<option value="writer">작성자</option>
			<option value="subject">제목</option>
			<option value="content">내용</option>
		</select>
		<input type="text" name="search" />
		<input type="submit" value="검색" />
	</form>
</div>