<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.List"%>
<%@ page import="team03.bean.BoardDAO" %>
<%@ page import="team03.bean.CommentDAO" %>
<%@ page import="team03.bean.CommentDTO" %>

<jsp:useBean class="team03.bean.BoardDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />

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
	
	//댓글 수정 함수
	function updateComment(boardNum, num, pageNum){
		window.name = "ParentForm";
		window.open("commentUpdateForm.jsp?boardNum="+boardNum+"&num="+num+"&pageNum="+pageNum,
					"updateForm", "width=570, height=350, resizable = no, scrollbars = no");
	}
	
	// 댓글 삭제 함수
	function deleteComment(boardNum, num, pageNum){
		window.name = "ParentForm";
		window.open("commentDeleteForm.jsp?boardNum="+boardNum+"&num="+num+"&pageNum="+pageNum,
					"deleteForm", "width=570, height=350, resizable = no, scrollbars = no");
	}
	
	// 답글 함수
	function reComment(boardNum, num, re_step, re_level){
		window.name = "ParentForm";
		window.open("reCommentForm.jsp?boardNum="+boardNum+"&num="+num+"&re_step="+re_step+"&re_level="+re_level,
					"reCommentForm", "width=570, height=350, resizable = no, scrollbars = no");
		
	}
	
</script>

<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	kid = "카카오"+kid;

	String pageNum = request.getParameter("pageNum");
	
	BoardDAO dao = BoardDAO.getInstance();
	dao.readcountUp(dto);
	
	dto = dao.getContent(dto);
%>

<table id="center">
	<tr>
		<th colspan="4"> <a href="list.jsp"> 게시글 </a> </th>
	</tr>
	<tr>
		<td> 작성자 </td>
		<td> <%= dto.getWriter() %> </td>
		<td> 조회수 </td>
		<td> <%= dto.getReadcount() %> </td>
	</tr>
	<tr>
		<td> 제목 </td>
		<td colspan="4"> <%= dto.getSubject() %> </td>
	</tr>
	<tr>
		<td style="padding-bottom: 300px;"> 내용 </td>
		<td colspan="4" style="padding-bottom: 300px;"> <%= dto.getContent() %> </td>
	</tr>
	<%if(dto.getFilename() != null){ %>
		<tr>
			<td> 첨부파일 </td>
			<td colspan="4">
				<a href="/team03/team03File/<%= dto.getFilename() %>">
					<%= dto.getFilename() %>
				</a>
			</td>
		</tr>
<%	} else { %>
		<tr>
			<td colspan="4">
				[첨부파일 없음]
			</td>
		</tr>
<%	} %>
	<tr>
		<td> <input type="button" value="공감"
				onclick="window.location='goodPro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
		<td> <%= dto.getGood() %> </td>
		<td> <input type="button" value="비공감"
				onclick="window.location='badPro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
		<td> <%= dto.getBad() %> </td>
	</tr>
	<tr>
		<%
		if(kid != null){
			if(kid.equals(dto.getWriter())){ %>
				<td> <input type="button" value="글 수정"
						onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
				<td> <input type="button" value="글 삭제"
						onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
		<%	}
			
			if(id != null){
				if(id.equals(dto.getWriter())){ %>
					<td> <input type="button" value="글 수정"
							onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
					<td> <input type="button" value="글 삭제"
							onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
		<%		}
			} 
			if(dto.getPw() != null){ %>
				<td> <input type="button" value="글 수정"
						onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
				<td> <input type="button" value="글 삭제"
						onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
				</td>
		<%	} 
		
		} %>
		
		<td style="text-align: right;" colspan="4">
					<input type="button" value="글 목록"
						onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
		</td>
	</tr>
</table>

