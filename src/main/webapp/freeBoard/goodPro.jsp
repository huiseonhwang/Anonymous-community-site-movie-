<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.BoardDAO" %>
<%@ page import="team03.bean.GoodbadDAO" %>
<%@ page import="team03.bean.GoodbadDTO" %>

<jsp:useBean class="team03.bean.BoardDTO" id = "dto" />
<jsp:setProperty property="*" name = "dto" />

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-자유게시판</title>
</head>

<%! //전역변수(클래스에 선언한 변수) 선언

// 사용자의 IP 주소를 가져오는 코드
String getClientIP(HttpServletRequest request) {

  String ip = request.getHeader("X-FORWARDED-FOR"); 
     
  if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
    ip= request.getHeader("Proxy-Client-IP");
  }

  if (ip == null || ip.length() == 0|| "unknown".equalsIgnoreCase(ip)) {
    ip= request.getHeader("WL-Proxy-Client-IP");  
  }

  if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
      ip = request.getHeader("HTTP_CLIENT_IP"); 
  } 
  
  if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
      ip = request.getHeader("HTTP_X_FORWARDED_FOR"); 
  }
  
  if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
      ip = request.getHeader("X-Real-IP"); 
  }
  
  if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
      ip = request.getHeader("X-RealIP"); 
  }
  
  if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) { 
      ip = request.getHeader("REMOTE_ADDR");
  }
  
  if (ip == null || ip.length() == 0|| "unknown".equalsIgnoreCase(ip)) {
    ip= request.getRemoteAddr() ;
  }
     
  return ip;
}

%>

