<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>현위치 인증</title>
</head>
<body>

<div id="map" style="width:100%;height:350px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4147436544c83be489e3217e1b3cc9a4"></script>
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
            var detailAddr = '<div>' + result[0].address_name + '</div>';
            
            var content = '<div class="bAddr">' +
                            '<span class="title">내 위치</span>' + 
                            detailAddr + 
                        '</div>';

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
<!-- <script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨 
    }; 


var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();	// 주소-좌표 변환 객체를 생성합니다

// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    out.print("실패");
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
        
        var locPosition = new kakao.maps.LatLng(lat, lon); // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
        var message = '<div style="padding:5px;">여기에 계신가요?!</div>';
        displayMarker(locPosition, message);
        
        geocoder.coord2RegionCode(lon, lat, function(result, status) {
        	 if (status === kakao.maps.services.Status.OK) {

        		var Addr = result[0].address_name;
                message = '<div class="bAddr">' + '<span class="title">내 위치</span>' + Addr + '</div>';
                displayMarker(locPosition, message);
       		}
       });    
        
/*         searchAddrFromCoords(locPosition, function(result, status) {

         	 if (status === kakao.maps.services.Status.OK) {
                 var Addr = result[0].address_name + '</div>';
                 var content = '<div class="bAddr">' +
                                 '<span class="title">내 위치</span>' + 
                                 Addr + 
                             '</div>';
                 displayMarker(locPosition, content);
        	}
        });*/
    });
    
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation 에러';
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
</script> -->
</body>
</html>