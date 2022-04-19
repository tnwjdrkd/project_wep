<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
    <title>����ġ ����</title>
    <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
    <style>
        #userlocation{
            width:500px;
            margin: 0 auto;
        }
        #map{
            width: 500px; /* ũ�� ���� ���� */
            height: 500px; /* ũ�� ���� ���� */
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
    /* ������_����Ʈ��*/
        @media screen and (max-width:767px){ body{ width: auto }}
    </style>
</head>
<body>
	<div id="userlocation">
        <div id="map">
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4147436544c83be489e3217e1b3cc9a4&libraries=services,clusterer,drawing"></script>
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
            					var Addr = result[0].address_name;
            					document.getElementById('Addr').value = Addr;
            					
            					var content = '<div class="bAddr">' + '<span class="title"><b>�� ��ġ</b></span><div>' + Addr + '</div></div>';
								
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
        </div>
        
        <div id="locationinfo">
            <p>���� ��ġ�� <input type="text" id="Addr" name="Addr" value="" readonly="readonly"> �Դϴ�.</p>
           	<p><input type="button" value="�� ��ġ ����ϱ�" onClick="close()"></p>
        </div>
        <script type="text/javascript">
   			function close(){//�Ϸ� ��������?
   				window.opener.document.getElementById("address").value = document.getElementById("Addr").value
   				//window.close();
   				//window.open("about:blank", "_self").close(); �־ȵǴ°�
			}
		</script>
    </div>
</body>
</html>