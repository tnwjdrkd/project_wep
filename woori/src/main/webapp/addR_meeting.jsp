<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<head>
    <title>정모 추가하기</title>
    <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
    <style>
        * {
            font-family: '빙그레체' , 'Malgun Gothic' , Gothic, sans-serif;
        }
        #Rmeeting {
            width: 420px; margin: 0 auto;
            padding: 200px;
        }
        h1{
            color: #8b60be;
            text-align: center;
            text-shadow: 2px 2px 1px #C996CC;
            margin-bottom: 40px;
            font-size: 40px;
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

        li { list-style: none;}

        li>input{
            width: 400px;
            height: 40px;
            margin-bottom: 10px;
        }

        li > a { color: black; }
    /* 반응형_스마트폰*/
        @media screen and (max-width:767px){
        body{ width: auto }
        }
    </style>
</head>
<body>
	<% 
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
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
	%>
    <div id="Rmeeting">
        <h1>정모 추가하기</h1>
        <form method="post" action="addR_meetingAction.jsp?mtID=<%= URLEncoder.encode(mtID, "UTF-8") %>">
	        <li id="Rmeeting_date"><input id="date" type="date" name="rmtDate"></li>
	        <li id="Rmeeting_time"><input id="time" type="time" name="rmtTime"></li>
	        <li id="Rmeeting_place"><input id="place" type="text" name="rmtPlace" placeholder="정모 장소를 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='정모 장소를 입력해주세요.'"></li>
	        <li id="Rmeeting_cost"><input id="cost" type="text" name="rmtCost" placeholder="비용을 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='비용을 입력해주세요'"></li>
	        <br>
	        <div id="submit_btn">
	            <input id="submit" type="submit" name="submit" value="등록">
	        </div>
        </form>
    </div>
</body>