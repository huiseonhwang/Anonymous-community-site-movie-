<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.MovieDAO" %>

<jsp:useBean class="team03.bean.MovieDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-영화게시판</title>
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
	
	// 제목, 내용, 비밀번호 입력값이 없을 시 띄우는 경고창 (유효성 검사)
	function nullCheck(){
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
	}
	
	// 제목, 내용, 비밀번호 입력값이 없을 시 띄우는 경고창 (유효성 검사)
	function memNullCheck(){
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
</script>

<%
	String pageNum = request.getParameter("pageNum");
	
	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	
	MovieDAO dao = MovieDAO.getInstance();
	dto = dao.getContent(dto);
 %>
 	<%
 		if(kid == null && id == null){%>
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
						<td> 장르 </td>
						<td>
							<select name = "kategorie">
								<option value ="romance"> 로맨스/멜로 </option>
								<option value = "comic"> 코미디 </option>
								<option value = "action"> 액션 </option>
								<option value = "sf"> SF </option>
								<option value = "fantasy"> 판타지 </option>
								<option value = "thriller"> 스릴러/공포 </option>
								<option value = "adventure"> 어드벤쳐 </option>
								<option value = "drama"> 드라마 </option>
							</select>
						</td>
					<tr>
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
					<tr>
						<td>비밀번호</td>
						<td>
							<input type="password" name="pw" />
						</td>
					</tr>
					<tr>
						<th colspan="3">
							<input type="submit" value="수정"/>
							<input type="button" value="닫기"
									onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
						</th>
					</tr>
				</table>
			</form>
 	<%	}else{%>
	 		<form action="updatePro.jsp" method="post" enctype="multipart/form-data" onsubmit="return memNullCheck();">
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
					<td> 장르 </td>
					<td>
						<select name = "kategorie">
							<option value ="로맨스/멜로"> 로맨스/멜로 </option>
							<option value = "코미디"> 코미디 </option>
							<option value = "액션"> 액션 </option>
							<option value = "SF"> SF </option>
							<option value = "판타지"> 판타지 </option>
							<option value = "스릴러/공포"> 스릴러/공포 </option>
							<option value = "어드벤쳐"> 어드벤쳐 </option>
							<option value = "드라마"> 드라마 </option>
						</select>
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
					<tr>
						<th colspan="3">
							<input type="submit" value="수정"/>
							<input type="button" value="닫기"
									onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
						</th>
					</tr>
				</table>
			</form>
 <%	}
 	%>
	