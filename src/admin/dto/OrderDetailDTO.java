package admin.dto;

import java.sql.Timestamp;

public class OrderDetailDTO {
	private int pdCode;
	private String productName;
	private String userAddr;
	private String userContact;
	private int price;
	private String color;
	private String sizes;
	private int pdQuantity;
	private String orderStatus;
	private String pdStatus;
	private Timestamp orderDate;
	private String userId;
	private int supplyPrice;
	private int amount;
	private int pdDetailCode;
	private int odCode;
	private String paymethod;
	private String phonenumber;
	private String invoice; // 송장번호
	
	
	
	public String getInvoice() {		return invoice;	}
	public void setInvoice(String invoice) {		this.invoice = invoice;	}
	public String getPhonenumber() {		return phonenumber;	}
	public void setPhonenumber(String phonenumber) {		this.phonenumber = phonenumber;	}
	public int getOdCode() {		return odCode;	}
	public void setOdCode(int odCode) {		this.odCode = odCode;	}
	public String getPaymethod() {		return paymethod;	}
	public void setPaymethod(String paymethod) {		this.paymethod = paymethod;	}
	public int getPdCode() {		return pdCode;	}
	public void setPdCode(int pdCode) {		this.pdCode = pdCode;	}
	public String getProductName() {		return productName;	}
	public void setProductName(String productName) {		this.productName = productName;	}
	public String getUserAddr() {		return userAddr;	}
	public void setUserAddr(String userAddr) {		this.userAddr = userAddr;	}
	public String getUserContact() {		return userContact;	}
	public void setUserContact(String userContact) {		this.userContact = userContact;	}
	public int getPrice() {		return price;	}
	public void setPrice(int price) {		this.price = price;	}
	public String getColor() {		return color;	}
	public void setColor(String color) {		this.color = color;	}
	public String getSizes() {		return sizes;	}
	public void setSizes(String sizes) {		this.sizes = sizes;	}
	public int getPdQuantity() {		return pdQuantity;	}
	public void setPdQuantity(int pdQuantity) {		this.pdQuantity = pdQuantity;	}
	public String getOrderStatus() {		return orderStatus;	}
	public void setOrderStatus(String orderStatus) {		this.orderStatus = orderStatus;	}
	public String getPdStatus() {		return pdStatus;	}
	public void setPdStatus(String pdStatus) {		this.pdStatus = pdStatus;	}
	public Timestamp getOrderDate() {		return orderDate;	}
	public void setOrderDate(Timestamp orderDate) {		this.orderDate = orderDate;	}
	public String getUserId() {		return userId;	}
	public void setUserId(String userId) {		this.userId = userId;	}
	public int getSupplyPrice() {		return supplyPrice;	}
	public void setSupplyPrice(int supplyPrice) {		this.supplyPrice = supplyPrice;	}
	public int getAmount() {		return amount;	}
	public void setAmount(int amount) {		this.amount = amount;	}
	public int getPdDetailCode() {		return pdDetailCode;	}
	public void setPdDetailCode(int pdDetailCode) {		this.pdDetailCode = pdDetailCode;
	}
	
	
	
	
	
}
