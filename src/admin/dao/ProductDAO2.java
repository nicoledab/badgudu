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
   
   // ��ü ��ǰ ����
   public int getProductCount() throws Exception {
      int x=0;
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select count(*) from product");
         rs = pstmt.executeQuery(); 
         if (rs.next()) { // rs.getInt(1) = int�� �� ù ��° �÷��� �����ڴ� // select count(*) from board ������ �÷����� count(*) // rs.getInt(1) = rs.getInt("count(*)")
            x= rs.getInt(1); // �˻��� ù ��° �÷��� �ǹ� // ���� rs.getInt("count(*)") �̷� ������ ���� // select count(*) from board ���ప(=10)�� �־��� ��
         }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return x; 
   }
   
   // ��ü �� ���
   public List getProducts(int start, int end) throws Exception { // �� ��� �ҷ���
      List productList=null;
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select pdCode,display,pdCategory,productName,pdExplain,pdDetailExplain,supplyPrice,sellingPrice,color,sizes,pdQuantity,regDate,sale, event,r "
               + "from (select pdCode,display,pdCategory,productName,pdExplain,pdDetailExplain,supplyPrice,sellingPrice,color,sizes,pdQuantity,regDate,sale, event, rownum r "
               + "from (select * "
               + "from product order by pdCode desc) order by pdCode desc) where r >= ? and r <= ?");
               pstmt.setInt(1, start); 
               pstmt.setInt(2, end); 
               // �˻� ��� ������� ��ȣ ���� rownum�� 1 �̻� 10 ������ �� �ҷ��� = �� ��� �ҷ��� ��
               
               rs = pstmt.executeQuery(); // 4�ܰ� ����
               if (rs.next()) { 
                  productList = new ArrayList(end);
                  do{ 
                     ProductDTO product = new ProductDTO(); // �ݺ��� ������ DTO �����ؼ� ����ֱ� // DTO�� ���� article�� ����
                     product.setPdCode(rs.getInt("pdCode")); // DB���� ���� num�� DTO�� article�� set // num�̶�� �÷����� ã�Ƽ� �������
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
                     productList.add(product); // �������� list�� add
                  }while(rs.next());
               }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return productList; // DB�� �����͸� DTO�� �� �����ؼ� List�� �־���
   }
   
   // ��ǰ ��� �ҷ����� �޼ҵ�
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
   
   // ��ǰ���� ����(����)���� �ѱ�(����)�� ���� �� �ְ� // ������ �޼ҵ�
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
   
   // getArticleCount // �˻� ��ǰ ����
   public int getProductCount(String col, String str) throws Exception {
      int x=0;
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "select count(*) from product where "+col+" like '%"+str+"%'";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery(); // 4�ܰ� ����
         if (rs.next()) { // rs.getInt(1) = int�� �� ù ��° �÷��� �����ڴ� // select count(*) from board ������ �÷����� count(*) // rs.getInt(1) = rs.getInt("count(*)")
            x= rs.getInt(1); // �˻��� ù ��° �÷��� �ǹ� // ���� rs.getInt("count(*)") �̷� ������ ���� // select count(*) from board ���ప(=10)�� �־��� ��
         }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return x; 
   }
   
   // getArticles // �˻� ��� ��� �ҷ��� (��ǰ��ȣ, ��ǰ��)
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
               // �˻� ��� ������� ��ȣ ���� rownum�� 1 �̻� 10 ������ �� �ҷ��� = �� ��� �ҷ��� ��
               
               rs = pstmt.executeQuery(); // 4�ܰ� ����
               if (rs.next()) { 
                  productList = new ArrayList(end);
                  do{ 
                     ProductDTO product = new ProductDTO(); // �ݺ��� ������ DTO �����ؼ� ����ֱ� // DTO�� ���� article�� ����
                     product.setPdCode(rs.getInt("pdCode")); // DB���� ���� num�� DTO�� article�� set // num�̶�� �÷����� ã�Ƽ� �������
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
                     productList.add(product); // �������� list�� add
                  }while(rs.next());
               }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return productList; // DB�� �����͸� DTO�� �� �����ؼ� List�� �־���
   }
   
   // getArticles // �˻� ��� ��� �ҷ��� (��ǰ����)
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
               // �˻� ��� ������� ��ȣ ���� rownum�� 1 �̻� 10 ������ �� �ҷ��� = �� ��� �ҷ��� ��
               
               rs = pstmt.executeQuery(); // 4�ܰ� ����
               if (rs.next()) { 
                  productList = new ArrayList(end);
                  do{ 
                     ProductDTO product = new ProductDTO();  // �ݺ��� ������ DTO �����ؼ� ����ֱ� // DTO�� ���� article�� ����
                     product.setPdCode(rs.getInt("pdCode")); // DB���� ���� num�� DTO�� article�� set // num�̶�� �÷����� ã�Ƽ� �������
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
                     productList.add(product); // �������� list�� add
                  }while(rs.next());
               }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return productList; // DB�� �����͸� DTO�� �� �����ؼ� List�� �־���
   }

   // ��ϵ� ��ǰ ����
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
   
   // ��ǰ��ȣ�� PRODUCT ������ ��������   
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
   
   // ��ǰ��ȣ�� STOCK ������ ��������
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
///////////////// �ֿ��� ������//////////////////////////////////////////////////////////////////////////////      
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
   
