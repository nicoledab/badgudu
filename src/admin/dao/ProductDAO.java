package admin.dao;

import java.sql.*;

import admin.dto.ProductDTO;

public class ProductDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	
	public void productInsert(ProductDTO dto) {
		try {
			conn = ConnectionDAO.getConnection();
			
			String sql = "insert into product values(product_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,?,sysdate,2,2)";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getDisplay());
			pstmt.setInt(2, dto.getPdCategory());
			pstmt.setString(3, dto.getProductName());
			pstmt.setString(4, dto.getPdExplain());
			pstmt.setString(5, dto.getPdDetailExplain());
			pstmt.setInt(6, dto.getSupplyPrice());
			pstmt.setInt(7, dto.getSellingPrice());
			pstmt.setString(8, dto.getPdQuantity());
			pstmt.setString(9, dto.getColor());
			pstmt.setString(10, dto.getSize());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	public void imgInsert(ProductDTO dto) {
		try {
			conn = ConnectionDAO.getConnection();
			
			String productImg1 = dto.getProductImg1();
			String productImg2 = dto.getProductImg2();
			String productImg3 = dto.getProductImg3();
			String productDetailImg1 = dto.getProductDetailImg1();
			String productDetailImg2 = dto.getProductDetailImg2();
			
			if(productImg1==null) {
				productImg1="이미지 없음";
			}
			if(productImg2==null) {
				productImg2="";
			}
			if(productImg3==null) {
				productImg3="";
			}
			if(productDetailImg1 == null) {
				productDetailImg1="";
			}
			if(productDetailImg2 == null) {
				productDetailImg2="";
			}
			
			
		
			String sql = "insert into pdimage values(pdimage_seq.NEXTVAL,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productImg1);
			pstmt.setString(2, productImg2);
			pstmt.setString(3, productImg3);
			pstmt.setString(4, productDetailImg1);
			pstmt.setString(5, productDetailImg2);
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	public void stockInsert(ProductDTO dto) {
		try {
				conn = ConnectionDAO.getConnection();
				int pdCode = 0;
				String number = "select max(pdcode) from product";
				pstmt = conn.prepareStatement(number);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					pdCode = rs.getInt("max(pdCode)");					
				}
				
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
						pstmt.setInt(11, pdCode);
						pstmt.setInt(12, Integer.parseInt(pdQuantity));

						pstmt.executeUpdate();
						++i; 
					}
				}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}

	}
	
	
}
