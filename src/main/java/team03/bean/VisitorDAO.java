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
			String sql = "insert into visitor values(visitor_seq.nextval,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getid());
			pstmt.setString(2, dto.getpw());
			pstmt.setString(3, dto.getcontent());
	
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
	
	public int getCount() {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from visitor");
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
	
	public int getMyCount(String id) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from visitor where id=?");
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
	
	public List<VisitorDTO> getAllList(int start, int end){
		List<VisitorDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
					+ "	(select num, id, pw, content, reg, rownum r from"
					+ " (select * from visitor order by num desc)) "
					+ " where r >= ? and r <= ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList();
			while(rs.next()) {
				VisitorDTO dto = new VisitorDTO();
				dto.setnum(rs.getInt("num"));
				dto.setid(rs.getString("id"));
				dto.setpw(rs.getString("pw"));
				dto.setcontent(rs.getString("content"));
				dto.setreg(rs.getTimestamp("reg"));
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
	
	public List<VisitorDTO> getMyList(String id, int start, int end){
		List<VisitorDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from " 
					+ "(select num,id,content,reg,rownum r from "
					+ "(select * from visitor where id=? order by num desc))"
					+ " where r >= ? and r <= ?");
			pstmt.setString(1, id);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList();
			while(rs.next()) {
				VisitorDTO dto = new VisitorDTO();
				dto.setnum(rs.getInt("num"));
				dto.setid(rs.getString("id"));
				dto.setcontent(rs.getString("string"));
				dto.setreg(rs.getTimestamp("reg"));
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
}	
	
	
	