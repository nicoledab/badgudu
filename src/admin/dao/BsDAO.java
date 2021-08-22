package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import admin.dto.BsDTO;

public class BsDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public BsDTO insertBs() {
		BsDTO dto = null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from bs";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new BsDTO();
				dto.setContent(rs.getString("content"));
				dto.setImg(rs.getString("img"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return dto;
	}
	
	public void updateBs(BsDTO dto) {
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "update bs set content=?,img=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getContent());
			pstmt.setString(2, dto.getImg());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	
}