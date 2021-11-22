<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Random" %>   

<html>
	<head>
		<title>시네톡-Q&A 글작성</title>
		<link rel="shortcut icon" href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" type="image/x-icon">
	</head>
		<body>

		<h2 align="center">Q&A</h2> 
		<h5 align="center">- 문의사항을 남겨주세요</h5>

		<style>
		  table {
		    width: 50%;
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

		<%-- 내용, 비밀번호 기입되었는지 확인 --%>
		<script>
			function check(){
				contentcheck = document.getElementsByName("content")[0].value;
				pwcheck = document.getElementsByName("pw")[0].value;
				
				if(contentcheck == ""){
					alert("내용을 작성해주세요");
					return false;
				}
				
				if(pwcheck == ""){
					alert("비밀번호를 입력해주세요")
					return false;	
				}
			}
		</script>

		<%
			int num = 0, ref = 1, re_step = 0, re_level = 0;
			if(request.getParameter("num") != null){
				num = Integer.parseInt(request.getParameter("num"));
				ref = Integer.parseInt(request.getParameter("ref"));
				re_step = Integer.parseInt(request.getParameter("re_step"));
				re_level = Integer.parseInt(request.getParameter("re_level"));
			}
		%>

		<%	
			String id;
			String id2 = (String)session.getAttribute("id"); 
			String kid = (String)session.getAttribute("kid"); 
			String admin = (String)session.getAttribute("admin"); 
		
			Random random = new Random();
			String writer = "익명" + random.nextInt(1000000); 
		
			// 첫번째 조건문은 admin이 null값일 때
			// 두번째 조건문은 kid가 null값일 때
			// 세번째 조건문은 실제 id인 id2가 null값일 때
			if(admin == null){	
				if(kid == null){ 
					if(id2 == null){ 
						id = writer;
					} else {
						id = id2;
					}
				} else {
					id = "카카오" + kid; 
				}
			} else { 
				id = admin;
			}
		%>	

		<form action="q&a_WritePro.jsp" method="post" onsubmit="return check();"> 
			<table width="700" align="center"> 
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="ref" value="<%=ref%>">
				<input type="hidden" name="re_step" value="<%=re_step%>">
				<input type="hidden" name="re_level" value="<%=re_level%>">
				
				<tr>
					<%if(request.getParameter("num") == null) {%>
						<td width="85" align="center">작성자</td>
						<td><input type="hidden" name="id" value="<%=id%>"><%=id%></td>
					<%}else{%>
						<td width="85" align="center">작성자</td>
						<td><input type="hidden" name="id" value="<%=admin%>"><%=admin%></td>
					<%}%>
				</tr>
				<tr>
					<%-- 첫번째는 num이 null값이면 답변으로 바뀌는 조건문 --%>
					<%-- 두번째는 id가 admin이면 안내드립니다로 바뀌는 조건문 --%>
					<%if(request.getParameter("num") == null) {%>
						<%if(id == admin){%>
							<td width="85" align="center">제목</td>
							<td>
								<select name="subject" value="안내 드립니다">
									<option>안내 드립니다</option>
								</select>
							</td>
						<%}else{%>
							<td width="85" align="center">제목</td>
							<td>
								<select name="subject" value="문의 드립니다">
									<option>문의 드립니다</option>
								</select>
							</td>
						<%}%>
					<%}else{%>
						<td width="85" align="center">제목</td>
						<td>
							<select name="subject" value="답변 드립니다">
								<option>답변 드립니다</option>
							</select>
						</td>
					<%}%>
				</tr>
				<tr>
					<td width="85" align="center">내용</td>
					
					<td><textarea rows="10" cols="100" name="content" placeholder="내용을 작성해주세요"></textarea></td>
				</tr>
				<tr>
					<td width="85" align="center">비밀번호</td>
					<td><input type="password" name="pw"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="등록하기"> 
						<input type="reset" value="다시작성"> 
						<input type="button" value="목록보기" onclick="window.location='q&a_List.jsp'">
					</td>
				</tr>
			</table>	
		</form>    
	</body> 
</html>