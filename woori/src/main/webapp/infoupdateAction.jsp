<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="woori.User" %>
<%@ page import="woori.UserDAO" %>
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
			script.println("alert('유효하지 않은 세션입니다.')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		User user = new UserDAO().getUser(userID);
			if(request.getParameter("userPassword") == null || request.getParameter("userName") == null || request.getParameter("userBirth") == null
				|| request.getParameter("userPhone") == null || request.getParameter("userAddress") == null ||  request.getParameter("userPhone") == null
					|| request.getParameter("userPassword").equals("") || request.getParameter("userName").equals("") || request.getParameter("userBirth").equals("")
						|| request.getParameter("userPhone").equals("") || request.getParameter("userAddress").equals("") ||  request.getParameter("userNickname").equals("")) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('빈 칸을 모두 입력해주세요.')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						UserDAO userDAO = new UserDAO();    // 데이터베이스 접근 객체 생성
						int result = userDAO.infoupdate(userID, request.getParameter("userPassword"), request.getParameter("userName"), request.getParameter("userBirth")
								, request.getParameter("userPhone"), request.getParameter("userAddress"), request.getParameter("userNickname"));
						if (result == -1) {    // DB 에러
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('회원정보 수정에 실패하였습니다.')");
							script.println("history.back()");
							script.println("</script>");
						} else {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('회원정보 수정을 완료하였습니다.')");
							script.println("location.href = 'main.jsp'");
							script.println("</script>");
						}
				}
		
	%>
</body>
</html>