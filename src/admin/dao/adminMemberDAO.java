package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import user.dao.ConnectionDAO;
import user.dto.MemberDTO;

public class adminMemberDAO {
   
   private Connection conn = null;
   private PreparedStatement pstmt = null;
   private ResultSet rs = null;
   
      public boolean adminloginCheck(String id, String pw) {
         boolean result = false;
         try {
            conn = ConnectionDAO.getConnection();
            pstmt = conn.prepareStatement("select * from member where id=? and password=? and status =10");
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            rs = pstmt.executeQuery();
            if(rs.next()) {
               result = true;
            }
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
            ConnectionDAO.close(rs, pstmt, conn);
         }
         return result;
      }
      
      // status읽기 위한 메서드 추가 - 입력받은 id로 검색
        public MemberDTO selectMemberInfo(String id) {
           MemberDTO dto = new MemberDTO();
           try {
              conn = ConnectionDAO.getConnection();
              pstmt = conn.prepareStatement("select * from member where id=? and status !=3");
              pstmt.setString(1, id);
              rs = pstmt.executeQuery();
              if(rs.next()) {
                 dto.setId(rs.getString("id"));
                 dto.setName(rs.getString("name"));
                 dto.setPw(rs.getString("password"));
                 dto.setStatus(rs.getInt("status"));
                 dto.setAddress(rs.getString("address"));
              }
           }catch(Exception e) {
              e.printStackTrace();
           }finally {
              ConnectionDAO.close(rs, pstmt, conn);
           }
           return dto;
        }   
        
        
        public int adminCode(String id) {
        	int code = 0;
        	try {
        		conn = ConnectionDAO.getConnection();
        		String sql = "select status from member where id =?";
        		pstmt = conn.prepareStatement(sql);
        		pstmt.setString(1, id);
        		rs = pstmt.executeQuery();
        		if(rs.next()) {
        			code = rs.getInt(1);
        		}
        		
        	}catch(Exception e) {
        		e.printStackTrace();
        	}finally {
        		ConnectionDAO.close(rs, pstmt, conn);
        	}
        	return code;
        }
}