<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.net.URLEncoder" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="member.Member" scope="page" />
<jsp:setProperty name="member" property="mbUser"/>
<jsp:setProperty name="member" property="mbGreet"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리 동네 커뮤니케이션</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {  // 세션 확인
			userID = (String) session.getAttribute("userID"); // 세션이 존재하면 userID에 해당 세션 값 부여
		}
		if(userID == null) {  // 세션이 부여된 상태
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인하세요.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		} 
		String mtID = null;
		if(request.getParameter("mtID") != null) {
			mtID = (String)request.getParameter("mtID");
		}
		if(mtID == null) {   // 모임 존재시 모임 페이지 조회가능
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 모임입니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		} else {
			if(member.getMbUser() == null || member.getMbGreet() == null) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('빈 칸을 모두 입력해주세요.')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						MemberDAO mbDAO = new MemberDAO();    // 데이터베이스 접근 객체 생성
						int result = mbDAO.memberjoin(mtID, member.getMbUser(), member.getMbGreet());
						if (result == -1) {    // DB 에러
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('모임 가입 오류가 발생하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						} else if (result == -2) {    // DB 에러
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('모임 가입 오류2가 발생하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						} else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'meeting.jsp?mtID=" + URLEncoder.encode(mtID, "UTF-8") + "'");
							script.println("</script>");
						}
		}
		
		}
	%>
</body>
</html>