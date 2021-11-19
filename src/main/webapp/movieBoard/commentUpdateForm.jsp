<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.MovieCommentDAO" %>

<jsp:useBean class = "team03.bean.MovieCommentDTO" id = "dto" />
<jsp:setProperty property = "*" name = "dto" />

    
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
		contentVal = document.getElementsByName("content")[0].value;
		pwVal = document.getElementsByName("pw")[0].value;
		
		if(contentVal == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
		if(pwVal == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
	}
	
</script>

<%
	String pageNum = request.getParameter("pageNum");
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));

	MovieCommentDAO dao = MovieCommentDAO.getInstance();
	dto = dao.getContent(dto, re_step, re_level);
%>

<form action = "commentUpdatePro.jsp" method = "post" onsubmit="return nullCheck();" >
	<input type = "hidden" name = "boardNum" value = "<%=dto.getBoardNum() %>" />
	<input type = "hidden" name = "num" value = "<%=dto.getNum() %>" />
	<input type = "hidden" name = "pageNum" value = "<%=pageNum %>" />
	<input type = "hidden" name = "re_step" value = "<%=dto.getRe_step() %>" />
	<input type = "hidden" name = "re_level" value = "<%=dto.getRe_level() %>" />
	
	<table>
		<tr>
			<th colspan = "2"> 댓글 수정 </th>
		</tr>
		<tr>
			<td>
				<textarea rows="2" cols="60" name="content"><%=dto.getContent()%></textarea>
			</td>
		</tr>
		<% if (dto.getPw() != null) { %>
			<tr>
				<td style = "text-align:center;" >
					비밀번호를 입력하세요 <br/>
					<input type = "password" name = "pw" />
				</td>
			</tr>
		<% } %>
		
		<tr>
			<td style = "text-align:center;" >
				<input type = "submit" value = "수정하기" />
				<input type = "button" value = "창 닫기"
					onclick = "window.close()"/>
			</td>
		</tr>				
	</table>
</form>