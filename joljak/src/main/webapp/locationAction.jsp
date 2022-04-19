<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%!
	String add;
%>
<%
	request.setCharacterEncoding("EUC-KR");
	add = request.getParameter("Addr");
%>
<%= add%>
</body>
</html>