<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.CommentDTO" %>
<%@ page import="team03.bean.CommentDAO" %>
<%@ page import="team03.bean.AdminDTO" %>
<%@ page import="team03.bean.AdminDAO" %>

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
	#center{
		text-align: center;
	}
</style>

<script type="text/javascript">
	
	// 댓글 삭제 함수
	function deleteComment(boardNum, num, pageNum){
		window.name="ParentForm";
		window.open("adminCommentDeletePro.jsp?boardNum="+boardNum+"&num="+num+"&pageNum"+pageNum,
					"deleteForm", "width=300, height=150, resizable = no, scrollbars = no");
	}
	
</script>

<%
String admin = (String)session.getAttribute("admin");
if(admin == null){ 
%>	<script>
		alert("잘못된 접근입니다.");
		window.location="/team03/main.jsp";
	</script>
<%	}else{
	
	String pageNum = request.getParameter("pageNum");

	if(pageNum == null){
		pageNum = "1";
	}
	
	int pageSize = 10;
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1;
	int end = currentPage * pageSize;
	
	int count = 0;
	
	
	AdminDAO Adao = AdminDAO.getInstance();
	List<CommentDTO> list = null;
	
	count = Adao.commentCount();
	if(count > 0){
		list = Adao.getAllComment(start, end);
	}
	
%>

<table style="text-align: left;">
	<tr>
		<% if(count == 0){ %>
			<th colspan="3">댓글이 없습니다.</th>
	</tr>
		<% } else { %>
	<tr>
		<th colspan="3">자유게시판 댓글</th>
	</tr>
	<tr>
		<%	for(CommentDTO Cdto : list){ %>
				<td style="font-size: 13;">
					<div>
					<%
						if(Cdto.getRe_level() > 0){
							for(int i = 0; i < Cdto.getRe_level(); i++){ %>
								&nbsp;&nbsp;&nbsp;&nbsp;
						<%	} %>
						<img src="/team03/freeBoard/images/re.gif">
					<%	}
						
						if(Cdto.getWriter().contains("익")) { %>
							<%=Cdto.getWriter()%>
						<%} else { %>
								<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(Cdto.getWriter(), "UTF-8")%>">
									<%=Cdto.getWriter()%>
								</a>
						<%}%>
					</div>
					</td>	
				
					<td width="200">
						<div>
							<%= Cdto.getContent() %>
						</div>
					</td>
				
					<td height="80" style="font-size: 13;">
						<div>
							<p><a href="#" onclick="deleteComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=pageNum%>)">댓글 삭제</a></p>
					</div>
				</td>
			</tr>
		<%	} 
		}  %>
</table>

<div id="center">
<%
	// 페이지 정렬
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		int startPage = (currentPage / 10) * 10 + 1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock-1;
		if(endPage > pageCount){
			endPage = pageCount;
		}	
		if(startPage > 10){%>
			<a href="adminCommentDeleteForm.jsp?pageNum=<%=startPage-10%>">[이전]</a>
		<%}
		for(int i = startPage ; i <= endPage ; i++){
		%>	<a href="adminCommentDeleteForm.jsp?pageNum=<%=i%>">[<%=i%>]</a> 	
	  <%}
		if(endPage < pageCount){%>
		<a href="adminCommentDeleteForm.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
	  <%}	
	}
%>
</div>

<%}%>