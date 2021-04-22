package board.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import database.DBConnectionMgr;
	//보드 DTO를 사용하는 메소드들을 정의(DB연결 등 처리)
public class BoardMgr {

	
	private DBConnectionMgr pool;
	
	
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
//board 테이블의 레코드 개수
	public int getListCount(String items, String text) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql;
		int x = 0;

		
		try {
			con = pool.getConnection();
			stmt = con.createStatement();
			if (items == null && text == null)
				sql = "select  count(*) from board";
			else
				sql = "SELECT   count(*) FROM board where " + items + " like '%" + text + "%'";
			
			rs = stmt.executeQuery(sql);

			if (rs.next()) 
				x = rs.getInt(1);
			
		} catch (Exception ex) {
			System.out.println("getListCount() 에러: " + ex);
		} finally {			
			pool.freeConnection(con, stmt, rs);
		}		
		return x;
	}
	//board 테이블의 리스트 출력
	public ArrayList<BoardBean> getBoardList(int page,  String items, String text,int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		start = (page * cnt)-cnt; // 리스트 출력할 시작 위치

		ArrayList<BoardBean> list = new ArrayList<BoardBean>();


		try {
			con = pool.getConnection();
			if (items == null && text == null) // 그냥 게시판을 클릭했을때 전체 게시글이 검색됨
				sql = "select * from board ORDER BY num DESC limit ?,?";
			else // 검색대상과, 검색어가 있을경우 결과
				sql = "SELECT  * FROM board where " + items + " like '%" + text + "%' ORDER BY num DESC limit ?,?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, cnt);
			rs = pstmt.executeQuery();

			while (rs.next()) { // 반복문 인덱스 번호에 맞는 레코드(행)을 가져온다.
				BoardBean board = new BoardBean(); //빈 보드 객체 생성
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
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}
	//member 테이블에서 인증된 id의 사용자명 가져오기
	public String getLoginNameById(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		String name= "";

		try {
			con = pool.getConnection();
			sql = "select * from member where id = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) 
				name = rs.getString("name");	
			
			return name;
		} catch (Exception ex) {
			System.out.println("getBoardByNum() 에러 : " + ex);
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}

	//board 테이블에 새로운 글 삽입히가
	public void insertBoard(BoardBean board)  {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			//for(int i=0; i<10; i++) {
			sql = "insert into board values(?, ?, ?, ?, ?, ?, ?, ?)";
		
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
			//}
		} catch (Exception ex) {
			System.out.println("insertBoard() 에러 : " + ex);
		} finally {
			pool.freeConnection(con, pstmt);
		}		
	} 

	//선택된 글의 조회수 증가하기
	public void updateHit(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = pool.getConnection();

			sql = "select hit from board where num = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			int hit = 0;

			if (rs.next())
				hit = rs.getInt("hit") + 1;

			sql = "update board set hit=? where num=?";
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
	public BoardBean getBoardByNum(int num, int page) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		BoardBean board = null;

		updateHit(num);

		try {
			con = pool.getConnection();
			sql = "select * from board where num = ? ";
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
	//선택된 글 내용 수정하기
	public void updateBoard(BoardBean board) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "update board set name=?, subject=?, content=? where num=?";

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
	public void deleteBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";

		try {
			con = pool.getConnection();
			sql = "delete from board where num=?";	
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

		} catch (Exception ex) {
			System.out.println("deleteBoard() 에러 : " + ex);
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
}
