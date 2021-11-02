package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	

	private static LoginDAO instance = new LoginDAO();
	public static LoginDAO getInstance() {
		return instance;
	}
	
	private LoginDAO() {}
	
	public boolean logincheck(LoginDTO dto) {
		boolean result = false;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from member where id=? and pw=?");
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try{rs.close();}catch(SQLException s) {}}
			if(pstmt !=null) {try {rs.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
			}
		return result;
		
	}
}
