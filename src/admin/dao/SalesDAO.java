package admin.dao;

import java.sql.*;
import java.util.*;
import admin.dao.ConnectionDAO;
import admin.dto.SalesDTO;

public class SalesDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public int dateCount() {
		int x = 0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select count(DISTINCT(to_char(orderdate,'YYYYMMDD'))) count from order_detail";
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
	
	public List dateSales(int startRow, int endRow) {
		List list = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from (select rank() over(order by to_timestamp(to_char(orderdate, 'YYYY-MM-DD')) desc) rank,"
					+ "to_timestamp(to_char(orderdate, 'YYYY-MM-DD'))as salesdate, count(DISTINCT(odcode)) count, sum(sell) sell, sum(supply) supply, sum(margin) margin "
					+ "from (select a.orderdate orderdate,a.odcode,a.productname,a.pdquantity,(a.pdquantity*b.sellingprice) sell, (a.pdquantity*b.supplyprice) supply,"
					+ "(a.pdquantity*b.sellingprice)-(a.pdquantity*b.supplyprice) margin "
					+ "from order_detail A, product B where A.pdcode = B.pdcode) group by to_timestamp(to_char(orderdate, 'YYYY-MM-DD')) ) A "
					+ "left outer join(select to_timestamp(to_char(orderdate, 'YYYY-MM-DD'))as salesdate,count(*) cancel "
					+ "from (select * from shoporder where orderstatus like '%취소%') group by to_char(orderdate, 'YYYY-MM-DD')) C "
					+ "on a.salesdate = c.salesdate where a.rank>=? and rank<=? order by a.salesdate desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList(endRow);
				do {
					SalesDTO dto = new SalesDTO();
					dto.setSalesDate(rs.getTimestamp("salesdate").toString().substring(0, 10));
					dto.setSalesCount(rs.getInt("count"));
					dto.setCancelCount(rs.getInt("cancel"));
					dto.setSell(rs.getInt("sell"));
					dto.setSupply(rs.getInt("supply"));
					dto.setMargin(rs.getInt("margin"));
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
	
	public int datePartCount(String date) {
		int x = 0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select count(*) from shoporder where to_char(orderdate,'YYYY-MM-DD')=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				x = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return x;
	}
	
	public List datePartSales(String date, int startRow, int endRow) {
		List list = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from(select odcode, userid, productname, amount, to_char(orderdate,'YYYY-MM-DD') salesdate, useraddr, paymethod, orderstatus, phonenumber, invoice, rownum r "
					+ "from shoporder where to_char(orderdate,'YYYY-MM-DD') = ? order by odcode desc)where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList(endRow);
				do {
					SalesDTO dto = new SalesDTO();
					dto.setUserId(rs.getString("userid"));
					dto.setProductName(rs.getString("productname"));
					dto.setAmount(rs.getInt("amount"));
					dto.setUserAddr(rs.getString("useraddr"));
					dto.setPaymethod(rs.getString("paymethod"));
					dto.setOrderstatus(rs.getString("orderstatus"));
					dto.setPhonenumber(rs.getString("phonenumber"));
					dto.setOdcode(rs.getInt("odcode"));
					dto.setInvoice(rs.getString("invoice"));
					list.add(dto);
				} while(rs.next());
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		
		return list;
	}
	
	public List recentlyDateOrder() {
		List list = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from (select rank() over(order by to_timestamp(to_char(orderdate, 'YYYY-MM-DD')) desc) rank,"
					+ "to_timestamp(to_char(orderdate, 'YYYY-MM-DD'))as salesdate, count(DISTINCT(odcode)) count, sum(sell) sell, sum(supply) supply, sum(margin) margin "
					+ "from (select a.orderdate orderdate,a.odcode,a.productname,a.pdquantity,(a.pdquantity*b.sellingprice) sell, (a.pdquantity*b.supplyprice) supply,"
					+ "(a.pdquantity*b.sellingprice)-(a.pdquantity*b.supplyprice) margin "
					+ "from order_detail A, product B where A.pdcode = B.pdcode and to_char(orderdate, 'YYYY-MM-DD')>=to_char(sysdate-2, 'YYYY-MM-DD') and to_char(orderdate, 'YYYY-MM-DD')<=to_char(sysdate, 'YYYY-MM-DD')) "
					+ "group by to_timestamp(to_char(orderdate, 'YYYY-MM-DD')) ) A "
					+ "left outer join(select to_timestamp(to_char(orderdate, 'YYYY-MM-DD'))as salesdate,count(*) cancel from (select * from shoporder where orderstatus like '%취소%') "
					+ "group by to_char(orderdate, 'YYYY-MM-DD')) C on a.salesdate = c.salesdate "
					+ "order by a.salesdate desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
					SalesDTO dto = new SalesDTO();
					dto.setSalesDate(rs.getTimestamp("salesdate").toString().substring(0, 10));
					dto.setSalesCount(rs.getInt("count"));
					dto.setCancelCount(rs.getInt("cancel"));
					dto.setSell(rs.getInt("sell"));
					dto.setMargin(rs.getInt("margin"));
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
	
	
}
