<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
    <head>
        <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
        <title>우리 동네 커뮤니케이션 회원가입</title>
        <style>
            * {
                font-family: '빙그레체' , 'Malgun Gothic' , Gothic, sans-serif;
            }

            h1 {text-align: center;}
            p {text-align: center;}
            #result {
                width: 100%;
                border: 1px solid #444444;
                border-collapse: collapse;
                text-align: center;
            }
            h3{text-align: right;}
        </style>
        <%-- date picker 선언_jquery UI --%>
			<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
			<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
			<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    </head>
    <body>
        <h1>우리 동네 커뮤니케이션</h1>
        <fieldset>
            <legend>회원가입</legend>
            <form method="post" action="joinAction.jsp">
                <table>
                    <tr>
                        <td><label for="id">아이디 </label></td>
                        <td><input id="id" type="text" name="userID"></td>
                    </tr>
                    <tr>
                        <td><label for="password">비밀번호</label></td>
                        <td><input id="password" type="password" name="userPassword"></td>
                    </tr>
                    <tr>
                        <td><label for="name">이름</label></td>
                        <td><input id="name" type="text" name="userName"></td>
                    </tr>
                    <tr>
                        <td><label for="birth">생년월일</label></td>
                        <td><input id="birth" type="text" name="userBirth">
                        	<script>
    						    $(function() {
    					            $("#birth").datepicker({
    					                dateFormat: 'yy-mm-dd', showOtherMonths: true, showMonthAfterYear:true
    					                ,changeYear: true, changeMonth: true, yearSuffix: "년"
    					                ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
    					            	,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트	
    					           		,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
    					            });
    					            $('#datepicker').datepicker('setDate', 'today');    
    					        });
   							</script></td>
                    </tr>
                    <tr>
                        <td><label for="phonenum">휴대전화번호</label></td>
                        <td><input id="phonenum" type="text" placeholder="-없이 입력해주세요." name="userPhone"></td>
                    </tr>
                    <tr>
                        <td><label for="address">주소</label></td>
                        <td><input id="address" value="" type="text" name="userAddress" readonly="readonly">
                        <input type="button" value="위치 인증하기" onClick="addPopup()"></td>
                    </tr>
                    <tr>
                        <td><label for="nickname">닉네임</label></td>
                        <td><input id="nickname" type="text" name="userNickname"></td>
                    </tr>
                    <tr>
                        <td colspan="2"><br><input type="submit"  style="width:275px; height:45px;" value="가입하기"></td>
                        <td></td>
                    </tr>
                </table>
            </form>
        </fieldset>
        <script type="text/javascript">
        	function addPopup(){
        		const pop = window.open("${pageContext.request.contextPath}/location.jsp", "pop", "width=550, height=630, scrollbars=no, resizable=yes");
        		/* pop.addEventListener('beforeunload', function() {
        			var add = windowPopup.document.getElementById('Addr').value;
        			document.getElementById('address').value = add;
        		});
        		pop.addEventListener('unload', function() {
        			var add = windowPopup.document.getElementById('Addr').value;
        			document.getElementById('address').value = add;
        		});
        		pop.onbeforeunload = function() {
        			var add = windowPopup.document.getElementById('Addr').value;
        			document.getElementById('address').value = add;
        			//callback(add);
        		}; */
        	}
        	/* function addCallBack(add){
        		document.getElementById('address').value = add;
        	} */
        </script>
	</body>
</html>