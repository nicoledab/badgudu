package user.dto;

import java.sql.Timestamp;

public class MemberDTO {
   private int num;
   private String pw;
   private String id;
   private String name;
   private String address;
   private int status;
   private Timestamp signupdate;
   private String phoneNumber;
   private String ph1;
   private String ph2;
   private String ph3;

   
   public void setPw(String pw) { this.pw = pw;}
   public void setId(String id) { this.id = id;}
   public void setName(String name) { this.name = name;}
   public void setAddress(String address) { this.address = address;}
   public void setStatus(int status) { this.status = status;}
   public void setSignupdate(Timestamp signupdate) {this.signupdate = signupdate;}
   public void setNum(int num) {this.num = num;}


   public String getPw() { return pw;}
   public String getId() { return id;}
   public String getName() { return name;}
   public String getAddress() { return address;}
   public int getStatus() { return status;}
   public Timestamp getSignupdate() {return signupdate;}
   public int getNum() {return num;}
   
   
   
	public String getPh1() {
	return ph1;
	}
	public void setPh1(String ph1) {
		this.ph1 = ph1;
	}
	public String getPh2() {
		return ph2;
	}
	public void setPh2(String ph2) {
		this.ph2 = ph2;
	}
	public String getPh3() {
		return ph3;
	}
	public void setPh3(String ph3) {
		this.ph3 = ph3;
	}
	public String getPhoneNumber() {
		phoneNumber = this.ph1+"-"+this.ph2+"-"+this.ph3;
		return phoneNumber;
	}
	public void setPhoneNumber(String phnoeNumber) {
		phoneNumber = this.ph1+"-"+this.ph2+"-"+this.ph3;
		this.phoneNumber = phoneNumber;
	}
   
   
   
   

}