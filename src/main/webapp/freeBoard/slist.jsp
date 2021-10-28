<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.BoardDAO" %>
<%@ page import="team03.bean.BoardDTO" %>

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
	request.setCharacterEncoding("UTF-8");
	

	String colum = request.getParameter("colum");
	String search = request.getParameter("search");
	String id = (String)session.getAttribute("id");
	String pageNum = request.getParameter("pageNum");
	String my = request.getParameter("my"); //내작성글로 갈 때 대입되는 글.
	
	int pageSize = 10;
	
	if(pageNum==null){
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1;
	int end = currentPage * pageSize;
	int count = 0;
	
	List<BoardDTO> list = null;
	BoardDAO dao = BoardDAO.getInstance();
	
	if(my==null){
		count=dao.getSearchCount(colum, search);
		if(count > 0){
			list = dao.getSearchList(colum, search, start, end);
		}
	} %>

<h1 style="text-align: center;"> 게시판 </h1>

<table>
	<tr style="text-align: right;">
		<% if(id != null){ %>
			<td colspan="7"> 
				<input type="button" value="글쓰기"
					onclick="window.location='writeForm.jsp'" />
				<input type="button" value="내 작성글"
					onclick="window.location='list.jsp?my=1'" />
			</td>
		<%	} else { %>
			<td colspan="7">
				<input type="button" value="글쓰기"
					onclick="window.location='writeForm.jsp'" />
			</td>
	<%	} %>
	</tr>
	<tr>
		<th>글 번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회</th>
		<th>공감</th>
		<th>비공감</th>
	</tr>
<%	if(count == 0){ %>
		<tr>
			<td colspan="7">작성된 글이 없습니다...</td>
		</tr>
<%	}else{ %>

	<%	for(BoardDTO dto : list) { %>
			<tr>
				<td> <%= dto.getNum() %> </td>
				<td>
					<a href="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
						<%= dto.getSubject() %>
					</a>
				</td>
				<td> <%= dto.getWriter() %> </td>
				<td> <%= dto.getReg() %> </td>
				<td> <%= dto.getReadcount() %> </td>
				<td> <%= dto.getGood() %> </td>
				<td> <%= dto.getBad() %> </td>
			</tr>
	<%	}%>
<%	} %>
	
</table>

<%
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = (currentPage / 10) * 10 + 1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock-1;
		if(endPage > pageCount){
			endPage = pageCount;
		}	
		if(startPage > 10){%>
			<a href="slist.jsp?pageNum=<%=startPage-10%>">[이전]</a>
		<%}
		for(int i = startPage ; i <= endPage ; i++){
		%>	<a href="slist.jsp?pageNum=<%=i%>">[<%=i%>]</a> 	
	  <%}
		if(endPage < pageCount){%>
		<a href="slist.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
	  <%}	
	}
%>

<form action="slist.jsp"  method="post">
	<select name="colum">
		<option value="writer">작성자</option>
		<option value="subject">제목</option>
		<option value="content">내용</option>
	</select>
	<input type="text" name="search" />
	<input type="submit" value="검색" />
</form>