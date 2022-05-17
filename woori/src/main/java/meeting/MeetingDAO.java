package meeting;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.Board;

public class MeetingDAO {
	private Connection conn;
	private ResultSet rs;
	
	// mysql 접속
	public MeetingDAO() {
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
	// 글 작성시 시간.
	public String getDate() { 
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1); // 현재 날짜를 그대로 반환.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // 빈문자열 반환(DB 오류 발생)
	}
	
	public Meeting getMeeting(String mtID) {  //  글 내용 조회(게시글 ID에 해당하는 게시글 가져옴)
		String SQL = "SELECT * FROM meeting WHERE mtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, mtID);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
			if (rs.next()) {
				Meeting mt = new Meeting();
				mt.setMtID(rs.getString(1));
				mt.setMtAddress(rs.getString(2));
				mt.setMtCategory(rs.getString(3));
				mt.setMtLeader(rs.getString(4));
				mt.setMtSummary(rs.getString(5));
				mt.setMtDate(rs.getString(6));
				return mt;
			}
		} catch (Exception e) {
			e.printStackTrace(); // 해당 글이 존재하지 않는 경우
		}
		return null; // null 반환
	}
}
