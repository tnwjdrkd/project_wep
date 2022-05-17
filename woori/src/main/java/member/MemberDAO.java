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
		ArrayList<Member> list = new ArrayList<Member>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, mbMeeting);
			rs = pstmt.executeQuery(); 
			while (rs.next()) {
				Member mb = new Member();
				mb.setMbID(rs.getInt(1)); 
				mb.setMbMeeting(rs.getString(2)); 
				mb.setMbUser(rs.getString(3)); 
				mb.setMbGreet(rs.getString(4)); 
				list.add(mb); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
}