//   // ��ǰ ����, ����� ��� Ȯ�� 
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
         pstmt.executeUpdate(); // 4�ܰ�
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
               pstmt.setInt(8, Integer.parseInt(qty)+y); // ���ʼ���
               pstmt.setInt(9, Integer.parseInt(qty)); // �ܿ�����
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
      
         pstmt.executeUpdate(); // 4�ܰ�
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

///////////////// ������ �߰���//////////////////////////////////////////////////////////////////////////////  

   // PRODUCT ���̺� DB ���� delete
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
   
   // STOCK ���̺� DB ���� delete
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
      
   // PDIMAGE ���̺� DB ���� delete
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
   
// stock ��ü ��ǰ ���� - ����¡
		public int getStockCount() throws Exception {
			int x=0;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select count(*) from stock");
				rs = pstmt.executeQuery(); 
				if (rs.next()) { // rs.getInt(1) = int�� �� ù ��° �÷��� �����ڴ� // select count(*) from board ������ �÷����� count(*) // rs.getInt(1) = rs.getInt("count(*)")
					x= rs.getInt(1); // �˻��� ù ��° �÷��� �ǹ� // ���� rs.getInt("count(*)") �̷� ������ ���� // select count(*) from board ���ప(=10)�� �־��� ��
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return x; 
		}
		
		// stock ��� �ҷ����� �޼ҵ�
		public ArrayList<StockDTO> getStockList() {
			ArrayList<StockDTO> list = new ArrayList<StockDTO>();
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select * from stock order by pdCode desc");
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					StockDTO dto = new StockDTO();
					dto.setPdCode(rs.getInt("pdCode")); // DB���� ���� num�� DTO�� article�� set // num�̶�� �÷����� ã�Ƽ� �������
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
		
		// stock ��ü �� ��� - ����¡
		public List getStock(int start, int end) throws Exception { // �� ��� �ҷ���
			List stockList=null;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select pdCode,productName,color,sizes,supplyPrice,sellingPrice,pdQuantity,orderquant,remainquant,r "
						+ "from (select pdCode,productName,color,sizes,supplyPrice,sellingPrice,pdQuantity,orderquant,remainquant,rownum r "
						+ "from (select * "
						+ "from stock order by pdCode desc) order by pdCode desc) where r >= ? and r <= ?");
						pstmt.setInt(1, start); 
						pstmt.setInt(2, end); 
						// �˻� ��� ������� ��ȣ ���� rownum�� 1 �̻� 10 ������ �� �ҷ��� = �� ��� �ҷ��� ��
						
						rs = pstmt.executeQuery(); // 4�ܰ� ����
						if (rs.next()) { 
							stockList = new ArrayList(end);
							do{ 
								StockDTO stock = new StockDTO(); // �ݺ��� ������ DTO �����ؼ� ����ֱ� // DTO�� ���� article�� ����
								stock.setPdCode(rs.getInt("pdCode")); // DB���� ���� num�� DTO�� article�� set // num�̶�� �÷����� ã�Ƽ� �������
								stock.setProductName(rs.getString("productName"));
								stock.setColor(rs.getString("color"));
								stock.setSize(rs.getString("sizes"));
								stock.setSupplyPrice(rs.getInt("supplyPrice"));
								stock.setSellingPrice(rs.getInt("sellingPrice"));
								stock.setPdQuantity(rs.getInt("pdQuantity"));
								stock.setOrderquant(rs.getInt("orderquant"));
								stock.setRemainquant(rs.getInt("remainquant"));
								stockList.add(stock); // �������� list�� add
							}while(rs.next());
						}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return stockList; // DB�� �����͸� DTO�� �� �����ؼ� List�� �־���
		}
		
		// ���˻� .. col = ����/���� (�˻� �� ���� ��), search  = �˻� ��
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
		// �˻�2
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
						//System.out.println("search" + search); // search ���� �� �Ѿ������ Ȯ�� ���� 
						//System.out.println("col" + col);		  // col ���� �� �Ѿ������ Ȯ�� ����
				rs = pstmt.executeQuery();
						if (rs.next()) {
							articleList = new ArrayList(end); 
							do{ 
								StockDTO article= new StockDTO();
								article.setPdCode(rs.getInt("pdCode")); // DB���� ���� num�� DTO�� article�� set // num�̶�� �÷����� ã�Ƽ� �������
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

