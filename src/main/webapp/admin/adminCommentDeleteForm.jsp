<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.CommentDTO" %>
<%@ page import="team03.bean.LocalBoardCommentDTO" %>
<%@ page import="team03.bean.MovieCommentDTO" %>
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
	#parent{
		margin: 5px auto;
		width: 90%;
	}
</style>

<head>

<title>관리자용 댓글 모아보기</title>
<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
</head>

<script type="text/javascript">
	
	// 자유게시판 댓글 삭제 함수
	function deleteComment(CboardNum, Cnum, pageNum){
		window.name="ParentForm";
		window.open("adminCommentDeletePro.jsp?CboardNum="+CboardNum+"&Cnum="+Cnum+"&pageNum"+pageNum,
					"CdeleteForm", "width=300, height=150, resizable = no, scrollbars = no");
	}
	
	// 지역게시판 댓글 삭제 함수
	function localDeleteComment(LboardNum, Lnum, pageNum){
		window.name="ParentForm";
		window.open("adminCommentDeletePro.jsp?LboardNum="+LboardNum+"&Lnum="+Lnum+"&pageNum"+pageNum,
					"LdeleteForm", "width=300, height=150, resizable = no, scrollbars = no");
	}
	
	// 영화게시판 댓글 삭제 함수
	function movieDeleteComment(MboardNum, Mnum, pageNum){
		window.name="ParentForm";
		window.open("adminCommentDeletePro.jsp?MboardNum="+MboardNum+"&Mnum="+Mnum+"&pageNum"+pageNum,
					"MdeleteForm", "width=300, height=150, resizable = no, scrollbars = no");
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
	
	
	AdminDAO dao = AdminDAO.getInstance();
	List<CommentDTO> list = null;
	
	count = dao.commentCount();
	if(count > 0){
		list = dao.getAllComment(start, end);
	}
	
%>
<center>
		<input type="button" value="메인으로 돌아가기"
		onclick="window.location='/team03/main.jsp'" />
		<input type="button" value="관리자페이지로 돌아가기"
		onclick="window.location='/team03/admin/adminMain.jsp'" />
</center>
<div id = "parent">
	<div style="float: left; width: 33%;">
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
	</div>
	
	<%
		int LCcount = 0;
	
		List<LocalBoardCommentDTO> LClist = null;
		
		LCcount = dao.LocalCommentCount();
		if(LCcount > 0){
			LClist = dao.getLocalComment(start, end);
		}
	%>
	
	<div style="float: left; width: 33%;">
		<table style="text-align: left;">
			<tr>
				<% if(count == 0){ %>
					<th colspan="3">댓글이 없습니다.</th>
			</tr>
				<% } else { %>
			<tr>
				<th colspan="3">지역게시판 댓글</th>
			</tr>
			<tr>
				<%	for(LocalBoardCommentDTO dto : LClist){ %>
						<td style="font-size: 13;">
							<div>
							<%
								if(dto.getRe_level() > 0){
									for(int i = 0; i < dto.getRe_level(); i++){ %>
										&nbsp;&nbsp;&nbsp;&nbsp;
								<%	} %>
								<img src="/team03/freeBoard/images/re.gif">
							<%	}
								
								if(dto.getWriter().contains("익")) { %>
									<%=dto.getWriter()%>
								<%} else { %>
										<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>">
											<%=dto.getWriter()%>
										</a>
								<%}%>
							</div>
							</td>	
						
							<td width="200">
								<div>
									<%= dto.getContent() %>
								</div>
							</td>
						
							<td height="80" style="font-size: 13;">
								<div>
									<p><a href="#" onclick="localDeleteComment(<%=dto.getBoardNum()%>, <%=dto.getNum()%>, <%=pageNum%>)">댓글 삭제</a></p>
							</div>
						</td>
					</tr>
				<%	} 
				}  %>
		</table>
		
		<div id="center">
		<%
			// 페이지 정렬
			if(LCcount > 0){
				int pageCount = LCcount / pageSize + (LCcount % pageSize == 0 ? 0 : 1);
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
	</div>
	
	<%
		int MCcount = 0;
	
		List<MovieCommentDTO> MClist = null;
		
		MCcount = dao.MovieCommentCount();
		if(MCcount > 0){
			MClist = dao.getMovieComment(start, end);
		}
	%>
	
	<div style="float: left; width: 33%;">
		<table style="text-align: left;">
			<tr>
				<% if(count == 0){ %>
					<th colspan="3">댓글이 없습니다.</th>
			</tr>
				<% } else { %>
			<tr>
				<th colspan="3">영화게시판 댓글</th>
			</tr>
			<tr>
				<%	for(MovieCommentDTO dto : MClist){ %>
						<td style="font-size: 13;">
							<div>
							<%
								if(dto.getRe_level() > 0){
									for(int i = 0; i < dto.getRe_level(); i++){ %>
										&nbsp;&nbsp;&nbsp;&nbsp;
								<%	} %>
								<img src="/team03/freeBoard/images/re.gif">
							<%	}
								
								if(dto.getWriter().contains("익")) { %>
									<%=dto.getWriter()%>
								<%} else { %>
										<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>">
											<%=dto.getWriter()%>
										</a>
								<%}%>
							</div>
							</td>	
						
							<td width="200">
								<div>
									<%= dto.getContent() %>
								</div>
							</td>
						
							<td height="80" style="font-size: 13;">
								<div>
									<p><a href="#" onclick="movieDeleteComment(<%=dto.getBoardNum()%>, <%=dto.getNum()%>, <%=pageNum%>)">댓글 삭제</a></p>
							</div>
						</td>
					</tr>
				<%	} 
				}  %>
		</table>
		
		<div id="center">
		<%
			// 페이지 정렬
			if(MCcount > 0){
				int pageCount = MCcount / pageSize + (MCcount % pageSize == 0 ? 0 : 1);
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
	</div>
</div>
<%}%>