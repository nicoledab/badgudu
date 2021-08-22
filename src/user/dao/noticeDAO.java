package user.dao;

import java.nio.charset.CharsetEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import user.dao.ConnectionDAO;
import user.dto.MemberDTO;
import user.dto.noticeDTO;

public class noticeDAO 
{	
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	private Connection conn = null;
	
	public void insertBoard(noticeDTO dto) { 
		try {
			conn = ConnectionDAO.getConnection();	// 1-2�떒怨� 硫붿꽌�뱶 �샇異�
			// 3�떒怨�
			pstmt = conn.prepareStatement("insert into noticeboard values(noticeboard_seq.nextval,?,?,?,?,sysdate,?)");
			// noticeboard_seq.nextval = �떆���뒪 紐낅졊�뼱瑜� �꽔�쑝硫대맂�떎. �엯�젰諛쏅뒗 寃껋씠 �븘�땶 �옄�룞�쑝濡� �엯�젰 �옄�룞�쑝濡� �닔媛� 利앷�
			// �옉�꽦�옄, �젣紐�, �궡�슜, �뙆�씪紐�, �궇吏�, 議고쉶�닔
			pstmt.setString(1, "관리자");				// �늻媛� �쟻�뱺 �옉�꽦�옄媛� 愿�由ъ옄濡� �쟻�엳寃뚮걫
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getSave());
			pstmt.setInt(5, dto.getReadcount());
			
			// �떎�뻾
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {	// 萸먭� �릺�뿀�뱺 �떎�뻾�븳�떎
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	// �쟾泥� noticeboard �뀒�씠釉붿쓽 �젅肄붾뱶 �닔 由ы꽩!! �쟾泥� 湲� 媛��닔  
		public int getArticleCount() throws Exception {
			int x=0;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select count(*) from noticeboard"); //count-媛��닔 (寃뚯떆湲��쓽)
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
		
		// 由ъ뒪�듃
		public List getArticles(String id, int start, int end) throws Exception {
			List articleList=null;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement(
						"select num,writer,subject,reg,readcount,content,r "+
						"from (select num,writer,subject,content,reg,readcount,rownum r " +
						"from (select num,writer,subject,reg,readcount,content " +
						"from noticeboard where writer=? order by num desc) order by desc) where r >= ? and r <= ? ");
						pstmt.setString(1, id);
						pstmt.setInt(2, start);                         
						pstmt.setInt(3, end); 

				rs = pstmt.executeQuery();
						if (rs.next()) {
							articleList = new ArrayList(end); 
							do{ 
								noticeDTO article= new noticeDTO();
								article.setNum(rs.getInt("num"));
								article.setWriter(rs.getString("writer"));
								article.setSubject(rs.getString("subject"));
								article.setContent(rs.getString("content"));
								article.setReg(rs.getTimestamp("reg"));
								article.setReadcount(rs.getInt("readcount"));
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
		// 由ъ뒪�듃2
		public List getArticles(int start, int end) throws Exception {
			List articleList=null;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement(
						"select num,writer,subject,reg,readcount,content,r "+
						"from (select num,writer,subject,content,reg,readcount,rownum r " +
						"from (select num,writer,subject,reg,readcount,content " +
						"from noticeboard order by num desc) order by num desc) where r >= ? and r <= ? ");
						pstmt.setInt(1, start);                         
						pstmt.setInt(2, end); 

				rs = pstmt.executeQuery();
						if (rs.next()) {
							articleList = new ArrayList(end); 
							do{ 
								noticeDTO article= new noticeDTO();
								article.setNum(rs.getInt("num"));
								article.setWriter(rs.getString("writer"));
								article.setSubject(rs.getString("subject"));
								article.setContent(rs.getString("content"));
								article.setReg(rs.getTimestamp("reg"));
								article.setReadcount(rs.getInt("readcount"));
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
		
		// 議고쉶�닔 - 議고쉶�븷 �븣 留덈떎 1�뵫 利앷�
		public noticeDTO getArticle(int num) throws Exception {
			noticeDTO article=null;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement(
				"update noticeboard set readcount=readcount+1 where num = ?"); 
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				pstmt = conn.prepareStatement(
				"select * from noticeboard where num = ?"); 
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					article = new noticeDTO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setReg(rs.getTimestamp("reg"));
					article.setContent(rs.getString("content"));
					article.setSave(rs.getString("save"));
					article.setReadcount(rs.getInt("readcount"));
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			
			return article;
		}
		
		public noticeDTO updateGetArticle(int num) throws Exception {
			noticeDTO article=null;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement(
				"select * from noticeboard where num = ?"); 
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					article = new noticeDTO();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setSubject(rs.getString("subject"));
					article.setReg(rs.getTimestamp("reg"));
					article.setReadcount(rs.getInt("readcount"));
					article.setContent(rs.getString("content"));
					article.setSave(rs.getString("save"));
				}
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}

			return article;
		}
		
		// �닔�젙 - 蹂�寃�
		public void updateBoard(noticeDTO dto, int num) { 
			try {
				conn = ConnectionDAO.getConnection();	
				pstmt = conn.prepareStatement("update noticeboard set subject=?, content=?, save=? where num = ?");
				pstmt.setString(1, dto.getSubject());
				pstmt.setString(2, dto.getContent());
				pstmt.setString(3, dto.getSave());
				pstmt.setInt(4, num);	
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
		}
		
		// 湲�踰덊샇 諛쏆븘 �빐�떦 湲� �궘�젣
		public void deleteBoard(int num) {
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("delete from noticeboard where num=? ");
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
		}
		
		// 寃��깋 .. col = �젣紐�/�궡�슜 (寃��깋 �꺆 �꽑�깮 媛�), search  = 寃��깋 媛�
		public int getArticleCount(String col , String search) throws Exception {
			int x=0;
			try {
				conn = ConnectionDAO.getConnection();
				String sql = "select count(*) from noticeboard where "+col+" like '%"+search+"%'";
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
		
		// 寃��깋2
		public List getArticles(String col , String search, int start, int end) throws Exception {
			List articleList=null;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement(
						"select num,writer,subject,reg,readcount,content,r "+
						"from (select num,writer,subject,content,reg,readcount,rownum r " +
						"from (select num,writer,subject,reg,readcount,content " +
						"from noticeboard where "+col+" like '%"+search+"%' order by num)) where r >= ? and r <= ? ");
						pstmt.setInt(1, start);                           // desc �궡由쇱감�닚,  �삤由꾩감�닚 asc
						pstmt.setInt(2, end); 
						// System.out.println("search" + search); // search 媛믪씠 �옒 �꽆�뼱�삤�뒗吏� �솗�씤 �쐞�빐 
						// System.out.println("col" + col);		  // col 媛믪씠 �옒 �꽆�뼱�삤�뒗吏� �솗�씤 �쐞�빐
				rs = pstmt.executeQuery();
						if (rs.next()) {
							articleList = new ArrayList(end); 
							do{ 
								noticeDTO article= new noticeDTO();
								article.setNum(rs.getInt("num"));
								article.setWriter(rs.getString("writer"));
								article.setSubject(rs.getString("subject"));
								article.setContent(rs.getString("content"));
								article.setReg(rs.getTimestamp("reg"));
								article.setReadcount(rs.getInt("readcount"));
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
		
}