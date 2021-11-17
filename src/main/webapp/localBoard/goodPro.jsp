<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LocalBoardDAO" %>
<%@ page import="team03.bean.GoodbadDAO" %>

<jsp:useBean class="team03.bean.LocalBoardDTO" id = "dto" />
<jsp:setProperty property="*" name = "dto" />

<%! //전역변수(클래스에 선언한 변수) 선언

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
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
	
	
	String writer = "사용자";
	
	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	
	if(id != null){
		writer = id;
	}
	if(kid != null){
		writer = kid;
	}
	
	GoodbadDAO GBdao = GoodbadDAO.getInstance();
	int GBResult = GBdao.check(num, getClientIP(request), writer);
	
	if(GBResult == 1){
		LocalBoardDAO dao = LocalBoardDAO.getInstance();
		int result = dao.LgoodCountUp(dto);
		
		if(result == 1) { %>
		<script>
			alert("공감완료");
			window.location="localContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>";
		</script>	
	<%	}  %>
<%	} else {%>
		<script>
			alert("공감/비공감은 한 번만 가능합니다.");
			window.location="localContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>";
		</script>
<%	}
%>