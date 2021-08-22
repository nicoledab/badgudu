package user.dao;
import java.sql.*;
import java.util.*;

import user.dao.QnaBoardDAO;
import user.dto.ConnectionDAO;
import user.dto.QnaBoardDTO;
import user.dto.ReviewBoardDTO;


public class QnaBoardDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	
	
	
	public void insertqnaBoard(QnaBoardDTO dto) throws Exception {
		int num=dto.getNum();
		int readcount = dto.getReadcount();
		int ref=dto.getRef();
		int re_step=dto.getRe_step();
		int re_level=dto.getRe_level();
		int number=0;
		String sql="";
		try {
			conn = ConnectionDAO.getConnection(); 
			pstmt = conn.prepareStatement("select max(num) from qnaboard");
			rs = pstmt.executeQuery();
			
			if (rs.next()) 
				number=rs.getInt(1)+1;	
			else
				number=1; 
			if (num!=0) 
			{                          // �ֱٱ��� 1.            where ref= 14 and re_step > 0
				sql="update qnaboard set re_step=re_step+1 where ref= ? and re_step> ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);      //��� 
				pstmt.setInt(2, re_step);   //��� 
				pstmt.executeUpdate();
				re_step=re_step+1;      
				re_level=re_level+1;    
			}else{      //���� �ۼ� 
				ref=number;
				re_step=0;
				re_level=0;
			}
			                                                                 //
			sql = "insert into qnaboard(num,writer,subject,title,content,reg_date,readcount,";
			sql+="ref,re_step,re_level) values(qnaboard_seq.NEXTVAL,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setTimestamp(5, dto.getReg_date());
			pstmt.setInt(6, readcount);
			pstmt.setInt(7, ref);
			pstmt.setInt(8, re_step);
			pstmt.setInt(9, re_level);
		
			pstmt.executeUpdate();
			
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	
	
	/*
	public ArrayList<QnaBoardDTO> getList() {
		ArrayList<QnaBoardDTO> list = new ArrayList<QnaBoardDTO>();
		
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select * from qnaboard order by reg_date desc");
			rs = pstmt.executeQuery();
			
			//   rs.next() -ù��° ���� true Ȯ��, �ι�°~ ���������� ��� �ݺ�!   
			while(rs.next()) {
				ReviewBoardDTO dto = new ReviewBoardDTO(); 
				
				dto.setNum(rs.getInt("num"));
			    dto.setWriter(rs.getString("writer"));
			    dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSave(rs.getString("save"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setStatus(rs.getInt("status"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
				
				list.add(dto);// list�� �ִ´�
			}
					
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return list;
		
	}
	*/
	
	
	
	
	// ��ü qnaboard ���̺��� ���ڵ� �� ����!! getQnaCount getArticleCount()
	public int getArticleCount() throws Exception {
		int x=0;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select count(*) from qnaboard"); //count-���� (�Խñ���)
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return x; 
	}
	
	
	   // ��ø select �� 
	public List getArticles(int start, int end) throws Exception {
		List articleList=null;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement(
					"select num,writer,subject,title,content,reg_date,readcount,ref,re_step,re_level,r "+
					"from (select num,writer,subject,title,content,reg_date,readcount, ref,re_step,re_level,rownum r " +
					"from (select num,writer,subject,title,content,reg_date,readcount, ref,re_step,re_level " +
					"from qnaboard order by ref desc, re_step asc) order by ref desc, re_step asc ) where r >= ? and r <= ? ");
					pstmt.setInt(1, start);                          // ref ��������, restep �������� 
					pstmt.setInt(2, end); 

					rs = pstmt.executeQuery();
					if (rs.next()) {
						articleList = new ArrayList(end); 
						do{ 
							QnaBoardDTO article= new QnaBoardDTO();
							article.setNum(rs.getInt("num"));
							article.setWriter(rs.getString("writer"));
							article.setSubject(rs.getString("subject"));
							article.setTitle(rs.getString("title"));
							article.setContent(rs.getString("content"));
							article.setReg_date(rs.getTimestamp("reg_date"));
							article.setReadcount(rs.getInt("readcount"));
							article.setRef(rs.getInt("ref"));
							article.setRe_step(rs.getInt("re_step"));
							article.setRe_level(rs.getInt("re_level"));
							
							articleList.add(article); 
						}while(rs.next());
					}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}

		return articleList;
	}
	
	
	public int getCount(String id) throws Exception {
		int x=0;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select count(*) from qnaboard where writer=?"); 
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return x; 
	}
	
	
	//��ȸ�� 
	public void readCount (int num) {
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("update qnaboard set readcount=readcount+1 where num= ? ");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	
	//select *from qnaboard where num=3; �� sql �� �˻�, ���� Ȯ���Ҽ��ִ�
	public QnaBoardDTO getContent(int num) {
		
		QnaBoardDTO dto = new QnaBoardDTO();
		
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select * from qnaboard where num=? ");
			pstmt.setInt(1, num);
			
			rs= pstmt.executeQuery();
			
				if(rs.next()) {
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setRe_level(rs.getInt("re_level"));
				}
	
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return dto;
	}
	
	
    ///���º���   3-���� 
	public void deleteBoard(int num) {
		try {                                 // ���¸� ��ȭ "update reviewboard set status=3 where num=? ")
			conn = ConnectionDAO.getConnection();   // "delete from reviewboard where num=?"
			pstmt = conn.prepareStatement("delete from qnaboard where num=?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		}catch(Exception e) {
e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}	
	
	
	//5 �˻� ���                            , int start, int end
	public List<QnaBoardDTO> getqna(String col, String search, int start, int end) throws Exception {
		List<QnaBoardDTO> reviewList=null;
		try {
			conn = ConnectionDAO.getConnection();//"select * from qnaboard where "+col+" like %"+search+"%' order by reg_date desc "
			pstmt = conn.prepareStatement("select *  from (select num,writer,subject,title,content,reg_date,readcount, ref,re_step,re_level,rownum r "+
					  "from ( select * from qnaboard where "+col+" like '%"+search+"%' order by reg_date desc) order by reg_date desc )where r >= ? and r <= ? ");
					pstmt.setInt(1, start);                          
					pstmt.setInt(2, end); 
						
					rs = pstmt.executeQuery();
					if (rs.next()) {
						reviewList = new ArrayList<QnaBoardDTO>(); 
						do{ 
							QnaBoardDTO dto = new QnaBoardDTO(); 
							
							dto.setNum(rs.getInt("num"));
							dto.setWriter(rs.getString("writer"));
							dto.setSubject(rs.getString("subject"));
							dto.setTitle(rs.getString("title"));
							dto.setContent(rs.getString("content"));
							dto.setReg_date(rs.getTimestamp("reg_date"));
							dto.setReadcount(rs.getInt("readcount"));
							dto.setRef(rs.getInt("ref"));
							dto.setRe_step(rs.getInt("re_step"));
							dto.setRe_level(rs.getInt("re_level"));
	
							reviewList.add(dto); 
						}while(rs.next());
					}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}

		return reviewList;
	}
	
	// 5�� ..
	public int getqnaCount(String col, String search ) throws Exception {
		int x=0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql ="select count(*) from qnaboard where " +col+" like '%"+search+"%'";
			pstmt = conn.prepareStatement(sql); 
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return x; 
	}
	
	
	
	
	
	//��۹��� Ŭ���ϸ� ������ �޼ҵ� 
	public int getShippingCount(String subject) throws Exception {
		int x=0;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select count(*) from qnaboard where subject='��۹���'"); 
			pstmt.setString(1, subject);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				x= rs.getInt(1); 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return x; 
	}

	//shipping 
	public List<QnaBoardDTO> getShipping(String subject, int start, int end) throws Exception {
		List<QnaBoardDTO> reviewList=null;
		try {
			conn = ConnectionDAO.getConnection();//"select * from qnaboard where "+col+" like %"+search+"%' order by reg_date desc "
			pstmt = conn.prepareStatement("select num,writer,subject,title,content,reg_date,readcount,ref,re_step,re_level,r  " +
					  "from (select num,writer,subject,title,content,reg_date,readcount, ref,re_step,re_level,rownum r "+
					  "from ( select num,writer,subject,title,content,reg_date,readcount, ref,re_step,re_level  "+
					"from qnaboard where subject='��۹���' order by reg_date desc) order by reg_date desc )where r >= ? and r <= ? ");
					pstmt.setInt(1, start);                          
					pstmt.setInt(2, end); 
						
			
					
					rs = pstmt.executeQuery();
					if (rs.next()) {
						reviewList = new ArrayList<QnaBoardDTO>(); 
						do{ 
							QnaBoardDTO dto = new QnaBoardDTO(); 
							
							dto.setNum(rs.getInt("num"));
							dto.setWriter(rs.getString("writer"));
							dto.setSubject(rs.getString("subject"));
							dto.setTitle(rs.getString("title"));
							dto.setContent(rs.getString("content"));
							dto.setReg_date(rs.getTimestamp("reg_date"));
							dto.setReadcount(rs.getInt("readcount"));
							dto.setRef(rs.getInt("ref"));
							dto.setRe_step(rs.getInt("re_step"));
							dto.setRe_level(rs.getInt("re_level"));
	
							reviewList.add(dto); 
						}while(rs.next());
					}
		
					
					
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}

		return reviewList;
	}
	
	
	//������Ʈ ...
	public void updateqnaBoard(QnaBoardDTO dto) {
		try {
			conn = ConnectionDAO.getConnection();  // 1/2�ܰ� �޼��� ȣ��			
			String sql = "update qnaboard set writer=?,subject=?,title=?,content=? where num=?";
			
			pstmt = conn.prepareStatement(sql);       
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, dto.getNum());
			
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	
	
	
	
}
