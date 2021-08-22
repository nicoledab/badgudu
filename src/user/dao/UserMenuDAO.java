package user.dao;

import java.sql.*;
import java.util.*;

import admin.dao.ConnectionDAO;
import user.dto.UserMenuDTO;

public class UserMenuDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public int getProductCount() {
		int x = 0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select count(pdcode) from product where display='true'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		
		return x;
	}
	
	public List getThumbnailImg(int startRow, int endRow) {
		List pdImg = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from("
					+ "select productimg1, rank() over(order by pdcode desc) AS rank, pdcode from "
					+ "(select A.productimg1, A.pdcode from pdimage A, product B where A.pdcode = B.pdcode and B.display = 'true') ) "
					+ "where rank>=? and rank<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2,endRow);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pdImg = new ArrayList(endRow);
				do {
					pdImg.add(rs.getString("productimg1"));
				}while(rs.next());

			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdImg;
	}
	
	// qqqq
	   public List getThumbnailPd(int startRow, int endRow) {
	      List pdImg = null;
	      try {
	         conn = ConnectionDAO.getConnection();
	         String sql = "select * from("
	               + "select pdcode, productname, sellingprice, sale, event, rank() over(order by pdcode desc) AS rank from product where display='true') "
	               + "where rank>=? and rank<=?";
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setInt(1, startRow);
	         pstmt.setInt(2,endRow);
	         rs = pstmt.executeQuery();
	         if (rs.next()) {
	            pdImg = new ArrayList(endRow);
	            do {
	               UserMenuDTO dto = new UserMenuDTO();
	               dto.setProductName(rs.getString("productname"));
	               dto.setSellingPrice(rs.getInt("sellingprice"));
	               dto.setPdCode(rs.getInt("pdcode"));
	               dto.setSale(rs.getInt("sale"));
	               dto.setEvent(rs.getInt("event"));
	               pdImg.add(dto);
	            }while(rs.next());

	         }
	         
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         ConnectionDAO.close(rs, pstmt, conn);
	      }
	      return pdImg;
	   }
	
	public int getCatePdCount(int currentCate) {
		int x = 0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select count(pdcode) from product where display='true' and pdcategory=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, currentCate);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		
		return x;
	}
	
	// 신상품 게시물 개수
	   public int getCateNewPdCount(int currentCate) {
	      int x = 0;
	      try {   // 기존 게시물 갯수에서 날짜 조건부 추가
	         conn = ConnectionDAO.getConnection();
	         String sql = "SELECT count(pdcode) FROM product WHERE display='true' and" 
	               + " ( to_char(regdate, 'YYYYMMDD') >= to_char(sysdate - 3, 'yyyymmdd')"
	               + " AND to_char(regdate, 'YYYYMMDD') <= to_char(sysdate, 'yyyymmdd') )";
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            x = rs.getInt(1);
	         }
	      } catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         ConnectionDAO.close(rs, pstmt, conn);
	      }
	      
	      return x;
	   }
	
	public List getCateThumPd(int currentCate, int startRow, int endRow) {
		List pdImg = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from("
					+ "select pdcode, productname, sellingprice, rank() over(order by pdcode desc) AS rank from product where display='true' and pdCategory=?) "
					+ "where rank>=? and rank<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, currentCate);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3,endRow);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pdImg = new ArrayList(endRow);
				do {
					UserMenuDTO dto = new UserMenuDTO();
					dto.setProductName(rs.getString("productname"));
					dto.setSellingPrice(rs.getInt("sellingprice"));
					dto.setPdCode(rs.getInt("pdcode"));
					pdImg.add(dto);
				}while(rs.next());

			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdImg;
	}
	
	//신상품 조회
	public List getCateThumNewPd(int currentCate, int startRow, int endRow) {
		List pdImg = null;
		try {	// 
			conn = ConnectionDAO.getConnection();
			String sql = "select * from(SELECT pdcode, productname, sellingprice, sale, event, rank() over(order by pdcode desc) AS rank FROM product WHERE display='true' and "
					+ " 1 = case when to_char(regdate, 'YYYYMMDD') >= to_char(sysdate - 3, 'yyyymmdd') AND to_char(regdate, 'YYYYMMDD') <= to_char(sysdate, 'yyyymmdd') then 1 end) where rank>=? and rank<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2,endRow);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pdImg = new ArrayList(endRow);
				do {
					UserMenuDTO dto = new UserMenuDTO();
					dto.setProductName(rs.getString("productname"));
					dto.setSellingPrice(rs.getInt("sellingprice"));
					dto.setPdCode(rs.getInt("pdcode"));
					dto.setSale(rs.getInt("sale"));
					dto.setEvent(rs.getInt("event"));
					pdImg.add(dto);
				}while(rs.next());

			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdImg;
	}
	
	// sale 조회
		public List getCateThumSalePd(int currentCate, int startRow, int endRow) {
			List pdImg = null;
			try {	// 
				conn = ConnectionDAO.getConnection();
				String sql = "select * from(SELECT pdcode, productname, sellingprice, sale, event, rank() over(order by pdcode desc) AS rank FROM product WHERE display='true' and "
						+ " sale=1) where rank>=? and rank<=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2,endRow);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					pdImg = new ArrayList(endRow);
					do {
						UserMenuDTO dto = new UserMenuDTO();
						dto.setProductName(rs.getString("productname"));
						dto.setSellingPrice(rs.getInt("sellingprice"));
						dto.setPdCode(rs.getInt("pdcode"));
						dto.setSale(rs.getInt("sale"));
						dto.setEvent(rs.getInt("event"));
						pdImg.add(dto);
					}while(rs.next());

				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return pdImg;
		}
	
		// event 조회
				public List getCateThumEventPd(int currentCate, int startRow, int endRow) {
					List pdImg = null;
					try {	// 
						conn = ConnectionDAO.getConnection();
						String sql = "select * from(SELECT pdcode, productname, sellingprice, sale, event, rank() over(order by pdcode desc) AS rank FROM product WHERE display='true' and"
								+ " event=1) where rank>=? and rank<=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, startRow);
						pstmt.setInt(2,endRow);
						rs = pstmt.executeQuery();
						if (rs.next()) {
							pdImg = new ArrayList(endRow);
							do {
								UserMenuDTO dto = new UserMenuDTO();
								dto.setProductName(rs.getString("productname"));
								dto.setSellingPrice(rs.getInt("sellingprice"));
								dto.setPdCode(rs.getInt("pdcode"));
								dto.setSale(rs.getInt("sale"));
								dto.setEvent(rs.getInt("event"));
								pdImg.add(dto);
							}while(rs.next());

						}
						
					}catch(Exception e) {
						e.printStackTrace();
					}finally {
						ConnectionDAO.close(rs, pstmt, conn);
					}
					return pdImg;
				}	
		
	public String getCateThumbImg(int pdCode) {
		String pdImg = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select productimg1, pdcode from("
					+ "select A.productimg1, A.pdcode from pdimage A, product B where A.pdcode = B.pdcode and B.display = 'true') where pdcode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pdCode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pdImg = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdImg;
	}
	
	//0520 상품 상세 이미지들 
	public String getCateThumbImg2(int pdCode) { //이미지 2
		String pdImg = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select productimg2, pdcode from("
					+ "select A.productimg2, A.pdcode from pdimage A, product B where A.pdcode = B.pdcode and B.display = 'true') where pdcode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pdCode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pdImg = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdImg;
	}
	
	
	public String getCateThumbImg3(int pdCode) { //이미지 3
		String pdImg = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select productimg3, pdcode from("
					+ "select A.productimg3, A.pdcode from pdimage A, product B where A.pdcode = B.pdcode and B.display = 'true') where pdcode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pdCode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pdImg = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdImg;
	}
	
	
	public String getCateThumbImg4(int pdCode) { //이미지 4
		String pdImg = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select PRODUCTDETAILIMG1, pdcode from("
					+ "select A.PRODUCTDETAILIMG1, A.pdcode from pdimage A, product B where A.pdcode = B.pdcode and B.display = 'true') where pdcode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pdCode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pdImg = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdImg;
	}
	
	
	public String getCateThumbImg5(int pdCode) { //이미지 5
		String pdImg = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select PRODUCTDETAILIMG2, pdcode from("
					+ "select A.PRODUCTDETAILIMG2, A.pdcode from pdimage A, product B where A.pdcode = B.pdcode and B.display = 'true') where pdcode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pdCode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pdImg = rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdImg;
	}
	
	public String categoryName(int currentCate) {
		String categoryName = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select categoryname from category where pdcategory=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, currentCate);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				categoryName = rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return categoryName;
	}
	
	public UserMenuDTO productInfo(int pdCode) {
		UserMenuDTO dto = null;
		try {
			conn=ConnectionDAO.getConnection();
			String sql = "select * from product where display='true' and pdcode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pdCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new UserMenuDTO();
				dto.setProductName(rs.getString("productname"));
				dto.setSellingPrice(rs.getInt("sellingprice"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return dto;
		
	}
	
	public List pdSize(int pdCode) {
		List pdSize = null;
		try {
			conn=ConnectionDAO.getConnection();
			String sql = "select distinct(sizes)sizes from stock where pdcode=? order by sizes";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pdCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pdSize = new ArrayList();
				do {
					pdSize.add(rs.getString("sizes"));
				} while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdSize;
		
	}
	
	public List pdColor(int pdCode) {
		List pdColor = null;
		try {
			conn=ConnectionDAO.getConnection();
			String sql = "select distinct(color) color from stock where pdcode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pdCode);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pdColor = new ArrayList();
				do {
					pdColor.add(rs.getString("color"));
				} while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdColor;
		
	}
	
	public ArrayList<UserMenuDTO> getStock(int pdCode) throws Exception {
		ArrayList<UserMenuDTO> getStock = new ArrayList<UserMenuDTO>();
		try {
			conn=ConnectionDAO.getConnection();
			String sql = "select * from stock where pdcode=? order by color, sizes";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pdCode);
			rs = pstmt.executeQuery();
			while(rs.next()){
				UserMenuDTO dto = new UserMenuDTO();
				dto.setColor(rs.getString("color"));
				dto.setSize(rs.getString("sizes"));
				dto.setRemainQuant(rs.getInt("remainquant"));
				getStock.add(dto);
			}
			
		}catch(Exception e) {
			
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return getStock;
	}
	
	//검색
	
	public int getProductCount(String search) {
		int x = 0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select count(pdcode) from product where display='true' and productname like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		
		return x;
	}
	
	public List getThumbnailImg(int startRow, int endRow, String search) {
		List pdImg = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from("
					+ "select productimg1, rank() over(order by pdcode desc) AS rank, pdcode from ( "
					+ "select A.productimg1, A.pdcode from pdimage A, ("
					+ "select pdcode from product where productname like '%"+search+"%' and display = 'true')B where A.pdcode = B.pdcode))"
							+ "where rank>=?and rank<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2,endRow);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pdImg = new ArrayList(endRow);
				do {
					pdImg.add(rs.getString("productimg1"));
				}while(rs.next());

			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdImg;
	}
	
	public List getThumbnailPd(int startRow, int endRow, String search) {
		List pdImg = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from("
					+ "select pdcode, productname, sellingprice, sale, event, rank() over(order by pdcode desc) AS rank from product "
					+ "where display='true' and productname like '%"+search+"%') where rank>=? and rank<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2,endRow);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pdImg = new ArrayList(endRow);
				do {
					UserMenuDTO dto = new UserMenuDTO();
					dto.setProductName(rs.getString("productname"));
					dto.setSellingPrice(rs.getInt("sellingprice"));
					dto.setPdCode(rs.getInt("pdcode"));
					dto.setSale(rs.getInt("sale"));
					dto.setEvent(rs.getInt("event"));
					pdImg.add(dto);
				}while(rs.next());

			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return pdImg;
	}
	
	public int checkMember(String id) {
		int status=0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select status from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				status = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return status;
	}
	
	// sale 갯수
	   public int getCateSalePdCount(int currentCate) {
	      int x = 0;
	      try {
	         conn = ConnectionDAO.getConnection();
	         String sql = "select count(pdcode) from product where display='true' and sale=1";
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            x = rs.getInt(1);
	         }
	      } catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         ConnectionDAO.close(rs, pstmt, conn);
	      }
	      
	      return x;
	   }
	   
	   // event 갯수
	   public int getCateEventPdCount(int currentCate) {
	      int x = 0;
	      try {
	         conn = ConnectionDAO.getConnection();
	         String sql = "select count(pdcode) from product where display='true' and event=1";
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	            x = rs.getInt(1);
	         }
	      } catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         ConnectionDAO.close(rs, pstmt, conn);
	      }
	      
	      return x;
	   }
	
}
