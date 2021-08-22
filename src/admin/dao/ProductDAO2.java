package admin.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import admin.dto.ProductDTO;
import admin.dto.UpdateDTO;
import admin.dto.StockDTO;
import admin.dao.ConnectionDAO;

public class ProductDAO2 {
   
   private Connection conn = null;
   private PreparedStatement pstmt = null;
   private ResultSet rs = null;
   
   // 전체 상품 개수
   public int getProductCount() throws Exception {
      int x=0;
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select count(*) from product");
         rs = pstmt.executeQuery(); 
         if (rs.next()) { // rs.getInt(1) = int로 된 첫 번째 컬럼을 꺼내겠다 // select count(*) from board 했으니 컬럼명이 count(*) // rs.getInt(1) = rs.getInt("count(*)")
            x= rs.getInt(1); // 검색된 첫 번째 컬럼을 의미 // 원래 rs.getInt("count(*)") 이런 식으로 썼음 // select count(*) from board 실행값(=10)을 넣어준 것
         }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return x; 
   }
   
   // 전체 글 목록
   public List getProducts(int start, int end) throws Exception { // 글 목록 불러옴
      List productList=null;
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select pdCode,display,pdCategory,productName,pdExplain,pdDetailExplain,supplyPrice,sellingPrice,color,sizes,pdQuantity,regDate,sale, event,r "
               + "from (select pdCode,display,pdCategory,productName,pdExplain,pdDetailExplain,supplyPrice,sellingPrice,color,sizes,pdQuantity,regDate,sale, event, rownum r "
               + "from (select * "
               + "from product order by pdCode desc) order by pdCode desc) where r >= ? and r <= ?");
               pstmt.setInt(1, start); 
               pstmt.setInt(2, end); 
               // 검색 결과 순서대로 번호 붙인 rownum이 1 이상 10 이하인 글 불러옴 = 글 목록 불러온 것
               
