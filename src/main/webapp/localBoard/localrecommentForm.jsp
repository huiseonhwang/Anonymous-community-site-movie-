<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

<%
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	int num = Integer.parseInt(request.getParameter("num"));
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	
	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	
	// 댓글 작성자 writer 변수 선언
	String writer ="사용자";
	
	if(id != null){
		writer = id;
	}
	if(kid != null){
		writer = kid;
	}
		
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

<form action="localrecommentPro.jsp" method="post" onsubmit = "return check();">

	<input type="hidden" name="num" value="<%=num%>" />
	<input type="hidden" name="pageNum" value="<%=pageNum%>" />
	<input type="hidden" name="boardNum" value="<%=boardNum%>" />
	<input type="hidden" name="re_step" value="<%=re_step%>" />
	<input type="hidden" name="re_level" value="<%=re_level%>" />
	
	<table>
		<tr>
			<th colspan="5">
				답글 작성
			</th>
		</tr>
		<tr>
			<td> 작성자 </td>
			<td colspan="3">
				<%= writer %>
				<input type="hidden" name="writer" value="<%=writer%>" />
			</td>
		</tr>
			<tr>
				<td colspan="5">
					<textarea rows="4" cols="60" name="content" placeholder="내용을 작성해주세요!"></textarea>
				<br/>
					<input type="submit" value="답글작성" />
					<input type="button" value="창 닫기"
						onclick="windowClose();" />
				</td>
			</tr>
	</table>
</form>

<script type="text/javascript">
	
	function windowClose(){
		opener.location.reload();
		window.close();
	}
	
</script>