package team03.bean;

public class SignUpDTO {
	private String id;
	private String pw;
	private String email1;
	private String email2;
	private String name;
	
	public void setId(String id) {
		this.id = id;
	}
	public String getId() {
		return id;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getPw() {
		return pw;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getEmail2() {
		return email2;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getName() {
		return name;
	}

}