               rs = pstmt.executeQuery(); // 4단계 실행
               if (rs.next()) { 
                  productList = new ArrayList(end);
                  do{ 
                     ProductDTO product = new ProductDTO(); // 반복할 때마다 DTO 생성해서 집어넣기 // DTO를 변수 article에 넣음
                     product.setPdCode(rs.getInt("pdCode")); // DB에서 꺼낸 num을 DTO인 article에 set // num이라는 컬럼명을 찾아서 집어넣음
                     product.setDisplay(rs.getString("display"));
                     product.setPdCategory(rs.getInt("pdCategory"));
                     product.setProductName(rs.getString("productName"));
                     product.setPdExplain(rs.getString("pdExplain"));
                     product.setPdDetailExplain(rs.getString("pdDetailExplain"));
                     product.setSupplyPrice(rs.getInt("supplyPrice"));
                     product.setSellingPrice(rs.getInt("sellingPrice"));
                     product.setColor(rs.getString("color"));
                     product.setSize(rs.getString("sizes"));
                     product.setPdQuantity(rs.getString("pdQuantity"));
                     product.setRegDate(rs.getTimestamp("regDate"));
                     product.setSale(rs.getInt("sale"));
                     product.setEvent(rs.getInt("event"));
                     productList.add(product); // 마지막에 list에 add
                  }while(rs.next());
               }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return productList; // DB의 데이터를 DTO에 다 저장해서 List에 넣어줌
   }
   
   // 상품 목록 불러오는 메소드
   public ArrayList<ProductDTO> getList() {
      ArrayList<ProductDTO> list = new ArrayList<ProductDTO>();
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select * from product order by pdCode desc");
         
         rs = pstmt.executeQuery();
         while(rs.next()) {
            ProductDTO dto = new ProductDTO();
            dto.setPdCode(rs.getInt("pdCode"));
            dto.setDisplay(rs.getString("display"));
            dto.setPdCategory(rs.getInt("pdCategory"));
            dto.setProductName(rs.getString("productName"));
            dto.setPdExplain(rs.getString("pdExplain"));
            dto.setPdDetailExplain(rs.getString("pdDetailExplain"));
            dto.setSupplyPrice(rs.getInt("supplyPrice"));
            dto.setSellingPrice(rs.getInt("sellingPrice"));
            dto.setColor(rs.getString("color"));
            dto.setSize(rs.getString("sizes"));
            dto.setPdQuantity(rs.getString("pdQuantity"));
            dto.setRegDate(rs.getTimestamp("regDate"));
            dto.setSale(rs.getInt("sale"));
            dto.setEvent(rs.getInt("event"));
            list.add(dto);
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return list;
   }
   
   // 상품종류 숫자(문자)에서 한글(문자)로 나올 수 있게 // 예은님 메소드
   public String categoryName(int currentCate) {
      String categoryName = null;
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select categoryname from category where pdcategory=?");
         pstmt.setInt(1, currentCate);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            categoryName = rs.getString(1);
         }
      }catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return categoryName;
   }
   
   // getArticleCount // 검색 상품 개수
   public int getProductCount(String col, String str) throws Exception {
      int x=0;
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "select count(*) from product where "+col+" like '%"+str+"%'";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(); // 4단계 실행
         if (rs.next()) { // rs.getInt(1) = int로 된 첫 번째 컬럼을 꺼내겠다 // select count(*) from board 했으니 컬럼명이 count(*) // rs.getInt(1) = rs.getInt("count(*)")
            x= rs.getInt(1); // 검색된 첫 번째 컬럼을 의미 // 원래 rs.getInt("count(*)") 이런 식으로 썼음 // select count(*) from board 실행값(=10)을 넣어준 것
         }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return x; 
   }
   
   // getArticles // 검색 결과 목록 불러옴 (상품번호, 상품명)
   public List getProducts(String col, String search, int start, int end) throws Exception {
      List productList=null;
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select pdCode,display,pdCategory,productName,pdExplain,pdDetailExplain,supplyPrice,sellingPrice,color,sizes,pdQuantity,regDate,sale,event, r "
         		+ "from (select pdCode,display,pdCategory,productName,pdExplain,pdDetailExplain,supplyPrice,sellingPrice,color,sizes,pdQuantity,regDate,sale,event,rownum  r "
         		+ "from (select * from product where "+col+" like '%"+search+"%' order by pdCode desc) order by pdCode desc) "
         		+ "where r >= ? and r <= ?");
               pstmt.setInt(1, start); 
               pstmt.setInt(2, end); 
               // 검색 결과 순서대로 번호 붙인 rownum이 1 이상 10 이하인 글 불러옴 = 글 목록 불러온 것
               
               rs = pstmt.executeQuery(); // 4단계 실행
               if (rs.next()) { 
                  productList = new ArrayList(end);
                  do{ 
                     ProductDTO product = new ProductDTO(); // 반복할 때마다 DTO 생성해서 집어넣기 // DTO를 변수 article에 넣음
                     product.setPdCode(rs.getInt("pdCode")); // DB에서 꺼낸 num을 DTO인 article에 set // num이라는 컬럼명을 찾아서 집어넣음
                     product.setDisplay(rs.getString("display"));
                     product.setPdCategory(rs.getInt("pdCategory"));
                     product.setProductName(rs.getString("productName"));
                     product.setPdExplain(rs.getString("pdExplain"));
                     product.setPdDetailExplain(rs.getString("pdDetailExplain"));
                     product.setSupplyPrice(rs.getInt("supplyPrice"));
                     product.setSellingPrice(rs.getInt("sellingPrice"));
                     product.setColor(rs.getString("color"));
                     product.setSize(rs.getString("sizes"));
                     product.setPdQuantity(rs.getString("pdQuantity"));
                     product.setRegDate(rs.getTimestamp("regDate"));
                     product.setSale(rs.getInt("sale"));
                     product.setEvent(rs.getInt("event"));
                     productList.add(product); // 마지막에 list에 add
                  }while(rs.next());
               }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return productList; // DB의 데이터를 DTO에 다 저장해서 List에 넣어줌
   }
   
   // getArticles // 검색 결과 목록 불러옴 (상품종류)
   public List getProducts2(String col, String category, int start, int end) throws Exception { 
      List productList=null;
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select pdCode,display,pdCategory,productName,pdExplain,pdDetailExplain,supplyPrice,sellingPrice,color,sizes,pdQuantity,regDate,sale,eventr "
               + "from (select pdCode,display,pdCategory,productName,pdExplain,pdDetailExplain,supplyPrice,sellingPrice,color,sizes,pdQuantity,regDate,rownum,sale,event  r "
               + "from (select * "
               + "from product where "+col+" like '%"+category+"%' order by pdCode desc) order by pdCode desc) where r >= ? and r <= ?");
               pstmt.setInt(1, start);
               pstmt.setInt(2, end);
               // 검색 결과 순서대로 번호 붙인 rownum이 1 이상 10 이하인 글 불러옴 = 글 목록 불러온 것
               
               rs = pstmt.executeQuery(); // 4단계 실행
               if (rs.next()) { 
                  productList = new ArrayList(end);
                  do{ 
                     ProductDTO product = new ProductDTO();  // 반복할 때마다 DTO 생성해서 집어넣기 // DTO를 변수 article에 넣음
                     product.setPdCode(rs.getInt("pdCode")); // DB에서 꺼낸 num을 DTO인 article에 set // num이라는 컬럼명을 찾아서 집어넣음
                     product.setDisplay(rs.getString("display"));
                     product.setPdCategory(rs.getInt("pdCategory"));
                     product.setProductName(rs.getString("productName"));
                     product.setPdExplain(rs.getString("pdExplain"));
                     product.setPdDetailExplain(rs.getString("pdDetailExplain"));
                     product.setSupplyPrice(rs.getInt("supplyPrice"));
                     product.setSellingPrice(rs.getInt("sellingPrice"));
                     product.setColor(rs.getString("color"));
                     product.setSize(rs.getString("sizes"));
                     product.setPdQuantity(rs.getString("pdQuantity"));
                     product.setRegDate(rs.getTimestamp("regDate"));
                     product.setSale(rs.getInt("sale"));
                     product.setEvent(rs.getInt("event"));
                     productList.add(product); // 마지막에 list에 add
                  }while(rs.next());
               }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return productList; // DB의 데이터를 DTO에 다 저장해서 List에 넣어줌
   }

   // 등록된 상품 삭제
