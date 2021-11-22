package team03.bean;

import java.sql.Timestamp;

public class VisitorDTO {
	private String owner;
	private int num; 	
	private String id;		
	private String pw;		
	private String content;	
	private Timestamp reg;	
	
	public void setOwner(String owner) { this.owner = owner; }
	public void setNum(int num) { this.num = num; }
	public void setId(String id) { this.id = id;}
	public void setPw(String pw) { this.pw = pw; }
	public void setContent(String content) { this.content = content; }
	public void setReg(Timestamp reg) { this.reg = reg; }
	
	public String getOwner() { return owner; }
	public int getNum() { return num; }
	public String getId() { return id; }
	public String getPw() { return pw; }
	public String getContent() { return content; }
	public Timestamp getReg() { return reg; }
}
