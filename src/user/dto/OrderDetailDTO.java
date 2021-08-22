package user.dto;

import java.sql.Timestamp;

public class OrderDetailDTO {
	private int pdDetailCode;
	private String userid;
	private int pdcode;  
	private String productname;  
	private String color;
	private String sizes;
	private int pdQuantity;
	private int supplyPrice; //¤Ì¤Ì
	private String orderstatus;
	private Timestamp orderdate;
	private int Amount; 
	private int odcode;
	private String paymethod;
	private String UserAddr;
	private String phonenumber;
	 	
	 	
	 	
		public String getUserAddr() {
		return UserAddr;
	}
	public void setUserAddr(String userAddr) {
		UserAddr = userAddr;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phoneNumber) {
		phonenumber = phoneNumber;
	}
		public int getPdDetailCode() {
			return pdDetailCode;
		}
		public void setPdDetailCode(int pdDetailCode) {
			this.pdDetailCode = pdDetailCode;
		}
		public String getUserid() {
			return userid;
		}
		public void setUserid(String userid) {
			this.userid = userid;
		}
		public int getPdcode() {
			return pdcode;
		}
		public void setPdcode(int pdcode) {
			this.pdcode = pdcode;
		}
		public String getProductname() {
			return productname;
		}
		public void setProductname(String productname) {
			this.productname = productname;
		}
		public String getColor() {
			return color;
		}
		public void setColor(String color) {
			this.color = color;
		}
		public String getSizes() {
			return sizes;
		}
		public void setSizes(String sizes) {
			this.sizes = sizes;
		}
		public int getPdQuantity() {
			return pdQuantity;
		}
		public void setPdQuantity(int pdQuantity) {
			this.pdQuantity = pdQuantity;
		}
		public int getSupplyPrice() {
			return supplyPrice;
		}
		public void setSupplyPrice(int supplyPrice) {
			this.supplyPrice = supplyPrice;
		}
		public String getOrderstatus() {
			return orderstatus;
		}
		public void setOrderstatus(String orderstatus) {
			this.orderstatus = orderstatus;
		}
		public Timestamp getOrderdate() {
			return orderdate;
		}
		public void setOrderdate(Timestamp orderdate) {
			this.orderdate = orderdate;
		}
		public int getAmount() {
			return Amount;
		}
		public void setAmount(int amount) {
			Amount = amount;
		}
		public int getOdcode() {
			return odcode;
		}
		public void setOdcode(int odcode) {
			this.odcode = odcode;
		}
		public String getPaymethod() {
			return paymethod;
		}
		public void setPaymethod(String paymethod) {
			this.paymethod = paymethod;
		}
		public String getUseraddr() {
			return UserAddr;
		}
		public void setUseraddr(String useraddr) {
			this.UserAddr = useraddr;
		}
	
	
	 	
	 	
	 	
	
}
