package comments.model;

public class CommentsBean {
	private int num;
	private int board_num;
	private String name;
	private String content;
	private String regist_day;
	
	
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegist_day() {
		return regist_day;
	}
	public void setRegist_day(String regist_day) {
		this.regist_day = regist_day;
	}
	
	
	
}
