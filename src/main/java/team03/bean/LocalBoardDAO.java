package team03.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LocalBoardDAO {
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	

	private static LocalBoardDAO instance = new LocalBoardDAO();
	public static LocalBoardDAO getInstance() {
		return instance;
	}
	
	private LocalBoardDAO() {}

	
	//게시물 갯수
	public int LgetCount() {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from localboard");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	//게시물 정렬, 출력
	public List<LocalBoardDTO> LgetAllList(int start, int end){
		List<LocalBoardDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
					+ " (select num,local,writer,subject,content,filename,reg,readcount, good, bad, rownum r from " 
					+ " (select * from localboard order by num desc)) "
					+ " where r >= ? and r <= ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList();
			while(rs.next()) {
				LocalBoardDTO dto = new LocalBoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setLocal(rs.getString("local"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setWriter(rs.getString("writer"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}
	//내가 쓴글 갯수
	public int LgetMyCount(String writer) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from localboard where writer = ?");
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return result;
	}
	//내 게시물 정렬,출력
	public List<LocalBoardDTO> LgetMyList(String writer, int start, int end){
		List<LocalBoardDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from " 
					+ " (select num,local, writer, subject, content, filename, reg, readcount, good, bad, rownum r from " 
					+ " (select * from localboard where writer = ? order by num desc)) "
					+ " where r >=? and r <=?");
			pstmt.setString(1, writer);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList();
			while(rs.next()) {
				LocalBoardDTO dto = new LocalBoardDTO();
				dto.setNum(rs.getInt("num"));
				dto.setLocal(rs.getString("local"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}
	//글쓰기
	public int LinsertContentMem(LocalBoardDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"insert into localBoard values("
					+ "localBoard_seq.nextval,?, ?, ?, ?, ?, sysdate, 0, 0, 0)");
			pstmt.setString(1, dto.getLocal());
			pstmt.setString(2, dto.getWriter());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getFilename());
			
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
	//조회수 증가
	public void LreadcountUp(LocalBoardDTO dto) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update localBoard set readcount = readcount+1 where num = ?");
			pstmt.setInt(1, dto.getNum());
			
			pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
	}
	//게시글 페이지 
	public LocalBoardDTO LgetContent(LocalBoardDTO dto) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from localBoard where num = ? ");
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setLocal(rs.getString("local"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
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
	//게시물 수정
	public int LupdateContent(LocalBoardDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("update localboard set subject=?, content=?, filename =? where num=?");
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getFilename());
			pstmt.setInt(4, dto.getNum());
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
	//게시물 삭제
	public int LdeleteMemContent(LocalBoardDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"delete from localBoard where num = ?");
			pstmt.setInt(1, dto.getNum());
			
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
	//좋이요 증가
	public int LgoodCountUp(LocalBoardDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update localBoard set good = good + 1 where num = ?");
			pstmt.setInt(1, dto.getNum());
			
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
	//싫어요 증가
	public int LbadCountUp(LocalBoardDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update localBoard set bad = bad + 1 where num = ?");
			pstmt.setInt(1, dto.getNum());
			
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
	
	// 개시글 검색
		public List<LocalBoardDTO> LgetSearchList (String colum, String search, int start, int end){
			List<LocalBoardDTO> list = null;//객체 없으면 값 안들어감
			try {
				conn=OracleDB.getConnection();
				pstmt=conn.prepareStatement("select * from "
						+ " (select num,local,writer,subject,content,filename,reg,readcount, good, bad, rownum r from " 
						+ " (select * from localBoard where "+colum+" like '%"+search+"%' order by num desc)) "
						+ " where r >=? and r <=?");
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs=pstmt.executeQuery();
				list = new ArrayList<LocalBoardDTO>();
				while(rs.next()) {
					LocalBoardDTO dto = new LocalBoardDTO();
					dto.setNum(rs.getInt("num"));
					dto.setLocal(rs.getString("local"));
					dto.setWriter(rs.getString("writer"));
					dto.setContent(rs.getString("content"));
					dto.setSubject(rs.getString("subject"));
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
		
		// 검색한 개시글 갯수
		public int LgetSearchCount(String colum, String search) {
			int result = 0;
			try {
				conn=OracleDB.getConnection();
				pstmt = conn.prepareStatement(
						"select count(*) from localBoard where "+colum+" like '%"+search+"%'");
				
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
		//검색한 지역별 게시물 갯수
		public int LLgetSearchCount(String local) {
			int result = 0;
			try {
				conn=OracleDB.getConnection();
				pstmt = conn.prepareStatement(
						"select count(*) from localBoard where"+local);
				
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
		
		 //개시글 검색
			public List<LocalBoardDTO> LLgetSearchList (String local, int start, int end){
				List<LocalBoardDTO> list = null;//객체 없으면 값 안들어감
				try {
					conn=OracleDB.getConnection();
					pstmt=conn.prepareStatement("select * from "
							+ " (select num,local,writer,subject,content,filename,reg,readcount, good, bad, rownum r from " 
							+ " (select * from localBoard where local = ? order by num desc)) "
							+ " where r >=? and r <=?");
					pstmt.setString(1, local);
					pstmt.setInt(2, start);
					pstmt.setInt(3, end);
					rs=pstmt.executeQuery();
					list = new ArrayList<LocalBoardDTO>();
					while(rs.next()) {
						LocalBoardDTO dto = new LocalBoardDTO();
						dto.setNum(rs.getInt("num"));
						dto.setLocal(rs.getString("local"));
						dto.setWriter(rs.getString("writer"));
						dto.setContent(rs.getString("content"));
						dto.setSubject(rs.getString("subject"));
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
			
	}

	