/*   public void deleteList(int pdCode) {
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("update product set status=3 where pdCode=?"); // 
         
         pstmt.setInt(1, pdCode);
         pstmt.executeUpdate();
   }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
   } 
 */
   
   // 상품번호로 PRODUCT 데이터 가져오기   
   public UpdateDTO getData(String pdCode) {
      UpdateDTO dto = null;
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "select * from product where pdCode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, pdCode);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            dto = new UpdateDTO();
            dto.setPdCode(rs.getInt("pdCode"));
            dto.setDisplay(rs.getString("display"));
            dto.setPdCategory(rs.getInt("pdCategory"));
            dto.setProductName(rs.getString("productName")+"");
            dto.setPdExplain(rs.getString("pdExplain"));
            dto.setPdDetailExplain(rs.getString("pdDetailExplain"));
            dto.setSupplyPrice(rs.getInt("supplyPrice"));
            dto.setSellingPrice(rs.getInt("sellingPrice"));
            dto.setCl(rs.getString("color").split("/"));
            dto.setSz(rs.getString("sizes").split("/"));
            dto.setSale(rs.getInt("sale"));
            dto.setEvent(rs.getInt("event"));
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return dto;
   }
   
   // 상품번호로 STOCK 데이터 가져오기
   public UpdateDTO getData2(String pdCode) {
      UpdateDTO dto = null;
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "select * from stock where pdCode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, pdCode);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            dto = new UpdateDTO();
            dto.setColor(rs.getString("color"));
            dto.setSize(rs.getString("sizes"));
            dto.setPdQuantity(rs.getInt("remainQuant"));
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return dto;
   }
