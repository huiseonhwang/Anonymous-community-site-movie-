package team03.bean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import team03.bean.OracleDB;


public class AllSbjDAO {
	
	
	private static AllSbjDAO instance = new AllSbjDAO();
	public static AllSbjDAO getInstance(){
		return instance;
	}
	private AllSbjDAO(){}
	
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	

	public int insertContent(AllSbjDTO dto) {
		int result = 0;
		try {
			conn=OracleDB.getConnection();
			String sql = "insert into teamBoard(num,writer,pw,subject,content,filename,";
			sql+="reg,readcount,good,bad) values(teamBoard_seq.NEXTVAL,?,?,?,?,?,sysdate,0,0,0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getFilename());
			result = pstmt.executeUpdate(); //여기서 result 대입 안하면 인지부조화 
		}catch (Exception e) {
			e.printStackTrace();
		}finally { 
		if(rs!=null)try{rs.close();}catch (SQLException e){}
		if(pstmt!=null)try{pstmt.close();}catch (SQLException e){}
		if(conn!=null)try{conn.close();}catch (SQLException e){}
		}
		return result;
	}

	public int getCount(){
		int result = 0;
		try {
			conn=OracleDB.getConnection();
			pstmt=conn.prepareStatement("select count(*) from teamBoard");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {} //연결과 쿼리문을 끊고
		
		}return result;
		
	}
	
	public List<AllSbjDTO> getAllList(int start, int end){
		List<AllSbjDTO> list = null;
		try {
			conn=OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
					+ " (select num,writer,subject,pw,content,filename,reg,readcount, good, bad, rownum r from " 
					+ " (select * from teamBoard order by num desc)) "
					+ " where r >= ? and r <= ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList();
				do {
				AllSbjDTO dto = new AllSbjDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
				list.add(dto);
				}while(rs.next());
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {} //연결과 쿼리문을 끊고
		
		}
		return list;
	}
	
	public List<AllSbjDTO> getMyList(String writer, int start, int end){
		List<AllSbjDTO>list = null;
		try {
			conn=OracleDB.getConnection();
			pstmt=conn.prepareStatement("select * from"
					+  " (select num, writer, subject, pw, content, filename, reg, readcount, good, bad, rownum r from " 
					+ " (select * from teamBoard where writer = ? order by num desc)) "
					+ " where r >=? and r <=?");
			pstmt.setString(1, writer);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs=pstmt.executeQuery();
			
			list= new ArrayList();
			while(rs.next()) {
				AllSbjDTO dto = new AllSbjDTO();
				dto.setNum(rs.getInt("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
				list.add(dto);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
		
		
	}
	
	public int getMtCount(String writer) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt=conn.prepareStatement("select count(*) from teamBoard where writer = ?");
			pstmt.setString(1, writer);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result=rs.getInt(1);
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
	
	public List<AllSbjDTO> getSearchList (String colum, String search, int start, int end){
		List<AllSbjDTO> list = null;//객체 없으면 값 안들어감
		try {
			conn=OracleDB.getConnection();
			pstmt=conn.prepareStatement("select * from "
					+ " (select num,writer,subject,pw,content,filename,reg,readcount, good, bad, rownum r from " 
					+ " (select * from teamBoard where "+colum+" like '%"+search+"%' order by num desc)) "
					+ " where r >=? and r <=?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs=pstmt.executeQuery();
			list = new ArrayList<AllSbjDTO>();
			while(rs.next()) {
				AllSbjDTO dto = new AllSbjDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setContent(rs.getString("content"));
				dto.setSubject(rs.getString("subject"));
				dto.setPw(rs.getString("pw"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
				list.add(dto);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}

			}
		return list;
		}

	public int getSearchCount(String colum, String search) {
		int result = 0;
		try {
			conn=OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from teamBoard where "+colum+" like '%"+search+"%'");
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	
}
