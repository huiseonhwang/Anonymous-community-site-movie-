<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Random" %>   

<h2 align="left">Q&A</h2> 
<h5 align="left">- 문의사항을 남겨주세요</h5>

<style>
  table {
    width: 70%;
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

<%
	int num=0, ref=1, re_step=0, re_level=0;
	if(request.getParameter("num") != null){
		num=Integer.parseInt(request.getParameter("num"));
		ref=Integer.parseInt(request.getParameter("ref"));
		re_step=Integer.parseInt(request.getParameter("re_step"));
		re_level=Integer.parseInt(request.getParameter("re_level"));
	}
%>

<%	
	String id = (String)session.getAttribute("id");	
	String kid = (String)session.getAttribute("kid");
	String admin = (String)session.getAttribute("admin");

	Random random = new Random();
	String writer = "익명"+random.nextInt(1000000);
	
	if(id == null && writer == null){
		id = "kakao"+kid;
	}
	
	if(id == null && kid == null){
		id = writer;		
	}
%>

<table width="700">
	<form action="q&a_WritePro.jsp" method="post">
	<input type="hidden" name="num" value="<%=num%>">
	<input type="hidden" name="ref" value="<%=ref%>">
	<input type="hidden" name="re_step" value="<%=re_step%>">
	<input type="hidden" name="re_level" value="<%=re_level%>">
		<tr>
			<% if(request.getParameter("num") == null) { %>
				<td width="80" align="center">작성자</td>
				<td><input type="hidden" name="id" value="<%=id%>"><%=id%></td>
			<% } else { %>
				<td width="80" align="center">작성자</td>
				<td><input type="hidden" name="id" value="<%=admin%>"><%=admin%></td>
			<% } %>
		</tr>
		<tr>
			<% if(request.getParameter("num") == null) { %>
				<td width="80" align="center">제목</td>
				<td><select name="subject" value="문의 드립니다"><option>문의 드립니다</option></select></td>
			<% } else { %>
				<td width="80" align="center">제목</td>
				<td><select name="subject" value="답변 드립니다"><option>답변 드립니다</option></select></td>
			<% } %>
		</tr>
		<tr>
			<td width="80" align="center">내용</td>
			
			<td><textarea rows="10" cols="90" name="content" placeholder="내용을 작성해주세요"></textarea></td>
		</tr>
		<tr>
			<td width="80" align="center">공개여부</td>
			<td class="form-inline">
   				 <input type="radio" name="cs_open" id="cs_open" value="Y" class="radio" /><span class="ml_10">공개</span>
    			 <input type="radio" name="cs_open" id="cs_open" value="N" class="radio" /><span class="ml_10">비공개</span>
			</td>
		</tr>
		<tr>
			<td width="80" align="center">비밀번호</td>
			<td><input type="password" name="pw"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="등록하기"> 
				<input type="reset" value="다시작성"> 
				<input type="button" value="목록보기" onclick="window.location='q&a_List.jsp'">
			</td>
		</tr>	
	</form>
</table>
