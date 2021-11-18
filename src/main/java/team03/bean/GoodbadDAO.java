package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GoodbadDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// dao�� ��ü�� dao Ŭ�������� �̸� ������ �� �޼ҵ带 ȣ���ϴ� �������� dao Ŭ������ ����ϴ� �ڵ�
	private static GoodbadDAO instance = new GoodbadDAO();
	public static GoodbadDAO getInstance() {
		return instance;
	}
	private GoodbadDAO() {}
	
	// ����, ����� �ߺ� üũ
	public int check(int num, String ip, String writer) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"insert into goodbad values(?, ?, ?)");
			pstmt.setInt(1, num);
			pstmt.setString(2, ip);
			pstmt.setString(3, writer);
			
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
	
	// ����, ����� ���̺� ���� �ִ� ���� ��ȸ
	public GoodbadDTO getUserInfo(int num) {
		GoodbadDTO dto = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from goodbad where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				dto = new GoodbadDTO();
				dto.setIp(rs.getString("ip"));
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
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
}
