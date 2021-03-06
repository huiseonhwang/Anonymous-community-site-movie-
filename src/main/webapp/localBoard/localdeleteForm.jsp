<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean class="team03.bean.LocalBoardDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />

<head>
<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
<title>지역게시판 게시물 삭제</title>
</head>

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
</style>

<%
	String id = (String)session.getAttribute("id");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>

<form action="localdeletePro.jsp" method="post">
	<input type="hidden" name="num" value="<%= num %>" />
	<input type="hidden" name="pageNum" value="<%= pageNum %>" />
	
	<table>
		<tr>
			<th colspan="2"> 게시글 삭제 </th>
		</tr>
		<tr>
			<td style="text-align:center;">
				<input type="submit" value="삭제" />
			</td>
			<td style="text-align:center;">
				<input type="button" value="글 목록"
					onclick="window.location='localList.jsp?pageNum=<%=pageNum%>'" />
			</td>
		</tr>
	</table>
</form>