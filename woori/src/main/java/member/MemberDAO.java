package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MemberDAO {
	private Connection conn;
	private ResultSet rs;
	
	// mysql 접속
	public MemberDAO() {
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
	
	public ArrayList<Member> getMbList(String mbMeeting) {
		String SQL = "SELECT * FROM member WHERE mbMeeting = ? ORDER BY mbID ASC";
		ArrayList<Member> list = new ArrayList<Member>();  // Board 클래스의 인스턴스 보관 리스트
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, mbMeeting);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
			while (rs.next()) {
				Member mb = new Member(); // 인스턴스 생성
				mb.setMbID(rs.getInt(1)); // brd의 속성들
				mb.setMbMeeting(rs.getString(2)); 
				mb.setMbUser(rs.getString(3)); 
				mb.setMbGreet(rs.getString(4)); 
				list.add(mb); // 리스트에 해당 인스턴스 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 뽑아온 게시글 리스트 출력
	}
}
