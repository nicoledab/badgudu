package admin.dto;

public class UpdateDTO {
	
	private int pdCode; // pdCode로 가져옴
	// PRODUCT
	private String display;
	private int pdCategory;
	private String productName;
	private String pdExplain;
	private String pdDetailExplain;
	private int supplyPrice;
	private int sellingPrice;
	private String productqty; //pdquantity와 동일
	private String color1;
	private String size1;
	private int sale;
	private int event;
	
	
	// STOCK update
	private int pdQuantity;
	private int remainQuant;
	private String [] colorOrigin;
	private String [] sizeOrigin;
	private String [] qtyOrigin;
	
	// PDIMAGE
	private String productImg1;
	private String productImg2;
	private String productImg3;
	private String productDetailImg1;
	private String productDetailImg2;
	
	// CATEGORY	
	private String categoryName;
	
	//STOCK INSERT
	private String [] cl;
	private String [] sz;
	private String [] qty;
	private String color;
	private String size;
	
	
	
	public String[] getColorOrigin() {
		return colorOrigin;
	}
	public void setColorOrigin(String[] colorOrigin) {
		this.colorOrigin = colorOrigin;
	}
	public String[] getSizeOrigin() {
		return sizeOrigin;
	}
	public void setSizeOrigin(String[] sizeOrigin) {
		this.sizeOrigin = sizeOrigin;
	}
	public String[] getQtyOrigin() {
		return qtyOrigin;
	}
	public void setQtyOrigin(String[] qtyOrigin) {
		this.qtyOrigin = qtyOrigin;
	}
	public String getColor1() {
		return color1;
	}
	public void setColor1(String color1) {
		this.color1 = color1;
	}
	public String getSize1() {
		return size1;
	}
	public void setSize1(String size1) {
		this.size1 = size1;
	}
	
	public String getProductqty() {
		return productqty;
	}
	public void setProductqty(String productqty) {
		this.productqty = productqty;
	}
	/////////////////
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getDisplay() {
		return display;
	}
	public void setDisplay(String display) {
		this.display = display;
	}
	public int getPdCategory() {
		return pdCategory;
	}
	public void setPdCategory(int pdCategory) {
		this.pdCategory = pdCategory;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getPdExplain() {
		return pdExplain;
	}
	public void setPdExplain(String pdExplain) {
		this.pdExplain = pdExplain;
	}
	public String getPdDetailExplain() {
		return pdDetailExplain;
	}
	public void setPdDetailExplain(String pdDetailExplain) {
		this.pdDetailExplain = pdDetailExplain;
	}
	public int getSupplyPrice() {
		return supplyPrice;
	}
	public void setSupplyPrice(int supplyPrice) {
		this.supplyPrice = supplyPrice;
	}
	public int getSellingPrice() {
		return sellingPrice;
	}
	public void setSellingPrice(int sellingPrice) {
		this.sellingPrice = sellingPrice;
	}
	public String[] getCl() {
		return cl;
	}
	public void setCl(String[] cl) {
		this.cl = cl;
	}
	public String[] getSz() {
		return sz;
	}
	public void setSz(String[] sz) {
		this.sz = sz;
	}
	public String[] getQty() {
		return qty;
	}
	public void setQty(String[] qty) {
		this.qty = qty;
	}
	public String getProductImg1() {
		return productImg1;
	}
	public void setProductImg1(String productImg1) {
		this.productImg1 = productImg1;
	}
	public String getProductImg2() {
		return productImg2;
	}
	public void setProductImg2(String productImg2) {
		this.productImg2 = productImg2;
	}
	public String getProductImg3() {
		return productImg3;
	}
	public void setProductImg3(String productImg3) {
		this.productImg3 = productImg3;
	}
	public String getProductDetailImg1() {
		return productDetailImg1;
	}
	public void setProductDetailImg1(String productDetailImg1) {
		this.productDetailImg1 = productDetailImg1;
	}
	public String getProductDetailImg2() {
		return productDetailImg2;
	}
	public void setProductDetailImg2(String productDetailImg2) {
		this.productDetailImg2 = productDetailImg2;
	}
	
	public String getColor() {
		String color ="";
		for(String c : cl) {
			color += c+"/";
		}
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getSize() {
		String size ="";
			for(String s : sz) {
				size += s+"/";
			}
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
	public int getPdCode() {
		return pdCode;
	}
	public void setPdCode(int pdCode) {
		this.pdCode = pdCode;
	}

	// event / sale 추가
	public int getSale() {   return sale;}
	public void setSale(int sale) {   this.sale = sale;}
	public int getEvent() {   return event;}
	public void setEvent(int event) {   this.event = event;}

}
