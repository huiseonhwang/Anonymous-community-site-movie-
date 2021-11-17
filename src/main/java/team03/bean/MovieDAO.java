package team03.bean;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	private static MovieDAO instance = new MovieDAO();
	public static MovieDAO getInstance() {
		return instance;
	}
	private MovieDAO() {}
	
	// 페이지 정렬, 처리
	public List<MovieDTO> getAllList(int start, int end) throws Exception {
		List<MovieDTO> list = new  ArrayList<MovieDTO>();
		// <> 제네릭, 타입지정 (타입통일)
		// MovieDTO안에 들어간 정보들만 받는다.
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from "
					+ " (select num,writer,kategorie,subject,pw,content,filename,reg,readcount, good, bad, rownum r from " 
					+ " (select * from movieBoard order by num desc))"
					+ " where r >= ? and r <= ?");
			// sql문 작성
			// rownnum 게시글 순서
			// num 은 남는다, 왜? => 열번호이기 때문에 
			// 열의 처음부터 끝까지 다 검색한다.
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MovieDTO dto = new MovieDTO();
				dto.setNum(rs.getInt("Num"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setKategorie(rs.getString("kategorie"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return list;
	}
	
	// 게시글 갯수 (DB값이 있는지 없는지 확인 메서드)
	public int getCount() {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count (*) from movieboard");
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
				// count 1 = result 1
				// count 2 = result 2
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
	
	// 회원 글 작성
	public int insertContentMemver(MovieDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("insert into movieboard values"
					+ "(movieboard_seq.nextval,?,?,?,?,?,?,sysdate,0,0,0);");
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getKategorie());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getFilename());
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
	
	// 본인의 게시글 갯수
	public int getMyCount(String writer) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select count(*) from movieBoard where writer = ?");
			pstmt.setString(1, writer);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		} return result;
	}
	
	// 본인의 게시글 페이지 정렬, 출력
	public List<MovieDTO> getMyList(String writer, int start, int end){
		List<MovieDTO> list = null;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select * from " 
					+ " (select num, writer, kategorie, subject, pw, content, filename, reg, readcount, good, bad, rownum r from " 
					+ " (select * from movieBoard where writer = ? order by num desc)) "
					+ " where r >=? and r <=?");
			pstmt.setString(1, writer);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList();
			while(rs.next()) {
				MovieDTO dto = new MovieDTO();
				dto.setNum(rs.getInt("num"));
				dto.setKategorie(rs.getString("kategorie"));
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
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}
	
	// 게시글 조회수 증가
	public void readCountUp(MovieDTO dto) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("update movieBoard set readcount = readcount+1 where num = ?");
			pstmt.setInt(1, dto.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
	}
	
	// 게시글 페이지 (내용 출력)
	public MovieDTO getContent(MovieDTO dto) {
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from movieBoard where num = ?");
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setPw(rs.getString("pw"));
				dto.setKategorie(rs.getString("kategorie"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setFilename(rs.getString("filename"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadcount(rs.getInt("readcount"));
				dto.setGood(rs.getInt("good"));
				dto.setBad(rs.getInt("bad"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return dto;
	}
	
	//  회원 게시글 수정
	public int updateMemContent(MovieDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("update MovieBoard set kategorie =?, subject = ?, content = ?, filename = ? where num = ?");
			pstmt.setString(1, dto.getKategorie());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getFilename());
			pstmt.setInt(5, dto.getNum());
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	} 
	
	// 회원 게시글 삭제
	public int deleteMemContent(MovieDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("delete from movieBoard where num =?");
			pstmt.setInt(1, dto.getNum());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	} 
	
	// 익명 글 작성
	public int insertContent(MovieDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("insert into movieBoard values(" 
					+ " movieBoard_seq.nextval, ?, ?, ?, ?, ?, ?, sysdate, 0, 0, 0)");
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getSubject());
			pstmt.setString(4, dto.getKategorie());
			pstmt.setString(5, dto.getContent());
			pstmt.setString(6, dto.getFilename());
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
	
	// 익명 게시글 수정
	
	public int updateContent(MovieDTO dto) {
		int result = -1;
		String dbpasswd="";
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select pw from movieBoard where num = ?");
			pstmt.setInt(1, dto.getNum());
			rs = pstmt.executeQuery();
			if(rs.next()){
				dbpasswd= rs.getString("pw"); 
				if(dbpasswd.equals(dto.getPw())){
					pstmt = conn.prepareStatement(
							"update movieBoard set subject = ?, pw = ?, content = ?, filename = ? where num = ?");
					pstmt.setString(1, dto.getSubject());
					pstmt.setString(2, dto.getPw());
					pstmt.setString(3, dto.getContent());
					pstmt.setString(4, dto.getFilename());
					pstmt.setInt(5, dto.getNum());
					pstmt.executeUpdate();
					result = 1;
				}else{
					result = 0;
				}
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
	
	// 익명 게시글 삭제
	
	public int deleteContent(int num, String pw) {
		String DBpw;
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"select pw from movieBoard where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				DBpw = rs.getString("pw"); 
				if(DBpw.equals(pw)){
					pstmt = conn.prepareStatement(
							"delete from movieBoard where num = ?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					result = 1;
				}else{
					result = 0;
				}
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if (conn != null) try { conn.close(); } catch(SQLException ex) {}
		}
		return result;
	}
	
	// 게시글 비공강 증감
	public int badCountUp(MovieDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update movieBoard set bad = bad + 1 where num = ?");
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
	
	// 게시글 공감 증가
	public int goodCountUp(MovieDTO dto) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement(
					"update movieBoard set good = good + 1 where num = ?");
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
	
	// 검색한 게시글 갯수
	public int getSearchCount(String colum, String search) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement
					("select count (*) from MovieBoard where "+colum+" like '%"+search+"%'");
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
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
	
	// 게시글 검색
	public List<MovieDTO> getSearchList (String colum, String search, int start, int end) {
		List<MovieDTO> list = null; // 객체가 없으면 값은 안들어감
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from "
					+ " (select num,writer, kategorie, subject,pw,content,filename,reg,readcount, good, bad, rownum r from " 
					+ " (select * from movieBoard where "+colum+" like '%"+search+"%' order by num desc)) "
					+ " where r >=? and r <=?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			list = new ArrayList<MovieDTO>();
			while (rs.next()) {
				MovieDTO dto = new MovieDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setKategorie(rs.getString("kategorie"));
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}
	
	// 카테고리 게시글 개수
	public int getKategorieSearchCount(String colum) {
		int result = 0;
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement
					("select count (*) from MovieBoard where kategorie = ?");
			pstmt.setString(1, colum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
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
	
	// 카테고리 게시글 검색
	public List<MovieDTO> getKategorieSearchList (String colum, int start, int end) {
		List<MovieDTO> list = null; // 객체가 없으면 값은 안들어감
		try {
			conn = OracleDB.getConnection();
			pstmt = conn.prepareStatement("select * from "
					+ " (select num,writer,kategorie, subject,pw,content,filename,reg,readcount, good, bad, rownum r from " 
					+ " (select * from movieBoard where kategorie = ? order by num desc)) "
					+ " where r >=? and r <=?");
	
			pstmt.setString(1, colum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			list = new ArrayList<MovieDTO>();
			while (rs.next()) {
				MovieDTO dto = new MovieDTO();
				dto.setNum(rs.getInt("num"));
				dto.setWriter(rs.getString("writer"));
				dto.setKategorie(rs.getString("kategorie"));
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
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) {try {rs.close();}catch(SQLException s) {}}
			if(pstmt != null) {try {pstmt.close();}catch(SQLException s) {}}
			if(conn != null) {try {conn.close();}catch(SQLException s) {}}
		}
		return list;
	}
}