package woori;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// mysql 접속
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/Woori?serverTimezone=UTC" ;
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 로그인 함수
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;  // 로그인 성공
				}
				else
					return 0;  // 비밀번호 불일치
			}
			return -1; // 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;  // DB 에러
	}

	// 회원가입 함수
		public int join(User user) {
			String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?, ?)";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, user.getUserID());
				pstmt.setString(2, user.getUserPassword());
				pstmt.setString(3, user.getUserName());
				pstmt.setString(4, user.getUserBirth());
				pstmt.setString(5, user.getUserPhone());
				pstmt.setString(6, user.getUserAddress());
				pstmt.setString(7, user.getUserNickname());
				return pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			}
			return -1; // DB 오류
		}
	
}