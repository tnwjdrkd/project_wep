<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   <%-- script 문장을 실행할 수 있도록 하는 라이브러리 --%>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<head>
    <title>게시글 작성</title>
    <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
    <style>
        * {
            font-family: '빙그레체' , 'Malgun Gothic' , Gothic, sans-serif;
        }
        #writemenu {
            width: 500px; margin: 0 auto;
        }
        h1{
            color:  rgb(138, 111, 111);
            text-align: center;
            text-shadow: 2px 2px 1px rgb(194, 157, 157);
        }
        #submit {
            cursor: pointer;
            background:rgb(204, 180, 180);
            border:1px solid rgb(158, 158, 158);
            border-radius: 3px;
            font-size: 15px;
        }
        #submit:hover{
            color:white;
        }
        #submitbtn{
            width: 100px; margin: 0 auto;
        }
        /* 반응형_스마트폰*/
        @media screen and (max-width:767px){
        body{ width: auto }
        }
    </style>
</head>
<body>
	<% 
		String userID = null;  // 로그인 세션 관리 
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		if(userID == null) {   // 비로그인 시 로그인페이지로 이동
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");      
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
		Board brd = new BoardDAO().getBoard(brdID);  // brdID 값으로 해당 글을 가져온다.
		if(!userID.equals(brd.getUserID())) {  // 글 작성자 확인
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정 권한이 없습니다.')");      
			script.println("location.href='main.jsp'");   
			script.println("</script>");
		}
	%>
    <div id="writemenu">
        <h1>게시글 수정</h1>
        <form method="post" action="updateAction.jsp?brdID=<%= brdID %>">
            <table id="bbwrite">
                <tr>
                    <td><label for="title">제목</label></td>
                    <td><input id="title" type="text" name="brdTitle" style="width:400px;" autofocus="autofocus" value="<%= brd.getBrdTitle() %>"></td>
                </tr>
                <tr>
                    <td><label for="content">내용</label></td>
                    <td><textarea id="content" type="text" name="brdContent" style="width:400px;  height:400px;"><%= brd.getBrdContent() %></textarea></td>
                </tr>
            </table>
            <br>
            <div id="submitbtn">
        	<input id="submit" type="submit" name="submit" style="width:100px;" value="등록">
    		</div>
        </form>
    </div>
</body>