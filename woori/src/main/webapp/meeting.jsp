<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="meeting.MeetingDAO" %>
<%@ page import="meeting.Meeting" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.Member" %>
<%@ page import="r_meeting.R_meetingDAO" %>
<%@ page import="r_meeting.R_meeting" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
    <head>
        <title>모임</title>
        <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
        <style>
            * {
                margin: 0; padding: 0;
                font-family: '빙그레체' , 'Malgun Gothic' , Gothic, sans-serif;
            }
            a { text-decoration: none; }
            li { list-style: none; }
            li > a { color: black; }
        </style>
        <!-- 페이지 구성 -->
        <style>
            body { 
                width: 1500px; margin: 0 auto;
                background-image: url('purple.jpg');
                background-size: cover;
                background-repeat: no-repeat;
                background-position: center;
                background-attachment: fixed;
            }
            #page-wrapper {
                background-color: white;
                margin: 40px 0; padding: 10px 20px;
                height: 1000px;
            }
        </style>
        <!-- 헤더(타이틀) 구성 -->
        <style>
            #main-header {
                padding: 80px 0;
            }
            .main-title {
                font-size: 50px;
                color: #8b60be;
                text-align: center;
                text-shadow: 3px 3px 1px #C996CC;
            }
        </style>
        <!-- 본문 구성(모임/멤버) -->
        <style>
            #content {
                overflow: hidden;
                background-color: rgb(255, 255, 255);
                border: 2px solid #C996CC;
                border-radius: 20px;
                padding: 10px 30px 10px 30px;
                margin: 10px 10px 10px 0;
            }
            #main-aside {
                width: 300px;
                float: left;
                margin: 0 100px 0 0;
            }
            .inner-aside {
                width: 300px; height: 150px;
                background-color: rgb(255, 255, 255);
                border: 2px solid #C996CC;
                border-radius: 20px;
                margin: 10px 0 30px 10px;
                padding: 20px;
            }
            .inner-aside > h2{
                text-align: center;
            }
            .content-header { padding: 10px 0; }

            .content-title { 
                padding-bottom: 20px;
            }
            ul > li {
                font-size: 17px;
                padding-bottom: 5px;
            }
            h2 {
                color:#7440b3;
                padding-bottom: 15px;
            }
            .member_info > li > a:hover{
                color:#8b60be;
            }
            .meeting_leader>a:hover{
                color:#8b60be;
            }
            #meeting-join{
                width: 340px;
                height: 70px;
                margin: 0px 0 10px 10px;
                background:rgb(222, 187, 255);
                border: 1px solid #ffffff;
                border-radius: 10px;
                cursor: pointer;
            }
            #meeting-join:hover{
                background:rgb(200, 141, 255);
                color:white;
            }
            #meeting-record{
                width: 340px;
                height: 70px;
                margin: 10px 0 10px 10px;
                background:rgb(222, 187, 255);
                border: 1px solid #ffffff;
                border-radius: 10px;
                cursor: pointer;
            }
            #meeting-record:hover{
                background:rgb(200, 141, 255);
                color:white;
            }
        </style>
        <!-- 게시판 -->
        <style>
            #bulletinboard {
                width: 100%;
                border-top: 1px solid #9b9b9b;
                border-collapse: collapse;
            }
            .bbline {
                border-bottom: 1px solid #9b9b9b;
                padding: 10px;
                text-align: center;
            }
        </style>
        <!-- 게시판 페이징 -->
        <style>
            #menu {
                width: 200px;
                margin: 0 auto;
            }
            .number-menu {
                list-style: none;
                display: inline-block;
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
                background:rgb(222, 187, 255);
                color: white;
            }
            #write:hover {
                color: white;
            }
        </style>
        <!-- 정모  -->
        <style>
            #content2 {
                overflow: hidden;
                background-color: rgb(255, 255, 255);
                border: 2px solid #C996CC;
                border-radius: 20px;
                padding: 20px 30px 10px 30px;
                margin: 30px 10px 0 0;
            }
            #join {
                width: 370px;
                height: 40px;
                margin: 10px 0 10px 0;
                background:rgb(222, 187, 255);
                border: 1px solid #ffffff;
                border-radius: 10px;
                cursor: pointer;
            }
            #join:hover {
                background:rgb(200, 141, 255);
                color:white;
            }
            #more:hover{
                cursor: pointer;
                background:rgb(233, 210, 255);
            }
            /* 반응형_스마트폰*/
            @media screen and (max-width:767px) {
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
			String userID = null;    // 로그인 확인 후 userID에 로그인한 값, 비로그인 null
			if(session.getAttribute("userID") != null) {
				userID = (String)session.getAttribute("userID");
			}
			int pageNumber = 1; // 게시판 기본 페이지 설정
			int r_meetingpage = 1;
			if (request.getParameter("pageNumber") != null) {  // pageNumber 존재 시 해당 페이지 값 대입.
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
				r_meetingpage = Integer.parseInt(request.getParameter("r_meetingpage"));
			}
			String mtID = null;
			if(request.getParameter("mtID") != null) {
				mtID = (String)request.getParameter("mtID");
			}
			if(mtID == null) {   // 모임 존재시 모임 페이지 조회가능
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 모임입니다.')");      
				script.println("location.href='main.jsp'");   
				script.println("</script>");
			}
			Meeting mt = new MeetingDAO().getMeeting(mtID); // 모임 조회 인스턴스
		%>
        <div id="page-wrapper">
            <header id="main-header">
                <hgroup>
                    <h1 class="main-title"><%= mt.getMtID() %></h1> <!-- 모임명-->
                </hgroup>
            </header>
        <aside id="main-aside">
            <div class="inner-aside">
                <h2>모임</h2>
                <ul class="meeting_info">
                    <li class="meeting_leader"><img src="leader.png" width="20")><a href="project_meminfo.html"><%= mt.getMtLeader() %></a></li> <!-- 모임장(닉네임) -->
                    <li class="meeting_opendate"><img src="date.png" width="20")><%= mt.getMtDate().substring(0, 4) + "년" + mt.getMtDate().substring(5, 7) + "월" + mt.getMtDate().substring(8, 10) + "일" %></li> <!-- 모임 생성 날짜 -->
                    <li class="meeting_introduction"><%= mt.getMtSummary() %></li> <!-- 모임 소개 -->
                </ul>
            </div>
            <div class="inner-aside">
                <h2>멤버</h2>
                <ul class="member_info">
                <%
					MemberDAO mbDAO = new MemberDAO(); // 인스턴스 생성
					ArrayList<Member> mblist = mbDAO.getMbList(mtID); // 리스트 생성.
					for(int i = 0; i < mblist.size(); i++) { 
				%>
                <li><img src="people.png" width="18")><a href="project_meminfo.html"><%= mblist.get(i).getMbUser() %></a></li> <!-- 모임에 가입된 회원1 -->
                <%
					}
				%>
                </ul>
            </div>
            <div class="meeting-aside">
                <input id="meeting-join"  type="button" value="모임 가입하기" style="font-size: 17px;" onClick="location.href='project_meetingjoin.html'">
            </div>
            <div class="meeting-aside">
                <input id="meeting-record"  type="button" value="정모후기 보기" style="font-size: 17px;" onClick="location.href='review.jsp?mtID=<%= URLEncoder.encode(mtID, "UTF-8") %>'">
            </div>
        </aside>
        <div id="content">
            <div class="content-header">
                <h2  class="content-title">게시판</h2>
                <table id="bulletinboard">
                    <tr>
                        <td class="bbline">번호</td>
                        <td class="bbline">제목</td>
                        <td class="bbline">작성자</td>
                        <td class="bbline">작성일</td>
                        <td class="bbline">댓글수</td>
                        <td class="bbline">조회수</td>
                    </tr>
                    <%
						BoardDAO brdDAO = new BoardDAO(); // 인스턴스 생성
						ArrayList<Board> list = brdDAO.getMtList(pageNumber, mtID); // 리스트 생성.
						for(int i = 0; i < list.size(); i++) { 
					%>
                   	<tr>
						<td class="bbline"><%= list.get(i).getBrdID() %></td>
						<td class="bbline"><a href="boardView.jsp?brdID=<%= list.get(i).getBrdID() %>"><%= list.get(i).getBrdTitle() %></a></td>
						<td class="bbline"><%= list.get(i).getUserNickname() %></td>
						<td class="bbline"><%= list.get(i).getBrdDate().substring(0, 11)  + list.get(i).getBrdDate().substring(11, 13) + "시" + list.get(i).getBrdDate().substring(14,16) + "분" %></td>
						<td class="bbline"><%= list.get(i).getCmtCount() %></td>
						<td class="bbline"><%= list.get(i).getBrdCount() %></td>
					</tr>
						<%
							}
						%>
                 </table>
            </div>
            <div id="menu">
                <ul class="number-menu">
                   	<%
	               		int startPage = (pageNumber / 10) * 10 + 1;
	               		if(pageNumber % 10 == 0) startPage -= 10;
	               		int targetPage = new BoardDAO().targetMtPage(pageNumber, mtID);
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
            <div id="content2">
                <h2>모임 정모  <img src="more.png" width="18" id="more"  onClick="location.href='addR_meeting.jsp?mtID=<%= URLEncoder.encode(mtID, "UTF-8") %>'")></h2>
                <%	// 게시글 출력 부분. 게시글을 뽑아올 수 있도록
					R_meetingDAO rmtDAO = new R_meetingDAO(); // 인스턴스 생성
					ArrayList<R_meeting> rmlist = rmtDAO.getRmList(r_meetingpage, mtID); // 리스트 생성.
					for(int i = 0; i < rmlist.size(); i++) { 
				%>
                <ul id="Rmeeting">
                    <li><img src="date.png" width="20")><%= rmlist.get(i).getRmtDate().substring(0, 4) + "년 " + rmlist.get(i).getRmtDate().substring(5, 7) + "월 " + rmlist.get(i).getRmtDate().substring(8, 10) + "일 " + rmlist.get(i).getRmtTime() %></li> <!-- 정모 시간 -->
                    <li><img src="location.png" width="22")><%= rmlist.get(i).getRmtPlace() %></li> <!-- 정모 장소-->
                    <li><img src="money.png" width="20")><%= rmlist.get(i).getRmtCost() %></li> <!-- 정모 비용 -->
                </ul>
                <input id="join"  type="button" value="참여하기" onClick="alert('참여 신청을 보냈습니다. 모임장 수락시 참여 가능합니다.')" style="font-size: 17px;"> 
                <%
					}
				%>
                <!-- 클릭시 알림창 생성 -->
            </div>
        </div>
    </body>
</html>