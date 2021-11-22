<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
	<head>
		<title>시네톡-미니페이지 삭제</title>
		<link rel="shortcut icon" href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" type="image/x-icon">
	</head>
		<body>

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
			request.setCharacterEncoding("UTF-8");
		
			String num = request.getParameter("num");
			String pageNum=request.getParameter("pageNum");
			String owner = request.getParameter("owner");
			
		%>

		<br />
		
		<form action="deletePro.jsp" method="post" >
			<table>	
				<tr>	
					<td width="300">
						<div style="text-align: center;">
							<input type="password" name="pw" placeholder="삭제를 원하시면, 비밀번호를 입력해주세요" style="width:280">
						</div>				
					</td>
				</tr>
				<tr>
					<td width="300">
						<div style="text-align: center;">
							<input type="submit" value="삭제하기" style="width:280">
						</div>	
					</td>
				</tr>
				<tr>
					<td width="300">
						<div style="text-align: center;">
							<input type="button" value="이전페이지로" style="width:280" onclick="window.location='/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>'">
						</div>	
					</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" name="owner" value="<%=owner%>" />
						<input type="hidden" name="pageNum" value="<%=pageNum%>" />
						<input type="hidden" name="num" value="<%=num%>" />
					</td>
				</tr>
			</table> 
		</form>
	</body>	
</html>	