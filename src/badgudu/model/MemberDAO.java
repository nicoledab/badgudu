package badgudu.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public void insertMember(MemberDTO dto) {
		try {
			conn = ConnectionDAO.getConnection(); //1/2단계 메서드 호출
			pstmt = conn.prepareStatement("insert into member values(?,?,?)");
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getPw());
			
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(conn, pstmt, rs);
		}
	}
	//boolean, int, String, DTO
	public boolean loginCheck(String id, String pw) {
		boolean result = false;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select * from member where id=? pw=? and status !=3");
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(conn, pstmt, rs);
		}
		return result;
	}
}	