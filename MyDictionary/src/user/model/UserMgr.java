package user.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import database.DBConnectionMgr;

public class UserMgr {
	
	private DBConnectionMgr pool;
	
	public UserMgr () {
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
	
//아이디 찾기
	public String sendId(String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "select id from member where mail = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}
//인증번호 받기
	public int sendKey(String userId, String userEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			con = pool.getConnection();
			sql = "select count(*) from member where id = ? and mail = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userEmail);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				return rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return 0;
	}
	
//인증번호 확인시 비밀번호 변경
	public void updatePwd (String password, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "update member set password=? where id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, password);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			con.commit();
			
		} catch (Exception e) {
			e.addSuppressed(e);
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
//회원 아이디 중복체크
	public int checkUserId(String userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = pool.getConnection();
			
			sql = "SELECT count(*) FROM MEMBER WHERE ID=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getInt(1);
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return 0;
	}
//회원  이메일 중복 체크
	public int checkUserEmail(String email) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = pool.getConnection();
			
			sql = "SELECT count(*) FROM MEMBER WHERE mail=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return 0;
	}
	
//닉네임 중복 체크
	public int checkUserName(String name) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = pool.getConnection();
			
			sql = "SELECT count(*) FROM MEMBER WHERE name=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			if(rs.next())
				return rs.getInt(1);
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return 0;
	}
	
	
//메뉴바 닉네임 표시
	public String getName(String userid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "SELECT name from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}
	
//회원 가입
	public void insertUser(UserBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "INSERT INTO member VALUES (?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUserID());
			pstmt.setString(2, bean.getUserPassword());
			pstmt.setString(3, bean.getUserName());
			pstmt.setString(4, bean.getUserEmail());
			pstmt.setString(5, bean.getregist_day());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		
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
//	public int getAllPaging(String search, int cnt) {
//		int total = 0;
//		int paging = 0;
//		
//		total = getAllCount(search); // 회원관리 전체 개수
//			
//			if(total%cnt==0) { // 나머지가 0일때
//				paging = total/cnt;
//				Math.floor(paging);// 소수점 버리기
//			} else { // 아닐때 페이지1개 추가
//				paging = total/cnt+1;
//				Math.floor(paging);// 소수점 버리기
//			}
//			
//				return paging;
//	}
	
	
//회원정보 전체보기 리스트
	public ArrayList<UserBean> getAllMember(int pageNum, String search, int start, int cnt){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql ="";
		start = (pageNum*cnt)-cnt;

		ArrayList<UserBean> list = new ArrayList<UserBean>();
		
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
				UserBean User = new UserBean();
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
