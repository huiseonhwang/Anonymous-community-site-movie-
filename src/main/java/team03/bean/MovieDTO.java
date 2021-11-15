package team03.bean;

import java.sql.Timestamp;

public class MovieDTO {
	private int num;
	private String writer;
	private String pw;
	private String subject;
	private String kategorie;
	private String content;
	private String filename;
	private Timestamp reg;
	private int readcount;
	private int good;
	private int bad;
	
	public void setNum(int num) {
		this.num = num;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public void setKategorie(String kategorie) {
		this.kategorie = kategorie;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public void setBad(int bad) {
		this.bad = bad;
	}
	public int getNum() {
		return num;
	}
	public String getWriter() {
		return writer;
	}
	public String getPw() {
		return pw;
	}
	public String getSubject() {
		return subject;
	}
	public String getKategorie() {
		return kategorie;
	}
	public String getContent() {
		return content;	
	}
	public String getFilename() {
		return filename;
	}
	public Timestamp getReg() {
		return reg;
	}
	public int getReadcount() {
		return readcount;
	}
	public int getGood() {
		return good;
	}
	public int getBad() {
		return bad;
	}
}

