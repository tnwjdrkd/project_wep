package board;

public class Board {
	private int brdID;
	private String userID;
	private String brdAddress;
	private String brdTitle;
	private String category;
	private String userNickname;
	private String brdDate;
	private String brdContent;
	private int brdCount;
	private int brdAvailable;
	private int cmtCount;
	
	public int getBrdID() {
		return brdID;
	}
	public void setBrdID(int brdID) {
		this.brdID = brdID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBrdAddress() {
		return brdAddress;
	}
	public void setBrdAddress(String brdAddress) {
		this.brdAddress = brdAddress;
	}
	public String getBrdTitle() {
		return brdTitle;
	}
	public void setBrdTitle(String brdTitle) {
		this.brdTitle = brdTitle;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getUserNickname() {
		return userNickname;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}
	public String getBrdDate() {
		return brdDate;
	}
	public void setBrdDate(String brdDate) {
		this.brdDate = brdDate;
	}
	public String getBrdContent() {
		return brdContent;
	}
	public void setBrdContent(String brdContent) {
		this.brdContent = brdContent;
	}
	public int getBrdCount() {
		return brdCount;
	}
	public void setBrdCount(int brdCount) {
		this.brdCount = brdCount;
	}
	public int getBrdAvailable() {
		return brdAvailable;
	}
	public void setBrdAvailable(int brdAvailable) {
		this.brdAvailable = brdAvailable;
	}
	public int getCmtCount() {
		return cmtCount;
	}
	public void setCmtCount(int cmtCount) {
		this.cmtCount = cmtCount;
	}
}
