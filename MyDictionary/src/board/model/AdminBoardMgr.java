package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import database.DBConnectionMgr;

	//보드 DTO를 사용하는 메소드들을 정의(DB연결 등 처리)
public class AdminBoardMgr {
	private DBConnectionMgr pool;
	
	
	public AdminBoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	
//공지사항 리스트 출력
	public ArrayList<BoardBean> getNoticeList() {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql;
		
		ArrayList<BoardBean> list = new ArrayList<BoardBean>();

		try {
			con = pool.getConnection();
			stmt = con.createStatement();
			sql = "select * from adminboard ORDER BY num DESC";
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				BoardBean board = new BoardBean();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
				list.add(board); // 리스트에 추가
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getBoardList() 에러 : " + ex);
		} finally {
			pool.freeConnection(con, stmt, rs);
		}
		return null;
	}
	
	
//선택된 글의 조회수 증가하기
	public void adminupdateHit(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = pool.getConnection();

			sql = "select hit from adminboard where num = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			int hit = 0;

			if (rs.next())
				hit = rs.getInt("hit") + 1;

			sql = "update adminboard set hit=? where num=?";
			pstmt = con.prepareStatement(sql);		
			pstmt.setInt(1, hit);
			pstmt.setInt(2, num);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("updateHit() 에러 : " + ex);
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
	}
	
//선택된 글 상세 내용 가져오기
	public BoardBean admingetBoardByNum(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		BoardBean board = null;

		adminupdateHit(num);

		try {
			con = pool.getConnection();
			sql = "select * from adminboard where num = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				board = new BoardBean();
				board.setNum(rs.getInt("num"));
				board.setId(rs.getString("id"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setRegist_day(rs.getString("regist_day"));
				board.setHit(rs.getInt("hit"));
				board.setIp(rs.getString("ip"));
			}
			
			return board;
		} catch (Exception ex) {
			System.out.println("getBoardByNum() 에러 : " + ex);
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}
	
//공지사항 등록
	public void insertNotice(BoardBean board)  {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "insert into adminboard values(?, ?, ?, ?, ?, ?, ?, ?)";
		
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board.getNum());
			pstmt.setString(2, board.getId());
			pstmt.setString(3, board.getName());
			pstmt.setString(4, board.getSubject());
			pstmt.setString(5, board.getContent());
			pstmt.setString(6, board.getRegist_day());
			pstmt.setInt(7, board.getHit());
			pstmt.setString(8, board.getIp());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("insertBoard() 에러 : " + ex);
		} finally {
			pool.freeConnection(con, pstmt);
		}		
	}
	
//선택된 글 내용 수정하기
	public void adminupdateBoard(BoardBean board) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "update adminboard set name=?, subject=?, content=? where num=?";

			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, board.getName());
			pstmt.setString(2, board.getSubject());
			pstmt.setString(3, board.getContent());
			pstmt.setInt(4, board.getNum());
			pstmt.executeUpdate();			

		} catch (Exception ex) {
			System.out.println("updateBoard() 에러 : " + ex);
		} finally {
			pool.freeConnection(con, pstmt);
		}
	} 
//선택된 글 삭제하기
	public void admindeleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = pool.getConnection();
			sql = "delete from adminboard where num=?";	
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("deleteBoard() 에러 : " + ex);
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
// 현재 회원 수
	public int MemberCount() {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "";
		int num = 0; 
		try {
			con = pool.getConnection();
			stmt = con.createStatement();
			sql = "select count(*) from member";	
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				num = rs.getInt(1);
			}
			

		} catch (Exception ex) {
			System.out.println("deleteBoard() 에러 : " + ex);
		} finally {
			pool.freeConnection(con, stmt, rs);
		}
		return num;
	}

}
