package team03.bean;

import java.sql.Timestamp;

public class VisitorDTO {
	private int num; 	
	private String id;		
	private String pw;		
	private String content;	
	private Timestamp reg;	
	
	public void setNum(int num) { this.num = num; }
	public int getNum() { return num; }
	
	public void setId(String id) { this.id = id;}
	public String getId() { return id; }
	
	public void setPw(String pw) { this.pw = pw; }
	public String getPw() { return pw; }
	
	public void setContent(String content) { this.content = content; }
	public String getContent() { return content; }
	
	public void setReg(Timestamp reg) { this.reg = reg; }
	public Timestamp getReg() { return reg; }
}

