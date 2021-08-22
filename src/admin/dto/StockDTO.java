package admin.dto;

import java.sql.Timestamp;

public class StockDTO {
	/*
	pdcode    		-- 상품번호
    productname 	-- 상품이름
    color       	-- 색상
    sizes      		-- 사이즈
    supplyprice     -- 공급가
    sellingprice    -- 판매단가
    pdquantity      -- 기초수량
    orderquant      -- 판매수량
    remainquant     -- 잔여수량
    */
	private int pdNumber;
	private String display;
    private int pdCategory;
    private String categoryName;
    private String productName;
    private String pdExplain;
    private String pdDetailExplain;
    private int supplyPrice;
    private int sellingPrice;
    private Timestamp regDate;
    private String color;
    private String size;
    private int pdQuantity;
    private int orderquant;
    private int remainquant;
    private int pdCode;
    
    
    public int getPdNumber() {		return pdNumber;	}
	public void setPdNumber(int pdNumber) {		this.pdNumber = pdNumber;	}
	
	public String getDisplay() {		return display;	}
	public void setDisplay(String display) {		this.display = display;	}
	
	public int getPdCategory() {		return pdCategory;	}
	public void setPdCategory(int pdCategory) {		this.pdCategory = pdCategory;	}
	
	public String getCategoryName() {		return categoryName;	}
	public void setCategoryName(String categoryName) {		this.categoryName = categoryName;	}
	
	public String getProductName() {		return productName;	}
	public void setProductName(String productName) {		this.productName = productName;	}
	
	public String getPdExplain() {		return pdExplain;	}
	public void setPdExplain(String pdExplain) {		this.pdExplain = pdExplain;	}
	
	public String getPdDetailExplain() {		return pdDetailExplain;	}
	public void setPdDetailExplain(String pdDetailExplain) {		this.pdDetailExplain = pdDetailExplain;	}
	
	public int getSupplyPrice() {		return supplyPrice;	}
	public void setSupplyPrice(int supplyPrice) {		this.supplyPrice = supplyPrice;	}
	
	public int getSellingPrice() {		return sellingPrice;	}
	public void setSellingPrice(int sellingPrice) {		this.sellingPrice = sellingPrice;	}
	
	public Timestamp getRegDate() {		return regDate;	}
	public void setRegDate(Timestamp regDate) {		this.regDate = regDate;	}
	
	public String getColor() {		return color;	}
	public void setColor(String color) {		this.color = color;	}
	
	public String getSize() {		return size;	}
	public void setSize(String size) {		this.size = size;	}
	
	public int getPdQuantity() {		return pdQuantity;	}
	public void setPdQuantity(int pdQuantity) {		this.pdQuantity = pdQuantity;	}
	
	public int getOrderquant() {		return orderquant;	}
	public void setOrderquant(int orderquant) {		this.orderquant = orderquant;	}
	
	public int getRemainquant() {		return remainquant;	}
	public void setRemainquant(int remainquant) {		this.remainquant = remainquant;	}
	
	public int getPdCode() {		return pdCode;	}
	public void setPdCode(int pdCode) {		this.pdCode = pdCode;	}
	
	
}
