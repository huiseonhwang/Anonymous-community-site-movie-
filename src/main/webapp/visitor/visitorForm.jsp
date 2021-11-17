<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.VisitorDTO" %>
<%@ page import="team03.bean.VisitorDAO" %>
<%@ page import="java.util.List" %> 
<%@page import="java.util.Random"%>

<html>
	<body>
		<head>
			<title>방명록</title>
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

<%-- 비밀번호를 입력했는지 체크해주는 코드입니다. --%>
<script>
	function check(){
		pw = document.getElementsByName("pw")[0].value;
		if(pw == ""){
			alert("비밀번호를 입력해주세요.")
			return false;	
		}
	}
</script>

<%-- 
	세션을 받았을때는 id가 사용되지만, 로그인을 하지않고 방명록에 접근했을때는 
	id에 null값이 대입되어, 아래의 랜덤번호를 부여하는 코드가 실행되고 
	이때는 id에 writer가 대입되게 됩니다.   
--%>
<%
	String kid = (String)session.getAttribute("kid");
	String id = (String)session.getAttribute("id");
	
	if(kid == null){
		if(id == null){
			Random r = new Random();
			String writer = "익명"+r.nextInt(100000);	
			id = writer;
		} else {
			id = id;
		}
	} else {
		id = "카카오" + kid;
	}
%>

<%
	request.setCharacterEncoding("UTF-8");

	String content = request.getParameter("content");
	String owner = request.getParameter("owner");
%>

<% 
	int pageSize = 10; 
	String pageNum = request.getParameter("pageNum");
	String my = request.getParameter("my");
	 
	if(pageNum == null){
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum); 
	int start = (currentPage-1) * pageSize+1;  
	int end = currentPage * pageSize;
	int number = 0;
	
	VisitorDAO dao = new VisitorDAO();
	
	int count = 0;
	List<VisitorDTO> list = null;
	
	count = dao.getCount(owner);
	if(count > 0){
		list = dao.getAllList(owner, start, end);
	}
	
	number = count-(currentPage-1)*pageSize;
%>

<br />

<form action="visitorPro.jsp" method="post" onsubmit="return check();">
	<table border="1" width="700" align="center">
		<tr>
			<th colspan="4"><h1><%= owner %> 방명록</h1>
				<input type="hidden" name="owner" value=<%= owner %> />
				<input type="hidden" name="pageNum" value="<%=pageNum%>"/>
			</th>
		</tr>					
		<tr>
			<td>아이디</td>
			<td>
				<%=id%>
				<input type="hidden" name="id" value=<%=id%>>
			</td>
						
			<td>비밀번호</td>
			<td>
				<input type="password" name="pw">
			</td>
		</tr>
				
		<tr>
			<td colspan="4">
				<textarea rows="10" cols="90" name="content" placeholder="내용을 작성해주세요!"></textarea>
			</td>
		</tr>
		
		<tr>
			<td colspan="4" align="center">
				<input type="submit" value="등록">
				<input type="reset" value="다시입력">
				<input type="button" value="게시판" onclick="window.location='/team03/freeBoard/list.jsp'">
				<input type="button" value="메인으로" onclick="window.location='/team03/main.jsp'">
			</td>
		</tr>
	</table>
</form>
	
	<br />
	<br />

		<form>
			<table width="700">
				<tr>
					<% if(count == 0){ %> 
					<td colspan="4"> 방명록이 없습니다! </td>
				</tr>
					<% }else{ 
						
						 for(VisitorDTO dto : list) { %>
									<tr>
									<td width="100" align="center">
										<h5><%=dto.getReg()%></h5>
										<strong><font color="red"><h5>No.<%=number--%></h5></font></strong>
										<h3><font color="blue"><%=dto.getId()%></font></h3>
									</td>
									<th align="left"> <%=dto.getContent()%> </th>
									<th width="90">
										<input type="button" value="삭제하기" onclick="window.location='deleteForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
										<br /><br />
										<input type="button" value="수정하기" onclick="window.location='updateForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" >
										<input type="hidden" name="owner" value="<%= dto.getOwner() %>" />
									</th>
								 </tr>
						<% } %>	
					<% } %>0
					
				 <tr>
					<td width="90" align="center"><strong>페이지</strong></td>
					<td colspan="2">
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
									<a href="visitorForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&pageNum=<%=startPage-10%>">[이전]</a>
							   	<% }
								for(int i = startPage ; i <= endPage ; i++){ %>
							   		<a href="visitorForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&pageNum=<%=i%>">[<%=i%>]</a>
							    <% }
								if(endPage < pageCount){ %>
									<a href="visitorForm.jsp?owner=<%=URLEncoder.encode(owner, "UTF-8")%>&pageNum=<%=startPage+10%>">[다음]</a>
								<% }
							 } %>
						</td>
					</tr>
			</table>
		</form>		
	</body>	
</html>