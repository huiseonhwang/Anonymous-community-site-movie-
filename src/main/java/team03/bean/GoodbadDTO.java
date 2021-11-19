package team03.bean;

public class GoodbadDTO {
	private int num;
	private String ip;
	private String writer;
	private String boardName;
	
	public void setNum(int num) {
		this.num = num;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public void SetBoardName(String boardName) {
		this.boardName = boardName;
	}
	
	public int getNum() {
		return num;
	}
	public String getIp() {
		return ip;
	}
	public String getWriter() {
		return writer;
	}
	public String getBoardName() {
		return boardName;
	}
}
