<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="meeting.MeetingDAO" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="meeting" class="meeting.Meeting" scope="page" />
<jsp:setProperty name="meeting" property="mtCategory"/>
<jsp:setProperty name="meeting" property="mtID"/>
<jsp:setProperty name="meeting" property="mtSummary"/>
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
		} else {
			if(meeting.getMtCategory() == null || meeting.getMtID() == null || meeting.getMtSummary() == null) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('빈 칸을 모두 입력해주세요.')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						MeetingDAO mtDAO = new MeetingDAO();
						BoardDAO brdDAO = new BoardDAO();
						int result = mtDAO.makeMeeting(meeting.getMtID(), meeting.getMtAddress(), meeting.getMtCategory()
								, brdDAO.getuserNickname(userID), meeting.getMtSummary());
						if (result == -1) {    // DB 에러
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('중복된 모임 이름이 존재합니다.')");
							script.println("history.back()");
							script.println("</script>");
						} else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'main.jsp'");
							script.println("</script>");
						}
		}
		
		}
	%>
</body>
</html>