<%
	// content.jsp 에서 넘겨받은 boardName(게시판 이름)과 페이지 번호, 게시글 번호
	String freeBoard = request.getParameter("boardName");
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
	
	Random r = new Random();
	String writer = "익명"+r.nextInt(100000);
	
	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	
	GoodbadDTO Gdto = new GoodbadDTO();
	GoodbadDAO GBdao = GoodbadDAO.getInstance();
	// 공감/비공감 DTO, DAO를 각각 객체생성, 호출한 후 Gdto 변수에 GoodBad 데이터베이스 값을 가져오는 메소드 호출  
	Gdto = GBdao.getUserInfo(num, freeBoard);
	
	if(id != null){
		writer = id;
	}
	if(kid != null){
		writer = kid;
	}
	
	// Gdto(GoodBad 데이터베이스)내에 값이 없을 시 (공감/비공감을 누른 사용자가 한 명도 없을 시)
	if(Gdto == null){
		if(kid == null){
			if(id == null){
				// 게시글 번호와 사용자의 IP, 작성자명(익명), 게시판 이름을 Insert 해주는 메소드를 호출
				int GBResult = GBdao.check(num, getClientIP(request), writer, freeBoard);
				
				// 데이터베이스에 값이 정상적으로 들어갔을 시
				if(GBResult == 1){
					// BoardDAO를 호출한 후 공감 카운트를 올려주는 메소드를 호출
					BoardDAO dao = BoardDAO.getInstance();
					int result = dao.goodCountUp(dto);
					
					if(result == 1) { %>
					<script>
						alert("공감완료");
						window.location="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>";
					</script>
					<%}
				}
			} else {
				// 게시글 번호와 사용자의 IP, 작성자명(id), 게시판 이름을 Insert 해주는 메소드를 호출
				int GBResult = GBdao.check(num, getClientIP(request), writer, freeBoard);
				
				// 데이터베이스에 값이 정상적으로 들어갔을 시
				if(GBResult == 1){
					// BoardDAO를 호출한 후 공감 카운트를 올려주는 메소드를 호출
					BoardDAO dao = BoardDAO.getInstance();
					int result = dao.goodCountUp(dto);
					
					if(result == 1) { %>
					<script>
						alert("공감완료");
						window.location="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>";
					</script>
					<%}
				}
			}
		} else {
			// 게시글 번호와 사용자의 IP, 작성자명(kid), 게시판 이름을 Insert 해주는 메소드를 호출
			int GBResult = GBdao.check(num, getClientIP(request), writer, freeBoard);
			
			// 데이터베이스에 값이 정상적으로 들어갔을 시
			if(GBResult == 1){
				// BoardDAO를 호출한 후 공감 카운트를 올려주는 메소드를 호출
				BoardDAO dao = BoardDAO.getInstance();
				int result = dao.goodCountUp(dto);
				
				if(result == 1) { %>
				<script>
					alert("공감완료");
					window.location="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>";
				</script>
				<%}
			}
		}
	// Gdto(GoodBad 데이터베이스)내에 값이 이미 들어가 있을 시 (이미 공감/비공감을 누른 사용자가 있을 시)
	} else {
		if(kid == null){
			if(id == null){
					// 익명 사용자일 때
					// Gdto(GoodBad 데이터베이스) 내에 저장된 사용자의 IP와 실사용자의 IP를 비교해서 서로가 같을 때
					if(getClientIP(request).equals(Gdto.getIp())){%>
						<script>
							alert("공감/비공감은 한 번만 가능합니다.");
							window.location="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>";
						</script>
				<%	// Gdto(GoodBad 데이터베이스) 내에 저장된 사용자의 IP와 실사용자의 IP를 비교해서 서로가 다를 때
					}else{
						// 게시글 번호와 사용자의 IP, 작성자명(익명), 게시판 이름을 Insert 해주는 메소드를 호출
						int GBResult = GBdao.check(num, getClientIP(request), writer, freeBoard);
						
						// 데이터베이스에 값이 정상적으로 들어갔을 시
						if(GBResult == 1){
							// BoardDAO를 호출한 후 공감 카운트를 올려주는 메소드를 호출
							BoardDAO dao = BoardDAO.getInstance();
							int result = dao.goodCountUp(dto);
							
							if(result == 1) { %>
							<script>
								alert("공감완료");
								window.location="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>";
							</script>
							<%}
						}
					}
				
			} else {
				// id 세션일 때
				// Gdto(GoodBad 데이터베이스) 내에 저장된 사용자의 이름과 실사용자의 ID를 비교해서 서로가 같을 때
				if(id.equals(Gdto.getWriter())){%>
					<script>
						alert("공감/비공감은 한 번만 가능합니다.");
						window.location="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>";
					</script>
			<%	// Gdto(GoodBad 데이터베이스) 내에 저장된 사용자의 이름과 실사용자의 ID를 비교해서 서로가 다를 때	
				} else {
					// 게시글 번호와 사용자의 IP, 작성자명(id), 게시판 이름을 Insert 해주는 메소드를 호출
					int GBResult = GBdao.check(num, getClientIP(request), writer, freeBoard);
					
					// 데이터베이스에 값이 정상적으로 들어갔을 시
					if(GBResult == 1){
						// BoardDAO를 호출한 후 공감 카운트를 올려주는 메소드를 호출
						BoardDAO dao = BoardDAO.getInstance();
						int result = dao.goodCountUp(dto);
						
						if(result == 1) { %>
						<script>
							alert("공감완료");
							window.location="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>";
						</script>
						<%}
					}
				}
			}
		} else {
			// kid 세션일 때
			// Gdto(GoodBad 데이터베이스) 내에 저장된 사용자의 이름과 실사용자의 KID를 비교해서 서로가 같을 때
			if(kid.equals(Gdto.getWriter())){%>
				<script>
					alert("공감/비공감은 한 번만 가능합니다.");
					window.location="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>";
				</script>
			<%	// Gdto(GoodBad 데이터베이스) 내에 저장된 사용자의 이름과 실사용자의 KID를 비교해서 서로가 다를 때
			} else {
				// 게시글 번호와 사용자의 IP, 작성자명(kid), 게시판 이름을 Insert 해주는 메소드를 호출
				int GBResult = GBdao.check(num, getClientIP(request), writer, freeBoard);
				
				// 데이터베이스에 값이 정상적으로 들어갔을 시
				if(GBResult == 1){
					// BoardDAO를 호출한 후 공감 카운트를 올려주는 메소드를 호출
					BoardDAO dao = BoardDAO.getInstance();
					int result = dao.goodCountUp(dto);
					
					if(result == 1) { %>
						<script>
							alert("공감완료");
							window.location="content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>";
						</script>
					<%}
				}
			}
		}
	}
	
%>
