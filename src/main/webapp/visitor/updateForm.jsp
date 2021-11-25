<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.VisitorDAO" %>

<html>
	<head>
		<title>시네톡-미니페이지 수정</title>
		<link rel="shortcut icon" href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" type="image/x-icon">
	</head>
		<body>

		<jsp:useBean class="team03.bean.VisitorDTO" id="dto" /> 
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

		<script>
			function nullCheck(){
				contentVal = document.getElementsByName("content")[0].value;
				pwVal = document.getElementsByName("pw")[0].value;
				
				if(contentVal == ""){
					alert("내용을 작성해주세요.");
					return false;
				}
				if(pwVal == ""){
					alert("비밀번호를 입력해주세요.");
					return false;
				}
			}
			
			function memNullCheck(){
				contentVal = document.getElementsByName("content")[0].value;
				
				if(contentVal == ""){
					alert("내용을 작성해주세요.");
					return false;
				}
			}
		</script>

		<%	
			request.setCharacterEncoding("UTF-8");
		
			String id = (String)session.getAttribute("id"); 
			String kid = (String)session.getAttribute("kid"); 
			
			String owner = request.getParameter("owner");
			String pageNum = request.getParameter("pageNum");
			
			VisitorDAO dao = new VisitorDAO();
			dto = dao.getContent(dto);
		%>
		<%
			if(kid == null && id == null){%>
				<form action="updatePro.jsp" method="post" onsubmit="return nullCheck();">
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
		<%	}else{%>
				<form action="updatePro.jsp" method="post" onsubmit="return memNullCheck();">
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
		<%	}
		%>
	    
	</body>	
</html>
