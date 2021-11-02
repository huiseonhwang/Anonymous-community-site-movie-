<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
	String num = request.getParameter("num");
	String pageNum=request.getParameter("pageNum");
%>

<br />

<table>
	<form action="deletePro.jsp" method="post" >
	
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
			
		<tr>	
			<td width="300">
				<div style="text-align: center;">
					<input type="password" name="pw" placeholder="삭제를 원하시면, 비밀번호를 입력해주세요!" style="width : 280">
				</div>				
			</td>
		</tr>
		
		<tr>
			<td width="300">
				<div style="text-align: center;">
					<input type="submit" value="삭제하기" style="width : 280">
				</div>	
			</td>
		</tr>
		
		<tr>
			<td width="300">
				<div style="text-align: center;">
					<input type="button" value="이전페이지로" style="width : 280" onclick="window.location='/team03/visitor/visitorForm.jsp'">
				</div>	
			</td>
		</tr>
		
	</form>
</table> 