<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.MovieDAO" %>
<jsp:useBean class = "team03.bean.MovieDTO" id = "dto" />
<jsp:setProperty property = "*" name = "dto" />


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

<script>
	// 삭제 시 비밀번호에 입력된 값이 없을 때 띄우는 경고장 (유효성 검사) 
	function nullCheck() {
		pwVal = document.getElementsByName("pw")[0].value;
		if (pwVal == "") {
			alert("비밀번호를 입력하세요.");
			return false;
		}
	}
</script>

<%
	String pageNum = request.getParameter("pageNum");
	MovieDAO dao = MovieDAO.getInstance();
	dto = dao.getContent(dto);
%>

<form action = "deletePro.jsp" method = "post" onsubmit="return nullCheck();" >
	<input type = "hidden" name = "num" value = "<%=dto.getNum() %>" />
	<input type = "hidden" name = "pageNum" value = "<%=pageNum %>" />
	<table>
		<tr>
			<th colspan ="2" > 게시글 삭제 </th>
		</tr>
		<% if (dto.getPw() != null) { %>
			<tr>
				<td colspan = "2" style = "text-align:center;" >
					비밀번호를 입력하세요 . <br/>
					<input type = "password" name = "pw" />
				</td>
			</tr>
		<% } %>
		
		<tr>
			<td style = "text-align:center;">
				<input type = "submit" value = "삭제" />
			</td>
			<td style = "text-align:center;">
				<input type = "button" value = "글 목록"
					onclick = "window.location='list.jsp?=pageNum<%=pageNum %>'" />
			</td>
		</tr>
	</table>
</form>