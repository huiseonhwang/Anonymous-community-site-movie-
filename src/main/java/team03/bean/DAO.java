package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import team03.bean.OracleDB;

public class DAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	

	private static DAO instance = new DAO();
	public static DAO getInstance() {
		return instance;
	}
	
	private DAO() {}
	
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
