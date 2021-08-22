package user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import user.dao.ConnectionDAO;
import java.sql.*;
import java.util.*;

import user.dto.OrderDetailDTO;
import user.dto.ReviewBoardDTO; 

public class OrderDetailDAO {

	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	
	public int getArticleCount(int odcode) throws Exception {
		int x=0;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select count(*) from order_detail where odcode= ?"); //count-���� (�Խñ���)
			pstmt.setInt(1, odcode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);;
		}
		return x; 
	}
	

	
	public List<OrderDetailDTO> getArticles(int start, int end) throws Exception {
		List<OrderDetailDTO> articleList=null;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement(
					"select pddetailcode, userid, pdcode,productname,color,sizes,pdquantity,supplyprice,oderstatus,orderdate,amount,odcode,paymethod,useraddr,r" 
				   + "from (pddetailcode, userid, pdcode,productname,color,sizes,pdquantity,supplyprice,oderstatus,orderdate,amount,odcode,paymethod,useraddr,rownum r" 
				   + "from (pddetailcode, userid, pdcode,productname,color,sizes,pdquantity,supplyprice,oderstatus,orderdate,amount,odcode,paymethod,useraddr," 
				   + " from order_detail by orderdate desc) order by orderdate desc)  where r >= ? and r <= ? "); 
					
					pstmt.setInt(1, start);                          // ref ��������, restep �������� 
					pstmt.setInt(2, end); 
					rs = pstmt.executeQuery(); // sql ����
					if (rs.next()) { // �����ͺ��̽��� �����Ͱ� ������ ����
						articleList = new ArrayList(end);   // list ��ü ����
						do{     
							OrderDetailDTO article= new OrderDetailDTO();
							article.setPdDetailCode(rs.getInt("pdDetailCode"));
							article.setUserid(rs.getString("userid"));
							article.setPdcode(rs.getInt("pdcode"));
							article.setProductname(rs.getString("productname"));
							article.setColor(rs.getString("color"));
							article.setSizes(rs.getString("sizes"));
							article.setPdQuantity(rs.getInt("pdQuantity"));
							article.setSupplyPrice(rs.getInt("supplyPrice"));
							article.setOrderstatus(rs.getString("orderstatus"));
							article.setOrderdate(rs.getTimestamp("orderdate"));
							article.setAmount(rs.getInt("Amount"));
							article.setOdcode(rs.getInt("odcode"));
							article.setPaymethod(rs.getString("paymethod"));
							article.setUseraddr(rs.getString("UserAddr"));
							articleList.add(article); 
							
						}while(rs.next());
					}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);;
		}

		return articleList;
	}
	
	
	
	public ArrayList<OrderDetailDTO> getList(int odcode) {
		ArrayList<OrderDetailDTO> list = new ArrayList<OrderDetailDTO>();
		
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select * from order_detail where odcode =? order by orderdate desc");
			pstmt.setInt(1, odcode);
			rs = pstmt.executeQuery();
			
			/*
			try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select * from order_detail order by orderdate desc");
			rs = pstmt.executeQuery();
			 * */
			//rs.next() -ù��° ���� true Ȯ��, �ι�°~ ���������� ��� �ݺ�!   
			while(rs.next()) {
				OrderDetailDTO article= new OrderDetailDTO();
				article.setPdDetailCode(rs.getInt("PDDETAILCODE"));
				article.setUserid(rs.getString("USERID"));
				article.setPdcode(rs.getInt("PDCODE"));
				article.setProductname(rs.getString("PRODUCTNAME"));
				article.setColor(rs.getString("COLOR"));
				article.setSizes(rs.getString("SIZES"));
				article.setPdQuantity(rs.getInt("PDQUANTITY"));
				article.setSupplyPrice(rs.getInt("SUPPLYPRICE"));
				article.setOrderstatus(rs.getString("ODERSTATUS"));
				article.setOrderdate(rs.getTimestamp("ORDERDATE"));
				article.setAmount(rs.getInt("AMOUNT"));
				article.setOdcode(rs.getInt("ODCODE"));
				article.setPaymethod(rs.getString("PAYMETHOD"));
				article.setUseraddr(rs.getString("USERADDR"));
				list.add(article);// list�� �ִ´�
				
				
				/*
				
				*/
			}
					
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);;
		}
		return list;
	}
	
	
	
	
	
	
}
	
	
	
	

