<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="r_meeting.R_meetingDAO" %>
<%@ page import="r_meeting.R_meeting" %>
<%@ page import="review.ReviewDAO" %>
<%@ page import="review.Review" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<head>
    <title>정모 후기</title>
    <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
    <style>
        * {
            font-family: '빙그레체' , 'Malgun Gothic' , Gothic, sans-serif;
        }
        #Rmeeting {
            width: 550px; margin: 0 auto;
            padding: 200px;
        }
        h1{
            color: #8b60be;
            text-align: center;
            text-shadow: 2px 2px 1px #C996CC;
            margin-bottom: 10px;
            font-size: 40px;
        }
        p{
            text-align: center;
            margin-bottom: 30px;
        }
        #submit {
            cursor: pointer;
            border: 1px solid #d5a0e6;
            border-radius: 5px;
            background: #d5a0e6;
            font-size: 17px;
            width:408px;
            height: 60px;
            color: white;
            margin-top: 10px;
        }
        #submit_btn{ margin: 0 auto; }

        li {
            list-style: none;
        }

        li>input{
            width: 400px;
            height: 40px;
            margin-bottom: 10px;
        }
        #RmeetingR {
            overflow: hidden;
            background-color: rgb(255, 255, 255);
            border: 2px solid #C996CC;
            border-radius: 20px;
            padding: 20px  10px  20px  45px;
            margin: 30px 10px 0 0;
        }
        #writeReview {
            width: 440px;
            height: 40px;
            background:rgb(222, 187, 255);
            border: 1px solid #ffffff;
            border-radius: 10px;
            cursor: pointer;
            margin: 20px 50px 10px 0;
        }
        #checkReview {
            width: 440px;
            height: 40px;
            background:rgb(222, 187, 255);
            border: 1px solid #ffffff;
            border-radius: 10px;
            cursor: pointer;
            margin: 0 50px 2px 0;
        }
        #Review {
            margin: 20px 0 0 0;
        }
        #ReviewList {
            margin: 5px 0 0 0;
        }
        .ReviewPage {
		    text-align: center;
		    margin: 5px 0 0 0; 
		}
        li > a { color: black; }
    /* 반응형_스마트폰*/
        @media screen and (max-width:767px){
        body{ width: auto }
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <script>
        $(function (){
	            $("#checkReview").click(function (){
  	            $("#Review").show();
            });
        });
    </script>
</head>
<body>
	<% 
		String userID = null;    // 로그인 확인 후 userID에 로그인한 값, 비로그인 null
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		int pageNumber = 1; // 게시판 기본 페이지 설정
		if (request.getParameter("pageNumber") != null) {  // pageNumber 존재 시 해당 페이지 값 대입.
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
		R_meeting rmt = new R_meetingDAO().getR_meeting(mtID); // 모임 조회 인스턴스
	%>
    <div id="Rmeeting">
        <h1>정모 후기</h1>
        <div id="RmeetingR">
        <li><img src="date.png" width="20")><%= rmt.getRmtDate().substring(0, 4) + "년 " + rmt.getRmtDate().substring(5, 7) + "월 " + rmt.getRmtDate().substring(8, 10) + "일 " + rmt.getRmtTime() %></li> <!-- 정모 시간 -->
        <li><img src="location.png" width="22")><%= rmt.getRmtPlace() %></li> <!-- 정모 장소-->
        <li><input id="writeReview"  type="button" value="후기 쓰기"  onClick="location.href='project_writeReview.html'"></li>
        <li><input id="checkReview"  type="button" value="후기 보기"></li>
			<div id="Review" style="display:none">
				<%	// 게시글 출력 부분. 게시글을 뽑아올 수 있도록
					ReviewDAO rvDAO = new ReviewDAO(); // 인스턴스 생성
					ArrayList<Review> rvlist = rvDAO.getRvList(pageNumber, rmt.getRmtID()); // 리스트 생성.
					for(int i = 0; i < rvlist.size(); i++) { 
				%>
					<li id="ReviewList"><%= rvlist.get(i).getRvUser() + ": " + rvlist.get(i).getRvContent() %></li>
				<%
					}
					if(pageNumber != 1)	{
				%>	
					<div class="ReviewPage">
					<a id="ReviewPage" href="review.jsp?mtID=<%= URLEncoder.encode(mtID, "UTF-8") %>&pageNumber=<%=pageNumber - 1%>">이전</a>
					</div>
				<%
					} if(rvDAO.nextPage(pageNumber + 1, rmt.getRmtID())) {
				%>
					<div class="ReviewPage">
					<a id="ReviewPage" href="review.jsp?mtID=<%= URLEncoder.encode(mtID, "UTF-8") %>&pageNumber=<%=pageNumber + 1%>">다음</a>
					</div>
				<%
					}
				%>
			</div>
        </div>
    </div>
</body>