///////////////// 최예은 수정함//////////////////////////////////////////////////////////////////////////////      
   public UpdateDTO getimageData(String pdCode) {
      UpdateDTO dto = null;
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "select * from pdimage where pdcode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, pdCode);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            dto = new UpdateDTO();
            dto.setProductImg1(rs.getString("productimg1"));
            dto.setProductImg2(rs.getString("productimg2"));
            dto.setProductImg3(rs.getString("productimg3"));
            dto.setProductDetailImg1(rs.getString("productdetailimg1"));
            dto.setProductDetailImg2(rs.getString("productdetailimg2"));
         }
         
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return dto;
   }
   
//   // 상품 색상, 사이즈별 재고 확인 
   public ArrayList<UpdateDTO> stockCheck(String pdCode) {
      ArrayList<UpdateDTO> list = new ArrayList<UpdateDTO>();
      try {
         conn = ConnectionDAO.getConnection();            
         pstmt = conn.prepareStatement("select color,sizes,remainQuant from stock where pdCode=? order by color, sizes");
         pstmt.setString(1, pdCode);
         rs = pstmt.executeQuery();
         while(rs.next()) {
            UpdateDTO dto = new UpdateDTO();               
            dto.setColor1(rs.getString("color"));
            dto.setSize1(rs.getString("sizes"));               
            dto.setRemainQuant(rs.getInt("remainQuant"));
            list.add(dto);
         }
      }catch(Exception e) {
            e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return list;
   }
   
   
   // PRODUCT DB update
   public void productUpdate(UpdateDTO dto) {
	  String color = "";
	  String size = "";
      try {
    	  
         conn = ConnectionDAO.getConnection();
         
         String sql = "select DISTINCT(color) from stock where pdcode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, dto.getPdCode());
         rs = pstmt.executeQuery();
         while(rs.next()) {
            color += rs.getString(1)+" ";
         }
         
         sql = "select DISTINCT(sizes) from stock where pdcode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, dto.getPdCode());
         rs = pstmt.executeQuery();
         while(rs.next()) {
            size += rs.getString(1)+" ";
         }
         
         sql = "update product set display=?, pdCategory=?, productName=?, pdExplain=?, pdDetailExplain=?, supplyPrice=?, sellingPrice=?, pdQuantity=?, color=?, sizes=?, sale=?, event=? where pdCode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, dto.getDisplay());
         pstmt.setInt(2, dto.getPdCategory());
         pstmt.setString(3, dto.getProductName());
         pstmt.setString(4, dto.getPdExplain());
         pstmt.setString(5, dto.getPdDetailExplain());
         pstmt.setInt(6, dto.getSupplyPrice());
           pstmt.setInt(7, dto.getSellingPrice());
           pstmt.setString(8, dto.getProductqty());
           pstmt.setString(9, color);
           pstmt.setString(10, size);
           pstmt.setInt(11, dto.getSale());
           pstmt.setInt(12, dto.getEvent());
           pstmt.setInt(13, dto.getPdCode());
         pstmt.executeUpdate(); // 4단계
      }catch(Exception e){
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
   }
   
   //STOCK DB update
   public void stockUpdate(UpdateDTO dto) {
      try {
         conn = ConnectionDAO.getConnection();
         String color = "";
         String sizes = "";
         int x = 0; //pdnumber
         int y = 0; //orderquant
         for(int i = 0; i<dto.getColorOrigin().length; i++) { //6
            
            color = dto.getColorOrigin()[i]; //ex)ivory
            sizes = dto.getSizeOrigin()[i]; //ex)240
            String sql = "select pdnumber from stock where pdcode=? and color = ? and sizes = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getPdCode());
            pstmt.setString(2, color);
            pstmt.setString(3, sizes);
            rs = pstmt.executeQuery();
            while(rs.next()) {
               
               x = rs.getInt(1);
               sql = "select orderquant from stock where pdnumber=?";
               pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, x);
               rs = pstmt.executeQuery();
               if(rs.next()) {
                  y = rs.getInt(1);
               }
               
               sql = "update stock set display=?, pdCategory=?, productName=?, pdExplain=?, pdDetailExplain=?, supplyPrice=?, sellingPrice=?, pdquantity=?, remainquant=?, color=?, sizes=?  where pdnumber=?";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, dto.getDisplay());
               pstmt.setInt(2, dto.getPdCategory());
               pstmt.setString(3, dto.getProductName());
               pstmt.setString(4, dto.getPdExplain());
               pstmt.setString(5, dto.getPdDetailExplain());
               pstmt.setInt(6, dto.getSupplyPrice());
               pstmt.setInt(7, dto.getSellingPrice());
               String qty = dto.getQtyOrigin()[i]; 
               pstmt.setInt(8, Integer.parseInt(qty)+y); // 기초수량
               pstmt.setInt(9, Integer.parseInt(qty)); // 잔여수량
               pstmt.setString(10, color);
               pstmt.setString(11, sizes);
               pstmt.setInt(12, x);
               pstmt.executeUpdate();
               
            }
         }
      } catch(Exception e) {
         e.printStackTrace();
      } finally{
         ConnectionDAO.close(rs, pstmt, conn);
      }
   }
   

   // PDIMAGE DB update
   public void imageUpdate(UpdateDTO dto) {
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "update pdimage set productImg1=?, productImg2=?, productImg3=?, productDetailImg1=?, productDetailImg2=? where pdCode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, dto.getProductImg1());
         pstmt.setString(2, dto.getProductImg2());
         pstmt.setString(3, dto.getProductImg3());
         pstmt.setString(4, dto.getProductDetailImg1());
         pstmt.setString(5, dto.getProductDetailImg2());
         pstmt.setInt(6, dto.getPdCode());
      
         pstmt.executeUpdate(); // 4단계
      }catch(Exception e){
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
   }
   
   public void stockAdd(UpdateDTO dto) {
      try {
         conn = ConnectionDAO.getConnection();
         String color = "";
         String sizes = "";
         int i = 0;
         for(String c : dto.getCl()) {
            for(String s : dto.getSz()) {
               color = c;
               sizes = s;
               String sql = "insert into stock values(stock_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,?,sysdate,?,0,?)";
               pstmt = conn.prepareStatement(sql);
               pstmt.setString(1, dto.getDisplay());
               pstmt.setInt(2, dto.getPdCategory());
               pstmt.setString(3, dto.getProductName());
               pstmt.setString(4, dto.getPdExplain());
               pstmt.setString(5, dto.getPdDetailExplain());
               pstmt.setInt(6, dto.getSupplyPrice());
               pstmt.setInt(7, dto.getSellingPrice());
               String pdQuantity = dto.getQty()[i];
               pstmt.setInt(8, Integer.parseInt(pdQuantity));
               pstmt.setString(9, color);
               pstmt.setString(10, sizes);
               pstmt.setInt(11, dto.getPdCode());
               pstmt.setInt(12, Integer.parseInt(pdQuantity));
               
               
               pstmt.executeUpdate();
               ++i;
            }
            
         }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
   }
   
   public void productUp(UpdateDTO dto) {
      String color = "";
      String size = "";
      String qty = "";
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "select DISTINCT(color) from stock where pdcode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, dto.getPdCode());
         rs = pstmt.executeQuery();
         while(rs.next()) {
            color += rs.getString(1)+" ";
         }
         
         sql = "select DISTINCT(sizes) from stock where pdcode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, dto.getPdCode());
         rs = pstmt.executeQuery();
         while(rs.next()) {
            size += rs.getString(1)+" ";
         }
         
         sql = "select remainquant from stock where pdcode=? order by pdnumber";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, dto.getPdCode());
         rs = pstmt.executeQuery();
         while(rs.next()) {
            qty += rs.getString(1)+" ";
         }
         
         sql = "update product set color = ?, sizes = ?, pdquantity =? where pdcode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, color);
         pstmt.setString(2, size);
         pstmt.setString(3, qty);
         pstmt.setInt(4, dto.getPdCode());
         pstmt.executeUpdate();
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
   }

