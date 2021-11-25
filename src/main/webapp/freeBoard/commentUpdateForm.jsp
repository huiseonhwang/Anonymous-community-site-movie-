<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.CommentDAO" %>

<jsp:useBean class="team03.bean.CommentDTO" id = "dto" />
<jsp:setProperty property="*" name = "dto" />

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


<script type="text/javascript">

	//수정 팝업을 끄면서 기존 게시글 페이지를 새로고침 하는 함수
	function windowClose(){
		opener.location.reload();
		window.close();
	}
	
	// 수정 시 작성 내용에 입력된 값이 없을 때 띄우는 경고창 (유효성 검사)
	function nullCheck(){
		
		// 세션값을 각각의 변수명에 대입
		var sessionId = '<%=(String)session.getAttribute("id")%>';
		var sessionKid = '<%=(String)session.getAttribute("kid")%>';
		
		// 세션의 여부를 판단하여 익명 사용자일 때와 로그인 된 사용자일 때를 구분
		if(sessionId == null && sessionKid == null){
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
	// boardNum(해당 게시글 번오)과 num(댓글번호)은 프로퍼티로 파라미터를 받고
	// 게시글이 있는 게시판 페이지는 리퀘스트로 파라미터를 받음
	String pageNum = request.getParameter("pageNum");
	
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	
	CommentDAO dao = CommentDAO.getInstance();
	dto = dao.getContent(dto, re_step, re_level);
%>

<form action="commentUpdatePro.jsp" method="post" onsubmit="return nullCheck();">
	<input type="hidden" name="boardNum" value="<%=dto.getBoardNum()%>" />
	<input type="hidden" name="num" value="<%=dto.getNum()%>" />
	<input type="hidden" name="pageNum" value="<%=pageNum%>" />
	<input type="hidden" name="re_step" value="<%=dto.getRe_step()%>" />
	<input type="hidden" name="re_level" value="<%=dto.getRe_level()%>" />
	
	<table>
		<tr>
			<th colspan="2"> 댓글 수정 </th>
		</tr>
		<tr>
			<td>
				<textarea rows="2" cols="60" name="content"><%=dto.getContent()%></textarea>
			</td>
		</tr>
		<%if(dto.getPw() != null){ %>
			<tr>
				<td style="text-align:center;">
					비밀번호를 입력하세요. <br/>
					<input type="password" name="pw" />
				</td>
			</tr>
		<% } %>
		
		<tr>
			<td style="text-align:center;">
				<input type="submit" value="수정하기" />
				<input type="button" value="창 닫기"
					onclick="windowClose();" />
			</td>
		</tr>
	</table>
</form>

