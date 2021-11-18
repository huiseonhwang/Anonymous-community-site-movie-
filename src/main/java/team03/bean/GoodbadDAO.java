package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GoodbadDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// dao의 객체를 dao 클래스에서 미리 생성한 후 메소드를 호출하는 형식으로 dao 클래스를 사용하는 코드
	private static GoodbadDAO instance = new GoodbadDAO();
	public static GoodbadDAO getInstance() {
		return instance;
	}
	private GoodbadDAO() {}
	
	// 공감, 비공감 중복 체크
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
	
	// 공감, 비공감 테이블 내에 있는 정보 조회
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
