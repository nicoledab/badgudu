package admin.dao;

import java.sql.*;
import java.util.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import admin.dao.ConnectionDAO;

import admin.dto.OrderListDTO;

public class adminMainDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public int getRecentlyOrderCount() {
		int x = 0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select count(*) from shoporder where (to_char(orderdate, 'YYYYMMDD')>= to_char(sysdate-3,'yyyymmdd'))";
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
	
	public List getRecentlyOrderList(int startRow, int endRow) {
		List order = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from(select odcode, userid, orderdate,amount, orderstatus, rank() over(order by odcode desc)AS rank "
					+ "from shoporder where (to_char(orderdate, 'YYYYMMDD')>= to_char(sysdate-3,'yyyymmdd')) "
					+ "order by odcode desc) where rank>=? and rank<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				order = new ArrayList(endRow);
				do{
					OrderListDTO dto = new OrderListDTO();
					dto.setOdcode(rs.getInt("odcode"));
					dto.setUserid(rs.getString("userid"));
					dto.setAmount(rs.getInt("amount"));
					dto.setOrderStatus(rs.getString("orderstatus"));
					dto.setOrderDate(rs.getTimestamp("orderdate"));
					order.add(dto);
				}while(rs.next());
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return order;
	}
	
}
