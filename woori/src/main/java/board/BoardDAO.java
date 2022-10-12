package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import comment.Comment;

public class BoardDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	// mysql 접속
	public BoardDAO() {
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
	// 닉네임 가져오기
	public String getuserNickname(String userID) {
		String SQL = "SELECT userNickname FROM USER WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // DB 오류 발생
	}
	// 게시글 번호. 최근 글 +1 해서 다음 글번호.
	public int getNext() { 
		String SQL = "SELECT brdID FROM board ORDER BY brdID DESC";
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
	// 게시글 작성 함수
	public int write(String brdTitle, String userID, String brdAddress, String brdMt, String userNickname, String brdContent, int brdCount) {
		String SQL = "INSERT INTO board (brdID, userID, brdAddress, brdTitle, brdMt, userNickname, brdDate, brdContent, brdCount, brdAvailable, cmtCount) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); 		// 게시글 번호
			pstmt.setString(2, userID);			// 작성자
			pstmt.setString(3, brdAddress); 	// 주소
			pstmt.setString(4, brdTitle);  		// 작성자
			pstmt.setString(5, brdMt);  		// 카테고리
			pstmt.setString(6, userNickname); 	// 닉네임
			pstmt.setString(7, getDate()); 		// 날짜
			pstmt.setString(8, brdContent);  	// 글 내용
			pstmt.setInt(9, brdCount);
			pstmt.setInt(10, 1);
			pstmt.setInt(11, 0);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // DB오류.
	}
	
	public ArrayList<Board> getList(int pageNumber) {
		String SQL = "SELECT * FROM board WHERE brdAvailable = 1 AND brdMt is NULL ORDER BY brdID DESC LIMIT ?, 10";
		ArrayList<Board> list = new ArrayList<Board>();  // Board 클래스의 인스턴스 보관 리스트
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
			while (rs.next()) {
				Board brd = new Board(); // 인스턴스 생성
				brd.setBrdID(rs.getInt(1)); // brd의 속성들
				brd.setUserID(rs.getString(2)); 
				brd.setBrdAddress(rs.getString(3)); 
				brd.setBrdTitle(rs.getString(4)); 
				brd.setBrdMt(rs.getString(5)); 
				brd.setUserNickname(rs.getString(6));
				brd.setBrdDate(rs.getString(7));
				brd.setBrdContent(rs.getString(8));
				brd.setBrdCount(rs.getInt(9));
				brd.setBrdAvailable(rs.getInt(10));
				brd.setCmtCount(rs.getInt(11));
				list.add(brd); // 리스트에 해당 인스턴스 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 뽑아온 게시글 리스트 출력
	}
	
	public ArrayList<Board> getBoardViewList(int pageNumber) {
		String SQL = "SELECT * FROM board WHERE brdAvailable = 1 AND brdMt is NULL ORDER BY brdID DESC LIMIT ?, 5";
		ArrayList<Board> list = new ArrayList<Board>();  // Board 클래스의 인스턴스 보관 리스트
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 5);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
			while (rs.next()) {
				Board brd = new Board(); // 인스턴스 생성
				brd.setBrdID(rs.getInt(1)); // brd의 속성들
				brd.setUserID(rs.getString(2)); 
				brd.setBrdAddress(rs.getString(3)); 
				brd.setBrdTitle(rs.getString(4)); 
				brd.setBrdMt(rs.getString(5)); 
				brd.setUserNickname(rs.getString(6));
				brd.setBrdDate(rs.getString(7));
				brd.setBrdContent(rs.getString(8));
				brd.setBrdCount(rs.getInt(9));
				brd.setBrdAvailable(rs.getInt(10));
				brd.setCmtCount(rs.getInt(11));
				list.add(brd); // 리스트에 해당 인스턴스 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 뽑아온 게시글 리스트 출력
	}
	
	public ArrayList<Board> getMtList(int pageNumber, String brdMt) {
		String SQL = "SELECT * FROM board WHERE brdAvailable = 1 AND brdMT = ? ORDER BY brdID DESC LIMIT ?, 10";
		ArrayList<Board> mtlist = new ArrayList<Board>();  // Board 클래스의 인스턴스 보관 리스트
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, brdMt);
			pstmt.setInt(2, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
			while (rs.next()) {
				Board brd = new Board(); // 인스턴스 생성
				brd.setBrdID(rs.getInt(1)); // brd의 속성들
				brd.setUserID(rs.getString(2)); 
				brd.setBrdAddress(rs.getString(3)); 
				brd.setBrdTitle(rs.getString(4)); 
				brd.setBrdMt(rs.getString(5)); 
				brd.setUserNickname(rs.getString(6));
				brd.setBrdDate(rs.getString(7));
				brd.setBrdContent(rs.getString(8));
				brd.setBrdCount(rs.getInt(9));
				brd.setBrdAvailable(rs.getInt(10));
				brd.setCmtCount(rs.getInt(11));
				mtlist.add(brd); // 리스트에 해당 인스턴스 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mtlist; // 뽑아온 게시글 리스트 출력
	}
	
	public ArrayList<Board> getBoardMtViewList(int pageNumber, String brdMt) {
		String SQL = "SELECT * FROM board WHERE brdAvailable = 1 AND brdMt = ? ORDER BY brdID DESC LIMIT ?, 5";
		ArrayList<Board> list = new ArrayList<Board>();  // Board 클래스의 인스턴스 보관 리스트
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, brdMt);
			pstmt.setInt(2, (pageNumber - 1) * 5);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
			while (rs.next()) {
				Board brd = new Board(); // 인스턴스 생성
				brd.setBrdID(rs.getInt(1)); // brd의 속성들
				brd.setUserID(rs.getString(2)); 
				brd.setBrdAddress(rs.getString(3)); 
				brd.setBrdTitle(rs.getString(4)); 
				brd.setBrdMt(rs.getString(5)); 
				brd.setUserNickname(rs.getString(6));
				brd.setBrdDate(rs.getString(7));
				brd.setBrdContent(rs.getString(8));
				brd.setBrdCount(rs.getInt(9));
				brd.setBrdAvailable(rs.getInt(10));
				brd.setCmtCount(rs.getInt(11));
				list.add(brd); // 리스트에 해당 인스턴스 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; // 뽑아온 게시글 리스트 출력
	}
	
	public boolean nextPage(int pageNumber) { // 페이징 처리 위한 함수
		String SQL = "SELECT * FROM board WHERE brdID >= ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pageNumber * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;  // 다음 페이지로 넘어갈 수 있다고 알림.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	} // 특정한 페이지가 존재하는지 nextPage를 이용해서 물어볼 수 있다.
	
	public int targetPage(int pageNumber) { // 페이징 처리 위한 함수, pN 이후 식별되는 모든 페이지  
//		String SQL = "SELECT Count(brdID) FROM board WHERE brdID > ? AND brdAvailable = 1 AND brdMt is null";
//		String SQL = "SELECT Count(brdID) FROM (SELECT brdID FROM board WHERE brdAvailable = 1 AND brdMt is null)A WHERE brdID > ?";
		String SQL = "SELECT COUNT(rowNum) FROM (SELECT @ROWNUM:=@ROWNUM+1 AS rowNum FROM (SELECT brdID FROM board WHERE brdAvailable = 1 AND brdMt is null)A, (SELECT @ROWNUM:=0) AS R)C WHERE rowNum > ?";
//		String SQL = "SELECT @rownum:=@rownum+1, Count(@rownum) FROM (SELECT brdID FROM board WHERE brdAvailable = 1 AND brdMt is null ORDER BY brdID DESC) A WHERE (@rownum:=1) > ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getInt(1) % 10 == 0) return rs.getInt(1) / 10 - 1;	// p 이후 남은 글의 개수가 10단위 개수이면 1을 줄여서 페이징 조절, 10단위가 아니면 낱개의 글들을 출력하기 위한 1페이지를 추가
				else return rs.getInt(1) / 10;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int targetBoardViewPage(int pageNumber) {
		String SQL = "SELECT COUNT(rowNum) FROM (SELECT @ROWNUM:=@ROWNUM+1 AS rowNum FROM (SELECT brdID FROM board WHERE brdAvailable = 1 AND brdMt is null)A, (SELECT @ROWNUM:=0) AS R)C WHERE rowNum > ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, (pageNumber - 1) * 5);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getInt(1) % 5 == 0) return rs.getInt(1) / 5 - 1;	// p 이후 남은 글의 개수가 10단위 개수이면 1을 줄여서 페이징 조절, 10단위가 아니면 낱개의 글들을 출력하기 위한 1페이지를 추가
				else return rs.getInt(1) / 5;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int targetMtPage(int pageNumber, String brdMt) {
		String SQL = "SELECT COUNT(rowNum) FROM (SELECT @ROWNUM:=@ROWNUM+1 AS rowNum FROM (SELECT brdID FROM board WHERE brdAvailable = 1 AND brdMt = ?)A, (SELECT @ROWNUM:=0) AS R)C WHERE rowNum > ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, brdMt);
			pstmt.setInt(2, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getInt(1) % 10 == 0) return rs.getInt(1) / 10 - 1;	// p 이후 남은 글의 개수가 10단위 개수이면 1을 줄여서 페이징 조절, 10단위가 아니면 낱개의 글들을 출력하기 위한 1페이지를 추가
				else return rs.getInt(1) / 10;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int targetBoardMtViewPage(int pageNumber, String brdMt) {
		String SQL = "SELECT COUNT(rowNum) FROM (SELECT @ROWNUM:=@ROWNUM+1 AS rowNum FROM (SELECT brdID FROM board WHERE brdAvailable = 1 AND brdMt = ?)A, (SELECT @ROWNUM:=0) AS R)C WHERE rowNum > ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, brdMt);
			pstmt.setInt(2, (pageNumber - 1) * 5);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if(rs.getInt(1) % 5 == 0) return rs.getInt(1) / 5 - 1;	// p 이후 남은 글의 개수가 10단위 개수이면 1을 줄여서 페이징 조절, 10단위가 아니면 낱개의 글들을 출력하기 위한 1페이지를 추가
				else return rs.getInt(1) / 5;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public Board getBoard(int brdID) {  //  글 내용 조회(게시글 ID에 해당하는 게시글 가져옴)
		String SQL = "SELECT * FROM board WHERE brdID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, brdID);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 결과를 가져올 수 있도록 한다.
			if (rs.next()) {
				Board brd = new Board();
				brd.setBrdID(rs.getInt(1));
				brd.setUserID(rs.getString(2)); 
				brd.setBrdAddress(rs.getString(3)); 
				brd.setBrdTitle(rs.getString(4)); 
				brd.setBrdMt(rs.getString(5)); 
				brd.setUserNickname(rs.getString(6));
				brd.setBrdDate(rs.getString(7));
				brd.setBrdContent(rs.getString(8));
				int brdCount=rs.getInt(9);
				brd.setBrdCount(brdCount);
				brdCount++;
				updatebrdCount(brdCount, brdID);
				brd.setBrdAvailable(rs.getInt(10));
				brd.setCmtCount(rs.getInt(11));
				return brd;
			}
		} catch (Exception e) {
			e.printStackTrace(); // 해당 글이 존재하지 않는 경우
		}
		return null; // null 반환
	}
	
	public int updatebrdCount(int brdCount, int brdID) {  // 조회수 갱신을 위한 함수
		String SQL = "update board set brdCount = ? where brdID = ?";
		try {
			PreparedStatement pstmt=conn.prepareStatement(SQL);
			pstmt.setInt(1, brdCount);
			pstmt.setInt(2, brdID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int update(int brdID, String brdTitle, String brdContent) { // 글 수정을 위한 함수
		String SQL = "UPDATE board SET brdTitle = ?, brdContent = ? WHERE brdID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, brdTitle);
			pstmt.setString(2, brdContent);
			pstmt.setInt(3, brdID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}
	
	public int delete(int brdID) { // 글 삭제를 위한 함수
		String SQL = "UPDATE board SET brdAvailable = 0 WHERE brdID = ?;" + "UPDATE comments SET cmtAvailable = 0 WHERE brdID = ?;";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, brdID);
			pstmt.setInt(2, brdID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}
}
