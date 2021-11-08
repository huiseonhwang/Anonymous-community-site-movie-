package team03.bean;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	private static MovieDAO instance = new MovieDAO();
	public static MovieDAO getInstance() {
		return instance;
	}
	private MovieDAO() {}
	
	// 페이지 정렬, 처리
	public List<MovieDTO> getAllList(int start, int end) throws Exception {
		List<MovieDTO> list = new  ArrayList<MovieDTO>();
		// <> 제네릭, 타입지정 (타입통일)
		// MovieDTO안에 들어간 정보들만 받는다.
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
					+ " (select num,writer,subject,pw,content,filename,reg,readcount, good, bad, rownum r from " 
					+ " (select * from movieBoard order by num desc))"
					+ " where r >= ? and r <= ?");
			// sql문 작성
			// rownnum 게시글 순서
			// num 은 남는다, 왜? => 열번호이기 때문에 
			// 열의 처음부터 끝까지 다 검색한다.
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieDTO dto = new MovieDTO();
				System.out.println(rs.getString("subject"));
				dto.setNum(rs.getInt("Num"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return list;
	}
	
	// 게시글 갯수 (DB값이 있는지 없는지 확인 메서드)
	public int getCount() {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count (*) from movieboard");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
				// count 1 = result 1
				// count 2 = result 2
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	// 회원 글 작성
	public int insertContentMemver(MovieDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("insert into movieboard values"
					+ "(movieboard_seq.nextval,?,?,?,?,?,sysdate,0,0,0);");
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getFilename());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
	return result;
	}
	
	// 본인의 게시글 갯수
	public int getMycount(String writer) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from movieBoard where writer = ?");
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		} return result;
	}
	// 본인의 게시글 페이지 정렬, 출력
	public List<MovieDTO> getMyList(String writer, int start, int end){
		List<MovieDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from " 
					+ " (select num, writer, subject, pw, content, filename, reg, readcount, good, bad, rownum r from " 
					+ " (select * from movieBoard where writer = ? order by num desc)) "
					+ " where r >=? and r <=?");
			pstmt.setString(1, writer);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			list = new ArrayList();
			while(rs.next()) {
				MovieDTO dto = new MovieDTO();
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}
	
	// 게시글 조회수 증가
	public void readCountUp(MovieDTO dto) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("update movieBoard set readcount = readcount+1 where num = ?;");
			pstmt.setInt(1, dto.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
	}
	
	// 게시글 페이지 (내용 출력)
	public MovieDTO getContent(MovieDTO dto) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from movieBoard where num = ?");
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return dto;
	}
	
	//  회원 게시글 수정
	public int updateMemContent(MovieDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("update MovieBoard set subject = ?, content = ?, filename = ? where num = ?");
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getFilename());
			pstmt.setInt(4, dto.getNum());
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	} 
	
	// 회원 게시글 삭제
	public int deleteMemContent(MovieDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("delete from movieBoard where num =?");
			pstmt.setInt(1, dto.getNum());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	} 
	
	// 익명 글 작성
	public int insertContent(MovieDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("insert into movieBoard values(" 
					+ " movieBoard_seq.nextval, ?, ?, ?, ?, ?, sysdate, 0, 0, 0)");
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getFilename());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	
	
}
