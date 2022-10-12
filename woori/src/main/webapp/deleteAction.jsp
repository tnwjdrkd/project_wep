<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
		int brdID = 0;    // 게시글 번호 초기화
		if (request.getParameter("brdID") != null) {
			brdID = Integer.parseInt(request.getParameter("brdID"));
		}
		if(brdID == 0) {   // 번호 존재하지 않다면 오류 메시지 출력
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 게시글입니다.')");      
			script.println("location.href='main.jsp'");   
			script.println("</script>");
		}
		String mtID = null;
		if(request.getParameter("mtID") != null) {
			mtID = (String)request.getParameter("mtID");
		}
		Board brd = new BoardDAO().getBoard(brdID);  // brdID 값으로 해당 글을 가져온다.
		if(!userID.equals(brd.getUserID())) {  // 글 작성자 확인
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제 권한이 없습니다.')");      
			script.println("location.href='main.jsp'");   
			script.println("</script>");
		} else {
				BoardDAO brdDAO = new BoardDAO();    // 데이터베이스 접근 객체 생성
				int result = brdDAO.delete(brdID);
				if (result == -1) {    // DB 에러
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					if(mtID == null) script.println("location.href = 'main.jsp'");
					else script.println("location.href = 'meeting.jsp?mtID=" + mtID + "'");
					script.println("</script>");
				}
		}
	%>
</body>
</html>