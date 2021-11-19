<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LocalBoardDAO" %>
<%@ page import="team03.bean.LocalBoardDTO" %>

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

	String local = request.getParameter("local");
	String kid = (String)session.getAttribute("kid");
	String id = (String)session.getAttribute("id");
	String pageNum = request.getParameter("pageNum");
	String my = request.getParameter("my");
	
	
	
	int pageSize = 10;
	
	if(pageNum==null){
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1;
	int end = currentPage * pageSize;
	int count = 0;
	int number = 0;
	
	List<LocalBoardDTO> list = null;
	LocalBoardDAO dao = LocalBoardDAO.getInstance();
	
	if(my==null){
		count=dao.LLgetSearchCount(local);
		if(count > 0){
			list = dao.LLgetSearchList(local, start, end);
		}
	} 
	
	number = count-(currentPage-1)*pageSize;
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
		<%	} %>
			
	</tr>
	<tr>
		<th>글 번호</th>
		<th> <select name ="local" onchange = "if(this.value) location.href=(this.value);">
		<option value = "local" > 지역 </option>
		<option value ="localList.jsp?l"> 전체 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("인천", "UTF-8")%>"> 인천 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("서울", "UTF-8")%>"> 서울 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("경기", "UTF-8")%>"> 경기 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("강원", "UTF-8")%>"> 강원 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("충남", "UTF-8")%>"> 충남 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("충북", "UTF-8")%>"> 충북 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("경북", "UTF-8")%>"> 경북 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("대전", "UTF-8")%>"> 대전 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("대구", "UTF-8")%>"> 대구 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("전북", "UTF-8")%>"> 전북 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("경남", "UTF-8")%>"> 경남 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("전남", "UTF-8")%>"> 전남 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("광주", "UTF-8")%>"> 광주 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("울산", "UTF-8")%>"> 울산 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("부산", "UTF-8")%>"> 부산 </option>
		<option value ="localssList.jsp?local=<%=URLEncoder.encode("제주도", "UTF-8")%>"> 제주도 </option>
		</select> </th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회</th>
		<th>공감</th>
		<th>비공감</th>
	</tr>
<%	if(count == 0){ %>
		<tr>
			<td colspan="8">작성된 글이 없습니다...</td>
		</tr>
<%	}else{ 
			for(LocalBoardDTO dto : list) { %>
			<tr>
				<td id="center">
					<%= number-- %>
					<input type="hidden" name="num" value="<%=dto.getNum() %>" />
				</td>
				<td> <%= dto.getLocal() %> </td>
				<td>
					<a href="localContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
						<%= dto.getSubject() %>
					</a>
				</td>
				<td><a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>">
								<%= dto.getWriter() %>
						</a></td>
				<td> <%= dto.getReg() %> </td>
				<td> <%= dto.getReadcount() %> </td>
				<td> <%= dto.getGood() %> </td>
				<td> <%= dto.getBad() %> </td>
			</tr>
	<%	}%>

	
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
			<a href="localssList.jsp?pageNum=<%=startPage-10%>&local=<%=URLEncoder.encode(local, "UTF-8")%>">[이전]</a>
		<%}
			for(int i = startPage ; i <= endPage ; i++){
			%>	<a href="localssList.jsp?pageNum=<%=i%>&local=<%=URLEncoder.encode(local, "UTF-8")%>">[<%=i%>]</a> 	
	  	  <%}
		if(endPage < pageCount){%>
		<a href="localssList.jsp?pageNum=<%=startPage + 10%>&local=<%=URLEncoder.encode(local, "UTF-8")%>">[다음]</a>
	  <%}
			}
				}%>

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