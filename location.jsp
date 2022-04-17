<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>����ġ ����</title>
</head>
<body>

<div id="map" style="width:100%;height:350px;"></div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4147436544c83be489e3217e1b3cc9a4"></script>
<script>
var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // ������ �߽���ǥ
        level: 3 // ������ Ȯ�� ���� 
    }; 

var map = new kakao.maps.Map(mapContainer, mapOption); // ������ �����մϴ�
var geocoder = new kakao.maps.services.Geocoder();	// �ּ�-��ǥ ��ȯ ��ü�� �����մϴ�
    
// HTML5�� geolocation���� ����� �� �ִ��� Ȯ���մϴ� 
if (navigator.geolocation) {
    
    // GeoLocation�� �̿��ؼ� ���� ��ġ�� ���ɴϴ�
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // ����
            lon = position.coords.longitude; // �浵
        
        var locPosition = new kakao.maps.LatLng(lat, lon); // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ�� �����մϴ�
        
        searchAddrFromCoords(locPosition, function(result, status) {
        if (status === kakao.maps.services.Status.OK) {
            var detailAddr = '<div>' + result[0].address_name + '</div>';
            
            var content = '<div class="bAddr">' +
                            '<span class="title">�� ��ġ</span>' + 
                            detailAddr + 
                        '</div>';

            displayMarker(locPosition, content);
        }   
    	});
     });
    
} else { // HTML5�� GeoLocation�� ����� �� ������ ��Ŀ ǥ�� ��ġ�� ���������� ������ �����մϴ�
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation�� ����Ҽ� �����..'
        
    displayMarker(locPosition, message);
}
function searchAddrFromCoords(coords, callback) {
 // ��ǥ�� ������ �ּ� ������ ��û�մϴ�
 geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}    
// ������ ��Ŀ�� ���������츦 ǥ���ϴ� �Լ��Դϴ�
function displayMarker(locPosition, message) {
    // ��Ŀ�� �����մϴ�
    var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    var iwContent = message, // ���������쿡 ǥ���� ����
        iwRemoveable = true;
    // ���������츦 �����մϴ�
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    // ���������츦 ��Ŀ���� ǥ���մϴ� 
    infowindow.open(map, marker);
    // ���� �߽���ǥ�� ������ġ�� �����մϴ�
    map.setCenter(locPosition);      
}    
</script>
<!-- <script>

var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // ������ �߽���ǥ
        level: 3 // ������ Ȯ�� ���� 
    }; 


var map = new kakao.maps.Map(mapContainer, mapOption); // ������ �����մϴ�
var geocoder = new kakao.maps.services.Geocoder();	// �ּ�-��ǥ ��ȯ ��ü�� �����մϴ�

// HTML5�� geolocation���� ����� �� �ִ��� Ȯ���մϴ� 
if (navigator.geolocation) {
    out.print("����");
    // GeoLocation�� �̿��ؼ� ���� ��ġ�� ���ɴϴ�
    navigator.geolocation.getCurrentPosition(function(position) {
        
        var lat = position.coords.latitude, // ����
            lon = position.coords.longitude; // �浵
        
        var locPosition = new kakao.maps.LatLng(lat, lon); // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ�� �����մϴ�
        var message = '<div style="padding:5px;">���⿡ ��Ű���?!</div>';
        displayMarker(locPosition, message);
        
        geocoder.coord2RegionCode(lon, lat, function(result, status) {
        	 if (status === kakao.maps.services.Status.OK) {

        		var Addr = result[0].address_name;
                message = '<div class="bAddr">' + '<span class="title">�� ��ġ</span>' + Addr + '</div>';
                displayMarker(locPosition, message);
       		}
       });    
        
/*         searchAddrFromCoords(locPosition, function(result, status) {

         	 if (status === kakao.maps.services.Status.OK) {
                 var Addr = result[0].address_name + '</div>';
                 var content = '<div class="bAddr">' +
                                 '<span class="title">�� ��ġ</span>' + 
                                 Addr + 
                             '</div>';
                 displayMarker(locPosition, content);
        	}
        });*/
    });
    
} else { // HTML5�� GeoLocation�� ����� �� ������ ��Ŀ ǥ�� ��ġ�� ���������� ������ �����մϴ�
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation ����';
    displayMarker(locPosition, message);
}

function searchAddrFromCoords(coords, callback) {
	 // ��ǥ�� ������ �ּ� ������ ��û�մϴ�
	 geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
	}

// ������ ��Ŀ�� ���������츦 ǥ���ϴ� �Լ��Դϴ�
function displayMarker(locPosition, message) {
    // ��Ŀ�� �����մϴ�
    var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    var iwContent = message, // ���������쿡 ǥ���� ����
        iwRemoveable = true;
    // ���������츦 �����մϴ�
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    // ���������츦 ��Ŀ���� ǥ���մϴ� 
    infowindow.open(map, marker);
    // ���� �߽���ǥ�� ������ġ�� �����մϴ�
    map.setCenter(locPosition);      
}
</script> -->
</body>
</html>