package review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import r_meeting.R_meeting;

public class ReviewDAO {
	private Connection conn;
	private ResultSet rs;
	
	// mysql 접속
	public ReviewDAO() {
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
		String SQL = "SELECT rvID FROM review ORDER BY rvID DESC";
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
	
	public ArrayList<Review> getRvList(int pageNumber, int rvRmeeting) {
		String SQL = "SELECT * FROM review WHERE rvRmeeting = ? ORDER BY rvID DESC LIMIT ?, 5";
		ArrayList<Review> list = new ArrayList<Review>(); 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, rvRmeeting);
			pstmt.setInt(2, (pageNumber - 1) * 5);
			rs = pstmt.executeQuery(); 
			while (rs.next()) {
				Review rv = new Review(); 
				rv.setRvID(rs.getInt(1));
				rv.setRvRmeeting(rs.getInt(2)); 
				rv.setRvUser(rs.getString(3));
				rv.setRvContent(rs.getString(4));
				rv.setRvAvailable(rs.getInt(5)); 
				list.add(rv); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int targetRvPage(int pageNumber, int rvRmeeting) { // 페이징 처리 위한 함수
		String SQL = "SELECT Count(rvID - 1) FROM review WHERE rvID - 1 > ? AND rvRmeeting = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 5);
			pstmt.setInt(2, rvRmeeting);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) / 5;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public boolean nextPage(int pageNumber, int rvRmeeting) {
		String SQL = "SELECT * FROM review WHERE rvID < ? AND rvRmeeting = ? AND rvAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 5);
			pstmt.setInt(2, rvRmeeting);
			rs = pstmt.executeQuery();
			if (rs.next()) { 
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	
	public int rvWrite(int rvRmeeting, String rvUser, String rvContent) {
		String SQL = "INSERT INTO review (rvID, rvRmeeting, rvUser, rvContent, rvAvailable) VALUES (?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); 		// 게시글 번호
			pstmt.setInt(2, rvRmeeting);			// 작성자
			pstmt.setString(3, rvUser); 	// 주소
			pstmt.setString(4, rvContent);
			pstmt.setInt(5, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // DB오류.
	}
}
