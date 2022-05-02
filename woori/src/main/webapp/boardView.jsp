<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   <%-- script 문장을 실행할 수 있도록 하는 라이브러리 --%>
<%@ page import="board.Board" %> <%-- 실제 DB를 사용할 수 있도록, DB 접근 객체 또한 가져온다. --%>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <title>게시글</title>
        <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
        <!-- 초기화 -->
        <style>
            * {
                margin: 0; padding: 0;
                font-family: '빙그레체' , 'Malgun Gothic' , Gothic, sans-serif;
            }
            a { text-decoration: none; }
            li { list-style: none; }

            body {
            width: 1500px;
            margin: 0 auto;
            }
        </style>
        <!-- 본문 -->
        <style>
            #board {
                width: 500px;
                float: right;
                margin-top: 150px;
                padding-left: 35px;
                padding-right: 30px;
                border-left: 1px dotted #9c9c9c;
            }
            #board-aside {
                overflow: hidden;
            }
            h1 {
                margin-bottom: 20px;
                font-weight: 500;
                font-size: 30px;
            }
            h3 {
                font-weight: 500;
                font-size: 20px;
            }
        </style>
        <!-- 게시글 목록 -->
        <style>
            #bulletinboard {
              width: 100%;
              border-top: 1px solid #9b9b9b;
              border-collapse: collapse;
            }
            .bbline {
              border-bottom: 1px solid #9b9b9b;
              padding: 15px;
              text-align: center;
            }
        </style>
        <!-- 게시판 페이징 -->
        <style>
            #menu {
                width: 300px;
                margin: 0 auto;
            }
            .number-menu {
                list-style: none;
                display: inline-block;
                margin-top: 5px;
            }
            .inner-number {
                float: left;
            }
            .inner-number > a {
                margin: 3px;
                padding: 3px;
                border: 1px solid #9b9b9b;
                text-align: center;
                text-decoration:none;
                color: black;
            }
            .inner-number > a:hover {
                background:rgb(194, 157, 157);
                color: white;
            }
            #write:hover {
                color: white;
            }
        </style>
        <!-- 모임 -->
        <!-- 현재 게시글 -->
        <style>
            #post {
                width: 850px;
                float:left;
                margin-top: 150px;
                padding-left: 50px;
            }
            #content {
                padding: 15px 0 15px 0;
                border-bottom: 1px solid #c9c9c9;
                line-height: 170%;
            }
            #postinfo {
                border-top: 1px solid #c9c9c9;
                border-bottom: 1px solid #c9c9c9;
                padding: 15px 0 15px 0;
            }
            #comment {
                padding: 15px 0 10px 0;
            }
            #nickname{
                font-size: 15px;
                padding: 5px 0 5px 0;
            }
            #cc{
                font-size: 15px;
                padding-bottom: 7px;
            }
            #commentdate{
                font-size: 13px;
                color:#9b9b9b;
                border-bottom: 1px solid #c9c9c9;
                padding-bottom: 5px;
            }
            #contentdate{
                font-size: 14px;
                color:#9b9b9b;
            }
            #update {
                width:55px;
                height:35px;
                background:rgb(204, 180, 180);
                border:1px solid rgb(158, 158, 158);
                cursor: pointer;
            }
            #delete {
                width:55px;
                height:35px;
                background:rgb(204, 180, 180);
                border:1px solid rgb(158, 158, 158);
                cursor: pointer;
            }
            /* 반응형_스마트폰*/
            @media screen and (max-width:767px){
            body{ width: auto }
            #main-aside { width: auto; float: none;}
            }
        </style>
    </head>
    <body>
    	<% 
			String userID = null;    // 로그인 세션 관리
			if(session.getAttribute("userID") != null) {
				userID = (String)session.getAttribute("userID");
			}
			int pageNumber = 1; // 게시판 기본 페이지 설정
			if (request.getParameter("pageNumber") != null) {
				pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
			}
			int brdID = 0;			// 글번호 매개변수 관리
			if (request.getParameter("brdID") != null) {
				brdID = Integer.parseInt(request.getParameter("brdID"));
			}
			if(brdID == 0) {   // 글번호 존재시 특정 글 조회가능
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 게시글입니다.')");      
				script.println("location.href='main.jsp'");   
				script.println("</script>");
			}
			Board brd = new BoardDAO().getBoard(brdID); // 게시글 조회 인스턴스 생성
	    %>
        <aside id="board-aside">
            <div id="board">
                <h1>목록</h1>
                    <table id="bulletinboard">
                    	<tr>
                        	<td class="bbline">제목</td>
                            <td class="bbline">작성자</td>
                            <td class="bbline">작성일</td>
                            <td class="bbline">댓글수</td>
                        </tr>
                          	<%	// 게시글 출력 부분. 게시글을 뽑아올 수 있도록
								BoardDAO brdDAO = new BoardDAO(); // 인스턴스 생성
								ArrayList<Board> list = brdDAO.getList(pageNumber); // 리스트 생성.
								for(int i = 0; i < list.size(); i++) { 
							%>
						<tr>
							<td class="bbline"><a href="boardView.jsp?brdID=<%= list.get(i).getBrdID() %>"><%= list.get(i).getBrdTitle() %></a></td>
							<td class="bbline"><%= list.get(i).getUserNickname() %></td>
							<td class="bbline"><%= list.get(i).getBrdDate().substring(0, 11) %></td>
							<td class="bbline"></td>
						</tr>
							<%
								}
							%>
                    </table>
                    <div id="menu">
                    	<ul class="number-menu">
                        	<%
                        		int startPage = (pageNumber / 10) * 10 + 1;
                        		if(pageNumber % 10 == 0) startPage -= 10;
                        		int targetPage = new BoardDAO().targetPage(pageNumber);
                        		if(startPage != 1) {
                        	%>		
                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= startPage - 1 %>">&lt;&lt;&nbsp;</a></li>
    						<%
    							} else {
                        	%>
                        		<li class="inner-number">&lt;&lt;&nbsp;</li>
                        	<%
    							}
                        		if(pageNumber != 1)	{
							%>
								<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber - 1 %>">&lt;&nbsp;</a></li>
							<%
								} else {
		                    %>
	                        	<li class="inner-number">&lt;&nbsp;</li>
	                        <%
	    						}
                        		for(int i = startPage; i < pageNumber; i++) {
                        	%>
                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= i %>"><%= i %></a></li>
                        	<%
                        		}
                        	%>
                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>"><%= pageNumber %></a></li>
                        	<%
                        		for (int i = pageNumber + 1; i <= targetPage + pageNumber; i++) {
                        			if(i <startPage + 10) {
                        	%>
                                <li class="inner-number"><a href="main.jsp?pageNumber=<%= i %>"><%= i %></a></li>
                            <%			
                        			}
                        		}
                        		if(pageNumber != targetPage + pageNumber)	{
    						%>
    							<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber + 1 %>">&nbsp;&gt;</a></li>
    						<%
    							} else {
    		                %>
    	                        <li class="inner-number">&nbsp;&gt;</li>
    	                    <%
    	    					}
                        		if(targetPage + pageNumber > startPage + 9) {
                        	%>
                                <li class="inner-number"><a href="main.jsp?pageNumber=<%= startPage + 10 %>">&nbsp;&gt;&gt;</a></li>
                            <%	
                        		} else {
                        	%>
                        		<li class="inner-number">&nbsp;&gt;&gt;</li>
                        	<%
                        		}
                        	%>
						</ul>
           	 		</div>
           	</div>
            <div id="post">
                <h1><%= brd.getBrdTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></h1>
                <li id="postinfo">
                    <ul><img src="people.png" width="13")><%= brd.getUserNickname() %></ul> 
                    <ul id="contentdate"><%= brd.getBrdDate().substring(0, 11) + brd.getBrdDate().substring(11, 13) + "시" + brd.getBrdDate().substring(14,16) + "분" %></ul> 
                </li>
                <p id="content"><%= brd.getBrdContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></p>
                <div id="registration">
                <%
				if(userID != null && userID.equals(brd.getUserID())) {
				%>
					<input id="update"  type="button" value="수정" onClick="location.href='update.jsp?brdID=<%= brdID %>'">
					<input id="delete"  type="button" value="삭제" onClick="dltbtnClick()">
					<script>
						function dltbtnClick() {
							if (confirm('정말로 삭제하시겠습니까?') == true)
								location.href="deleteAction.jsp?brdID=<%= brdID %>";
						}
					</script>
				<%
					}
				%>
				</div>
                <h3 id="comment"> 댓글</h3>
                <li>
                    <ul id="nickname"><img src="people.png" width="13")>닉네임</ul>
                    <ul id="cc">댓글내용</ul>
                    <ul id="commentdate">2022.04.17. 13:50</ul> <!-- 날짜 -->
                </li>
                <li>
                    <ul id="nickname"><img src="people.png" width="13")>닉네임</ul>
                    <ul id="cc">댓글내용</ul>
                    <ul id="commentdate">2022.04.17. 13:50</ul> <!-- 날짜 -->
                </li>
                <li>
                    <ul id="nickname"><img src="people.png" width="13")>닉네임</ul>
                    <ul id="cc">댓글내용</ul>
                    <ul id="commentdate">2022.04.17. 13:50</ul> <!-- 날짜 -->
                </li>
                <li>
                    <ul id="nickname"><img src="people.png" width="13")>닉네임</ul>
                    <ul id="cc">댓글내용</ul>
                    <ul id="commentdate">2022.04.17. 13:50</ul> <!-- 날짜 -->
                </li>
            </div>
        </aside>
    </body>
</html>