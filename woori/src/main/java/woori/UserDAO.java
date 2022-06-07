package woori;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import board.Board;
import encrypt.BCrypt;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// mysql 접속
	public UserDAO() {
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

	public String add(String userID) {
		String userAdd = null;
		String SQL = "SELECT LEFT(RIGHT(userAddress, 8), 4) from user WHERE userID = ?";
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
		String SQL = "SELECT userNickname FROM user WHERE userID = ?";
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
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				// if(rs.getString(1).equals(userPassword)) 
				if(BCrypt.checkpw(userPassword, rs.getString("userPassword")))   // BCrypt를 이용한 패스워드 인코딩 로그인
				{
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
				pstmt.setString(2, BCrypt.hashpw(user.getUserPassword(), BCrypt.gensalt(10)));   //  BCrypt를 이용한 패스워드 인코딩
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
		
		public User getUser(String userID) {  //  글 내용 조회(게시글 ID에 해당하는 게시글 가져옴)
			String SQL = "SELECT * FROM user WHERE userID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
				if (rs.next()) {
					User user = new User();
					user.setUserID(rs.getString(1));
					user.setUserPassword(rs.getString(2)); 
					user.setUserName(rs.getString(3)); 
					user.setUserBirth(rs.getString(4)); 
					user.setUserPhone(rs.getString(5)); 
					user.setUserAddress(rs.getString(6));
					user.setUserNickname(rs.getString(7));
					return user;
				}
			} catch (Exception e) {
				e.printStackTrace(); // 해당 글이 존재하지 않는 경우
			}
			return null; // null 반환
		}
		
		public int infoupdate(String userID, String userPassword, String userName, String userBirth, String userPhone, String userAddress, String userNickname) { // 글 수정을 위한 함수
			String SQL = "UPDATE user SET userPassword = ?, userName = ?, userBirth = ?, userPhone = ?, userAddress = ?, userNickname = ? WHERE userID = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				User user = new UserDAO().getUser(userID);
				pstmt.setString(1, BCrypt.hashpw(user.getUserPassword(), BCrypt.gensalt(10)));
				pstmt.setString(2, userName);
				pstmt.setString(3, userBirth);
				pstmt.setString(4, userPhone);
				pstmt.setString(5, userAddress);
				pstmt.setString(6, userNickname);
				pstmt.setString(7, userID);
				return pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; // DB 오류
		}
}