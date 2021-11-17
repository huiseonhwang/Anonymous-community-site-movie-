<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.Q_DTO" %>

<style>
  table {
    width: 15%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    border-left: 1px solid #444444;
    padding: 10px;
  }
  th:first-child, td:first-child {
    border-left: none;
  }
</style>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	Q_DTO dto = new Q_DTO();
%>

<table align="center">
	<form action="q&a_DeletePro.jsp" method="post">
		<input type="hidden" name="num" value=<%=num%>>
		<input type="hidden" name="pageNum" value=<%=pageNum%>>
		<tr>	
			<td align="center">
				<input type="password" name="pw" placeholder="비밀번호 확인">			
			</td>
		</tr>
		<tr>
			<td align="center">
				<input type="button" value="뒤로가기" onclick="window.location='/team03/QnA/q&a_Content.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">&nbsp;
				<input type="submit" value="삭제하기">
			</td>  
		</tr>
	</form>
</table> 
    