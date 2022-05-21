<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page" />
<jsp:setProperty name="board" property="brdTitle"/>
<jsp:setProperty name="board" property="brdContent"/>
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
		} else {
			if(board.getBrdTitle() == null || board.getBrdContent() == null) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('빈 칸을 모두 입력해주세요.')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						BoardDAO brdDAO = new BoardDAO();    // 데이터베이스 접근 객체 생성
						int result = brdDAO.write(board.getBrdTitle(), userID, board.getBrdAddress(),
								mtID, brdDAO.getuserNickname(userID), board.getBrdContent(), board.getBrdCount());
						if (result == -1) {    // DB 에러
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('모임글쓰기 오류가 발생하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						} else if (result == -2) {    // DB 에러
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('모임글쓰기 오류2가 발생하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						} else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'meeting.jsp?mtID=" + mtID + "'");
							script.println("</script>");
						}
		}
		
		}
	%>
</body>
</html>