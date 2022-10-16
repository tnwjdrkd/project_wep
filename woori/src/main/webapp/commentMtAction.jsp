<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>  
<%@ page import="member.MemberDAO" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="woori.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="comment" class="comment.Comment" scope="page" />
<jsp:setProperty name="comment" property="cmtContent"/>
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
		int brdID = 0;			// 글번호 매개변수 관리
		if (request.getParameter("brdID") != null) {
			brdID = Integer.parseInt(request.getParameter("brdID"));
		}
		String mtID = null;
		if(request.getParameter("mtID") != null) {
			mtID = (String)request.getParameter("mtID");
		}
		MemberDAO mbr = new MemberDAO();
		UserDAO usr = new UserDAO();
		if(!mtID.equals(mbr.checkMember(usr.nick(userID), mtID))) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모임에 가입되어있지 않습니다.')");      
			script.println("history.back()");   
			script.println("</script>");
		}
		if(brdID == 0) {   // 글번호 존재시 특정 글 조회가능
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 게시글입니다.')");      
			script.println("location.href='main.jsp'");   
			script.println("</script>");
		} else {
			if(comment.getCmtContent() == null) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('빈 칸을 모두 입력해주세요.')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						BoardDAO brdDAO = new BoardDAO();
						CommentDAO cmtDAO = new CommentDAO();
						int result = cmtDAO.write(userID, brdID, comment.getBrdAddress(),
								brdDAO.getuserNickname(userID), comment.getCmtContent());
						if (result == -1) {    // DB 에러
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('댓글 오류가 발생하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						} else if (result == -2) {    // DB 에러
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('댓글 오류2가 발생하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						} else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("location.href = 'boardMtView.jsp?brdID=" + brdID + "&mtID=" + mtID + "'");
							script.println("</script>");
						}
					}
		}
	%>
</body>
</html>