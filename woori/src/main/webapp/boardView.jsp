<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
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
            margin-bottom: 200px;
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
            .bbline2 {
              border-bottom: 1px solid #9b9b9b;
              padding: 10px;
              text-align: center;
            }
        </style>
        <!-- 게시판 페이징 -->
        <style>
            #menu {
                width: 350px;
                margin: 0 auto;
                padding-left: 60px;
            }
            .number-menu {
                list-style: none;
                display: inline-block;
                margin-top: 10px;
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
            /* 반응형_스마트폰*/
            @media screen and (max-width:767px){
            body{ width: auto }
            #main-aside { width: auto; float: none;}
            }
        </style>
        <style type="text/css">
			a, a:hover {
			color:#000000;
			text-decoration: none;
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
			Comment cmt = new CommentDAO().getComment(brdID);
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
							<td class="bbline2"><a href="boardView.jsp?brdID=<%= list.get(i).getBrdID() %>"><%= list.get(i).getBrdTitle() %></a></td>
							<td class="bbline2"><%= list.get(i).getUserNickname() %></td>
							<td class="bbline2"><%= list.get(i).getBrdDate().substring(0, 11) %></td>
							<td class="bbline2"><%= list.get(i).getCmtCount() %></td>
						</tr>
							<%
								}
							%>
                    </table>
                    <div id="menu">
                    	<ul class="number-menu">
                        	<%
                        		int startPage = (pageNumber / 5) * 5 + 1;
                        		if(pageNumber % 5 == 0) startPage -= 5;
                        		int targetPage = new BoardDAO().targetPage(pageNumber);
                        		if(startPage != 1) {
                        	%>		
                        		<li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= startPage - 1 %>">&lt;&lt;&nbsp;</a></li>
    						<%
    							} else {
                        	%>
                        		<li class="inner-number">&lt;&lt;&nbsp;</li>
                        	<%
    							}
                        		if(pageNumber != 1)	{
							%>
								<li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= pageNumber - 1 %>">&lt;&nbsp;</a></li>
							<%
								} else {
		                    %>
	                        	<li class="inner-number">&lt;&nbsp;</li>
	                        <%
	    						}
                        		for(int i = startPage; i < pageNumber; i++) {
                        	%>
                        		<li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= i %>"><%= i %></a></li>
                        	<%
                        		}
                        	%>
                        		<li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= pageNumber %>"><%= pageNumber %></a></li>
                        	<%
                        		for (int i = pageNumber + 1; i <= targetPage + pageNumber; i++) {
                        			if(i <startPage + 5) {
                        	%>
                                <li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= i %>"><%= i %></a></li>
                            <%			
                        			}
                        		}
                        		if(pageNumber != targetPage + pageNumber)	{
    						%>
    							<li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= pageNumber + 1 %>">&nbsp;&gt;</a></li>
    						<%
    							} else {
    		                %>
    	                        <li class="inner-number">&nbsp;&gt;</li>
    	                    <%
    	    					}
                        		if(targetPage + pageNumber > startPage + 4) {
                        	%>
                                <li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= startPage + 5 %>">&nbsp;&gt;&gt;</a></li>
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
                <p id="content" style="min-height: 100px"><%= brd.getBrdContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></p>
                <div id="registration">
                <%
				if(userID != null && userID.equals(brd.getUserID())) {
				%>
				<p style="float: right;">
					<input id="update"  type="button" value="수정" style="width:40px; height:25px; margin-top: 10px;" onClick="location.href='update.jsp?brdID=<%= brdID %>'">
					<input id="delete"  type="button" value="삭제" style="width:40px; height:25px;" onClick="dltbtnClick()">
					<script>
						function dltbtnClick() {
							if (confirm('정말로 삭제하시겠습니까?') == true)
								location.href="deleteAction.jsp?brdID=<%= brdID %>";
						}
					</script>
				</p>
				<%
					}
				%>
				</div>
                <h3 id="comment" style="margin-top: 30px"> 댓글</h3>
   				<%
				CommentDAO cmtDAO = new CommentDAO(); // 인스턴스 생성
				ArrayList<Comment> cmtlist = cmtDAO.getList(brdID); // 리스트 생성.
				for(int i = 0; i < cmtlist.size(); i++) { 
				%>
				<li>
                    <ul id="nickname"><img src="people.png" width="13")><%= "&nbsp;"+cmtlist.get(i).getUserNickname() %></ul>
                    <ul id="cc"><%= cmtlist.get(i).getCmtContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></ul>
                    <ul id="commentdate"><%=cmtlist.get(i).getCmtDate()%></ul> <!-- 날짜 -->
                </li>
				<%
					}
				%>
				<form method="post" action="commentAction.jsp?brdID=<%= brdID %>">
            		<table id="bbwrite">
            			<li>
                    		<ul id="nickname"><img src="people.png" width="13")><%= "&nbsp;"+ brdDAO.getuserNickname(userID) %></ul>
                    	</li>
		                <tr>
		                	<td><textarea id="content" type="text" name="cmtContent" style="width:750px; height:60px" placeholder="동네 이웃에게 따뜻한 댓글을 달아주세요."></textarea></td>
		               		<td><input id="submit" type="submit" name="submit" style="width:90px; height:90px; margin-left: 5px;" value="등 록"></td>
		                </tr>
	            	</table>
       			</form>
				<br>
            </div>
        </aside>
    </body>
</html>