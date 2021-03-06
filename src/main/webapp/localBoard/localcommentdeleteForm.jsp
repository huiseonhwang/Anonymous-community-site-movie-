<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LocalBoardCommentDAO" %>

<jsp:useBean class="team03.bean.LocalBoardCommentDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />

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
	String pageNum = request.getParameter("pageNum");
	
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));

	LocalBoardCommentDAO dao = LocalBoardCommentDAO.getInstance();
	dto = dao.LgetContent(dto, re_step, re_level);
	
%>

<form action="localcommentdeletePro.jsp" method="post">

	<input type="hidden" name="boardNum" value="<%=dto.getBoardNum()%>" />
	<input type="hidden" name="num" value="<%=dto.getNum()%>" />
	<input type="hidden" name="pageNum" value="<%=pageNum%>" />
	<input type="hidden" name="re_step" value="<%=dto.getRe_step()%>" />
	<input type="hidden" name="re_level" value="<%=dto.getRe_level()%>" />
	
	<table>
		<tr>
			<th colspan="2"> 댓글 삭제 </th>
		</tr>
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

<script type="text/javascript">
	
	// 삭제 팝업을 끄면서 기존 게시글 페이지를 새로고침 하는 함수
	function windowClose(){
		opener.location.reload();
		window.close();
	}
	
</script>