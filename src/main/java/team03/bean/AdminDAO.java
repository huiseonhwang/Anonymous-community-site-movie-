package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import java.util.ArrayList;

import team03.bean.OracleDB;


public class AdminDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//싱글톤 패턴. 쉽게 표현해 객체를 1개만 생성할 수 있게 한다.
	private static AdminDAO instance = new AdminDAO();
	public static AdminDAO getInstance(){
		return instance;
	}
	private AdminDAO(){}
	
	//로그인 시 관리자 계정의 정보를 불러오는 메서드
	public AdminDTO getAdmin() {
		AdminDTO dto = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select admin from admintable");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new AdminDTO();
				dto.setAdmin(rs.getString("admin"));
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return dto;
	}
	
	//홈페이지 회원의 정보를 불러오는 메서드
	public List<MemberDTO> getMember(int start, int end){
		List<MemberDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from(select id, pw, name, email1, email2, rownum r from(select * from member)) where r>=? and r <=?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
			list = new ArrayList<MemberDTO>();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setEmail1(rs.getString("email1"));
				dto.setEmail2(rs.getString("email2"));
				list.add(dto);
			}
		}	catch (Exception e) {
				e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}
	
	//카카오 로그인한 회원의 정보를 불러오는 메서드
	public List<KloginDTO> getKmember(int start, int end){
		List<KloginDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from(select kid, name, email, rownum r from(select * from kmember))where r>=? and r <=?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
			list = new ArrayList<KloginDTO>();
			while(rs.next()) {
				KloginDTO dto = new KloginDTO();
				dto.setKid(rs.getString("kid"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				list.add(dto);
			}
		}	catch (Exception e) {
				e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}
	
	//홈페이지 회원의 총 인원수를 세는 메서드
	public int getMemCount() {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from Member");
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	//카카오 회원의 총 인원수를 세는 메서드
	public int getKmemCount() {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from kmember");
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	// 홈페이지 회원을 강제 탈퇴시키는 메서드. 
	public int deleteMem(String id) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"delete from member where id = ?");
			pstmt.setString(1, id);
			
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	// 카카오 회원을 강제 탈퇴시키는 메서드
	public int deleteKMem(String kid) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"delete from kmember where kid = ?");
			pstmt.setString(1, kid);
			
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}

	//게시글을 번호로 찾아 지우는 메서드
	public int deleteContent(int num) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("delete from teamBoard where num =?");
			pstmt.setInt(1, num);
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
		
	//미니페이지(방명록)의 게시글 수를 세는 메서드
	public int getVisitorCount () {
		int result = 0;
		try {
			conn=OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from visitor");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result =rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	//미니페이지(방명록)의 게시글을 가져오는 메서드
	public List<VisitorDTO> getAllVlist(int start, int end){
		List<VisitorDTO> list = null;
		try {
			conn=OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from"
					+ " (select owner, num, id, pw, content, reg, rownum r from"
					+ " (select * from visitor  order by num desc))"
					+ " where r >= ? and r <= ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			list = new ArrayList();
			while(rs.next()) {
				VisitorDTO dto = new VisitorDTO();
				dto.setOwner(rs.getString("owner"));
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
				list.add(dto);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}

	
	//특정 미니페이지의 게시글(방명록)을 번호로 찾아 지우는 메서드
	public int VisitorDelete(String owner, int num) {
		int result = 0;
		try {
			conn=OracleDB.getConnection();
			pstmt=conn.prepareStatement("delete from visitor where owner = ? and num = ?");
			pstmt.setString(1, owner);
			pstmt.setInt(2, num);
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
	
	// 지역 게시판의 총 댓글을 세는 메서드
	public int commentCount() {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from boardComment");
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	// 지역 게시판의 모든 댓글을 불러오는 메서드
	public List<CommentDTO> getAllComment(int start, int end){
		List<CommentDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
					+ " (select boardNum, num, writer, pw, content, reg, re_step, re_level, rownum r from "
					+ " (select * from boardComment order by num desc)) "
					+ " where r >= ? and r <= ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<CommentDTO>();
			while(rs.next()) {
				CommentDTO dto = new CommentDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setNum(rs.getInt("num"));
				dto.setContent(rs.getString("content"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}
	
	// 자유게시판 내 특정 게시글의 댓글을 번호로 찾아 지우는 메서드
	public int deleteComment(int CboardNum, int Cnum) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"delete from boardComment where boardNum = ? and num = ?");
			pstmt.setInt(1, CboardNum);
			pstmt.setInt(2, Cnum);
			
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	//지역게시판 내 특정 게시글의 댓글을 번호로 찾아 지우는 메서드
	public int LocalDeleteContent(int num) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("delete from localBoard where num =?");
			pstmt.setInt(1, num);
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
	
	// 지역게시판의 총 댓글을 세는 메서드
	public int LocalCommentCount() {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from localBoardComment");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
	
	// 지역게시판의 모든 댓글을 불러오는 메서드
	public List<LocalBoardCommentDTO> getLocalComment(int start, int end){
		List<LocalBoardCommentDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
						+ " (select boardNum, num, writer, content, reg, re_step, re_level, rownum r from "
						+ " (select * from localBoardComment order by num desc)) "
						+ " where r >= ? and r <= ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<LocalBoardCommentDTO>();
			while(rs.next()) {
				LocalBoardCommentDTO dto = new LocalBoardCommentDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setNum(rs.getInt("num"));
				dto.setContent(rs.getString("content"));
				dto.setWriter(rs.getString("writer"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				list.add(dto);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return list;
	}
	
	// 지역게시판 내 특정 게시글의 댓글을 번호로 찾아 지우는 메서드
	public int localDeleteComment(int LboardNum, int Lnum) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"delete from localBoardComment where boardNum = ? and num = ?");
			pstmt.setInt(1, LboardNum);
			pstmt.setInt(2, Lnum);
			
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	// 영화게시판 내 게시글을 번호로 찾아 지우는 메서드
	public int MovieDeleteContent(int num) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("delete from MovieBoard where num =?");
			pstmt.setInt(1, num);
			result=pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
	
	// 영화게시판의 총 댓글을 세는 메서드
	public int MovieCommentCount() {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from movieComment");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
	
	// 영화게시판의 댓글을 불러오는 메서드
	public List<MovieCommentDTO> getMovieComment(int start, int end){
		List<MovieCommentDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
						+ " (select boardNum, num, writer, pw, content, reg, re_step, re_level, rownum r from "
						+ " (select * from MovieComment order by num desc)) "
						+ " where r >= ? and r <= ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<MovieCommentDTO>();
			while(rs.next()) {
				MovieCommentDTO dto = new MovieCommentDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setNum(rs.getInt("num"));
				dto.setContent(rs.getString("content"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				list.add(dto);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return list;
	}
	
	// 영화게시판 내 특정 게시글의 댓글을 번호로 찾아 지우는 메서드
	public int movieDeleteComment(int MboardNum, int Mnum) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"delete from movieComment where boardNum = ? and num = ?");
			pstmt.setInt(1, MboardNum);
			pstmt.setInt(2, Mnum);
			
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
}
