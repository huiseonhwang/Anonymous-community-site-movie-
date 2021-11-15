<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.CommentDAO" %>

<jsp:useBean class="team03.bean.CommentDTO" id="dto" />
<jsp:setProperty property="boardNum" name="dto" />
<jsp:setProperty property="num" name="dto" />

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
	
	// 삭제 팝업을 끄면서 기존 게시글 페이지를 새로고침 하는 함수
	function windowClose(){
		opener.location.reload();
		window.close();
	}
	
	// 삭제 시 비밀번호에 입력된 값이 없을 때 띄우는 경고창 (유효성 검사)
	function nullCheck(){
		pwVal = document.getElementsByName("pw")[0].value;
		
		if(pwVal == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
	}
	
</script>

<%
	String pageNum = request.getParameter("pageNum");

	CommentDAO dao = CommentDAO.getInstance();
	dto = dao.getContent(dto);
%>

<form action="commentDeletePro.jsp" method="post" onsubmit="return nullCheck();">

	<input type="hidden" name="boardNum" value="<%=dto.getBoardNum()%>" />
	<input type="hidden" name="num" value="<%=dto.getNum()%>" />
	<input type="hidden" name="pageNum" value="<%=pageNum%>" />
	
	<table>
		<tr>
			<th colspan="2"> 댓글 삭제 </th>
		</tr>
		<%if(dto.getPw() != null){ %>
			<tr>
				<td colspan="2" style="text-align:center;">
					비밀번호를 입력하세요. <br/>
					<input type="password" name="pw" />
				</td>
			</tr>
		<% } %>
		
		<tr>
			<td style="text-align:center;">
				<input type="submit" value="삭제" />
			</td>
			<td style="text-align:center;">
				<input type="button" value="창 닫기"
					onclick="windowClose();" />
			</td>
		</tr>
	</table>
</form>
