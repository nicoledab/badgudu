package user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import user.dto.ConnectionDAO;
import user.dto.ReviewBoardDTO;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import user.dto.ReviewBoardDTO;

public class ReviewBoardDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs= null;
	

	public void insertreviewBoard(ReviewBoardDTO dto) throws Exception {
		
		try {
			conn = ConnectionDAO.getConnection();
			
			                                                      //   num,writer,subject,content,save,reg_date,ref,ref_step,re_level, 조회수, 상태
			pstmt = conn.prepareStatement("insert into reviewboard values(reviewboard_seq.nextval,?,?,?,?,sysdate,0,1)");
			pstmt.setString(1, dto.getWriter()); //dto의 id를 꺼내서 set 하겠다! 
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getSave());
			
			pstmt.executeUpdate(); //4단계 
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	
	public ArrayList<ReviewBoardDTO> getList() {
		ArrayList<ReviewBoardDTO> list = new ArrayList<ReviewBoardDTO>();
		
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select * from reviewboard order by reg_date desc");
			rs = pstmt.executeQuery();
			
			//   rs.next() -첫번째 존재 true 확인, 두번째~ 마지막까지 계속 반복!   
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
				
				list.add(dto);// list에 넣는다
			}
					
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return list;
	}
	
	
	//내가 쓴 후기 보기
	public ArrayList<ReviewBoardDTO> getMyReviewList(String id) {
		ArrayList<ReviewBoardDTO> list = new ArrayList<ReviewBoardDTO>();
		
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select * from reviewboard where writer = ? order by reg_date desc");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			//   rs.next() -첫번째 존재 true 확인, 두번째~ 마지막까지 계속 반복!   
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
				
				list.add(dto);// list에 넣는다
			}
					
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return list;
	}
	
	//진짜, 찐 검색 
	public ArrayList<ReviewBoardDTO> getSearchResult(String col, String search) {
		ArrayList<ReviewBoardDTO> list = new ArrayList<ReviewBoardDTO>();
		
		try {
			
			/*	pstmt = conn.prepareStatement("select *  from (select num,writer,subject,title,content,reg_date,readcount, ref,re_step,re_level,rownum r "+
					  "from ( select * from qnaboard where "+col+" like '%"+search+"%' order by reg_date desc) order by reg_date desc )where r >= ? and r <= ? ");
				*/
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select *  from (select num,writer,subject,save,content,reg_date,readcount, status,rownum r "+
					"from ( select * from reviewboard where "+col+" like '%"+search+"%' order by reg_date desc) order by reg_date desc )where r >= ? and r <= ? ");
			rs = pstmt.executeQuery();
			
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
				
				list.add(dto);// list에 넣는다
			}
					
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return list;
	}
	
	
	
	
	public void readCount (int num) {
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("update reviewboard set readcount=readcount+1 where num= ? ");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
	}
	
	
	//select *from reviewboard where num=3; 로 sql 에 검색, 내용 확인할수있다
	public ReviewBoardDTO getContent(int num) {
		
		ReviewBoardDTO dto = new ReviewBoardDTO();
		
		
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement("select *from reviewboard where num=? ");
			pstmt.setInt(1, num);
			
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
			    dto.setWriter(rs.getString("writer"));
			    dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setSave(rs.getString("save"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setStatus(rs.getInt("status"));
				dto.setReg_date(rs.getTimestamp("reg_date"));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}
		return dto;
	}
	
	
	// 전체 reviewboard 테이블의 레코드 수 리턴!! 
		public int getreviewCount() throws Exception {
			int x=0;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select count(*) from reviewboard"); //count-갯수 (게시글의)
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
	
		
		//마이페이지에서의 내가 작성한 리뷰글 수 
		// 상품상세 페이지의 리뷰 글 수  
		public int getMyReviewCount(String id) throws Exception {
			int x=0;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select count(*) from reviewboard where writer = ?"); //count-갯수 (게시글의)
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
		
		// 상품상세 페이지의 리뷰 글 수  
		public int getPdReviewCount(String subject) throws Exception {
			int x=0;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select count(*) from reviewboard where subject = ?"); //count-갯수 (게시글의)
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
		
        ///상태변경   3-삭제 
		public void deleteBoard(int num) {
			try {                                 // 상태만 변화 "update reviewboard set status=3 where num=? ")
				conn = ConnectionDAO.getConnection();   // "delete from reviewboard where num=?"
				pstmt = conn.prepareStatement("delete from reviewboard where num=?");
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
	
			}catch(Exception e) {
	e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
		}	
		
		
		public void updateBoard(ReviewBoardDTO dto) {
			try {
				conn = ConnectionDAO.getConnection();  // 1/2단계 메서드 호출			
				String sql = "update reviewboard set writer=?,subject=?,content=?,save=? where num=?";
				if(dto.getSave() == null) {
					sql = "update reviewboard set writer=?,subject=?,content=? where num=?";
				}
				pstmt = conn.prepareStatement(sql);       
				pstmt.setString(1, dto.getWriter());
				pstmt.setString(2, dto.getSubject());
				pstmt.setString(3, dto.getContent());
				if(dto.getSave() == null) {
					pstmt.setInt(4, dto.getNum());
				}else {
					pstmt.setString(4, dto.getSave());
					pstmt.setInt(5, dto.getNum());
				}
				pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
		}
		
		
		//5 검색 기능                            , int start, int end
		public List<ReviewBoardDTO> getreview( String search, int start, int end) throws Exception {
			List<ReviewBoardDTO> reviewList=null;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select num,writer,subject,content, save, reg_date,readcount,status,r " +
						  "from (select num,writer,subject,content, save, reg_date,readcount,status,rownum r " +
						  "from (select num,writer,subject,content, save, reg_date,readcount,status "+
						"from reviewboard where subject like '%"+search+"%' order by reg_date desc) order by reg_date desc ) where r >= ? and r <= ?");
						
						pstmt.setInt(1, start);                          
						pstmt.setInt(2, end); 
						/*"select num,writer,subject,content, save, reg_date,readcount,status,r "+
						"from (select num,writer,subject,content, save, reg_date,readcount,status,rownum r " +
						"from (select num,writer,subject,content, save, reg_date,readcount,status " +
						"from reviewboard order by REG_DATE desc)  order by REG_DATE desc ) where r >= ? and r <= ? ");
						*/
						
						rs = pstmt.executeQuery();
						if (rs.next()) {
							reviewList = new ArrayList<ReviewBoardDTO>(); 
							do{ 
								ReviewBoardDTO dto = new ReviewBoardDTO(); 
								
								dto.setNum(rs.getInt("num"));
							    dto.setWriter(rs.getString("writer"));
							    dto.setSubject(rs.getString("subject"));
								dto.setContent(rs.getString("content"));
								dto.setSave(rs.getString("save"));
								dto.setReadcount(rs.getInt("readcount"));
								dto.setStatus(rs.getInt("status"));
								dto.setReg_date(rs.getTimestamp("reg_date"));
		
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
		/**/
		// 5번 ..
		public int getreviewCount(String search ) throws Exception {
			int x=0;
			try {
				conn = ConnectionDAO.getConnection();
				String sql ="select count(*) from reviewboard where subject like '%"+search+"%'";
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
		
		/*
		public int getreviewCount(String col) throws Exception {
			int x=0;
			try {
				conn = ConnectionDAO.getConnection();
				String sql ="select count(*) from reviewboard where subject="+col+"";
				System.out.println(col);
				System.out.println(search); //따로 검색어 없이 종류만 검색되면 되는건가요? 그래도 되고요 
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
		*/
		
		
		
		
		   // 중첩 select 문 
		public List getArticles(int start, int end) throws Exception {
			List articleList=null;
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement(
						"select num,writer,subject,content, save, reg_date,readcount,status,r "+
						"from (select num,writer,subject,content, save, reg_date,readcount,status,rownum r " +
						"from (select num,writer,subject,content, save, reg_date,readcount,status " +
						"from reviewboard order by REG_DATE desc)  order by REG_DATE desc ) where r >= ? and r <= ? ");
						pstmt.setInt(1, start);                          // ref 내림차순, restep 오름차순 
						pstmt.setInt(2, end); 

						rs = pstmt.executeQuery();
						if (rs.next()) {
							articleList = new ArrayList(end); 
							do{ 
								ReviewBoardDTO article= new ReviewBoardDTO();
								article.setNum(rs.getInt("num"));
								article.setWriter(rs.getString("writer"));
								article.setSubject(rs.getString("subject"));
								article.setContent(rs.getString("content"));
								article.setSave(rs.getString("save"));
								article.setReadcount(rs.getInt("readcount"));
								article.setStatus(rs.getInt("status"));
								article.setReg_date(rs.getTimestamp("reg_date"));
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
	
	
	/*
	//--------------------for reviewPractice 
	
	}*/
	
	
		//상품상세 게시판의 해당 상품 리뷰 보이기    // 인기글 순     //subeject 가 곧 상품명 .
		public ArrayList<ReviewBoardDTO> getPdReviewList(String subject) {
			ArrayList<ReviewBoardDTO> list = new ArrayList<ReviewBoardDTO>();
			
			try {
				conn = ConnectionDAO.getConnection();
				pstmt = conn.prepareStatement("select *from reviewboard where subject = ? order by readcount desc");
				pstmt.setString(1, subject);
				rs = pstmt.executeQuery();
				
				//   rs.next() -첫번째 존재 true 확인, 두번째~ 마지막까지 계속 반복!   
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
					
					list.add(dto);// list에 넣는다
				}
						
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return list;
		}
		
		
		
		//리뷰 페이지  상품이름만 불러오기 
		public String BringpdName(String pdCode) {
			String dto = null;
			try {
				conn = ConnectionDAO.getConnection();
				String sql = "select productname from product where pdcode = ? ";
				pstmt  = conn.prepareStatement(sql);
				pstmt.setString(1, pdCode);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto =  rs.getString("productName"); //어디서 사용하는 거죠?
					
				}
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return dto;
		}
	
		
		
		
		//본인이 구매한 상품만 리뷰 쓰게 하기
		public String idOdCheck(String id, String pdCode) {
			String dto = null;
			try {
				conn = ConnectionDAO.getConnection();
				String sql = "select *from order_detail a join reviewboard b on a.userid = b.writer where b.writer = ? and a.pdcode = ?  and  a.productname = b.subject ";
				pstmt  = conn.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pdCode);
				//pstmt.executeUpdate();
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto =  rs.getString("writer"); //
					dto =  rs.getString("pdcode"); //
					
				}
				
				
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				ConnectionDAO.close(rs, pstmt, conn);
			}
			return dto;
		}
	
	
}
