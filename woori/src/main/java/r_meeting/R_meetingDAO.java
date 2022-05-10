package r_meeting;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class R_meetingDAO {
	private Connection conn;
	private ResultSet rs;
	
	// mysql 접속
	public R_meetingDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/joljak?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getNext() { 
		String SQL = "SELECT rmtID FROM r_meeting ORDER BY rmtID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; // 다음 번호 반환
			}
				return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류 경우.
	}
	
	public int add(String rmtGroup, String rmtDate, String rmtTime, String rmtPlace, String rmtCost) {
		String SQL = "INSERT INTO r_meeting (rmtID, rmtGroup, rmtDate, rmtTime, rmtPlace, rmtCost, rmtAvailable) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); 		
			pstmt.setString(2, rmtGroup);	// 모임명
			pstmt.setString(3, rmtDate); 	// 정모 개설 날짜
			pstmt.setString(4, rmtTime);
			pstmt.setString(5, rmtPlace);  	// 정모 장소
			pstmt.setString(6, rmtCost);  	// 정모 참여 비용	
			pstmt.setInt(7, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // DB오류.
	}
	
	public R_meeting getR_meeting(String rmtGroup) {  //  글 내용 조회(게시글 ID에 해당하는 게시글 가져옴)
		String SQL = "SELECT * FROM r_meeting WHERE rmtGroup = ? AND rmtID = (SELECT MAX(rmtID) FROM r_meeting)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, rmtGroup);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				R_meeting rmt = new R_meeting();
				rmt.setRmtID(rs.getInt(1));
				rmt.setRmtGroup(rs.getString(2)); 
				rmt.setRmtDate(rs.getString(3));
				rmt.setRmtTime(rs.getString(4));
				rmt.setRmtPlace(rs.getString(5)); 
				rmt.setRmtCost(rs.getString(6)); 
				rmt.setRmtAvailable(rs.getInt(7));
				return rmt;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // null 반환
	}
}
