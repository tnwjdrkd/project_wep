<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="woori.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="woori.User" scope="page" />
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userBirth"/>
<jsp:setProperty name="user" property="userPhone"/>
<jsp:setProperty name="user" property="userAddress"/>
<jsp:setProperty name="user" property="userNickname"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리 동네 커뮤니케이션</title>
</head>
<body>
	<%
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
		|| user.getUserBirth() == null || user.getUserPhone() == null || user.getUserAddress() == null
		|| user.getUserNickname() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원정보를 모두 입력해주세요.')");
			script.println("history.back()");  // 이전 페이지로_join.jsp
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();    // 데이터베이스 접근 객체 생성
			int result = userDAO.join(user);
			if (result == -1) {    // DB 에러
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('중복된 아이디가 존재합니다.')");
				script.println("history.back()");  // 이전 페이지로_join.jsp
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'login.jsp'"); // 회원가입 완료 시 main.jsp로 이동
				script.println("</script>");
			}
		}
	%>
</body>
</html>