package admin.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import admin.dto.CompanyDTO;
import admin.dao.ConnectionDAO;

public class CompanyDAO {
	
	   private Connection conn = null;
	   private PreparedStatement pstmt = null;
	   private ResultSet rs = null;
	
	// 회사정보 수정 COMPANY 테이블 update
	public void companyUpdate(CompanyDTO dto) {
         try {
            conn = ConnectionDAO.getConnection();
            
            String sql = "update company set companyMail=?, companyNumber=?, businessHour=?, closedDays=?, companyAddress=?";
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, dto.getCompanyMail());
            pstmt.setString(2, dto.getCompanyNumber());
            pstmt.setString(3, dto.getBusinessHour());
            pstmt.setString(4, dto.getClosedDays());
            pstmt.setString(5, dto.getCompanyAddress());
         
            pstmt.executeUpdate();
            
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
            ConnectionDAO.close(rs, pstmt, conn);
         }
      }	
	
	// 회사정보 가져오기 COMPANY 테이블 select
	 public CompanyDTO getCompany() {
	      CompanyDTO dto = new CompanyDTO();
	      try {
	         conn = ConnectionDAO.getConnection();
	         pstmt = conn.prepareStatement("select * from company");
	         
	         rs = pstmt.executeQuery();
	         while(rs.next()) {
	            dto.setCompanyMail(rs.getString("companyMail"));
	            dto.setCompanyNumber(rs.getString("companyNumber"));
	            dto.setBusinessHour(rs.getString("businessHour"));
	            dto.setClosedDays(rs.getString("closedDays"));
	            dto.setCompanyAddress(rs.getString("companyAddress"));
	         }
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         ConnectionDAO.close(rs, pstmt, conn);
	      }
	      return dto;
	   }
}
