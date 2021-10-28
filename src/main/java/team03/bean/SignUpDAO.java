package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SignUpDAO {
	
		private Connection conn	= null; 
		private PreparedStatement pstmt = null;
		private ResultSet rs = null;
	
	public int memberInsert(SignUpDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("insert into member values (?,?,?,?,?)");
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getEmail1());
			pstmt.setString(5, dto.getEmail2());
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
	
	public boolean memberIdCheck(SignUpDTO dto) {
		boolean result = false;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from member where id =?");
			pstmt.setString(1, dto.getId());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = true;
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
}