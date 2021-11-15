package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MovieCommentDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// dao의 객체를 dao 클래스에서 미리 생성한 후 메소드를 호출하는 형식으로 dao 클래스를 사용하는 코드
	public static MovieCommentDAO instance = new MovieCommentDAO();
	public static MovieCommentDAO getInstance( ) {
		return instance;
	}
	private MovieCommentDAO() {
	}
	
	// 댓글 작성
	public int insertComment(MovieCommentDTO dto, int boardNum) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement
				("insert into movieComment values(?, boardComment_seq.nextval, ?, ?, ?, sysdate, 0, 0)");
			pstmt.setInt(1, boardNum);
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getPw());
			pstmt.setString(4, dto.getContent());
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
	
	// 댓글 갯수 카운트
	public int countComment(int boardNum) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count (*) from movieComment where boardNum=?");
			pstmt.setInt(1, boardNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
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
	
	// 댓글 내용 출력
	public List<MovieCommentDTO> getAllComment(int boardNum, int start, int end) {
		List<MovieCommentDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
					+ " (select boardNum, num, writer, pw, content, reg, re_step, re_level, rownum r from " 
					+ " (select * from MovieComment where boardNum = ? order by num asc)) "
					+ " where r >= ? and r <= ?");
			pstmt.setInt(1, boardNum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			list = new ArrayList();
			while(rs.next()) {
				MovieCommentDTO dto = new MovieCommentDTO();
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
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
	
	// 이미 작성된 댓글 정보 출력
	public MovieCommentDTO getContent(MovieCommentDTO dto) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement
					("select * from MovieComment where boardNum = ? and num =? ");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
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
	
	// 회원 댓글 수정
	public int updateMemComment(MovieCommentDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("update MovieComment set content = ? where boardNum =? and num =? ");
			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getBoardNum());
			pstmt.setInt(3, dto.getNum());
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
	
	// 익명 댓글 수정
	public int updateComment(MovieCommentDTO dto) {
		String pw;
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement
					("update MovieComment set pw where boardNum=? and num=?");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pw = rs.getString("pw");
				if(pw.equals(dto.getPw())) {
					pstmt = conn.prepareStatement("update MovieComment set pw =?, content =? where boardNum =? and num =?");
					pstmt.setString(1, dto.getPw());
					pstmt.setString(2, dto.getContent());
					pstmt.setInt(3, dto.getBoardNum());
					pstmt.setInt(4, dto.getNum());
					result = pstmt.executeUpdate();
				}
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
	
	// 회원 댓글 삭제
	public int deleteMemComment(MovieCommentDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("delete from MovieComment where boardNum = ? and num =?");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
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
	
	// 익명 댓글 삭제
	public int deleteComment(MovieCommentDTO dto) {
		String pw;
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select pw from MovieComment where boardNum=? and num=?");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
			result = pstmt.executeUpdate();
			if(rs.next()) {
				pw = rs.getString("pw");
				if (pw.equals(dto.getPw())) {
					pstmt = conn.prepareStatement("delete from MovieComment where boardNum = ? and num=?");
					pstmt.setInt(1, dto.getBoardNum());
					pstmt.setInt(2, dto.getNum());
					result = pstmt.executeUpdate();
				}
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
	
	// 댓글에 대한 답글 작성
	public int insertReComment(MovieCommentDTO dto, int boardNum) {
		int result = 0;
		int re_step = dto.getRe_step();
		int re_level = dto.getRe_level();
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement
					("update MovieComment set re_step + 1 where re_step > ?");
			pstmt.setInt(1, re_level);
			pstmt.executeUpdate();
			
			re_step = re_step + 1;
			re_level = re_level +1;
			
			pstmt = conn.prepareStatement
					("insert into MovieComment values(?, MovieComment_seq.nextval,?,?,?, sysdate,?,?");
			pstmt.setInt(1, boardNum);
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getPw());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, re_step);
			pstmt.setInt(6, re_level);
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

