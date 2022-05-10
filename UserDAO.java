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
			String dbURL = "jdbc:mysql://127.0.0.1:3306/?user=root";
			String dbID = "root";
			String dbPassword = "0501";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String add(String userID) {
		String userAdd = null;
		String SQL = "SELECT LEFT(RIGHT(userAddress, 8), 4) from joljak.user WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userAdd = rs.getString(1);
			}else {
				userAdd = "false";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return userAdd;
	}
	
	public String nick(String userID) {
		String userNick = null;
		String SQL = "SELECT userNickname FROM joljak.user WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				userNick = rs.getString(1);
			}else {
				userNick = "false";
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return userNick;
	}
	
	
	// 로그인 함수
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPW FROM joljak.user WHERE userID = ?";
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
			String SQL = "INSERT INTO joljak.user VALUES (?, ?, ?, ?, ?, ?, ?)";
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