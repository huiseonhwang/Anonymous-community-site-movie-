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
	
	// dao�� ��ü�� dao Ŭ�������� �̸� ������ �� �޼ҵ带 ȣ���ϴ� �������� dao Ŭ������ ����ϴ� �ڵ�
	public static MovieCommentDAO instance = new MovieCommentDAO();
	public static MovieCommentDAO getInstance( ) {
		return instance;
	}
	private MovieCommentDAO() {
	}
	
	// ��� �ۼ�
	public int insertComment(MovieCommentDTO dto, int boardNum) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement
				("insert into movieComment values(?, movieComment_seq.nextval, ?, ?, ?, sysdate, 0, 0)");
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
	
	// ��� ���� ī��Ʈ
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
	
	// ��� ���� ���
	public List<MovieCommentDTO> getAllComment(int boardNum, int start, int end) {
		List<MovieCommentDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
					+ " (select boardNum, num, writer, pw, content, reg, re_step, re_level, rownum r from " 
					+ " (select * from MovieComment where boardNum = ? order by num asc, reg asc)) "
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
	
	// �̹� �ۼ��� ��� ���� ���
	public MovieCommentDTO getContent(MovieCommentDTO dto, int re_step, int re_level) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from movieComment where boardNum = ? and num = ? and re_step = ? and re_level = ?");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
			pstmt.setInt(3, re_step);
			pstmt.setInt(4, re_level);
			
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
	
	// ȸ�� ��� ����
	public int updateMemComment(MovieCommentDTO dto, int re_step, int re_level) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("update MovieComment set content = ? where boardNum =? and num =? and re_step =? and re_level =?");
			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getBoardNum());
			pstmt.setInt(3, dto.getNum());
			pstmt.setInt(4, re_step);
			pstmt.setInt(5, re_level);
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
	
	// �͸� ��� ����
	public int updateComment(MovieCommentDTO dto, int re_step, int re_level) {
		String pw;
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement
					("select pw from MovieComment where boardNum =? and num =? and re_step =? and re_level =?");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
			pstmt.setInt(3, re_step);
			pstmt.setInt(4, re_level);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				pw = rs.getString("pw");
				if(pw.equals(dto.getPw())) {
					pstmt = conn.prepareStatement
							("update MovieComment set pw =?, content =? where boardNum =? and num =? and re_step =? and re_level =?");
					pstmt.setString(1, dto.getPw());
					pstmt.setString(2, dto.getContent());
					pstmt.setInt(3, dto.getBoardNum());
					pstmt.setInt(4, dto.getNum());
					pstmt.setInt(5, re_step);
					pstmt.setInt(6, re_level);
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
	
	// ȸ�� ��� ����
	public int deleteMemComment(MovieCommentDTO dto, int re_step, int re_level) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement
					("delete from MovieComment where boardNum = ? and num =? and re_step = ? and re_level =?");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
			pstmt.setInt(3, re_step);
			pstmt.setInt(4, re_level);
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
	
	// �͸� ��� ����
	public int deleteComment(MovieCommentDTO dto, int re_step, int re_level) {
		String pw;
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement
					("select pw from MovieComment where boardNum=? and num=? and re_step =? and re_level =?");
			pstmt.setInt(1, dto.getBoardNum());
			pstmt.setInt(2, dto.getNum());
			pstmt.setInt(3, re_step);
			pstmt.setInt(4, re_level);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pw = rs.getString("pw");
				if (pw.equals(dto.getPw())) {
					pstmt = conn.prepareStatement("delete from MovieComment where boardNum = ? and num=? and re_step =? and re_level =?");
					pstmt.setInt(1, dto.getBoardNum());
					pstmt.setInt(2, dto.getNum());
					pstmt.setInt(3, re_step);
					pstmt.setInt(4, re_level);
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
	
	// ��ۿ� ���� ��� �ۼ�
	public int insertReComment(MovieCommentDTO dto, int boardNum, int num) {
		int result = 0;
		int re_step = dto.getRe_step();
		int re_level = dto.getRe_level();
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update movieComment set re_step = re_step + 1 where re_step > ?");
			pstmt.setInt(1, re_step);
			
			pstmt.executeUpdate();
			
			re_step = re_step + 1;
			re_level = re_level + 1;
			
			pstmt = conn.prepareStatement(
					"insert into movieComment values(?, ?, ?, ?, ?, sysdate, ?, ?)");
			pstmt.setInt(1, boardNum);
			pstmt.setInt(2, num);
			pstmt.setString(3, dto.getWriter());
			pstmt.setString(4, dto.getPw());
			pstmt.setString(5, dto.getContent());
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			
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

