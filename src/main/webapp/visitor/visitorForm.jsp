<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.VisitorDTO" %>
<%@ page import="team03.bean.VisitorDAO" %>
<%@ page import="java.util.List" %> 
<%@page import="java.util.Random"%>

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
	function check(){
		id = document.getElementsByName("id")[0].value;
		pw = document.getElementsByName("pw")[0].value;
		if(id == ""){
			alert("아이디를 입력해주세요.")
			return false;
		}
		if(pw == ""){
			alert("비밀번호를 입력해주세요.")
			return false;
		}
	}
</script>

<%-- 세션 받아서 일단 주석처리
<%
	String id = (String)session.getAttribute("id");
	if(id == null){%>
	<script>
		alert("로그인 후 글쓰기가 가능합니다.")
		window.location=".jsp"; <- 로그인 화면으로
	</script>
<% }else{ %>
--%>

<%
String num = request.getParameter("num");
	String id = request.getParameter("id");
	String content = request.getParameter("content");
	
	int pageSize = 10;
	String pageNum = request.getParameter("pageNum");
	String my = request.getParameter("my");
	 
	if(pageNum == null){
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum); 
	int start = (currentPage-1) * pageSize+1;  
	int end = currentPage * pageSize;
	
	VisitorDAO dao = new VisitorDAO();
	
	//visitorDTO dto = new visitorDTO();
	//dto = dao.getContent(dto);
	//dto.setid(id);
	//dto.setcontent(content);
	
	int count = 0;
	List<VisitorDTO> list = null;
	
	count = dao.getCount();
	if(count > 0){
		list = dao.getAllList(start, end);
	}
%>

<%
Random r = new Random();
	String writer = "익명"+r.nextInt(100000);
%>

<%
if(id == null) { 
	 id = writer;
}
%>

<html>
	<body>
		<head>
			<title>방명록</title>
		</head>

		<form action="visitorPro.jsp" method="post" onsubmit="return check();">
			<table border="1" width="700" align="center">
				<tr>
					<th colspan="4"><h1>방명록</h1></th>
				</tr>					
				<tr>
					<td>아이디</td>
					<td>
						<input type="text" name="id" value=<%=writer%>>
					</td>
						
					<td>비밀번호</td>
					<td>
						<input type="password" name="pw">
					</td>
				</tr>
				
				<tr>
					<td colspan="4">
						<textarea rows="10" cols="90" name="content"> 내용을 작성해주세요! </textarea>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<input type="submit" value="등록">
						<input type="reset" value="다시입력">
					</td>
				</tr>
		</form> 
	</table>
	
	<br />
	<br />

		<table width="700">
				<tr>
					<%
					if(count == 0){
					%>
						<td colspan="4"> 방명록이 없습니다! </td>
				</tr>
					<%
					}else {
					%>
						<%
						for(VisitorDTO dto : list) {
						%>
				<tr>
					<td width="100" align="center">
						<strong><font color="red"><h5>No.<%=dto.getnum()%></h5></font></strong>
						<h4><font color="blue"><%=dto.getid()%></font></h4>
					</td>
					<th align="left"> <%=dto.getcontent()%> </th>
				</tr>
				<% } %>	
			<% } %>
				<tr>
					<td width="100" align="center"><strong>페이지</strong></td>
					<td>
					<%
					if(count > 0){
						int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
						int startPage = (currentPage / 10) * 10 + 1;
						int pageBlock = 10;
						int endPage = startPage + pageBlock - 1;
						if(endPage > pageCount){
							endPage = pageCount;
						}
						if(startPage > 10){ %>
							<a href="visitorForm.jsp?pageNum=<%=startPage-10%>">[이전]</a>
					   <% }
							for(int i = startPage ; i <= endPage ; i++){
					   %> 	<a href="visitorForm.jsp?pageNum=<%=i%>">[<%=i%>]</a>
					   <% }
							if(endPage < pageCount){%>
							<a href="visitorForm.jsp?pageNum=<%=startPage+10%>">[다음]</a>
					   <% }
					   } %>
					</td>
				</tr>
		</table>	
	</body>	
</html>