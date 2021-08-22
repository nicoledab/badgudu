package user.dto;

import java.sql.Timestamp;

public class OrderListDTO {
	private int odnum;
	private String userid; 
	private String productname;  
	private int amount;
	private Timestamp orderDate;  
	private String userAddr;  
	private String paymethod;
	private String orderStatus;
	
	public int getOdnum() {		return odnum;	}
	public void setOdnum(int odnum) {		this.odnum = odnum;	}
	public String getUserid() {		return userid;	}
	public void setUserid(String userid) {		this.userid = userid;	}
	public String getProductname() {		return productname;	}
	public void setProductname(String productname) {		this.productname = productname;	}
	public int getAmount() {		return amount;	}
	public void setAmount(int amount) {		this.amount = amount;	}
	public Timestamp getOrderDate() {		return orderDate;	}
	public void setOrderDate(Timestamp orderDate) {		this.orderDate = orderDate;	}
	public String getUserAddr() {		return userAddr;	}
	public void setUserAddr(String userAddr) {		this.userAddr = userAddr;	}
	public String getPaymethod() {		return paymethod;	}
	public void setPaymethod(String paymethod) {		this.paymethod = paymethod;	}
	public String getOrderStatus() {		return orderStatus;	}
	public void setOrderStatus(String orderStatus) {		this.orderStatus = orderStatus;	}
}
