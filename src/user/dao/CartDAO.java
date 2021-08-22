package user.dao;

import java.sql.*;
import java.util.*;
import user.dao.ConnectionDAO;
import user.dto.CartDTO;

public class CartDAO {
	public Connection conn = null;
	public PreparedStatement pstmt = null;
	public ResultSet rs = null;
	
	public int stockCheck(String pdCode, String color, String size) {
		int stockCheck = 0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select remainquant from stock where pdCode=? and color=? and sizes=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pdCode);
			pstmt.setString(2, color);
			pstmt.setString(3, size);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				stockCheck = rs.getInt("remainquant");
			}
		} catch(Exception e) {
			
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return stockCheck;
	}
	
	public void insertCart(CartDTO dto) {
		int amount=0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "insert into cart values(cart_seq.NEXTVAL,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getId());
			pstmt.setInt(2, dto.getUnitPrice());
			pstmt.setInt(3, dto.getPdQuantity());
			pstmt.setString(4, dto.getProductName());
			pstmt.setString(5, dto.getColor());
			pstmt.setString(6, dto.getSize());
			amount = dto.getUnitPrice()*dto.getPdQuantity();
			pstmt.setInt(7, amount);
			pstmt.setString(8, dto.getProductImg1());
			pstmt.setInt(9, dto.getPdCode());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
			String sql = "select * from cart where userid=?";
		}
	}
	
	public List getCart(String Mid) {
		List getCart = new ArrayList();;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from cart where userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Mid);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CartDTO dto = new CartDTO();
				dto.setCart_no(rs.getInt("cart_no"));
				dto.setProductImg1(rs.getString("productimg1"));
				dto.setProductName(rs.getString("productname"));
				dto.setColor(rs.getString("color"));
				dto.setSize(rs.getString("sizes"));
				dto.setUnitPrice(rs.getInt("unitprice"));
				dto.setPdQuantity(rs.getInt("pdquantity"));
				dto.setAmount(rs.getInt("amount"));
				dto.setPdCode(rs.getInt("pdcode"));
				getCart.add(dto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return getCart;
	}
	
	public void cartQtyDown(int cart_no) {
		int qty=0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from cart where cart_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				qty = rs.getInt("pdquantity");
				
				if(qty == 1) {
					qty=1;
				}else {
					qty= qty-1;
				}
				int amount = rs.getInt("unitprice")*qty;
				sql = "update cart set pdquantity=?, amount=? where cart_no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, qty);
				pstmt.setInt(2, amount);
				pstmt.setInt(3, cart_no);
				pstmt.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	public void cartQtyUp(int cart_no) {
		int qty=0;
		int remainQuant=0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from cart where cart_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_no);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				int pdCode = rs.getInt("pdCode");
				qty = rs.getInt("pdquantity");
				String color = rs.getString("color");
				String size = rs.getString("sizes");
				int unitprice = rs.getInt("unitprice");
				
				sql = "select remainquant from stock where pdcode=? and color=? and sizes=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pdCode);
				pstmt.setString(2, color);
				pstmt.setString(3, size);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					remainQuant = rs.getInt("remainquant");
				}
				
				
				if(qty >= remainQuant) {
					qty=remainQuant;
				}else {
					qty= qty+1;
				}
				
				int amount = unitprice*qty;
				sql = "update cart set pdquantity=?, amount=? where cart_no=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, qty);
				pstmt.setInt(2, amount);
				pstmt.setInt(3, cart_no);
				pstmt.executeUpdate();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	public void cartDelete(int cart_no) {
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "delete from cart where cart_no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_no);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	//선택된 상품만 주문목록에 담자 ... 
	   public List getOrderCart(String [] cart_no) {
	      List getCart = new ArrayList();
	      try {
	         conn = ConnectionDAO.getConnection();
	         String in="";
	         for(String cn : cart_no) {
	            in+=cn+",";   //ex] cart_no의 12,15 를 받는다 . 12,15, 이렇게됨 
	         }
	         in = in.substring(0, in.length()-1); // 마지막 쉼표(,)는 들어가면 안되니깐 잘라냄 0~마지막 앞 까지 12,15 이렇게 되게
	         String sql = "select * from cart where cart_no in("+in+")"; //이  아래 부턴 똑같.
	         pstmt = conn.prepareStatement(sql);
	         
	         rs = pstmt.executeQuery();
	         while(rs.next()) {
	            CartDTO dto = new CartDTO();
	            dto.setCart_no(rs.getInt("cart_no"));
	            dto.setProductImg1(rs.getString("productimg1"));
	            dto.setProductName(rs.getString("productname"));
	            dto.setColor(rs.getString("color"));
	            dto.setSize(rs.getString("sizes"));
	            dto.setUnitPrice(rs.getInt("unitprice"));
	            dto.setPdQuantity(rs.getInt("pdquantity"));
	            dto.setAmount(rs.getInt("amount"));
	            dto.setPdCode(rs.getInt("pdcode"));
	            getCart.add(dto);
	         }
	         
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         ConnectionDAO.close(rs, pstmt, conn);;
	      }
	      return getCart;
	   }

}
