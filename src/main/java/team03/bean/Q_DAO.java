package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import team03.bean.Q_DTO;

public class Q_DAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	//글 작성
	public void insertQuestion(Q_DTO dto) {
		int num = dto.getNum();
		int ref = dto.getRef();
		int re_step = dto.getRe_step();
		int re_level = dto.getRe_level();
		int number = 0;
		String sql = "";
		
		try {
			conn = OracleDB.getConnection(); 
			pstmt = conn.prepareStatement("select max(num) from question");
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) 
				number = rs.getInt(1)+1;	
			else
				number = 1; 
			if (num != 0) 
			{ 
				sql="update question set re_step = re_step + 1 where ref = ? and re_step > ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				
				pstmt.executeUpdate();
								
				re_step = re_step + 1;
				re_level = re_level + 1;
			}else{ 
				ref = number;
				re_step = 0;
				re_level = 0;
			}
			sql = "insert into question(num, id, pw, subject, content, reg, readcount, ref, re_step, re_level) "
					+ "values(question_seq.nextval, ?, ?, ?, ?, sysdate, 0, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException s) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException s) {}
			if (conn != null) try { conn.close(); } catch(SQLException s) {}
		}
	}

	//글 수정
	public int updateQuestion(Q_DTO dto) {
		String dbpw = "";
		String sql = "";
		int result = -1;
		
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select pw from question where num = ?");
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpw = rs.getString("pw");
				if(dbpw.equals(dto.getPw())) {
					pstmt = conn.prepareStatement("update question set pw = ?, content = ? where num = ?");
					pstmt.setString(1, dto.getPw());
					pstmt.setString(2, dto.getContent());
					pstmt.setInt(3, dto.getNum());
					
					pstmt.executeUpdate();
					
					result = 1;
				}else{
					result = 0;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException s) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException s) {}
			if (conn != null) try { conn.close(); } catch(SQLException s) {}
		}
		return result;
	}
	
	//글 삭제
	public int deleteQuestion(int num, String pw) {
		String dbpw = "";
		int result = -1;
		
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select pw from question where num = ?");
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpw=rs.getString("pw");
				if(dbpw.equals(pw)) {
					pstmt = conn.prepareStatement("delete from question where num = ?");
					pstmt.setInt(1, num);
					
					pstmt.executeUpdate();
					
					result = 1;
				}else
					result = 0;
				}			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException s) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException s) {}
			if (conn != null) try { conn.close(); } catch(SQLException s) {}
		}
		return result;
	}
	
	//글 페이지 출력
	public List<Q_DTO> getQuestionList(int start, int end) {
		List<Q_DTO> List = null;
		String sql = "";
		
		try {
			conn = OracleDB.getConnection();
			sql = "select num, id, pw, subject, reg, readcount, ref, re_step, re_level, r "
				+ "from (select num, id, pw, subject, reg, readcount, ref, re_step, re_level, rownum r " 
				+ "from (select num, id, pw, subject, reg, readcount, ref, re_step, re_level " 
				+ "from question order by ref desc, re_step asc) order by ref desc, re_step asc ) where r >= ? and r <= ? "; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				List = new ArrayList(); 
				do{ 
					Q_DTO dto = new Q_DTO();
					dto.setNum(rs.getInt("num"));
					dto.setId(rs.getString("id"));
					dto.setPw(rs.getString("pw"));
					dto.setSubject(rs.getString("subject"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setReadcount(rs.getInt("readcount"));
					dto.setRef(rs.getInt("ref"));
					dto.setRe_step(rs.getInt("re_step"));
					dto.setRe_level(rs.getInt("re_level"));
					
					List.add(dto); 
					
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException s) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException s) {}
			if (conn != null) try { conn.close(); } catch(SQLException s) {}
		}
		return List;
	}
	
	//글 내용 출력
	public Q_DTO getQuestionContent(int num) {
		Q_DTO dto = new Q_DTO();
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("update question set readcount = readcount + 1 where num = ?");
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement("select * from question where num = ?");
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally{
			if (rs != null) try { rs.close(); } catch(SQLException s) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException s) {}
			if (conn != null) try { conn.close(); } catch(SQLException s) {}
		}
		return dto;
	}

	//글 갯수
	public int getQuestionCount() {
		int result = 0;
		
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from question");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException s) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException s) {}
			if (conn != null) try { conn.close(); } catch(SQLException s) {}
		}
		return result;
	}
	
	//나의 글 페이지 출력
	public List<Q_DTO> getMyList(String id, int start, int end) {
		List<Q_DTO> list = null;
		
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
				  + " (select num, id, pw, subject, content, reg, readcount, rownum r from "
				  + " (select * from question where id = ? order by num desc)) "
				  + " where r >= ? and r <= ?");
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList();
			while(rs.next()) {
				Q_DTO dto = new Q_DTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException s) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException s) {}
			if (conn != null) try { conn.close(); } catch(SQLException s) {}
		}
		return list;
	}
	
	//나의 글 갯수
	public int getMyCount(String id) {
		int result = 0;
		
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from question where id = ?");
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException s) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException s) {}
			if (conn != null) try { conn.close(); } catch(SQLException s) {}
		}
		return result;
	}
	
	//글 검색
	public List<Q_DTO> getSearchList(String searchq, String search, int start, int end) {
		List<Q_DTO> list = null;
		
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from "
					  + " (select num, id, pw, subject, content, reg, readcount, ref, re_step, re_level, rownum r from "
					  + " (select * from question where "+searchq+" like '%"+search+"%' order by num desc)) "
					  + " where r >= ? and r <= ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			list = new ArrayList<Q_DTO>();
			while(rs.next()) {
				Q_DTO dto = new Q_DTO();
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setRef(rs.getInt("ref"));
				dto.setRe_step(rs.getInt("re_step"));
				dto.setRe_level(rs.getInt("re_level"));
				
				list.add(dto);
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException s) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException s) {}
			if (conn != null) try { conn.close(); } catch(SQLException s) {}
		}
		return list;
	}
		
	//검색한 글 갯수
	public int getSearchCount(String searchq, String search) {
		int result = 0;
		
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from question where "+searchq+" like '%"+search+"%'");
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException s) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException s) {}
			if (conn != null) try { conn.close(); } catch(SQLException s) {}
		}
		return result;
	}
}	
