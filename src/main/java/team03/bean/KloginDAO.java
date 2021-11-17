package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class KloginDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// dao�� ��ü�� dao Ŭ�������� �̸� ������ �� �޼ҵ带 ȣ���ϴ� �������� dao Ŭ������ ����ϴ� �ڵ�
	private static KloginDAO instance = new KloginDAO();
	public static KloginDAO getInstance() {
		return instance;
	}
	private KloginDAO() {}
	
	public int insertKid(KloginDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"insert into kmember values(?, ?, ?)");
			pstmt.setString(1, dto.getKid());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getEmail());
			
			
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

	public KloginDTO kgetUserInfo(String id) {
		KloginDTO dto = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from kmember where kid=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new KloginDTO();
				dto.setKid(rs.getString("kid"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return dto;
	}
	

	public int KmemberDataUpdate(KloginDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("update kmember set name=?, email=? where kid=?");
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getKid());
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

	public int KmemberDataDelete(KloginDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("delete from kmember where kid=?");
			pstmt.setString(1, dto.getKid());
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


}
