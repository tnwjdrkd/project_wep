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
			if(rs.next()) { // 결과가 있는 경우
				return rs.getInt(1) + 1; // 그 다음 게시글의 번호.
			}//else
				return 1; //현재가 첫번재 게시글인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류 경우.
	}

	public int write(String userID, int brdID, String brdAddress, String userNickname, String cmtContent) {
		String SQL = "INSERT INTO comments (cmtID, brdID, userID, brdAddress, userNickname, cmtContent, cmtDate, cmtAvailable) VALUES (?, ?, ?, ?, ?, ?, ?, ?);"
				+ "UPDATE board SET cmtCount = cmtCount + 1 WHERE brdID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); 		// 게시글 번호
			pstmt.setInt(2, brdID);			// 작성자
			pstmt.setString(3, userID); 	// 작성자
			pstmt.setString(4, brdAddress);  		// 작성자
			pstmt.setString(5, userNickname);  		// 카테고리
			pstmt.setString(6, cmtContent); 	// 닉네임
			pstmt.setString(7, getDate()); 	// 글 내용
			pstmt.setInt(8, 1);
			pstmt.setInt(9, brdID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // DB오류.
	}
	
	public Comment getComment(int cmtID) {  //  글 내용 조회(게시글 ID에 해당하는 게시글 가져옴)
		String SQL = "SELECT * FROM comments WHERE cmtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cmtID);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
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
			e.printStackTrace(); // 해당 글이 존재하지 않는 경우
		}
		return null; // null 반환
	}
	
	public ArrayList<Comment> getList(int brdID) {
		String SQL = "SELECT * FROM comments WHERE brdID = ? AND cmtAvailable = 1 ORDER BY cmtID ASC";
		ArrayList<Comment> list = new ArrayList<Comment>();  // Board 클래스의 인스턴스 보관 리스트
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, brdID);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
			while (rs.next()) {
				Comment cmt = new Comment(); // 인스턴스 생성
				cmt.setCmtID(rs.getInt(1));
				cmt.setBrdID(rs.getInt(2));
				cmt.setUserID(rs.getString(3));
				cmt.setBrdAddress(rs.getString(4));
				cmt.setUserNickname(rs.getString(5));
				cmt.setCmtContent(rs.getString(6));
				cmt.setCmtDate(rs.getString(7));
				cmt.setCmtAvailable(rs.getInt(8));
				list.add(cmt); // 리스트에 해당 인스턴스 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 뽑아온 게시글 리스트 출력
	}
	
	public int update(int cmtID,String cmtContent) { // 글 수정을 위한 함수
		String SQL = "UPDATE comments SET cmtContent = ? WHERE cmtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, cmtContent);
			pstmt.setInt(2, cmtID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}
	
	public int delete(int cmtID) { // 글 삭제를 위한 함수
		String SQL = "UPDATE comments SET cmtAvailable = 0 WHERE cmtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, cmtID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}
}