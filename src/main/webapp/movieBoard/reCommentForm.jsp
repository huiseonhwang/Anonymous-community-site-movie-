<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.Random" %>

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
	*{
		text-align: center;
	}
</style>
<script type="text/javascript">
	
	function windowClose(){
		opener.location.reload();
		window.close();
	}
	
	// 입력된 값이 없을 때 띄우는 경고창 (유효성 검사)
	function nullCheck(){
		
		// 세션값을 각각의 변수명에 대입
		var sessionId = '<%=(String)session.getAttribute("id")%>';
		var sessionKid = '<%=(String)session.getAttribute("kid")%>';
		
		// 세션의 여부를 판단하여 익명 사용자일 때와 로그인 된 사용자일 때를 구분
		if(sessionId == null || sessionKid == null){
			// 익명 사용자일 때
			pwVal = document.getElementsByName("pw")[0].value;
			contentVal = document.getElementsByName("content")[0].value;
			
			if(pwVal == ""){
				alert("비밀번호를 입력해주세요.");
				return false;
			}
			if(contentVal == ""){
				alert("내용을 작성해주세요.");
				return false;
			}
		} else {
			// 로그인 된 사용자일 때
			contentVal = document.getElementsByName("content")[0].value;
			
			if(contentVal == ""){
				alert("내용을 작성해주세요.");
				return false;
			}
		}
		
	}
	
</script>
<%
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	int num = Integer.parseInt(request.getParameter("num"));
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	
	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	
	// 댓글 작성자 (writer) 변수 선언
	String writer;
	if (kid == null) {
		// kid가 null일 때
		if (id == null) {
			// id가 null일때
			// writer 변수에 익명 대입
			Random r = new Random();
			writer = "익명"+r.nextInt(10000);
		} else {
			// id의 값이 null이 아닐때(값이 있을 때)
			writer = id;
		}   
	} else {
		// kid가 null이 아닐때
		// writer 에 kid 대입
		writer = "카카오" + kid;
	}
%>

<form action="reCommentPro.jsp" method="post" onsubmit="return nullCheck();">
	<input type="hidden" name="num" value="<%=num%>" />
	<input type="hidden" name="pageNum" value="<%=pageNum%>" />
	<input type="hidden" name="boardNum" value="<%=boardNum%>" />
	<input type="hidden" name="re_step" value="<%=re_step%>" />
	<input type="hidden" name="re_level" value="<%=re_level%>" />
	
	<table>
		<tr>
			<th colspan = "5">
				답글 작성
			</th>
		</tr>
		<tr>
			<td> 작성자 </td>
			<td colspan = "3">
				<%= writer %>
				<input type = "hidden" name = "writer" value = "<%= writer %>" />
			</td>
		</tr>
		<%-- kid가 null이고 id가 null일 때 (익명 사용자일 때) --%>
		<% if (kid == null && id == null) { %>
			<tr>
				<td> 비밀번호 </td>
				<td colspan = "3">
				<input type = "password" name = "pw" />
				</td>
			</tr>
		<% } %>
			<tr>
				<td colspan = "5" >
					<textarea rows = "4" cols = "60" name = "content" placeholder = "내용을 작성해 주세요" ></textarea >
					<br/>
					<input type = "submit" value = "답글 작성" />
					<input type = "button" value = "창 닫기"
						onclick = "window.close()"/>
				</td>
			</tr>
	</table>
</form>



