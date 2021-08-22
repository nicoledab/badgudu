package user.dao;

import java.sql.*;
import java.util.*;

import user.dto.otoBoardDataBean;

public class otoBoardDBBean {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;

	
	public void insertArticle(otoBoardDataBean article) throws Exception {
		int num=article.getNum();
		int ref=article.getRef();
		int re_step=article.getRe_step();
		int re_level=article.getRe_level();
		int number=0;
		String sql="";
		try {
			conn = ConnectionDAO.getConnection(); 
			pstmt = conn.prepareStatement("select max(num) from otoboard");
			rs = pstmt.executeQuery();
			if (rs.next()) 
				number=rs.getInt(1)+1;	
			else
				number=1; 
			if (num!=0) 
			{ 
				sql="update otoboard set re_step=re_step+1 where ref= ? and re_step> ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step=re_step+1;
				re_level=re_level+1;
			}else{ 
				ref=number;
				re_step=0;
				re_level=0;
			}
 
			sql = "insert into otoboard(num,writer,email,ph,subject,passwd,save,reg_date,";
			sql+="ref,re_step,re_level,content,ip,otonum) values(otoboard_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,?,?,?,otonum_seq.NEXTVAL)";
				pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getPh());
			pstmt.setString(4, article.getSubject());
			pstmt.setString(5, article.getPasswd());
			pstmt.setString(6, article.getSave());
			pstmt.setTimestamp(7, article.getReg_date());
			pstmt.setInt(8, ref);
			pstmt.setInt(9, re_step);
			pstmt.setInt(10, re_level);
			pstmt.setString(11, article.getContent());
			pstmt.setString(12, article.getIp());
			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	
	public void adminInsertArticle(otoBoardDataBean article) throws Exception {
		int num=article.getNum();
		int ref=article.getRef();
		int re_step=article.getRe_step();
		int re_level=article.getRe_level();
		int number=0;
		String sql="";
		try {
			conn = ConnectionDAO.getConnection(); 
			pstmt = conn.prepareStatement("select max(num) from otoboard");
			rs = pstmt.executeQuery();
			if (rs.next()) 
				number=rs.getInt(1)+1;	
			else
				number=1; 
			if (num!=0) 
			{ 
				sql="update otoboard set re_step=re_step+1 where ref= ? and re_step> ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step=re_step+1;
				re_level=re_level+1;
			}else{ 
				ref=number;
				re_step=0;
				re_level=0;
			}
			
			int otonum =0;
			sql = "select otonum from otoboard where num=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				otonum = rs.getInt(1);
			}
 
			sql = "insert into otoboard(num,writer,email,ph,subject,passwd,save,reg_date,";
			sql+="ref,re_step,re_level,content,ip,otonum) values(otoboard_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getPh());
			pstmt.setString(4, article.getSubject());
			pstmt.setString(5, article.getPasswd());
			pstmt.setString(6, article.getSave());
			pstmt.setTimestamp(7, article.getReg_date());
			pstmt.setInt(8, ref);
			pstmt.setInt(9, re_step);
			pstmt.setInt(10, re_level);
			pstmt.setString(11, article.getContent());
			pstmt.setString(12, article.getIp());
			pstmt.setInt(13, otonum);
			pstmt.executeUpdate();
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	// board 테이블에 전체 레코드수 리턴
	public int getArticleCount() throws Exception {
		int x=0;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select count(*) from otoboard");
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
	
	
	public int userGetArticleCount(String id) throws Exception {
		int x=0;
		try {
			conn = ConnectionDAO.getConnection();
			int st = 0;
			pstmt = conn.prepareStatement("select count(*) from otoboard A,(select otonum from otoboard where writer=?) B where A.otonum = B.otonum");
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

	public List userGetArticles(String id, int start, int end) throws Exception {
		List articleList=null;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement(
					"select num,writer,email,ph,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "
					+ "from (select num,writer,email,ph,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r "
					+ "from (select num,writer,email,ph,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount "
					+ "from (select * "
					+ "from otoboard A,(select otonum from otoboard where writer=?) B where A.otonum = B.otonum) order by ref asc, re_step asc) order by ref asc, re_step asc ) "
					+ "where r >= ? and r <= ?");
					pstmt.setString(1, id);
					pstmt.setInt(2, start); 
					pstmt.setInt(3, end);

					rs = pstmt.executeQuery();
					if (rs.next()) {
						articleList = new ArrayList(end); 
						do{ 
							otoBoardDataBean article= new otoBoardDataBean();
							article.setNum(rs.getInt("num"));
							article.setWriter(rs.getString("writer"));
							article.setEmail(rs.getString("email"));
							article.setPh(rs.getString("ph"));
							article.setSubject(rs.getString("subject"));
							article.setPasswd(rs.getString("passwd"));
							article.setReg_date(rs.getTimestamp("reg_date"));
							article.setReadcount(rs.getInt("readcount"));
							article.setRef(rs.getInt("ref"));
							article.setRe_step(rs.getInt("re_step"));
							article.setRe_level(rs.getInt("re_level"));
							article.setContent(rs.getString("content"));
							article.setIp(rs.getString("ip"));
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
	
	public otoBoardDataBean getArticle(int num , String id) throws Exception {
		otoBoardDataBean article=null;
		
		try {
			conn = ConnectionDAO.getConnection();
			int st = 0;
			String sql = "select status from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				st=rs.getInt(1);
			}
			
			// 완료 된거 거든 코드 이해됨?  옙 저는 계속 여기서 넣을려했어가지고 안됐나봐요 ㅇㅇ 코드에 고민의 흔적이 보이더라. ^^ 
			if(st == 10) {
				st = rs.getInt(1);
				pstmt = conn.prepareStatement("update otoboard set readcount=readcount+1 where num = ?");    
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			}
			pstmt = conn.prepareStatement("select * from otoboard where num = ?"); 
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new otoBoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setPh(rs.getString("ph"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setSave(rs.getString("save"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
				article.setOtonum(rs.getInt("otonum"));
				
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		
		return article;
	}
	
	
	public otoBoardDataBean updateGetArticle(int num) throws Exception {
		otoBoardDataBean article=null;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement(
			"select * from otoboard where num = ?"); 
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				article = new otoBoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setPh(rs.getString("ph"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setSave(rs.getString("save"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
				article.setOtonum(rs.getInt("otonum"));
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}

		return article;
	}
	

	public int updateArticle(otoBoardDataBean article) throws Exception {
		String dbpasswd="";
		String sql="";
		int x=-1;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement(
			"select passwd from otoboard where num = ?");
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbpasswd= rs.getString("passwd"); 
				if(dbpasswd.equals(article.getPasswd())){
					sql="update otoboard set writer=?,email=?,ph=?,subject=?,passwd=?";
					sql+=",content=? where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getPh());
					pstmt.setString(4, article.getSubject());
					pstmt.setString(5, article.getPasswd());
					pstmt.setString(6, article.getContent());
					pstmt.setInt(7, article.getNum());
					pstmt.executeUpdate();
					x= 1;
				}else{
					x= 0;
				}
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return x;
	}
	

	public int deleteArticle(int num, String passwd) throws Exception {
		String dbpasswd="";
		int otonum = 0;
		int x=-1;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement(
			"select passwd, otonum from otoboard where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbpasswd= rs.getString("passwd");
				otonum = rs.getInt("otonum"); 
				if(dbpasswd.equals(passwd)){
					pstmt = conn.prepareStatement("delete from otoboard where otonum=?");
					pstmt.setInt(1, otonum);
					pstmt.executeUpdate();
					x= 1; 
				}else
					x= 0; 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return x;
	}
	
	public int deleteArticleOne(int num, String passwd) throws Exception {
		String dbpasswd="";
		int x=-1;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement(
			"select passwd, otonum from otoboard where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbpasswd= rs.getString("passwd");
				if(dbpasswd.equals(passwd)){
					pstmt = conn.prepareStatement("delete from otoboard where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x= 1; 
				}else
					x= 0; 
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return x;
	}
	
	public int passwdCheck(int num, String passwd) throws Exception {
		String dbpasswd="";
		int x=-1; // 글번호가 잘못되었다.
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement(
			"select passwd from otoboard where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbpasswd= rs.getString("passwd");
				if(dbpasswd.equals(passwd)){
					x= 1; // 글번호에 비밀번호확인
				}else
					x= 0; // 비밀번호 틀렸다.
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return x;
	}
	
	public List getArticles(String id, int start, int end) throws Exception {
		List articleList=null;
		try {
			conn = ConnectionDAO.getConnection();
			int st = 0;
			String sql = "select status from member where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				st=rs.getInt(1);
			}

			if(st == 10) {
			pstmt = conn.prepareStatement(
					"select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "+
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r " +
					"from (select * " +
					"from otoboard order by otonum desc, re_step asc) order by otonum desc, re_step asc ) where r >= ? and r <= ? ");
					pstmt.setInt(1, start); 
					pstmt.setInt(2, end);
					
					rs = pstmt.executeQuery();
					if (rs.next()) {
						articleList = new ArrayList(end); 
						do{ 
							otoBoardDataBean article= new otoBoardDataBean();
							article.setNum(rs.getInt("num"));
							article.setWriter(rs.getString("writer"));
							article.setEmail(rs.getString("email"));
							article.setSubject(rs.getString("subject"));
							article.setPasswd(rs.getString("passwd"));
							article.setReg_date(rs.getTimestamp("reg_date"));
							article.setReadcount(rs.getInt("readcount"));
							article.setRef(rs.getInt("ref"));
							article.setRe_step(rs.getInt("re_step"));
							article.setRe_level(rs.getInt("re_level"));
							article.setContent(rs.getString("content"));
							article.setIp(rs.getString("ip"));
							articleList.add(article); 
						}while(rs.next());
					}
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}

		return articleList;
	}
	
	public int getArticleCount(String col , String search) throws Exception {
		int x=0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select count(*) from otoboard where "+col+" like '%"+search+"%'";
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
	
	public List getArticles(String col , String search, int start, int end) throws Exception {
		List articleList=null;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement(
					"select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r "+
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r " +
					"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount " +
					"from otoboard  where "+col+" like '%"+search+"%' order by reg_date desc) order by reg_date desc ) where r >= ? and r <= ? ");
					pstmt.setInt(1, start); 
					pstmt.setInt(2, end); 

					rs = pstmt.executeQuery();
					if (rs.next()) {
						articleList = new ArrayList(end); 
						do{ 
							otoBoardDataBean article= new otoBoardDataBean();
							article.setNum(rs.getInt("num"));
							article.setWriter(rs.getString("writer"));
							article.setEmail(rs.getString("email"));
							article.setSubject(rs.getString("subject"));
							article.setPasswd(rs.getString("passwd"));
							article.setReg_date(rs.getTimestamp("reg_date"));
							article.setReadcount(rs.getInt("readcount"));
							article.setRef(rs.getInt("ref"));
							article.setRe_step(rs.getInt("re_step"));
							article.setRe_level(rs.getInt("re_level"));
							article.setContent(rs.getString("content"));
							article.setIp(rs.getString("ip"));
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
	
	public List nonCheck (int startRow, int endRow) {
		List list=null;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select * from(select rank() over (order by otonum desc)r , otonum, count(*)c "
					+ "from otoboard group by otonum having count(*)=1)a inner join otoboard b on a.otonum = b.otonum "
					+ "where a.r>=? and r<=? order by a.otonum desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList(endRow);
				do {
					otoBoardDataBean dto = new otoBoardDataBean();
					dto.setReg_date(rs.getTimestamp("reg_date"));
					dto.setWriter(rs.getString("writer"));
					dto.setSubject(rs.getString("subject"));
					dto.setNum(rs.getInt("num"));
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
	
	public int nonCheckCount() {
		int x =0;
		try {
			conn = ConnectionDAO.getConnection();
			String sql = "select count(*) from(select otonum, count(*)c from otoboard group by otonum) where c=1";
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
}