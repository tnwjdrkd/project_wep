package meeting;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import board.Board;
import encrypt.BCrypt;
import woori.User;

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
	
	public int getNext() { 
		String SQL = "SELECT mtNum FROM meeting ORDER BY mtNum DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) { // 결과가 있는 경우
				return rs.getInt(1) + 1;
			}//else
				return 1; //현재가 첫번재 게시글인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류 경우.
	}
	
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
				mt.setMtNum(rs.getInt(1));
				mt.setMtID(rs.getString(2));
				mt.setMtAddress(rs.getString(3));
				mt.setMtCategory(rs.getString(4));
				mt.setMtLeader(rs.getString(5));
				mt.setMtSummary(rs.getString(6));
				mt.setMtDate(rs.getString(7));
				return mt;
			}
		} catch (Exception e) {
			e.printStackTrace(); // 해당 글이 존재하지 않는 경우
		}
		return null; // null 반환
	}
	
	public int makeMeeting(String mtID, String mtAddress, String mtCategory, String mtLeader, String mtSummary) {
		String SQL = "INSERT INTO meeting (mtNum, mtID, mtAddress, mtCategory, mtLeader, mtSummary, mtDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, mtID);
			pstmt.setString(3, mtAddress);
			pstmt.setString(4, mtCategory);
			pstmt.setString(5, mtLeader);
			pstmt.setString(6, mtSummary);
			pstmt.setString(7, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB오류.
	}
	
	public ArrayList<Meeting> getMeetingList(int pageNumber) {
		String SQL = "SELECT * FROM meeting ORDER BY mtNum DESC LIMIT ?, 5 ";
		ArrayList<Meeting> list = new ArrayList<Meeting>();  // Board 클래스의 인스턴스 보관 리스트
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 5);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
			while (rs.next()) {
				Meeting mt = new Meeting(); // 인스턴스 생성
				mt.setMtNum(rs.getInt(1)); // brd의 속성들
				mt.setMtID(rs.getString(2)); 
				mt.setMtAddress(rs.getString(3)); 
				mt.setMtCategory(rs.getString(4)); 
				mt.setMtLeader(rs.getString(5)); 
				mt.setMtSummary(rs.getString(6));
				mt.setMtDate(rs.getString(7));
				list.add(mt); // 리스트에 해당 인스턴스 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 뽑아온 게시글 리스트 출력
	}
	
	public ArrayList<Meeting> getMeetingCategoryList(int pageNumber, String mtCategory) {
		String SQL = "SELECT * FROM meeting WHERE mtCategory = ? ORDER BY mtNum DESC LIMIT ?, 5";
		ArrayList<Meeting> list = new ArrayList<Meeting>();  // Board 클래스의 인스턴스 보관 리스트
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, mtCategory);
			pstmt.setInt(2, (pageNumber - 1) * 5);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
			while (rs.next()) {
				Meeting mt = new Meeting(); // 인스턴스 생성
				mt.setMtNum(rs.getInt(1)); // brd의 속성들
				mt.setMtID(rs.getString(2)); 
				mt.setMtAddress(rs.getString(3)); 
				mt.setMtCategory(rs.getString(4)); 
				mt.setMtLeader(rs.getString(5)); 
				mt.setMtSummary(rs.getString(6));
				mt.setMtDate(rs.getString(7));
				list.add(mt); // 리스트에 해당 인스턴스 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 뽑아온 게시글 리스트 출력
	}
	
//	public boolean nextPage(int pageNumber) { // 페이징 처리 위한 함수
//		String SQL = "SELECT * FROM meeting WHERE mtNum - 1 >= ?";
//		try {
//			PreparedStatement pstmt = conn.prepareStatement(SQL);
//			pstmt.setInt(1, pageNumber * 5);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				return true;  // 다음 페이지로 넘어갈 수 있다고 알림.
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return false;
//	} // 특정한 페이지가 존재하는지 nextPage를 이용해서 물어볼 수 있다.
	
	public int targetMeetingPage(int pageNumber) { // 페이징 처리 위한 함수
		String SQL = "SELECT Count(mtNum - 1) FROM meeting WHERE mtNum - 1 > ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 5);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) / 5;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int targetMeetingCategoryPage(int pageNumber, String mtCategory) { // 페이징 처리 위한 함수
		String SQL = "SELECT Count(mtNum - 1) FROM meeting WHERE mtNum - 1 > ? AND mtCategory = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 5);
			pstmt.setString(2, mtCategory);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) / 5;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}