///////////////// 이혜연 추가함//////////////////////////////////////////////////////////////////////////////  

   // PRODUCT 테이블 DB 삭제 delete
   public boolean productDelete(String id, String password, int pdCode) {
      boolean result = false;
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "select * from member where id=? and password=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         pstmt.setString(2, password);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            sql = "delete from product where pdCode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, pdCode);
            pstmt.executeUpdate();
            result = true;
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return result;
   }
   
   // STOCK 테이블 DB 삭제 delete
   public boolean stockDelete(String id, String password, int pdCode) {
      boolean result = false;
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "select * from member where id=? and password=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);
         pstmt.setString(2, password);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            sql = "delete from stock where pdCode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, pdCode);
            pstmt.executeUpdate();
            result = true;
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return result;
   }
      
   // PDIMAGE 테이블 DB 삭제 delete
   public boolean pdImageDelete(String id, String password, int pdCode) {
   boolean result = false;
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "select * from member where id=? and password=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, id);      
         pstmt.setString(2, password);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            sql = "delete from pdimage where pdCode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, pdCode);
            pstmt.executeUpdate();
            result = true;
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return result;
   }
   
// stock 전체 상품 개수 - 페이징
		public int getStockCount() throws Exception {
			int x=0;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select count(*) from stock");
				rs = pstmt.executeQuery(); 
				if (rs.next()) { // rs.getInt(1) = int로 된 첫 번째 컬럼을 꺼내겠다 // select count(*) from board 했으니 컬럼명이 count(*) // rs.getInt(1) = rs.getInt("count(*)")
					x= rs.getInt(1); // 검색된 첫 번째 컬럼을 의미 // 원래 rs.getInt("count(*)") 이런 식으로 썼음 // select count(*) from board 실행값(=10)을 넣어준 것
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return x; 
		}
		
		// stock 목록 불러오는 메소드
		public ArrayList<StockDTO> getStockList() {
			ArrayList<StockDTO> list = new ArrayList<StockDTO>();
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select * from stock order by pdCode desc");
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					StockDTO dto = new StockDTO();
					dto.setPdCode(rs.getInt("pdCode")); // DB에서 꺼낸 num을 DTO인 article에 set // num이라는 컬럼명을 찾아서 집어넣음
					dto.setProductName(rs.getString("productName"));
					dto.setColor(rs.getString("color"));
					dto.setSize(rs.getString("sizes"));
					dto.setSupplyPrice(rs.getInt("supplyPrice"));
					dto.setSellingPrice(rs.getInt("sellingPrice"));
					dto.setPdQuantity(rs.getInt("pdQuantity"));
					dto.setOrderquant(rs.getInt("orderquant"));
					dto.setRemainquant(rs.getInt("remainquant"));
					list.add(dto);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return list;
		}
		
		// stock 전체 글 목록 - 페이징
		public List getStock(int start, int end) throws Exception { // 글 목록 불러옴
			List stockList=null;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select pdCode,productName,color,sizes,supplyPrice,sellingPrice,pdQuantity,orderquant,remainquant,r "
						+ "from (select pdCode,productName,color,sizes,supplyPrice,sellingPrice,pdQuantity,orderquant,remainquant,rownum r "
						+ "from (select * "
						+ "from stock order by pdCode desc) order by pdCode desc) where r >= ? and r <= ?");
						pstmt.setInt(1, start); 
						pstmt.setInt(2, end); 
						// 검색 결과 순서대로 번호 붙인 rownum이 1 이상 10 이하인 글 불러옴 = 글 목록 불러온 것
						
						rs = pstmt.executeQuery(); // 4단계 실행
						if (rs.next()) { 
							stockList = new ArrayList(end);
							do{ 
								StockDTO stock = new StockDTO(); // 반복할 때마다 DTO 생성해서 집어넣기 // DTO를 변수 article에 넣음
								stock.setPdCode(rs.getInt("pdCode")); // DB에서 꺼낸 num을 DTO인 article에 set // num이라는 컬럼명을 찾아서 집어넣음
								stock.setProductName(rs.getString("productName"));
								stock.setColor(rs.getString("color"));
								stock.setSize(rs.getString("sizes"));
								stock.setSupplyPrice(rs.getInt("supplyPrice"));
								stock.setSellingPrice(rs.getInt("sellingPrice"));
								stock.setPdQuantity(rs.getInt("pdQuantity"));
								stock.setOrderquant(rs.getInt("orderquant"));
								stock.setRemainquant(rs.getInt("remainquant"));
								stockList.add(stock); // 마지막에 list에 add
							}while(rs.next());
						}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return stockList; // DB의 데이터를 DTO에 다 저장해서 List에 넣어줌
		}
		
		// 재고검색 .. col = 제목/내용 (검색 탭 선택 값), search  = 검색 값
		public int getArticleCount(String col , String search) throws Exception {
			int x=0;
			try {
				conn = ConnectionDAO.getConnection();
				String sql = "select count(*) from stock where "+col+" like '%"+search+"%'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					x= rs.getInt(1); 
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return x; 
		}
		// 검색2
		public List getArticles(String col , String search, int start, int end) throws Exception {
			List articleList=null;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select pdCode,productName,color,sizes,supplyPrice,sellingPrice,pdQuantity,orderquant,remainquant,r "
						+ "from (select pdCode,productName,color,sizes,supplyPrice,sellingPrice,pdQuantity,orderquant,remainquant,rownum r "
						+ "from (select * "
						+ "from stock where "+col+" like '%"+search+"%' order by pdCode desc) order by pdCode desc) where r >= ? and r <= ?");
						pstmt.setInt(1, start);     
						pstmt.setInt(2, end); 
						//System.out.println("search" + search); // search 값이 잘 넘어오는지 확인 위해 
						//System.out.println("col" + col);		  // col 값이 잘 넘어오는지 확인 위해
				rs = pstmt.executeQuery();
						if (rs.next()) {
							articleList = new ArrayList(end); 
							do{ 
								StockDTO article= new StockDTO();
								article.setPdCode(rs.getInt("pdCode")); // DB에서 꺼낸 num을 DTO인 article에 set // num이라는 컬럼명을 찾아서 집어넣음
								article.setProductName(rs.getString("productName"));
								article.setColor(rs.getString("color"));
								article.setSize(rs.getString("sizes"));
								article.setSupplyPrice(rs.getInt("supplyPrice"));
								article.setSellingPrice(rs.getInt("sellingPrice"));
								article.setPdQuantity(rs.getInt("pdQuantity"));
								article.setOrderquant(rs.getInt("orderquant"));
								article.setRemainquant(rs.getInt("remainquant"));;
								articleList.add(article); 
							}while(rs.next());
						}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {	
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return articleList;
		}
		
		public List soldStock(int startRow, int endRow) {
			List list = null;
			try {
				conn = ConnectionDAO.getConnection();
				String sql = "select * from(select pdcode, productname, color, sizes, remainquant, row_number() over (order by remainquant asc) r "
						+ "from stock where remainquant<=5 order by remainquant asc, pdcode desc) where r>=? and r<=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					list = new ArrayList(endRow);
					do {
						StockDTO dto = new StockDTO();
						dto.setPdCode(rs.getInt("pdcode"));
						dto.setProductName(rs.getString("productname"));
						dto.setColor(rs.getString("color"));
						dto.setSize(rs.getString("sizes"));
						dto.setRemainquant(rs.getInt("remainquant"));
						list.add(dto);
					}while(rs.next());
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return list;
		}
		public int soldStockCount() {
			int x = 0;
			try {
				conn = ConnectionDAO.getConnection();
				String sql = "select count(*) from stock where remainquant<=5";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					x = rs.getInt(1);
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return x;
		}
   
}

