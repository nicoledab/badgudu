package admin.dto;

import java.sql.Timestamp;

public class OrderDTO {
	
	private int pdCode;
	private String productName;
	private String useraddr;
	private String usercontact;
	private int Price;
	private String color;
	private String size;
	private int pdQuantity;
	private String orderstatus;
	private String pdstatus;
	private Timestamp orderdate;
	private int orderquant;
	private int remainquant;
	private int amount;
	
	
	
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getPdCode() {
		return pdCode;
	}
	public void setPdCode(int pdCode) {
		this.pdCode = pdCode;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getUseraddr() {
		return useraddr;
	}
	public void setUseraddr(String useraddr) {
		this.useraddr = useraddr;
	}
	public String getUsercontact() {
		return usercontact;
	}
	public void setUsercontact(String usercontact) {
		this.usercontact = usercontact;
	}
	public int getPrice() {
		return Price;
	}
	public void setPrice(int price) {
		Price = price;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public int getPdQuantity() {
		return pdQuantity;
	}
	public void setPdQuantity(int pdQuantity) {
		this.pdQuantity = pdQuantity;
	}
	public String getOrderstatus() {
		return orderstatus;
	}
	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
	}
	public String getPdstatus() {
		return pdstatus;
	}
	public void setPdstatus(String pdstatus) {
		this.pdstatus = pdstatus;
	}
	public Timestamp getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(Timestamp orderdate) {
		this.orderdate = orderdate;
	}
	public int getOrderquant() {
		return orderquant;
	}
	public void setOrderquant(int orderquant) {
		this.orderquant = orderquant;
	}
	public int getRemainquant() {
		return remainquant;
	}
	public void setRemainquant(int remainquant) {
		this.remainquant = remainquant;
	}
	
	
	
	
}
