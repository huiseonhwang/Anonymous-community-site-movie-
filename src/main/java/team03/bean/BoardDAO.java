package team03.bean;

import java.sql.*;
import java.util.*;

import team03.bean.OracleDB;

public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// dao의 객체를 dao 클래스에서 미리 생성한 후 메소드를 호출하는 형식으로 dao 클래스를 사용하는 코드
	private static BoardDAO instance = new BoardDAO();
	public static BoardDAO getInstance() {
		return instance;
	}
	private BoardDAO() {}

	// 익명 글 작성
	public int insertContent(BoardDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"insert into teamBoard values(" 
					+ " teamBoard_seq.nextval, ?, ?, ?, ?, ?, sysdate, 0, 0, 0)");
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getFilename());
			
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
	
	// 회원 글 작성
	public int insertContentMem(BoardDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"insert into teamBoard values("
					+ "teamBoard_seq.nextval, ?, ?, ?, ?, ?, sysdate, 0, 0, 0)");
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getFilename());
			
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
	
	// 게시글 페이지 정렬, 출력
	public List<BoardDTO> getAllList(int start, int end){
		List<BoardDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
					+ " (select num,writer,subject,pw,content,filename,reg,readcount, good, bad, rownum r from " 
					+ " (select * from teamBoard order by num desc)) "
					+ " where r >= ? and r <= ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
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
	
	// 게시글 갯수
	public int getCount() {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from teamBoard");
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
	
	// 본인의 게시글 페이지 정렬, 출력
	public List<BoardDTO> getMyList(String writer, int start, int end){
		List<BoardDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from " 
					+ " (select num, writer, subject, pw, content, filename, reg, readcount, good, bad, rownum r from " 
					+ " (select * from teamBoard where writer = ? order by num desc)) "
					+ " where r >=? and r <=?");
			pstmt.setString(1, writer);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
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
	
	// 본인의 게시글 갯수
	public int getMyCount(String writer) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from teamBoard where writer = ?");
			pstmt.setString(1, writer);
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
	
	// 게시글 페이지 (내용 출력)
	public BoardDTO getContent(BoardDTO dto) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from teamBoard where num = ? ");
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
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
	
	// 게시글 조회수 증가
	public void readcountUp(BoardDTO dto) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update teamBoard set readcount = readcount+1 where num = ?");
			pstmt.setInt(1, dto.getNum());
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
	}
	
	// 익명 게시글 수정
	public int updateContent(BoardDTO dto) {
		String dbpasswd="";
		int x=-1;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select pw from teamBoard where num = ?");
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbpasswd= rs.getString("pw"); 
				if(dbpasswd.equals(dto.getPw())){
					pstmt = conn.prepareStatement(
							"update teamBoard set subject = ?, pw = ?, content = ?, filename = ? where num = ?");
					pstmt.setString(1, dto.getSubject());
					pstmt.setString(2, dto.getPw());
					pstmt.setString(3, dto.getContent());
					pstmt.setString(4, dto.getFilename());
					pstmt.setInt(5, dto.getNum());
					pstmt.executeUpdate();
					x= 1;
				}else{
					x= 0;
				}
			}
		} catch(Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return x;
	}
	
	// 익명 게시글 삭제
	public int deleteContent(int num, String pw) {
		String DBpw;
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select pw from teamBoard where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				DBpw = rs.getString("pw");
				if(DBpw.equals(pw)) {
					pstmt = conn.prepareStatement(
							"delete from teamBoard where num = ?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					
					result = 1;
				} else {
					result = 0;
				}
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
	
	// 회원 게시글 수정
	public int updateMemContent(BoardDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update teamBoard set subject = ?, content = ?, filename = ? where num = ?");
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getFilename());
			pstmt.setInt(4, dto.getNum());
			
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
	
	// 회원 게시글 삭제
	public int deleteMemContent(BoardDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"delete from teamBoard where num = ?");
			pstmt.setInt(1, dto.getNum());
			
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
	
	// 개시글 검색
	public List<BoardDTO> getSearchList (String colum, String search, int start, int end){
		List<BoardDTO> list = null;//객체 없으면 값 안들어감
		try {
			conn=OracleDB.getConnection();
			pstmt=conn.prepareStatement("select * from "
					+ " (select num,writer,subject,pw,content,filename,reg,readcount, good, bad, rownum r from " 
					+ " (select * from teamBoard where "+colum+" like '%"+search+"%' order by num desc)) "
					+ " where r >=? and r <=?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
			list = new ArrayList<BoardDTO>();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setContent(rs.getString("content"));
				dto.setSubject(rs.getString("subject"));
				dto.setPw(rs.getString("pw"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
				list.add(dto);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}

			}
		return list;
		}
	
	// 검색한 개시글 갯수
	public int getSearchCount(String colum, String search) {
		int result = 0;
		try {
			conn=OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from teamBoard where "+colum+" like '%"+search+"%'");
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	// 게시글 공감 증가
	public int goodCountUp(BoardDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update teamBoard set good = good + 1 where num = ?");
			pstmt.setInt(1, dto.getNum());
			
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
	
	// 게시글 비공감 증가
	public int badCountUp(BoardDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update teamBoard set bad = bad + 1 where num = ?");
			pstmt.setInt(1, dto.getNum());
			
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
}