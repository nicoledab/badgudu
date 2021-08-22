package admin.dto;

public class OrderDeleteDTO {
	private int pdCode;
	private int OdCode;
	private String color;
	private String sizes;
	private int pdQuantity;
	private int orderQuant;
	private int remainQuant;
	
	public int getOdCode() {		return OdCode;	}
	public void setOdCode(int odCode) {		OdCode = odCode;	}
	public int getPdCode() {		return pdCode;	}
	public void setPdCode(int pdCode) {		this.pdCode = pdCode;	}
	public String getColor() {		return color;	}
	public void setColor(String color) {		this.color = color;	}
	public String getSizes() {		return sizes;	}
	public void setSizes(String sizes) {		this.sizes = sizes;	}
	public int getPdQuantity() {		return pdQuantity;	}
	public void setPdQuantity(int pdQuantity) {		this.pdQuantity = pdQuantity;	}
	public int getOrderQuant() {		return orderQuant;	}
	public void setOrderQuant(int orderQuant) {		this.orderQuant = orderQuant;	}
	public int getRemainQuant() {		return remainQuant;	}
	public void setRemainQuant(int remainQuant) {		this.remainQuant = remainQuant;	}
}
