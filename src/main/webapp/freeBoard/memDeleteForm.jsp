<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean class="team03.bean.BoardDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />

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

<form action="memDeletePro.jsp" method="post">
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
					onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
			</td>
		</tr>
	</table>
</form>