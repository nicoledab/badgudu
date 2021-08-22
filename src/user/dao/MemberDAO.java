package user.dao;

import java.sql.*;
import java.util.*;
import user.dto.MemberDTO;

public class MemberDAO {
   private Connection conn = null;
   private PreparedStatement pstmt = null;
   private ResultSet rs = null;
   
   public void insertMember(MemberDTO dto) {
      try {
         conn = ConnectionDAO.getConnection(); 
         pstmt = conn.prepareStatement("insert into member values(?,?,?,1,sysdate,?,mem_seq.NEXTVAL,?)");
         pstmt.setString(1, dto.getName());
         pstmt.setString(2, dto.getId());
         pstmt.setString(3, dto.getPw());
         pstmt.setString(4, dto.getAddress());
         pstmt.setString(5, dto.getPhoneNumber());
         
         
         pstmt.executeUpdate();
         
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
   }
   
   public void AdminInsertMember(MemberDTO dto) {
	      try {
	         conn = ConnectionDAO.getConnection(); 
	         pstmt = conn.prepareStatement("insert into member values(?,?,?,10,sysdate,?,mem_seq.NEXTVAL,?)");
	         pstmt.setString(1, dto.getName());
	         pstmt.setString(2, dto.getId());
	         pstmt.setString(3, dto.getPw());
	         pstmt.setString(4, dto.getAddress());
	         pstmt.setString(5, dto.getPhoneNumber());
	         
	         
	         pstmt.executeUpdate();
	         
	      }catch(Exception e) {
	         e.printStackTrace();
	      }finally {
	         ConnectionDAO.close(rs, pstmt, conn);
	      }
	   }
   //boolean, int, String, DTO
   public boolean loginCheck(String id, String pw) {
      boolean result = false;
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select * from(select * from member where status=1 or status=10) where id=? and password=?");
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
   public String findid(String name, String pw) {
      String id="";
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select id from member where name=? and password=?");
         pstmt.setString(1, name);
         pstmt.setString(2, pw);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            id=rs.getString("id");
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return id;
   }
   public String findpw(String name, String id) {
      String pw="";
      try {
         conn = ConnectionDAO.getConnection();
         pstmt = conn.prepareStatement("select password from member where name=? and id=?");
         pstmt.setString(1, name);
         pstmt.setString(2, id);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            pw=rs.getString("password");
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
         }
      return pw;
      }
   public boolean confirmId(String id) {
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
         ConnectionDAO.close(rs, pstmt, conn);
         }
      return result;
   }
   public MemberDTO getUser(String id) {
      MemberDTO dto = new MemberDTO();
      try {
         conn = ConnectionDAO.getConnection();  
         pstmt = conn.prepareStatement("select * from member where id=?");
         pstmt.setString(1, id);
         rs = pstmt.executeQuery();
         if(rs.next()) {
            dto.setName(rs.getString("name"));
            dto.setId(rs.getString("id"));
            dto.setPw(rs.getString("password"));
            dto.setStatus(rs.getInt("status"));
            dto.setSignupdate(rs.getTimestamp("signupdate"));
            dto.setAddress(rs.getString("Address"));
            String [] ph = rs.getString("phonenumber").split("-");
            dto.setPh1(ph[0]);
            dto.setPh2(ph[1]);
            dto.setPh3(ph[2]);
         }
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return dto;
   }
   
   public int usergetArticleCount() throws Exception { // 유저 고객수 불러오기
	      int x=0;
	      try {
	         conn = ConnectionDAO.getConnection();
	         pstmt = conn.prepareStatement("select count (*) from member where status=1 or status=2 or status=3");
	         
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
   
   public int admingetArticleCount() throws Exception { // 어드민페이지 고객수
	      int x=0;
	      try {
	         conn = ConnectionDAO.getConnection();
	         pstmt = conn.prepareStatement("select count (*) from member where status=10");
	         
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

   public ArrayList<MemberDTO> select() {
      ArrayList<MemberDTO> list = null;
      try {
         conn = ConnectionDAO.getConnection();
         String sql = "select * from member";
         pstmt = conn.prepareStatement(sql);
         rs = pstmt.executeQuery();
         
         list = new ArrayList<MemberDTO>();
         while(rs.next()) {
            MemberDTO mem = new MemberDTO();
            mem.setName(rs.getString("name")+"");
            mem.setId(rs.getString("id"));
            mem.setPw(rs.getString("pw"));
            mem.setSignupdate(rs.getTimestamp("signupdate"));
            mem.setAddress(rs.getString("adrress"));
            String [] ph = rs.getString("phonenumber").split("-");
            mem.setPh1(ph[0]);
            mem.setPh2(ph[1]);
            mem.setPh3(ph[2]);
            list.add(mem);
         }   
      }catch(Exception e) {
         e.printStackTrace();
      }finally {
         ConnectionDAO.close(rs, pstmt, conn);
      }
      return list;
   }
      
  	public MemberDTO updateGetArticle(int num) throws Exception { // 고객 정보 수정 고객 데이터 가져오기
		MemberDTO article=null;
		try {
			conn = ConnectionDAO.getConnection();
			pstmt = conn.prepareStatement(
			"select * from member where num = ?"); 
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
	               article = new MemberDTO();
	               article.setName(rs.getString("num"));
	               article.setName(rs.getString("name"));
	               article.setId(rs.getString("id"));
	               article.setPw(rs.getString("password"));
	               article.setStatus(rs.getInt("status"));
	               article.setSignupdate(rs.getTimestamp("signupdate"));
	               article.setAddress(rs.getString("address"));
	               String [] ph = rs.getString("phonenumber").split("-");
	               article.setPh1(ph[0]);
	               article.setPh2(ph[1]);
	               article.setPh3(ph[2]);
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			ConnectionDAO.close(rs, pstmt, conn);
		}

		return article;
	}
      
      public int updateArticle(MemberDTO article) throws Exception { // 고객 정보 수정 고객 데이터 db 로 넘겨주기
         String sql="";
         int x=1;
         try {
            conn = ConnectionDAO.getConnection();
            sql = "update member set name=?,id=?,status=?,address=?,password=?, phonenumber=? where num=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, article.getName());
            pstmt.setString(2, article.getId());
            pstmt.setInt(3, article.getStatus());
            pstmt.setString(4, article.getAddress());
            pstmt.setString(5, article.getPw()); 
            pstmt.setString(6, article.getPhoneNumber());
            pstmt.setInt(7, article.getNum());
            
            pstmt.executeUpdate();
           
         } catch(Exception ex) {
            ex.printStackTrace();
         } finally {
            ConnectionDAO.close(rs, pstmt, conn);
         }
         return x;
      }     
      
      public MemberDTO getMember(String id) {
         MemberDTO dto = null;
         try {
            conn = ConnectionDAO.getConnection();
            String sql = "select * from member where id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if(rs.next()) {
               dto = new MemberDTO();
               dto.setName(rs.getString("name"));
               dto.setId(rs.getString("id"));
               dto.setPw(rs.getString("password"));
               dto.setStatus(rs.getInt("Status"));
               dto.setSignupdate(rs.getTimestamp("signupdate"));
               dto.setAddress(rs.getString("address"));
               String [] ph = rs.getString("phonenumber").split("-");
               dto.setPh1(ph[0]);
               dto.setPh2(ph[1]);
               dto.setPh3(ph[2]);
            }
         }catch(Exception e) {
            e.printStackTrace();
         }finally {
            ConnectionDAO.close(rs, pstmt, conn);
         }
         return dto;
      }
      
      public List usergetArticles( int start, int end) throws Exception { // 유저 고객 목록 불러오기
          List articleList=null;
          try {
             conn = ConnectionDAO.getConnection();
             pstmt = conn.prepareStatement(
                   "select num,name,id,password,status,signupdate,address,phonenumber, r "+    
                   "from (select num,name,id,password,status,signupdate,address,phonenumber, rownum r " +  // 여긴 컬럼이름을 다 적어야함 아.. 이부분이 계속 오류가나서 다른게 안되는거같아요 ㅇㅇ 컬럼 이름 다 적어 ^^ 
                   "from (select num,name,id,password,status,signupdate,address,phonenumber " +
                   "from member where status=1 or status=2 or status=3 order by num asc) order by num asc) where r >= ? and r <= ? ");
                   pstmt.setInt(1, start); 
                   pstmt.setInt(2, end);

                   rs = pstmt.executeQuery();
                   if (rs.next()) {
                      articleList = new ArrayList(end); 
                      do{ 
                         MemberDTO article= new MemberDTO();
                         article.setNum(rs.getInt("num"));
                         article.setName(rs.getString("name")+"");
                         article.setId(rs.getString("id"));
                         article.setPw(rs.getString("password"));
                         article.setStatus(rs.getInt("status"));
                         article.setSignupdate(rs.getTimestamp("signupdate"));
                         article.setAddress(rs.getString("address"));
                         String [] ph = rs.getString("phonenumber").split("-");
                         article.setPh1(ph[0]);
                         article.setPh2(ph[1]);
                         article.setPh3(ph[2]); 
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
   
      public List admingetArticles( int start, int end) throws Exception { // 어드민 페이지 고객 불러오기
          List articleList=null;
          try {
             conn = ConnectionDAO.getConnection();
             pstmt = conn.prepareStatement(
                   "select num,name,id,password,status,signupdate,address ,phonenumber ,r "+    
                   "from (select num,name,id,password,status,signupdate,address,phonenumber ,rownum r " +  
                   "from (select num,name,id,password,status,signupdate,address,phonenumber " +
                   "from member where status=10 order by num asc) order by num asc) where r >= ? and r <= ? ");
                   pstmt.setInt(1, start); 
                   pstmt.setInt(2, end);

                   rs = pstmt.executeQuery();
                   if (rs.next()) {
                      articleList = new ArrayList(end); 
                      do{ 
                         MemberDTO article= new MemberDTO();
                         article.setNum(rs.getInt("num"));
                         article.setName(rs.getString("name")+"");
                         article.setId(rs.getString("id"));
                         article.setPw(rs.getString("password"));
                         article.setStatus(rs.getInt("status"));
                         article.setSignupdate(rs.getTimestamp("signupdate"));
                         article.setAddress(rs.getString("address"));
                         String [] ph = rs.getString("phonenumber").split("-");
                         article.setPh1(ph[0]);
                         article.setPh2(ph[1]);
                         article.setPh3(ph[2]); 
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
         
     	public int admingetArticleCount(String col , String search) throws Exception { // 어드민 서치
    		int x=0;
    		try {
    			conn = ConnectionDAO.getConnection();
    			String sql = "select count (*) from (select num,name,id,password,status,signupdate,address, phonenumber"
    					+ " from member where status=10) where "+col+" like '%"+search+"%'";
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
     	
     	public int usergetArticleCount(String col , String search) throws Exception { // 고객 서치 고객수 불러오기
    		int x=0;
    		try {
    			conn = ConnectionDAO.getConnection();
    			String sql = "select count (*) from (select num,name,id,password,status,signupdate,address"
    					+ " from member where status=1 or status=2 or status=3) where "+col+" like '%"+search+"%'";
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
     	
    	public List admingetArticles(String col , String search, int start, int end) throws Exception { // 어드민 서치 고객목록 불러오기
    		List articleList=null;
    		try {
    			conn = ConnectionDAO.getConnection();
    			pstmt = conn.prepareStatement(
    	                "select num,name,id,password,status,signupdate,address, phonenumber,r "+    
    	                "from (select num,name,id,password,status,signupdate,address,phonenumber,rownum r " +  // 여긴 컬럼이름을 다 적어야함 아.. 이부분이 계속 오류가나서 다른게 안되는거같아요 ㅇㅇ 컬럼 이름 다 적어 ^^ 
    	                "from (select num,name,id,password,status,signupdate,address,phonenumber " +
    	                "from member where status=10 order by num asc) where "+col+" like '%"+search+"%' order by num asc) where r >= ? and r <= ? ");
    					pstmt.setInt(1, start); 
    					pstmt.setInt(2, end); 

    					rs = pstmt.executeQuery();
    					if (rs.next()) {
    						articleList = new ArrayList(end); 
    						do{ 
    							MemberDTO article= new MemberDTO();
    		                     article.setName(rs.getString("name")+"");
    		                     article.setId(rs.getString("id"));
    		                     article.setPw(rs.getString("password"));
    		                     article.setStatus(rs.getInt("status"));
    		                     article.setSignupdate(rs.getTimestamp("signupdate"));
    		                     article.setAddress(rs.getString("address"));
    		                     String [] ph = rs.getString("phonenumber").split("-");
    	                         article.setPh1(ph[0]);
    	                         article.setPh2(ph[1]);
    	                         article.setPh3(ph[2]); 
    	                         article.setNum(rs.getInt("num"));
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
      
    	public List usergetArticles(String col , String search, int start, int end) throws Exception { // 고객 목록 서치 불러오기
    		List articleList=null;
    		try {
    			conn = ConnectionDAO.getConnection();
    			pstmt = conn.prepareStatement(
    	                "select num,name,id,password,status,signupdate,address,phonenumber,r "+    
    	                "from (select num,name,id,password,status,signupdate,address,phonenumber, rownum r " +  // 여긴 컬럼이름을 다 적어야함 아.. 이부분이 계속 오류가나서 다른게 안되는거같아요 ㅇㅇ 컬럼 이름 다 적어 ^^ 
    	                "from (select num,name,id,password,status,signupdate,address,phonenumber " +
    	                "from member where status=1 or status=2 or status=3 order by num asc) where "+col+" like '%"+search+"%' order by num asc) where r >= ? and r <= ? ");
    					pstmt.setInt(1, start); 
    					pstmt.setInt(2, end); 

    					rs = pstmt.executeQuery();
    					if (rs.next()) {
    						articleList = new ArrayList(end); 
    						do{ 
    							MemberDTO article= new MemberDTO();
    		                     article.setName(rs.getString("name")+"");
    		                     article.setId(rs.getString("id"));
    		                     article.setPw(rs.getString("password"));
    		                     article.setStatus(rs.getInt("status"));
    		                     article.setSignupdate(rs.getTimestamp("signupdate"));
    		                     article.setAddress(rs.getString("address"));
    		                     article.setNum(rs.getInt("num"));
    		                     String [] ph = rs.getString("phonenumber").split("-");
    	                         article.setPh1(ph[0]);
    	                         article.setPh2(ph[1]);
    	                         article.setPh3(ph[2]); 
    	                         article.setNum(rs.getInt("num"));
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