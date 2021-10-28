package team03.bean;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;


import team03.bean.OracleDB;

public class MemberDAO {
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs = null;
	
	public MemberDTO getUserInfo(String id) {
		MemberDTO dto = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from member where id=?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setEmail1(rs.getString("email1"));
				dto.setEmail2(rs.getString("email2"));
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
	public int MemberDataUpdate(MemberDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("update member set name=?, email1=?, email2=? where id=?");
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail1());
			pstmt.setString(3, dto.getEmail2());
			pstmt.setString(4, dto.getId());
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
	public int PwDataUpdate(MemberDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("update member set pw=?, where id=?");
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getId());
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
	public int MemberDataDelete(MemberDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("delete from member where id=? and pw=?");
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
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







