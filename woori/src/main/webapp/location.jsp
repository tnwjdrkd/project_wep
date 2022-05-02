<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <title>현위치 인증</title>
    <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
    <style>
        #userlocation{
            width:500px;
            margin: 0 auto;
        }
        #map{
            width: 500px; /* 크기 임의 지정 */
            height: 500px; /* 크기 임의 지정 */
            border: 1px solid #a8a8a8;
            margin-top: 30px;
        }
        p {
            border: 1px solid #a8a8a8;
            float: left;
            padding:10px;
        }
        li { list-style: none; }
        li > a { color: black; }
        #locationinfo{
            width:100%;
            display:inline-block;
            text-align: right;
        }
        #locationsubmit{
            margin-top: 17px;
            height: 42px;
            width: 150px;
        }
        #locationsubmit:hover{
            cursor: pointer;
        }
    /* 반응형_스마트폰*/
        @media screen and (max-width:767px){ body{ width: auto }}
    </style>
</head>
<body>
	<div id="userlocation">
        <div id="map">
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4147436544c83be489e3217e1b3cc9a4&libraries=services,clusterer,drawing"></script>
			<script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    				mapOption = { 
        				center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        				level: 3 // 지도의 확대 레벨 
    				}; 

				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				var geocoder = new kakao.maps.services.Geocoder();	// 주소-좌표 변환 객체를 생성합니다
    
				// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
				if (navigator.geolocation) {
    
    				// GeoLocation을 이용해서 접속 위치를 얻어옵니다
    				navigator.geolocation.getCurrentPosition(function(position) {
        
        				var lat = position.coords.latitude, // 위도
            				lon = position.coords.longitude; // 경도
        
        				var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
        
        				searchAddrFromCoords(locPosition, function(result, status) {
        					if (status === kakao.maps.services.Status.OK) {
            					var Addr = result[0].address_name;
            					document.getElementById('Addr').value = Addr;
            					window.opener.document.getElementById("address").value = Addr;
            					
            					var content = '<div class="bAddr">' + '<span class="title"><b>내 위치</b></span><div>' + Addr + '</div></div>';
								
            					displayMarker(locPosition, content);
       	 					}   
    					});
     				});   
				} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    				var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        				message = 'geolocation을 사용할수 없어요..'
        
    					displayMarker(locPosition, message);
				}
				function searchAddrFromCoords(coords, callback) {
 				// 좌표로 행정동 주소 정보를 요청합니다
 				geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
				}    
				// 지도에 마커와 인포윈도우를 표시하는 함수입니다
				function displayMarker(locPosition, message) {
    				// 마커를 생성합니다
    				var marker = new kakao.maps.Marker({  
        				map: map, 
        				position: locPosition
    				}); 
    				var iwContent = message, // 인포윈도우에 표시할 내용
        				iwRemoveable = true;
    				// 인포윈도우를 생성합니다
    				var infowindow = new kakao.maps.InfoWindow({
        				content : iwContent,
        				removable : iwRemoveable
    				});
    				// 인포윈도우를 마커위에 표시합니다 
    				infowindow.open(map, marker);
    				// 지도 중심좌표를 접속위치로 변경합니다
    				map.setCenter(locPosition);      
				}    
			</script>
        </div>
        
        <div id="locationinfo">
            <p>접속 위치는 <input type="text" id="Addr" name="Addr" value="" readonly="readonly"> 입니다.</p>
           	<p><input type="button" value="이 위치 사용하기" onClick="popDown()"></p>
        </div>
        <script type="text/javascript">
   			function popDown(){//일로 못들어오니?
   				window.close();
   				//window.open("about:blank", "_self").close(); 왜안되는겨
			}
		</script>
    </div>
</body>
</html>