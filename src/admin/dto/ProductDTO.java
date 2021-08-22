package admin.dto;

import java.sql.Timestamp;

public class ProductDTO {
   
   private int pdNumber;
   private String display;
   private int pdCategory;
   private String categoryName;
   
   private String productName;
   private String pdExplain;
   private String pdDetailExplain;
   private int supplyPrice;
   private int sellingPrice;
   private String [] cl;
   private String [] sz;
   private String [] qty;
   private Timestamp regDate;
   private String productImg1;
   private String productImg2;
   private String productImg3;
   private String productDetailImg1;
   private String productDetailImg2;
   private String color;
   private String size;
   private String pdQuantity;
   private int pdCode;
   
   private int sale;
   private int event;

   public int getPdNumber() {
      return pdNumber;
   }
   public void setPdNumber(int pdNumber) {
      this.pdNumber = pdNumber;
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
   public String getCategoryName() {
	   return categoryName;
   }
   public void setCategoryName(String categoryName) {
	   this.categoryName = categoryName;
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
   public Timestamp getRegDate() {
      return regDate;
   }
   public void setRegDate(Timestamp regDate) {
      this.regDate = regDate;
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
         color += c+" ";
      }
      return color;
   }
   public String getColor2() {
	   return color;
   }
   
   public String getSize() {
      String size ="";
      for(String s : sz) {
         size += s+" ";
      }
      return size;
   }
   public String getSize2() {
	   return size;
   }
   
   public String getPdQuantity() {
      String pdQuantity ="";
      for(String q : qty) {
         pdQuantity += q+" ";
      }
      return pdQuantity;
   }
   
   public void setColor(String color) {
      this.color = color;
   }
   public void setSize(String size) {
      this.size = size;
   }
   public void setPdQuantity(String pdQuantity) {
      this.pdQuantity = pdQuantity;
   }
   public int getPdCode() {
	   return pdCode;
   }
   public void setPdCode(int pdCode) {
	   this.pdCode = pdCode;
   }
// event / sale Ãß°¡
   public int getSale() {   return sale;}
   public void setSale(int sale) {   this.sale = sale;}
   public int getEvent() {   return event;}
   public void setEvent(int event) {   this.event = event;}
   
}