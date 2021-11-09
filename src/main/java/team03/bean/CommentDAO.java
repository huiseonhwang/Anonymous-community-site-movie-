package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// dao의 객체를 dao 클래스에서 미리 생성한 후 메소드를 호출하는 형식으로 dao 클래스를 사용하는 코드
	private static CommentDAO instance = new CommentDAO();
	public static CommentDAO getInstance() {
		return instance;
	}
	private CommentDAO() {}
	
	// 댓글 작성
	public int insertComment(CommentDTO dto, int boardNum) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"insert into boardComment values(?, boardComment_seq.nextval, ?, ?, ?, sysdate, 0, 0)");
			pstmt.setInt(1, boardNum);
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getPw());
			pstmt.setString(4, dto.getContent());
			
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
	
	// 댓글 갯수 카운트
	public int countComment(int boardNum) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from boardComment where boardNum = ?");
			pstmt.setInt(1, boardNum);
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
	
	// 댓글 내용 출력
	public List<CommentDTO> getAllComment(int boardNum, int start, int end){
		List<CommentDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
						+ " (select boardNum, num, writer, pw, content, reg, re_step, re_level, rownum r from " 
						+ " (select * from boardComment where boardNum = ? order by num asc)) "
						+ " where r >= ? and r <= ?");
			pstmt.setInt(1, boardNum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList();
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
	
	// 이미 작성된 댓글 정보 출력
	public CommentDTO getContent(CommentDTO dto) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from boardComment where boardNum = ? and num = ?");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setBoardNum(rs.getInt("boardNum"));
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
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
	
	// 회원 댓글 수정
	public int updateMemComment(CommentDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update boardComment set content = ? where boardNum = ? and num = ?");
			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getBoardNum());
			pstmt.setInt(3, dto.getNum());
			
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
	
	// 익명 댓글 수정
	public int updateComment(CommentDTO dto) {
		String pw;
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select pw from boardComment where boardNum = ? and num = ?");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pw = rs.getString("pw");
				if(pw.equals(dto.getPw())) {
					pstmt = conn.prepareStatement(
							"update boardComment set pw = ?, content = ? where boardNum = ? and num = ?");
					pstmt.setString(1, dto.getPw());
					pstmt.setString(2, dto.getContent());
					pstmt.setInt(3, dto.getBoardNum());
					pstmt.setInt(4, dto.getNum());
					result = pstmt.executeUpdate();
				}
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
	
	// 회원 댓글 삭제
	public int deleteMemComment(CommentDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"delete from boardComment where boardNum = ? and num = ?");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
			
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
	
	// 익명 댓글 삭제
	public int deleteComment(CommentDTO dto) {
		String pw;
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select pw from boardComment where boardNum = ? and num = ?");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				pw = rs.getString("pw");
				if(pw.equals(dto.getPw())) {
					pstmt = conn.prepareStatement(
							"delete from boardComment where boardNum = ? and num = ?");
					pstmt.setInt(1, dto.getBoardNum());
					pstmt.setInt(2, dto.getNum());
					
					result = pstmt.executeUpdate();
				}
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
	
	// 댓글에 대한 답글 작성
	public int insertReComment(CommentDTO dto, int boardNum) {
		int result = 0;
		int re_step = dto.getRe_step();
		int re_level = dto.getRe_level();
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update boardComment set re_step = re_step + 1 where re_step > ?");
			pstmt.setInt(1, re_step);
			
			pstmt.executeUpdate();
			
			re_step = re_step + 1;
			re_level = re_level + 1;
			
			pstmt = conn.prepareStatement(
					"insert into boardComment values(?, boardComment_seq.nextval, ?, ?, ?, sysdate, ?, ?)");
			pstmt.setInt(1, boardNum);
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getPw());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, re_step);
			pstmt.setInt(6, re_level);
			
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
