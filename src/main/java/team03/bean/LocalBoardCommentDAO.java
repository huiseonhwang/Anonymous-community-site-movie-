package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LocalBoardCommentDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	private static LocalBoardCommentDAO instance = new LocalBoardCommentDAO();
	public static LocalBoardCommentDAO getInstance() {
		return instance;
	}
	private LocalBoardCommentDAO() {}
	
	// ����ۼ�
	public int LinsertComment(LocalBoardCommentDTO dto, int boardNum) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"insert into localboardComment values(?, localboardcomment_seq.nextval, ?, ?, sysdate, 0, 0)");
			pstmt.setInt(1, boardNum);
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getContent());
			
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
	// ��ۼ���
	public int LcountComment(int boardNum) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from localboardComment where boardNum = ?");
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
	
	// ��� ���� ���
		public List<LocalBoardCommentDTO> LgetAllComment(int boardNum, int start, int end){
			List<LocalBoardCommentDTO> list = null;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement(
						"select * from "
							+ " (select boardNum, num, writer, content, reg, re_step, re_level, rownum r from " 
							+ " (select * from localboardComment where boardNum = ? order by num asc, reg asc)) "
							+ " where r >= ? and r <= ?");
				pstmt.setInt(1, boardNum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				
				rs = pstmt.executeQuery();
				list = new ArrayList();
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
				if(rs != null) {try {rs.close();}catch(SQLException s) {}}
				if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
				if(conn != null) {try {conn.close();}catch(SQLException s) {}}
			}
			return list;
		}

		// �̹� �ۼ��� ��� ���� ���
		public LocalBoardCommentDTO LgetContent(LocalBoardCommentDTO dto, int re_step, int re_level) {
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement(
						"select * from localboardComment where boardNum = ? and num = ? and re_step = ? and re_level = ?");
				pstmt.setInt(1, dto.getBoardNum());
				pstmt.setInt(2, dto.getNum());
				pstmt.setInt(3, re_step);
				pstmt.setInt(4, re_level);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dto.setBoardNum(rs.getInt("boardNum"));
					dto.setNum(rs.getInt("num"));
					dto.setWriter(rs.getString("writer"));
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
		
		// ȸ�� ��� ����
		public int LupdateMemComment(LocalBoardCommentDTO dto, int re_step, int re_level) {
			int result = 0;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement(
						"update localboardComment set content = ? where boardNum = ? and num = ? and re_step = ? and re_level = ?");
				pstmt.setString(1, dto.getContent());
				pstmt.setInt(2, dto.getBoardNum());
				pstmt.setInt(3, dto.getNum());
				pstmt.setInt(4, re_step);
				pstmt.setInt(5, re_level);
				
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
		
		// ȸ�� ��� ����
		public int LdeleteMemComment(LocalBoardCommentDTO dto, int re_step, int re_level) {
			int result = 0;
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement(
						"delete from localboardComment where boardNum = ? and num = ? and re_step = ? and re_level = ?");
				pstmt.setInt(1, dto.getBoardNum());
				pstmt.setInt(2, dto.getNum());
				pstmt.setInt(3, re_step);
				pstmt.setInt(4, re_level);
				
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
		
		// ��ۿ� ���� ��� �ۼ�
		public int LinsertReComment(LocalBoardCommentDTO dto, int boardNum, int num) {
			int result = 0;
			int re_step = dto.getRe_step();
			int re_level = dto.getRe_level();
			try {
				conn = OracleDB.getConnection();
				pstmt = conn.prepareStatement(
						"update localboardComment set re_step = re_step + 1 where re_step > ?");
				pstmt.setInt(1, re_step);
				
				pstmt.executeUpdate();
				
				re_step = re_step + 1;
				re_level = re_level + 1;
				
				pstmt = conn.prepareStatement(
						"insert into localboardComment values(?, ?, ?, ?, sysdate, ?, ?)");
				pstmt.setInt(1, boardNum);
				pstmt.setInt(2, num);
				pstmt.setString(3, dto.getWriter());
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
