<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.VisitorDAO" %>

<jsp:useBean class="team03.bean.VisitorDTO" id="dto" />

<!-- 파라미터 받을 때 property로 넘어오는 값 확인 -->
<jsp:setProperty property="num" name="dto" />
<jsp:setProperty property="owner" name="dto" />

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
	String owner = request.getParameter("owner");
	String pageNum = request.getParameter("pageNum");
	
	VisitorDAO dao = new VisitorDAO();
	dto = dao.getContent(dto);
%>
    <form action="updatePro.jsp" method="post">
    <input type="hidden" name="num" value="<%= dto.getNum() %>" />
    <input type="hidden" name="owner" value="<%= owner %>" />
	<input type="hidden" name="pageNum" value="<%=pageNum%>" />
    	<table border="1" width="700" align="center">		
			<tr>
				<th colspan="4"><h1>방명록 수정</h1></th>
			</tr>					
			<tr>
				<td>아이디</td>
				<td>
					<%=dto.getId()%>
				</td>
							
				<td>비밀번호</td>
				<td>
					<input type="password" name="pw">
				</td>
			</tr>
					
			<tr>
				<td colspan="4">
					<textarea rows="10" cols="90" name="content"><%=dto.getContent()%></textarea>
				</td>
			</tr>
			
			<tr>
				<td colspan="4" align="center">
					<input type="submit" value="등록">
					<input type="reset" value="다시작성">
					<input type="button" value="이전페이지로" onclick="window.location='/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>'">
				</td>
			</tr>
		</table>
	</form>

