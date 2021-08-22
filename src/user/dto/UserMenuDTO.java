package user.dto;

public class UserMenuDTO {
	
	private int pdCode;
	private String productName;
	private int sellingPrice;
	private String color;
	private String size;
	private int pdQuantity;
	private int remainQuant;
	private int sale;
	private int event;
	
	
	
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
	public int getSellingPrice() {
		return sellingPrice;
	}
	public void setSellingPrice(int sellingPrice) {
		this.sellingPrice = sellingPrice;
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
	public int getRemainQuant() {
		return remainQuant;
	}
	public void setRemainQuant(int remainQuant) {
		this.remainQuant = remainQuant;
	}
	public int getSale() {
		return sale;
	}
	public void setSale(int sale) {
		this.sale = sale;
	}
	public int getEvent() {
		return event;
	}
	public void setEvent(int event) {
		this.event = event;
	}
	

}
