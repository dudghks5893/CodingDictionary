package user.model;

public class UserBean {
	private String userID;
	private String userPassword;
	private String userName;
	private String userEmail;
	private String regist_day;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getregist_day() {
		return regist_day;
	}
	public void setregist_day(String regist_day) {
		this.regist_day = regist_day;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
}
