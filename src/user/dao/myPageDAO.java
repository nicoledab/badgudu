package user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import user.dto.MemberDTO;


public class myPageDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public boolean loginCheck(String id, String pw) {
		boolean result = false;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select * from member where id=? and password=? and status =1");
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);;
		}
		return result;
	}
	public MemberDTO getUser(String id) {
		MemberDTO dto = new MemberDTO();
		try {
			conn = ConnectionDAO.getConnection();  // 1/2´Ü°è ¸Þ¼­µå È£Ãâ
			pstmt = conn.prepareStatement("select * from member where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("password"));
				dto.setAddress(rs.getString("Address"));
				String [] ph = rs.getString("phonenumber").split("-");
				dto.setPh1(ph[0]);
				dto.setPh2(ph[1]);
				dto.setPh3(ph[2]);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);;
		}
		return dto;
	}
		public void statusChange(String id) {
			try {
				conn = ConnectionDAO.getConnection();  // 1/2´Ü°è ¸Þ¼­µå È£Ãâ
				pstmt = conn.prepareStatement("update member set status=2 where id=?");
				pstmt.setString(1,id);
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);;
			}
	}
		public boolean confirmIdChange(String id) {
			boolean result=false;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select * from member where id=?");
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result=true;
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);;
				}
			return result;
		}
		public void changeName(MemberDTO dto) {
			try {
				conn = ConnectionDAO.getConnection();  // 1/2´Ü°è ¸Þ¼­µå È£Ãâ
				pstmt = conn.prepareStatement("update member set name=? where id=?");
				pstmt.setString(1, dto.getName());
				pstmt.setString(2, dto.getId());
		
				pstmt.executeUpdate();
			}catch(Exception e) {
		e.printStackTrace();
			}finally {
		ConnectionDAO.close(rs, pstmt, conn);
			}
		}
		public void changeAddress(MemberDTO dto) {
			try {
				conn = ConnectionDAO.getConnection();  // 1/2´Ü°è ¸Þ¼­µå È£Ãâ
				pstmt = conn.prepareStatement("update member set address=? where id=?");
				pstmt.setString(1, dto.getAddress());
				pstmt.setString(2, dto.getId());
			
				pstmt.executeUpdate();
			}catch(Exception e) {
			e.printStackTrace();
			}finally {
			ConnectionDAO.close(rs, pstmt, conn);;
			}
			return;
		}
		
		public void changePhoneNumber(MemberDTO dto) {
			try {
				conn = ConnectionDAO.getConnection();  // 1/2´Ü°è ¸Þ¼­µå È£Ãâ
				pstmt = conn.prepareStatement("update member set phonenumber=? where id=?");
				pstmt.setString(1, dto.getPhoneNumber());
				pstmt.setString(2, dto.getId());
			
				pstmt.executeUpdate();
			}catch(Exception e) {
			e.printStackTrace();
			}finally {
			ConnectionDAO.close(rs, pstmt, conn);;
			}
			return;
		}
		public void changePw(MemberDTO dto) {
			try {
				conn = ConnectionDAO.getConnection();  // 1/2´Ü°è ¸Þ¼­µå È£Ãâ
				pstmt = conn.prepareStatement("update member set password=? where id=?");
				pstmt.setString(1, dto.getPw());
				pstmt.setString(2, dto.getId());
					
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
				return;
			}

}
