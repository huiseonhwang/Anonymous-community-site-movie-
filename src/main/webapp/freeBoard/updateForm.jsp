<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.BoardDAO" %>

<jsp:useBean class="team03.bean.BoardDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-자유게시판</title>
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

<script>
	
	// 입력된 값이 없을 때 띄우는 경고창 (유효성 검사)
	function nullCheck(){
		
		// 세션값을 각각의 변수명에 대입
		var sessionId = '<%=(String)session.getAttribute("id")%>';
		var sessionKid = '<%=(String)session.getAttribute("kid")%>';
		
		// 세션의 여부를 판단하여 익명 사용자일 때와 로그인 된 사용자일 때를 구분
		if(sessionId == null || sessionKid == null){
			// 익명 사용자일 때
			subjectVal = document.getElementsByName("subject")[0].value;
			contentVal = document.getElementsByName("content")[0].value;
			pwVal = document.getElementsByName("pw")[0].value;
			
			if(subjectVal == ""){
				alert("제목을 작성해주세요.");
				return false;
			}
			if(contentVal == ""){
				alert("내용을 작성해주세요.");
				return false;
			}
			if(pwVal == ""){
				alert("비밀번호를 입력해주세요.");
				return false;
			}
		} else {
			// 로그인 된 사용자일 때
			subjectVal = document.getElementsByName("subject")[0].value;
			contentVal = document.getElementsByName("content")[0].value;
			
			if(subjectVal == ""){
				alert("제목을 작성해주세요.");
				return false;
			}
			if(contentVal == ""){
				alert("내용을 작성해주세요.");
				return false;
			}
		}
	}
	
</script>

<%
	String pageNum = request.getParameter("pageNum");
	
	BoardDAO dao = BoardDAO.getInstance();
	dto = dao.getContent(dto);
 %>
 	
	<form action="updatePro.jsp" method="post" enctype="multipart/form-data" onsubmit="return nullCheck();">
		<input type="hidden" name="num" value="<%= dto.getNum() %>" />
		<input type="hidden" name="pageNum" value="<%= pageNum %>" />
		<table>
			<tr>
				<th colspan="3"> <h1> 게시글 수정 </h1> </th>
			</tr>
			<tr>
				<td>작성자</td>
				<td> 
					<%= dto.getWriter() %>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="subject" value="<%= dto.getSubject() %>"/>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="20" cols="50" name="content"><%= dto.getContent() %></textarea>
				</td>
			</tr>
			<tr>
				<td>첨부파일</td>
				<td>
					<input type="file" name="filename" />
					<% if(dto.getFilename() != null){ %>
						[<%= dto.getFilename() %>]
						<input type="hidden" name="org" value="<%= dto.getFilename() %>" />
				<%	} else { %>
						[첨부파일 없음]
				<%	}%>
				</td>
			</tr>
			<%if(dto.getPw() != null){ %>
				<tr>
					<td>비밀번호</td>
					<td>
						<input type="password" name="pw" />
					</td>
				</tr>
			<% } %>
			<tr>
				<th colspan="3">
					<input type="submit" value="수정"/>
				</th>
			</tr>
		</table>
	</form>
