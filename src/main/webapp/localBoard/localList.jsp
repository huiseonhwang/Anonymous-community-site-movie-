<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LocalBoardDTO" %>
<%@ page import="team03.bean.LocalBoardDAO" %>

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
	String kid = (String)session.getAttribute("kid");
	String id = (String)session.getAttribute("id");
	
	String local = request.getParameter("local");
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
	
	List<LocalBoardDTO> list = null;
	LocalBoardDAO dao = LocalBoardDAO.getInstance();
	
	if(my == null){
		count = dao.LgetCount();
		if(count > 0){
			list = dao.LgetAllList(start, end);
		}
	} else {
		
		if(id != null){
			count = dao.LgetMyCount(id);
			if(count > 0){
				list = dao.LgetMyList(id, start, end);
			}
		}
		
		if(kid != null){
			count = dao.LgetMyCount("카카오"+kid);
			if(count > 0){
				list = dao.LgetMyList("카카오"+kid, start, end);
			}
		}
	}
%>

<%if(id == null && kid == null){ %>
<script>
alert("로그인 후 이용해주세요")
window.location = "/team03/main.jsp"; 
</script>
<%}else{%>
<h1 style="text-align: center;">
	<a href="localList.jsp">지역게시판</a>
</h1>

<table>
	<tr style="text-align: right;">
		<% if(id != null || kid != null){ %>
			<td colspan="8"> 
				<input type="button" value="글쓰기"
					onclick="window.location='localwriteForm.jsp'" />
				<input type="button" value="내 작성글"
					onclick="window.location='localList.jsp?my=1'" />
					<input type="button" value="메인으로 돌아가기"
					onclick="window.location='/team03/main.jsp'" />
			</td>
		<%} else { %>
			<script>
			alert("로그인 후 이용해주세요");
			history.go(-1);
			</script>
	 <%	 } %>
	</tr>
	<tr>
		<th> 글 번호 </th>
		<th> 지역 </th>
		<th> 제목 </th>
		<th> 작성자 </th>
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

	<%	for(LocalBoardDTO dto : list) { %>
			<tr>
				<td> <%= dto.getNum() %> </td>
				<td><%= dto.getLocal() %></td>
				<td>
					<a href="localContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
						<%= dto.getSubject() %>
					</a>
				</td>
				<td> 
					<a href="/team03/visitor/visitorForm.jsp?writer=<%=dto.getWriter()%>">
								<%= dto.getWriter() %>
						</a>
				</td>
				<td> <%= dto.getReg() %> </td>
				<td> <%= dto.getReadcount() %> </td>
				<td> <%= dto.getGood() %> </td>
				<td> <%= dto.getBad() %> </td>
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
			<a href="LocalList.jsp?pageNum=<%=startPage-10%>">[이전]</a>
		<%}
		for(int i = startPage ; i <= endPage ; i++){
		%>	<a href="LocalList.jsp?pageNum=<%=i%>">[<%=i%>]</a> 	
	  <%}
		if(endPage < pageCount){%>
		<a href="LocalList.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
	  <%}	
	}
%>
	
<form action="localsList.jsp"  method="post" >
	<select name="colum">
		<option value="local">지역</option>
		<option value="writer">작성자</option>
		<option value="subject">제목</option>
		<option value="content">내용</option>
	</select>
	<input type="text" name="search" />
	<input type="submit" value="검색" />
</form>
<%}%>