<br/>
<%-- 댓글 작성 --%>
<%
	// 위쪽에서 kid에 "카카오" String을 대입해놓으면 아래의 코드에서 에러가 나서 익명이어도 "카카오"가 대입되어서
	// 새로운 변수에 kid 세션 대입
	String kid2 = (String)session.getAttribute("kid");
	
	// 댓글 작성자 writer 변수 선언
	String writer;

	// kid(카카오 로그인)이 null일 때
	if(kid2 == null){
		// id(DB 로그인)이 null일 때
		if(id == null){
			// writer 변수에 익명+난수 대입
			Random r = new Random();
			writer = "익명"+r.nextInt(100000);	
		} else { //id(DB로그인)이 null이 아닐 때
			// writer에 id 대입
			writer = id;
		}
	} else { // kid(카카오 로그인)이 null이 아닐 때
		// writer에 kid 대입
		writer = "카카오"+kid2;
	}
	
	// 페이징 처리
	int pageSize = 20;
	
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1; // 결과 = 11
	int end = currentPage * pageSize; // 결과 = 20
	int count = 0;
 	
	String num = request.getParameter("num");
	
	List<CommentDTO> list = null;
	CommentDAO Cdao = CommentDAO.getInstance();
	
	count = Cdao.countComment(Integer.parseInt(num));
	if (count > 0){
		list = Cdao.getAllComment(Integer.parseInt(num), start, end);
	}
	
%>
<%-- 컨텐츠 페이지 내에 폼태그를 작성하여 컨텐츠 페이지 내에서 댓글을 작성하고 파라미터를 넘김 --%>
<form action="commentPro.jsp" method="post">
	<table id="center">
		<tr>
			<th colspan="5">
				댓글 작성
				<input type="hidden" name="num" value="<%=num%>" />
				<input type="hidden" name="pageNum" value="<%=pageNum%>" />
			</th>
		</tr>
		<tr>
			<td> 작성자 </td>
			<td colspan="3">
				<%= writer %>
				<input type="hidden" name="writer" value="<%=writer%>" />
			</td>
		</tr>
		<%-- kid가 null이고 id가 null일 때 (익명 사용자일 때) --%>
		<%if(kid2 == null && id == null){ %>
			<tr>
				<td> 비밀번호 </td>
				<td colspan="3"> <input type="password" name="pw" /> </td>
			</tr>
		<%} %>
			<tr>
				<td colspan="5">
					<textarea rows="4" cols="40" name="content" placeholder="내용을 작성해주세요!"></textarea>
				<br/>
					<input type="submit" value="댓글작성" />
				</td>
			</tr>
	</table>
</form>
<br/>

<table style="text-align: left;">
	<tr>
		<% if(count == 0){ %>
			<td colspan="5">댓글이 없습니다.</td>
	</tr>
		<% } else { %>
	<tr>
		<%	for(CommentDTO Cdto : list){ %>
				<tr>
					<td>
						<div>
						<%
							if(Cdto.getRe_level() > 0){ %>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<img src="images/re.gif">
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
							<%if(kid != null){
								if(kid.equals(Cdto.getWriter())){ %>
									<p><a href="#" onclick="updateComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=pageNum%>)">[수정]</a></p>
									<p><a href="#" onclick="deleteComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=pageNum%>)">[삭제]</a></p>
							<%	}
							} %>
									
							<%if(id != null){
								if(id.equals(Cdto.getWriter())){ %>	
									<p><a href="#" onclick="updateComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=pageNum%>)">[수정]</a></p>
									<p><a href="#" onclick="deleteComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=pageNum%>)">[삭제]</a>	</p>						
							<%	}
							} %>
									
							<%if(Cdto.getPw() != null){ %>		
								<p><a href="#" onclick="updateComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=pageNum%>)">[수정]</a></p>
								<p><a href="#" onclick="deleteComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=pageNum%>)">[삭제]</a>	</p>						
							<% } %>
								<p><a href="#" onclick="reComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=Cdto.getRe_step()%>, <%=Cdto.getRe_level()%>)">
									[답글]
								</a></p>
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
			<a href="content.jsp?pageNum=<%=startPage-10%>">[이전]</a>
		<%}
		for(int i = startPage ; i <= endPage ; i++){
		%>	<a href="content.jsp?pageNum=<%=i%>">[<%=i%>]</a> 	
	  <%}
		if(endPage < pageCount){%>
		<a href="content.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
	  <%}	
	}
%>
</div>