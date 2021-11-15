<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.MovieDAO" %>
<%@ page import = "team03.bean.MovieDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.net.URLEncoder" %>

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

	String kategorie = request.getParameter("kategorie");
	String colum = request.getParameter("colum");
	String search = request.getParameter("search");
	String kid = request.getParameter("kid");
	String id = request.getParameter("id");
	String pageNum = request.getParameter("pageNum");
	String searchkate = request.getParameter("searchkate"); // 내 작성글로 갈 때 대입되는 글
	
	int pageSize = 10;
	
	if (pageNum==null) {
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1;
	int end = currentPage * pageSize;
	int count = 0;
	
	List<MovieDTO> list = null;
	MovieDAO dao = MovieDAO.getInstance();
	
	if (searchkate == null) {
		count = dao.getKategorieSearchCount(colum, search);
		if (count > 0) {
			list = dao.getKategorieSearchList(colum, search, start, end);
		}
	}
%>	

<h1 style="text-align: center;">
	<a href="list.jsp">게시판</a>
</h1>

<table>
	<tr style="text-align: right;">
		<% if ( id != null || kid != null ) {
			// id가 kid가 null이라면 (로그인 정보가 있다면) %>
				<td colspan = "7" >
					<input type = "button" value = "글 쓰기" 
						onclick = "window.location='writerForm.jsp'" />
					<input type = "button" value = "내 작성글"
						onclick = "window.location='list.jsp?my=1'" />
					<input type = "button" value = "메인으로 돌아가기"
						onclick = "window.location='/team03/main.jsp'" />
				</td>
			<% } else { 
			// 로그인 정보가 없다면 (익명이라면) %>
				<td colspan = "7" >
										<input type = "button" value = "글 쓰기" 
						onclick = "window.location='writerForm.jsp'" />
					<input type = "button" value = "메인으로 돌아가기"
						onclick = "window.location='/team03/main.jsp'" />
				</td>
			<% } %>
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
		<% if ( count == 0) { %>
			<tr>
				<td colspan = "7" > 작정된 글이 없습니다.. </td>
			</tr>
		<% } else { %>
			<% for (MovieDTO dto : list) { %>
				<tr>
					<td> <%= dto.getNum() %> </td>
					<td>
						<a href = "content.jsp?num=<%=dto.getNum() %>&pageNum=<%=pageNum %>">
							<%=dto.getSubject() %>
						</a>
					</td>
					<td>
						<% if (!dto.getWriter().contains("익")) {  %>
							<a href = "/team03/visitor/visitorForm.jsp?writer=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>" >
								<%=dto.getWriter() %>
							</a>
						<% } else { %>
							<%= dto.getWriter() %>
						<% } %>
					</td>
					<td> <%= dto.getReg() %> </td>
					<td> <%= dto.getReadcount() %> </td>
					<td> <%= dto.getGood() %> </td>
					<td> <%= dto.getBad() %> </td>
				</tr>
			<% } %>
		<% } %>
</table>

<%
	if ( count > 0) {
		// 페이징 처리
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = (currentPage / 10) * 10 + 1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock-1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
		if (startPage > 10) { %>
			<a href = "slist.jsp?pageNum=<%=startPage-10 %>"> [이전] </a>
		<% } 
		 	for (int i = startPage; i <= endPage; i++) { %>
		 		<a href = "slist.jsp?pageNum=<%=i%>" > [<%=i %>] </a>
		 	<% }
		 	if (endPage < pageCount) { %>
		 	<a href="slist.jsp?pageNum=<%=startPage + 10%>"> [다음] </a>
	 <% }
	}
%>

<form action = "slist.jsp" method = "post">
	<select name = "colum">
		<option value = "writer" > 작성자 </option>
		<option value = "subject" > 제목 </option>
		<option value = "kategorie" > 카테고리 </option>
		<option value = "content" > 내용 </option>
	</select>
	<input type = "text" name = "search" />
	<input type = "submit" value = "검색" />
</form>
