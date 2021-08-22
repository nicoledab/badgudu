package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import admin.dao.ConnectionDAO;
import admin.dto.OrderDTO;
import admin.dto.OrderDeleteDTO;
import admin.dto.OrderListDTO;
import admin.dto.OrderDetailDTO;

public class OrderDAO {
   private Connection conn = null;
   private PreparedStatement pstmt = null;
   private ResultSet rs= null;
   
   
   // shopoder(주문목록) 전체 상품 개수 - 페이징
   public int getOrderCount() throws Exception {
      int x=0;
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select count(*) from shoporder");
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
               
   // shoporder 목록 불러오는 메소드
   public ArrayList<OrderListDTO> getOrderList() {
      ArrayList<OrderListDTO> list = new ArrayList<OrderListDTO>();
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select * from shoporder order by odNum desc");
         
         rs = pstmt.executeQuery();
         while(rs.next()) {
            OrderListDTO dto = new OrderListDTO();
            dto.setOdcode(rs.getInt("odcode"));
            dto.setOdnum(rs.getInt("odNum"));
            dto.setUserid(rs.getString("userid"));
            dto.setProductname(rs.getString("productname"));
            dto.setAmount(rs.getInt("amount"));
            dto.setOrderDate(rs.getTimestamp("orderdate"));
            dto.setUserAddr(rs.getString("useraddr"));
            dto.setPaymethod(rs.getString("paymethod"));
            dto.setOrderStatus(rs.getString("orderstatus"));
            dto.setPhonenumber(rs.getString("phonenumber"));
            dto.setInvoice(rs.getString("invoice"));
            list.add(dto);
         }
         // shoporder 목록 판매일자 3일경과 > 배송완료.. odcode 상관없이 판매일자로 확인하기 때문에 판매일자만 3일이 경과하면 배송완료로 변경
         String sql = "update shoporder set orderstatus='배송완료' where to_char(orderdate, 'yyyymmdd') <= to_char(sysdate - 3, 'yyyymmdd') "
                  + "and orderstatus='배송중'";
         pstmt = conn.prepareStatement(sql);
         pstmt.executeUpdate();   
         
         // shoporder 목록 판매일자 3일경과 > 배송완료.. odcode 상관없이 판매일자로 확인하기 때문에 판매일자만 3일이 경과하면 배송완료로 변경
         sql = "update order_detail set oderstatus='배송완료' where to_char(orderdate, 'yyyymmdd') <= to_char(sysdate - 3, 'yyyymmdd') "
               + "and oderstatus='배송중'";
      pstmt = conn.prepareStatement(sql);
      pstmt.executeUpdate();
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return list;
   }
   
   // shoporder 전체 글 목록 - 페이징
   public List getOrder(int start, int end) throws Exception { // 글 목록 불러옴
      List orderList=null;
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select odnum,userid,productname,amount,orderdate,useraddr,paymethod,orderstatus,odcode,phonenumber,invoice,r "
               + "from (select odnum,userid,productname,amount,orderdate,useraddr,paymethod,orderstatus,odcode,phonenumber,invoice,rownum r "
               + "from (select odnum,userid,productname,amount,orderdate,useraddr,paymethod,orderstatus,odcode,phonenumber,invoice "
               + "from shoporder order by odnum desc)) where r >= ? and r <= ?");
               pstmt.setInt(1, start); 
               pstmt.setInt(2, end); 
               // 검색 결과 순서대로 번호 붙인 rownum이 1 이상 10 이하인 글 불러옴 = 글 목록 불러온 것
               
               rs = pstmt.executeQuery(); // 4단계 실행
               if (rs.next()) { 
                  orderList = new ArrayList(end);
                  do{ 
                     OrderListDTO order = new OrderListDTO(); // 반복할 때마다 DTO 생성해서 집어넣기 // DTO를 변수 article에 넣음
                     order.setOdcode(rs.getInt("odcode"));
                     order.setOdnum(rs.getInt("odNum"));
                     order.setUserid(rs.getString("userid"));
                     order.setProductname(rs.getString("productname"));
                     order.setAmount(rs.getInt("amount"));
                     order.setOrderDate(rs.getTimestamp("orderdate"));
                     order.setUserAddr(rs.getString("useraddr"));
                     order.setPaymethod(rs.getString("paymethod"));
                     order.setOrderStatus(rs.getString("orderstatus"));
                     order.setPhonenumber(rs.getString("phonenumber"));
                     order.setInvoice(rs.getString("invoice"));
                     orderList.add(order); // 마지막에 list에 add
                  }while(rs.next());
               }
      } catch(Exception e) {
         e.printStackTrace();
      } finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return orderList; // DB의 데이터를 DTO에 다 저장해서 List에 넣어줌
   }
   
   // 주문검색 .. col = 제목/내용 (검색 탭 선택 값), search  = 검색 값
         public int getArticleCount(String col , String search) throws Exception {
            int x=0;
            try {
               conn = ConnectionDAO.getConnection();
               String sql = "select count(*) from shoporder where "+col+" like '%"+search+"%'";
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
   
   //검색 2
   public List getArticles(String col , String search, int start, int end) throws Exception {
      List articleList=null;
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select odnum,userid,productname,amount,orderdate,useraddr,paymethod,orderstatus,odcode,phonenumber,invoice, r "
               + "from (select odnum,userid,productname,amount,orderdate,useraddr,paymethod,orderstatus,odcode,phonenumber,invoice,rownum r "
               + "from (select odnum,userid,productname,amount,orderdate,useraddr,paymethod,orderstatus,odcode,phonenumber,invoice "
               + "from shoporder where "+col+" like '%"+search+"%' order by odnum)) where r >= ? and r <= ?");
               pstmt.setInt(1, start);     
               pstmt.setInt(2, end); 
               //System.out.println("search" + search); // search 값이 잘 넘어오는지 확인 위해  
               //System.out.println("col" + col);        // col 값이 잘 넘어오는지 확인 위해
         rs = pstmt.executeQuery();
               if (rs.next()) {
                  articleList = new ArrayList(end); 
                  do{ 
                     OrderListDTO article= new OrderListDTO();
                     article.setOdcode(rs.getInt("odcode"));
                     article.setOdnum(rs.getInt("odNum"));
                     article.setUserid(rs.getString("userid"));
                     article.setProductname(rs.getString("productname"));
                     article.setAmount(rs.getInt("amount"));
                     article.setOrderDate(rs.getTimestamp("orderdate"));
                     article.setUserAddr(rs.getString("useraddr"));
                     article.setPaymethod(rs.getString("paymethod"));
                     article.setOrderStatus(rs.getString("orderstatus"));
                     article.setPhonenumber(rs.getString("phonenumber"));
                     article.setInvoice(rs.getString("invoice"));
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

   
   public List getOrderDetail(int odcode) {
      List<OrderDetailDTO> getOrderDetail = new ArrayList();;
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "select * from order_detail where odcode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, odcode);
         
         rs = pstmt.executeQuery();
         while(rs.next()) {
            OrderDetailDTO dto = new OrderDetailDTO();
            dto.setPdDetailCode(rs.getInt("pddetailcode"));
            dto.setColor(rs.getString("color"));
            dto.setOrderDate(rs.getTimestamp("orderdate"));
            dto.setUserId(rs.getString("userid"));
            dto.setPdCode(rs.getInt("pdcode"));
            dto.setProductName(rs.getString("productname"));
            dto.setSizes(rs.getString("sizes"));
            dto.setPdQuantity(rs.getInt("pdquantity"));
            dto.setSupplyPrice(rs.getInt("supplyprice"));
            dto.setAmount(rs.getInt("amount"));
            dto.setUserAddr(rs.getString("useraddr"));
            dto.setPhonenumber(rs.getString("phonenumber"));
            getOrderDetail.add(dto);
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return getOrderDetail;
   }
   
   // admin 주문목록에서 확인버튼 클릭시 배송준비 변경
   public void updateOrder(OrderDetailDTO dto) {
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "update order_detail set oderstatus='배송준비' where odcode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, dto.getOdCode());
         pstmt.executeUpdate();   
         
         sql = "update shoporder set orderstatus='배송준비' where odcode=?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, dto.getOdCode());
         pstmt.executeUpdate();   
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
   }
   
   // admin 주문목록에서 송장번호 기입시 - 0520 수정
      public void updateOrder2(OrderDetailDTO dto) {
         try {
            conn = ConnectionDAO.getConnection();
            String sql = "update order_detail set oderstatus='배송중' where odcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dto.getOdCode());
            pstmt.executeUpdate();   
            
            sql = "update shoporder set orderstatus='배송중', invoice=? where odcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getInvoice()); // 송장번호 
            pstmt.setInt(2, dto.getOdCode());
            pstmt.executeUpdate();   
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
            ConnectionDAO.close(rs, pstmt, conn);
         }
      }
      
   // admin 주문목록에서 송장번호 수정
      public void updateOrder3(OrderDetailDTO dto) {
         try {
            conn = ConnectionDAO.getConnection();
            String sql = "update shoporder set invoice=? where odcode=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dto.getInvoice()); // 송장번호 
            pstmt.setInt(2, dto.getOdCode());
            pstmt.executeUpdate();   
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
            ConnectionDAO.close(rs, pstmt, conn);
         }
      }
      
   // admin 주문목록에서 삭제
   public void deleteOrder(OrderDeleteDTO dto) {
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "update order_detail set oderstatus='판매자 취소', amount=0 where odcode=?";	// order_detail테이블의 orderstatus 변경
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, dto.getOdCode());
         pstmt.executeUpdate();   
         
         sql = "update shoporder set orderstatus='판매자 취소', amount=0 where odcode=?";			// shoporder테이블의 oderstatus 변경
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, dto.getOdCode());
         pstmt.executeUpdate();   
         
         int cancel = 0;
         int [] pdquantity=null;
         int [] pdcode=null;
         String [] color = null;
         String [] sizes = null; 
         sql ="select pdquantity,pdcode,color,sizes from order_detail where odcode=?";	// 주문수량,pdcode,색상,사이즈를 가져오기 위함
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, dto.getOdCode());
         rs = pstmt.executeQuery();
         if(rs.next()) {	
            ArrayList list = new ArrayList();		// 묶음 상품일 경우를 대비하여 리스트로 생성
            do {
               OrderDeleteDTO ddto = new OrderDeleteDTO();
               ddto.setPdQuantity(rs.getInt("pdquantity"));
               ddto.setPdCode(rs.getInt("pdcode"));
               ddto.setColor(rs.getString("color"));
               ddto.setSizes(rs.getString("sizes"));
               list.add(ddto);
            }while(rs.next());
            
            for(int i=0; i<list.size(); i++) {
               OrderDeleteDTO ddto = (OrderDeleteDTO)list.get(i);
               //System.out.println(ddto.getPdQuantity());
               int orderquant = 0;
                 int remainquant = 0;
                 sql = "select remainquant, orderquant from stock where pdcode=? and color=? and sizes=?";	// 주문수량,잔여수량 가져오기위함
                 pstmt = conn.prepareStatement(sql);
                 pstmt.setInt(1, ddto.getPdCode());
                 pstmt.setString(2, ddto.getColor());
                 pstmt.setString(3, ddto.getSizes());
                 rs = pstmt.executeQuery();
                 if(rs.next()) {
                    remainquant = rs.getInt(1);
                    orderquant = rs.getInt(2);
                 }
                 sql = "update stock set orderquant=?, remainquant=? where pdcode=? and color=? and sizes=?";	// 마지막으로 stock테이블의 수량을 수정하기 위함
                 pstmt = conn.prepareStatement(sql);
                 int odq = orderquant - ddto.getPdQuantity();	// 주문수량(증가한) - 주문수량(취소된)
                 pstmt.setInt(1, odq);
                 int req = remainquant + ddto.getPdQuantity(); 	// 잔여수량 + 주문수량(취소된)
                 pstmt.setInt(2, req);
                 pstmt.setInt(3, ddto.getPdCode());
                 pstmt.setString(4, ddto.getColor());
                 pstmt.setString(5, ddto.getSizes());
                 pstmt.executeUpdate();
            }
         }
         sql = "update order_detail set pdquantity=0 where odcode=?";	// 위에서 pdquantity를 0으로 수정하면 수량수정이 불가능하므로 마지막으로 수정
             pstmt = conn.prepareStatement(sql);
             pstmt.setInt(1, dto.getOdCode());
             pstmt.executeUpdate();
         
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
   }
}