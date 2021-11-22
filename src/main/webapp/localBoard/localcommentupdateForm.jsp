<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LocalBoardCommentDAO" %>


<jsp:useBean class="team03.bean.LocalBoardCommentDTO" id = "dto" />
<jsp:setProperty property="*" name = "dto" />

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
	// boardNum(해당 게시글 번오)과 num(댓글번호)은 프로퍼티로 파라미터를 받고
	// 게시글이 있는 게시판 페이지는 리퀘스트로 파라미터를 받음
	String pageNum = request.getParameter("pageNum");

	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));

	LocalBoardCommentDAO dao = LocalBoardCommentDAO.getInstance();
	dto = dao.LgetContent(dto, re_step, re_level);
%>

<script>
   function check(){
	  contentv = document.getElementsByName("content")[0].value;
	   if(contentv == ""){
		   alert("내용을 입력하세요");
		   return false;
	   }
   }
   </script>

<form action="localcommentupdatePro.jsp" method="post" onsubmit = "return check();">
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
		
		<tr>
			<td style="text-align:center;">
				<input type="submit" value="수정하기" />
				<input type="button" value="창 닫기"
					onclick="windowClose();" />
			</td>
		</tr>
	</table>
</form>

<script type="text/javascript">

	//수정 팝업을 끄면서 기존 게시글 페이지를 새로고침 하는 함수
	function windowClose(){
		opener.location.reload();
		window.close();
	}
	
</script>
