<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.VisitorDTO" %>
<%@ page import="team03.bean.VisitorDAO" %>
<%@ page import="java.util.List" %> 
<%@page import="java.util.Random"%>

<html>
	<head>
		<title>시네톡-미니페이지 메인</title>
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

		<%-- 내용, 비밀번호 기입되었는지 확인 --%>
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
			String writer;
			String id = (String)session.getAttribute("id"); 
			String kid = (String)session.getAttribute("kid"); 
			String admin = (String)session.getAttribute("admin"); 
		
			// 첫번째 조건문은 admin이 null값일 때
			// 두번째 조건문은 kid가 null값일 때
			// 세번째 조건문은 실제 id인 id2가 null값일 때
			if(admin == null){	
				if(kid == null){ 
					if(id == null){ 
						Random random = new Random(); 
						writer = "익명" + random.nextInt(1000000);  
					}else{
						writer = id; 
					}
				}else{
					writer = "카카오" + kid; 
				}
			}else{ 
				writer = admin;
			}
		%>	

		<%
			request.setCharacterEncoding("UTF-8");
		
			String content = request.getParameter("content");
			String owner = request.getParameter("owner");
		%>

		<% 
			int pageSize = 10; 
			String pageNum = request.getParameter("pageNum");
			String my = request.getParameter("my");
			 
			if(pageNum == null){
				pageNum="1";
			}
			
			int currentPage = Integer.parseInt(pageNum); 
			int start = (currentPage-1) * pageSize+1;  
			int end = currentPage * pageSize;
			int number = 0;
			
			VisitorDAO dao = new VisitorDAO();
			
			int count = 0;
			List<VisitorDTO> list = null;
			
			count = dao.getCount(owner);
			if(count > 0){
				list = dao.getAllList(owner, start, end);
			}
			
			number = count-(currentPage-1)*pageSize;
		%>

		<br />
	<% 
		if(kid == null && id == null){%>
			<form action="visitorPro.jsp" method="post" onsubmit="return nullCheck();">
			<table border="1" style="width: 60%; text-align: center;">
				<tr>
					<th colspan="4"><h1><%=owner%>님의 미니페이지</h1>
						<input type="hidden" name="owner" value=<%=owner%> />
						<input type="hidden" name="pageNum" value="<%=pageNum%>"/>
					</th>
				</tr>					
				<tr>
					<td align="center" style="width: 30%;">작성자</td>
					<td align="center">
						<%=writer%>
						<input type="hidden" name="id" value=<%=writer%> />
					</td>
				</tr>
				<tr>
					<td align="center" style="width: 30%;">비밀번호</td>
					<td>
						<input type="password" name="pw">
					</td>		
				</tr>		
				<tr>
					<td colspan="4">
						<textarea rows="10" cols="100%" name="content" placeholder="내용을 작성해주세요"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<input type="submit" value="등록">
						<input type="reset" value="다시입력">
						<input type="button" value="메인으로" onclick="window.location='/team03/main.jsp'">
					</td>
				</tr>
			</table>
		</form>
	<%	}else{%>
			<form action="visitorPro.jsp" method="post" onsubmit="return memNullCheck();">
				<table border="1" style="width: 60%; text-align: center;">
					<tr>
						<th colspan="4"><h1><%=owner%>님의 미니페이지</h1>
							<input type="hidden" name="owner" value=<%=owner%> />
							<input type="hidden" name="pageNum" value="<%=pageNum%>"/>
						</th>
					</tr>					
					<tr>
						<td align="center" style="width: 30%;">작성자</td>
						<td align="center">
							<%=writer%>
							<input type="hidden" name="id" value=<%=writer%> />
						</td>
					</tr>		
					<tr>
						<td colspan="4">
							<textarea rows="10" cols="100%" name="content" placeholder="내용을 작성해주세요"></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="4" align="center">
							<input type="submit" value="등록">
							<input type="reset" value="다시입력">
							<input type="button" value="메인으로" onclick="window.location='/team03/main.jsp'">
						</td>
					</tr>
				</table>
			</form>
	<%	}
	%>
		
		<br />
	
		<form>
			<table style="width: 60%;">
				<tr>
					<%if(count == 0){%> 
					<td colspan="4">등록된 글이 없습니다</td>
				</tr>
					<%}else{ 
						
						 for(VisitorDTO dto : list) {%>
								<tr>
									<td width="100" align="center">
										<h5><%=dto.getReg()%></h5>
										<strong><font color="red"><h5>No.<%=number--%></h5></font></strong>
										<h3><font color="blue"><%=dto.getId()%></font></h3>
									</td>
										
									<th align="left">
										<div>
											<div style="float: left; padding:5% 0 5% 0;">
												<%=dto.getContent()%>
											</div>
								
											<div style="float: right; padding:2% 0 2% 0; text-align: right;">
												<%
												if(kid == null){
													if(id == null){
														if(dto.getPw() != null){%>
															<input type="button" value="수정하기" 
															onclick="window.location='updateForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
															<br/><br/>
															<input type="button" value="삭제하기" 
															onclick="window.location='deleteForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
															<input type="hidden" name="owner" value="<%=dto.getOwner()%>" />
														<%}
													}else{
														if(writer.equals(dto.getId())){%>
															<input type="button" value="수정하기" 
															onclick="window.location='updateForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
															<br/><br/>
															<input type="button" value="삭제하기" 
															onclick="window.location='deleteForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
															<input type="hidden" name="owner" value="<%=dto.getOwner()%>" />
														<%}
														if(dto.getPw() != null){%>
															<input type="button" value="수정하기" 
															onclick="window.location='updateForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
															<br/><br/>
															<input type="button" value="삭제하기" 
															onclick="window.location='deleteForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
															<input type="hidden" name="owner" value="<%=dto.getOwner()%>" />
														<%}
													}
												}else{
													if(writer.equals(dto.getId())){%>
														<input type="button" value="수정하기" 
														onclick="window.location='updateForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
														<br/><br/>
														<input type="button" value="삭제하기" 
														onclick="window.location='deleteForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
														<input type="hidden" name="owner" value="<%=dto.getOwner()%>" />
													<%}
													if(dto.getPw() != null){%>
														<input type="button" value="수정하기" 
														onclick="window.location='updateForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
														<br/><br/>
														<input type="button" value="삭제하기" 
														onclick="window.location='deleteForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
														<input type="hidden" name="owner" value="<%=dto.getOwner()%>" />
													<%}
												}
											%>
											</div>
										</div>
									</th>
								</tr>
						<%}%>	
					<%}%>
					
				 <tr>
					<td width="90" align="center"><strong>페이지</strong></td>
					<td colspan="2">
						<%
							if(count > 0){
								int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
								int startPage = (currentPage / 10) * 10 + 1;
								int pageBlock = 10;
								int endPage = startPage + pageBlock - 1;
								
								if(endPage > pageCount){ 
									endPage = pageCount;
								} 
								if(startPage > 10){ %>
									<a href="visitorForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&pageNum=<%=startPage-10%>">[이전]</a>
							   	<% }
								for(int i = startPage ; i <= endPage ; i++){ %>
							   		<a href="visitorForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&pageNum=<%=i%>">[<%=i%>]</a>
							    <% }
								if(endPage < pageCount){ %>
									<a href="visitorForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&pageNum=<%=startPage+10%>">[다음]</a>
								<% }
							 } %>
						</td>
					</tr>
			</table>
		</form>		
	</body>	
</html>