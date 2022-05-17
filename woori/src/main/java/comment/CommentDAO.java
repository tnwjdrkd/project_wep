package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	// mysql 접속
	public CommentDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/joljak?serverTimezone=UTC&allowMultiQueries=true";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
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
	
	public int getNext() { 
		String SQL = "SELECT cmtID FROM comments ORDER BY cmtID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				return rs.getInt(1) + 1; 
			}//else
				return 1; 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}

	public int write(String userID, int brdID, String brdAddress, String userNickname, String cmtContent) {
		String SQL = "INSERT INTO comments (cmtID, brdID, userID, brdAddress, userNickname, cmtContent, cmtDate, cmtAvailable) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
				+ "UPDATE board SET cmtCount = cmtCount + 1 WHERE brdID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); 	
			pstmt.setInt(2, brdID);			
			pstmt.setString(3, userID); 	
			pstmt.setString(4, brdAddress);  		
			pstmt.setString(5, userNickname);  		
			pstmt.setString(6, cmtContent); 	
			pstmt.setString(7, getDate()); 
			pstmt.setInt(8, 1);
			pstmt.setInt(9, brdID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; 
	}
	
	public Comment getComment(int cmtID) { 
		String SQL = "SELECT * FROM comments WHERE cmtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cmtID);
			rs = pstmt.executeQuery(); 
			if (rs.next()) {
				Comment cmt = new Comment();
				cmt.setCmtID(rs.getInt(1));
				cmt.setBrdID(rs.getInt(2));
				cmt.setUserID(rs.getString(3));
				cmt.setBrdAddress(rs.getString(4));
				cmt.setUserNickname(rs.getString(5));
				cmt.setCmtDate(rs.getString(6));
				cmt.setCmtContent(rs.getString(7));
				cmt.setCmtAvailable(rs.getInt(10));
				return cmt;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<Comment> getList(int brdID) {
		String SQL = "SELECT * FROM comments WHERE brdID = ? AND cmtAvailable = 1 ORDER BY cmtID ASC";
		ArrayList<Comment> list = new ArrayList<Comment>(); 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, brdID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Comment cmt = new Comment(); 
				cmt.setCmtID(rs.getInt(1));
				cmt.setBrdID(rs.getInt(2));
				cmt.setUserID(rs.getString(3));
				cmt.setBrdAddress(rs.getString(4));
				cmt.setUserNickname(rs.getString(5));
				cmt.setCmtContent(rs.getString(6));
				cmt.setCmtDate(rs.getString(7));
				cmt.setCmtAvailable(rs.getInt(8));
				list.add(cmt); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	public int update(int cmtID,String cmtContent) { 
		String SQL = "UPDATE comments SET cmtContent = ? WHERE cmtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, cmtContent);
			pstmt.setInt(2, cmtID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public int delete(int cmtID) {
		String SQL = "UPDATE comments SET cmtAvailable = 0 WHERE cmtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cmtID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
}