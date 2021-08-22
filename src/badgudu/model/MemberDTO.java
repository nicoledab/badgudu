package badgudu.model;


public class MemberDTO {
	private String pw;
	private String email;
	private String name;
	
	public void setPw(String pw) { this.pw = pw;}
	public void setEmail(String email) { this.email = email;}
	public void setName(String name) { this.name = name;}

	public String getPw() { return pw;}
	public String getEmail() { return email;}
	public String getName() { return name;}

}