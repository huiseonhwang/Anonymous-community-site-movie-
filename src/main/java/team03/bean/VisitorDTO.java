package team03.bean;

import java.sql.Timestamp;

public class VisitorDTO {
	private int num; 	
	private String id;		
	private String pw;		
	private String content;	
	private Timestamp reg;	
	
	public void setnum(int num) { this.num = num; }
	public int getnum() { return num; }
	
	public void setid(String id) { this.id = id;}
	public String getid() { return id; }
	
	public void setpw(String pw) { this.pw = pw; }
	public String getpw() { return pw; }
	
	public void setcontent(String content) { this.content = content; }
	public String getcontent() { return content; }
	
	public void setreg(Timestamp reg) { this.reg = reg; }
	public Timestamp getreg() { return reg; }
}

