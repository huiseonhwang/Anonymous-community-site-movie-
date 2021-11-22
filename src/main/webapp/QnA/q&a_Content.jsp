<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.Q_DAO" %>

<jsp:useBean class="team03.bean.Q_DTO"  id="dto" /> 
<jsp:setProperty property="*" name="dto" />

<h2 align="center">Q&A</h2> 
<h5 align="center">- 문의사항을 남겨주세요</h5>

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
	String id = (String)session.getAttribute("id");
	String admin = (String)session.getAttribute("admin");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	Q_DAO dao = new Q_DAO();
	dto = dao.getQuestionContent(num);
	
	int ref = dto.getRef();
	int re_step = dto.getRe_step();
	int re_level = dto.getRe_level();	 
%>

<form>
	<table width="800" align="center">
		<tr>
			<td colspan="2" align="center">조회수&nbsp;<font color="red"><%=dto.getReadcount()%></font></td>
		</tr>
		<tr>
			<td width="85" align="center">제목</td>
			<td><%=dto.getSubject()%></td>
		</tr>
		<tr> 
			<td width="85" align="center">작성자</td>
			<td><%=dto.getId()%></td>
		</tr>
		<tr>
			<td colspan="2"><%=dto.getContent()%></td>
		<tr>
		
		<tr>
			<td colspan="4" align="center">
				<%if(admin != null){%> 
		        	<input type="button" value="답글쓰기"  
		             onclick="document.location.href='q&a_WriteForm.jsp?num=<%=num%>&ref=<%=ref%>&re_step=<%=re_step%>&re_level=<%=re_level%>'">
				<%}%>
					<input type="button" value="목록보기" 
					 onclick="document.location.href='q&a_List.jsp?pageNum=<%=pageNum%>'">
					 
					<input type="button" value="수정하기"
					onclick="document.location.href='q&a_UpdateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'"> 
					
					<input type="button" value="삭제하기"
					onclick="document.location.href='q&a_DeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
			 </td>
		 </tr>
	 </table>
 </form>
