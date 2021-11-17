package team03.bean;

import java.sql.Timestamp;

public class Q_DTO {
	private int num;
	private String id;
	private String pw; 
	private String subject;
	private String content;
	private Timestamp reg;
	private int readcount;
	private int ref;
	private int re_step;
	private int re_level;
	
	public void setNum(int num) { this.num = num; }
	public void setId(String id) { this.id = id; }
	public void setPw(String pw) { this.pw = pw; }
	public void setSubject(String subject) { this.subject = subject; }
	public void setContent(String content) { this.content = content; }
	public void setReg(Timestamp reg) { this.reg = reg; }
	public void setReadcount(int readcount) { this.readcount = readcount; }
	public void setRef(int ref) { this.ref = ref; }
	public void setRe_step(int re_step) { this.re_step = re_step; }
	public void setRe_level(int re_level) { this.re_level = re_level; }  
	
	public int getNum() { return num; }
	public String getId() { return id; }
	public String getPw() { return pw; }
	public String getSubject() { return subject; }
	public String getContent() { return content; } 
	public Timestamp getReg() { return reg; }
	public int getReadcount() { return readcount; }
	public int getRef() { return ref; }
	public int getRe_step() { return re_step; }
	public int getRe_level() { return re_level; }
}
