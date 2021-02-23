package user;

import java.sql.*;
import java.util.ArrayList;

public class UserDAO {
	
	private DBConnectionMgr pool;
	
	public UserDAO () {
		pool = DBConnectionMgr.getInstance();
	}
	

//로그인 확인 메소드
	public int login(String userID, String userPassword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "SELECT password from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setNString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) { //결과인 유저패스워드와 비교 (열이 하나뿐임)
					return 1; //로그인 성공
				} 
				else {
					return 0; //비밀번호 불일치
				}
			}
			return -1; //아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return -2; //DB 오류
	}
	
//회원관리 전체 개수
	public int getAllCount(String search) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = pool.getConnection();
			stmt = con.createStatement();
			
			if(search != null)
				sql = "select count(*) from member where concat(id,password,name,mail,regist_day) like '%"+search+"%' order by regist_day desc";
			else
				sql = "select count(*) from member";
			
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, stmt, rs);
		}
		return -1;
	}
	
// 회원관리 페이징 개수
	public int getAllPaging(String search, int cnt) {
		int total = 0;
		int paging = 0;
		
		total = getAllCount(search); // 회원관리 전체 개수
			
			if(total%cnt==0) { // 나머지가 0일때
				paging = total/cnt;
				Math.floor(paging);// 소수점 버리기
			} else { // 아닐때 페이지1개 추가
				paging = total/cnt+1;
				Math.floor(paging);// 소수점 버리기
			}
			
				return paging;
	}
	
	
//회원정보 전체보기 리스트
	public ArrayList<User> getAllMember(int pageNum, String search, int start, int cnt){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		start = (pageNum*cnt)-cnt;

		ArrayList<User> list = new ArrayList<User>();
		
		try {
			con = pool.getConnection();
			if(search != null)
				sql = "SELECT * FROM member where concat(id,password,name,mail,regist_day) like '%"+search+"%' order by regist_day desc limit ?,?";
			else 
				sql = "SELECT * FROM member order by regist_day desc limit ?,?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, cnt);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User User = new User();
				User.setUserID(rs.getString(1));
				User.setUserPassword(rs.getString(2));
				User.setUserName(rs.getString(3));
				User.setUserEmail(rs.getString(4));
				User.setregist_day(rs.getString(5));
				
				list.add(User);

			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}
	
//유저 수정
	public void UserUpdate (String password, String name, String mail, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "update member set password=? , name=? , mail=? where id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setString(2, name);
			pstmt.setString(3, mail);
			pstmt.setString(4, id);
			pstmt.executeUpdate();
			con.commit();
			
		} catch (Exception e) {
			e.addSuppressed(e);
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
//유저 추방
	public void Userdelete (String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = pool.getConnection();
			sql = "delete from member where id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.addSuppressed(e);
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
	}

}
