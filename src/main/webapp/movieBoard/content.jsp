<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.MovieDAO" %>
<%@ page import = "team03.bean.MovieCommentDAO" %>
<%@ page import = "team03.bean.MovieCommentDTO" %>
<%@ page import = "java.util.Random"%>
<%@ page import = "java.util.List"%>
<%@ page import = "java.net.URLEncoder"%>

<jsp:useBean class = "team03.bean.MovieDTO" id = "dto" />
<jsp:setProperty property = "num" name = "dto" />

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
	
	// 대댓글 함수
	function reComment(boardNum, num, re_step, re_level){
		window.name = "ParentForm";
		window.open("reCommentForm.jsp?boardNum="+boardNum+"&num="+num+"&re_step="+re_step+"&re_level="+re_level,
					"reCommentForm", "width=570, height=350, resizable = no, scrollbars = no");
		
	}
	
	// 댓글 작성시 내용, 비밀번호 입력값이 없을 시 띄우는 경고창 (유효성 검사)
	function nullCheck(){
		pwVal = document.getElementsByName("pw")[0].value;
		contentVal = document.getElementsByName("content")[0].value;
		
		if(pwVal == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		if(contentVal == ""){
			alert("내용을 작성해주세요.");
			return false;
		}
	}
	
</script>


<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	
	if(kid != null) {
		// kid에 값이 존재할 때
		kid = "카카오" + kid;
	}

	String pageNum = request.getParameter("pageNum");
	
	if (pageNum == null) {
		pageNum = "1";
	}
	
	MovieDAO dao = MovieDAO.getInstance();
	dao.readCountUp(dto);
	
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
		<td> 카테고리 </td>
		<td colspan = "4"> <%=dto.getKategorie() %></td>
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
	
<%
	if(kid == null){
		// kid 에 정보가 없고
		if(id == null){
			// kid, id에 정보가 없을 경우 = 익명
			// 개시글 작성자가 익명일 때 표시되는 항목
			if(dto.getPw() != null){ 
				// dto에 있는 pw값이 있을 경우 => 익명
				%>
				<tr id="center">
					<td style="width: 5%;" colspan="2">
						<input type="button" value="글 수정"
							onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
						<input type="button" value="글 삭제"
							onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
					</td>
					<td style="width: 90%;" colspan="2" >
						<input type="button" value="글 목록"
							onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
					</td>
				</tr>
			<%}
			
		} else {
			// 게시글 작성자가 회원이고, 회원의 id세션이 작성자와 같을 때 표시되는 항목
			if(id.equals(dto.getWriter())){ %>
					<tr id="center">
						<td style="width: 5%;" colspan="2">
							<input type="button" value="글 수정"
								onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
							<input type="button" value="글 삭제"
								onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
						</td>
						<td style="width: 90%;" colspan="2">
							<input type="button" value="글 목록"
								onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
						</td>
					</tr>
			<%} else { 
			// 게시글 작성자가 회원이지만, 회원의 id세션이 작성자와 같이 않을 때 표시되는 항목 %>
				<tr id="center">
					<td colspan="4">
						<input type="button" value="글 목록"
							onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
					</td>
				</tr>
			<%}
		}
	} else {
		// 게시글 작성자가 카카오 회원이고, 카카오 회원의 kid세션이 작성자와 같을 때 표시되는 항목
		if(kid.equals(dto.getWriter())){ %>
		<tr id="center">
			<td style="width: 5%;" colspan="2">
				<input type="button" value="글 수정"
					onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
				<input type="button" value="글 삭제"
					onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
			</td>
			<td style="width: 90%;" colspan="2">
				<input type="button" value="글 목록"
					onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
			</td>
		</tr>
	<%} else { 
	// 게시글 작성자가 카카오 회원이지만, 카카오 회원의 kid세션이 작성자와 같이 않을 때 표시되는 항목 %>
		<tr id="center">
			<td colspan="4">
				<input type="button" value="글 목록"
					onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
			</td>
		</tr>
	
	<%}
}
	if (kid == null) {
		if (id == null) {
			if ( dto.getPw() == null) { 
				// 익명인데 pw가 없을 경우 => id, kid로 작성된 글일 경우
			%>
			
				<tr id="center">
				<td style="width: 90%;" colspan="4">
					<input type="button" value="글 목록"
						onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
				</td>
			</tr>
			<%}
			}
		}%>

		

</table>

<br/>
<%-- 댓글 작성 --%>
<%	
	// 댓글 작성자 writer 변수 선언
	String writer;


	// kid 가 null 일 때
	if (kid == null) {
		// id 가 null 일 때
		if (id == null) {
			Random r = new Random();
			writer = "익명" + r.nextInt(10000);
		} else {
			// id 가 null 이 아닐 떄
			// writer 에 id 대입
			writer = id;
		}
	} else {
		// kid 가 null 이 아닐 때
		// writer 에 kid 대입
		writer = kid;
	}
	
	// 페이징 처리
	int pageSize = 20;
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1; // 결과 = 11
	int end = currentPage * pageSize; // 결과 = 20
	int count = 0;
	
	String num = request.getParameter("num");
	
	List<MovieCommentDTO> list = null;
	MovieCommentDAO MCdao = MovieCommentDAO.getInstance();
	
	count = MCdao.countComment(Integer.parseInt(num));
	if (count > 0) {
		list = MCdao.getAllComment(Integer.parseInt(num), start, end);
	}
%>

<%-- 게시글에서 댓글을 작성할 수 있는 폼을 작성하고 값(피아미터)를 넘김 --%>
<form action = "commentPro.jsp" method = "post" onsubmit="return nullCheck();">
	<table id = "center">
		<tr>
			<th colspan = "5">
				댓글 작성
				<input type = "hidden" name = "num" value = "<%=num %>" />
				<input type = "hidden" name = "pageNum" value = "<%=pageNum %>"/>
			</th>
		</tr>
		<tr>
			<td> 작성자 </td>
			<td colspan = "3" >
				<%= writer%>
				<input type = "hidden" name = "writer" value = "<%=writer %>" />
			</td>
		</tr>
		<%-- kid랑 id가 null 일때 처리(익명사용자) --%>
		<% if (kid == null && id == null ) { %>
			<tr>
				<td> 비밀번호 </td>
				<td colspan = "3" >
				<input type = "password" name = "pw" /> 
				</td>
			</tr>
		<% } %>
			<tr>
				<td colspan = "5" >
					<textarea rows="4" cols="40" name = "content" placeholder="내용을 작성해주세요" >
					</textarea>
				<br/>
					<input type = "submit" value = "댓글작성" />
				</td>
			</tr>
	</table>
</form>
<br/>

<table style="text-align: left;">
	<tr>
		<% if ( count == 0) { %>
			<td colspan = "5" > 댓글이 없습니다. </td>
	</tr>
		<% } else { %>
	<tr>
		<th colspan = "5"> 댓글 </th>
	</tr>
	<tr>
		<% for (MovieCommentDTO MCdto : list) { %>
				<td>
					<div>
							<% if(MCdto.getRe_level() > 0){ %>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<img src="images/re.gif">
							<% }
								if(MCdto.getWriter().contains("익")) { %>
								<%=MCdto.getWriter()%>
							<% } else { %>
									<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(MCdto.getWriter(), "UTF-8")%>">
										<%=MCdto.getWriter()%>
									</a>
								<% } %>
					</div>
				</td>
				<td width = "2oo">
					<div>
						<%= MCdto.getContent()%>
					</div>
				</td>
					<td height="80" style="font-size: 13;">
						<div>
							<%if(kid != null){
								// kid의 값이 있고
								if(kid.equals(MCdto.getWriter())){ 
									// 로그인 되어있는 kid의 세션값과 작성자의 명이 같으면 
									%>
									<p><a href="#" onclick="updateComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>)">[수정]</a></p>
									<p><a href="#" onclick="deleteComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>)">[삭제]</a></p>
							<%	}
							} %>
									
							<%if(id != null){
								if(id.equals(MCdto.getWriter())){ %>	
									<p><a href="#" onclick="updateComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>)">[수정]</a></p>
									<p><a href="#" onclick="deleteComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>)">[삭제]</a>	</p>						
							<%	}
							} %>
									
							<%if(MCdto.getPw() != null){ %>		
								<p><a href="#" onclick="updateComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>)">[수정]</a></p>
								<p><a href="#" onclick="deleteComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>)">[삭제]</a>	</p>						
							<% } %>
								<p><a href="#" onclick="reComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=MCdto.getRe_step()%>, <%=MCdto.getRe_level()%>)">
									[답글]
								</a></p>
					</div>
				</td>
			</tr>
		<% } 
		}%>
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
	