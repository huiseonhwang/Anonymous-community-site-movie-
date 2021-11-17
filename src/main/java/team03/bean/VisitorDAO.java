package team03.bean;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VisitorDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	public int visitorInsert(VisitorDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			String sql = "insert into visitor values(?, visitor_seq.nextval, ?, ?, ?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getOwner());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getPw());
			pstmt.setString(4, dto.getContent());
	
			result = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	} 
	
	public int getCount(String owner) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from visitor where owner = ?");
			pstmt.setString(1, owner);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	public List<VisitorDTO> getAllList(String owner, int start, int end){
		List<VisitorDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
					+ "	(select owner, num, id, pw, content, reg, rownum r from"
					+ " (select * from visitor where owner = ? order by num desc)) "
					+ " where r >= ? and r <= ?");
			pstmt.setString(1, owner);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
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
	
	public int getMyCount(String id) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from visitor where owner=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
	public List<VisitorDTO> getMyList(String id, int start, int end){
		List<VisitorDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from " 
					+ "(select owner, num, id, content, reg, rownum r from "
					+ "(select * from visitor where vid=? order by num desc))"
					+ " where r >= ? and r <= ?");
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList();
			while(rs.next()) {
				VisitorDTO dto = new VisitorDTO();
				dto.setOwner(rs.getString("owner"));
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setContent(rs.getString("string"));
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
	
	public int VisitorDelete(String owner, String pw, int num) throws Exception {
		String dbpw="";
		int result = -1;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
				"select pw from visitor where owner = ? and num = ?");
			pstmt.setString(1, owner);
			pstmt.setInt(2, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pw");
				if(dbpw.equals(pw)) {
				pstmt = conn.prepareStatement(
					"delete from visitor where owner = ? and num = ?");
				pstmt.setString(1, owner);
				pstmt.setInt(2, num);
				pstmt.executeUpdate();
				result = 1;
			}else
				result = 0;
			}	
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
	
	public VisitorDTO getContent(VisitorDTO dto) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from visitor where owner = ? and num = ?");
			pstmt.setString(1, dto.getOwner());
			pstmt.setInt(2, dto.getNum());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setOwner(rs.getString("owner"));
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
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
	
	public int updateContent(VisitorDTO dto) {
		String dbpw="";
		int result=-1;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select pw from visitor where owner=? and num = ?");
			pstmt.setString(1, dto.getOwner());
			pstmt.setInt(2, dto.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpw = rs.getString("pw");
				if(dbpw.equals(dto.getPw())) {
					pstmt = conn.prepareStatement("update visitor set pw=?,content=? where owner=? and num = ?");
					pstmt.setString(1, dto.getPw());
					pstmt.setString(2, dto.getContent());
					pstmt.setString(3, dto.getOwner());
					pstmt.setInt(4, dto.getNum());
					pstmt.executeUpdate();
					result=1;
				}else{
					result=0;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
}	
		