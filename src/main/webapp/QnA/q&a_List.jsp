<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.Q_DAO" %>
<%@ page import="team03.bean.Q_DTO" %>
<%@ page import="java.util.List" %>

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
    padding: 15px;
  }
  th:first-child, td:first-child {
    border-left: none;
  }
</style>

<%
	int pageSize = 10;

	String admin = (String)session.getAttribute("admin");
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1;
	int end = currentPage * pageSize;
	int count = 0;
	int number = 0;

	List QuestionList = null;
	
	Q_DAO dao = new	Q_DAO();
	count = dao.getQuestionCount();		
	if (count > 0) {
			QuestionList = dao.getQuestion(start, end);
	}

	number=count-(currentPage-1)*pageSize;
%>

<%
	if(count == 0){
%>
<table>
<tr>
	<td>
		저장된 글이 없습니다
	</td>
</tr>
</table>
<%}else{%>
<table>
<tr>
	<td>번호</td>
	<td>제목</td>
	<td>작성자</td>
	<td>작성일</td>
	<td>조회수</td>
</tr>

<%
	for(int i=0; i<QuestionList.size(); i++) {
   	Q_DTO dto = (Q_DTO)QuestionList.get(i);
%>

<tr>
	<td><%=number--%></td>

	<td>
		<%
			int wid = 0; 
			
		    if(dto.getRe_level() > 0){ 
		    		wid = 10 * dto.getRe_level();
		%>
		  <img src="/team03/QnA/images/level.gif" width="<%=wid%>" height="16">
		  <img src="/team03/QnA/images/re.gif">	
		<%}else{%>
		  <img src="/team03/QnA/images/level.gif" width="<%=wid%>" height="16">	
		<%}%>
		
		<a href="q&a_Content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
		<%=dto.getSubject()%></a>
	
	 	<% if(dto.getReadcount() >= 30){%>
	    <img src="/team03/QnA/images/hot.gif" border="0"  height="16"><%}%>  
     </td>
    
<td><%=dto.getId()%></td>
<td><%=dto.getReg()%></td>
<td><%=dto.getReadcount()%></td>
</tr>
<%}%>
<tr>
	<td colspan="5" align="center">
		<form action="q&a_SearchList.jsp" method="post">
			<select name="search">
				<option value="writer">작성자</option>
			</select>
			<input type="text" name="search">
			<input type="submit" value="검색">
		</form>
	</td>
</tr>
</table>
<%}%>
<table>
<tr>
	<td align="center">
	<%
	    if (count > 0) {
	        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
			 
	        int startPage = (int)(currentPage/10)*10+1;
			int pageBlock=10;
	        int endPage = startPage + pageBlock-1;
	        if (endPage > pageCount) endPage = pageCount;
	        
	        if (startPage > 10) {    %>
	        <a href="q&a_List.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
	<%      }
	        for (int i = startPage ; i <= endPage ; i++) {  %>
	        <a href="q&a_List.jsp?pageNum=<%= i %>">[<%= i %>]</a>
	<%
	        }
	        if (endPage < pageCount) {  %>
	        <a href="q&a_List.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
	<%
	        }
	    }
	%>
	</td>
</tr>
<tr>
	<td align="center">
		<input type="button" value="작성하기"  onclick="window.location='q&a_WriteForm.jsp'">
		<input type="button" value="메인으로"  onclick="window.location='/team03/main.jsp'">
	</td>
</tr>
</table>














