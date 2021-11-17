package team03.bean;

import java.sql.Timestamp;

public class LocalBoardCommentDTO {

	private int boardnum;
	private int num;
	private String writer;
	private String content;
	private Timestamp reg;
	private int re_step;
	private int re_level;
	
	public void setBoardNum(int boardnum) {
		this.boardnum = boardnum;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}
	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}
	
	
	
	public int getBoardNum() {
		return boardnum;
	}
	public int getNum() {
		return num;
	}
	public String getWriter() {
		return writer;
	}
	public String getContent() {
		return content;
	}
	public Timestamp getReg() {
		return reg;
	}
	public int getRe_step() {
		return re_step;
	}
	public int getRe_level() {
		return re_level;	
	}
	
	
}
