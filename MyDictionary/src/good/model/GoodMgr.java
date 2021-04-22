package good.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import database.DBConnectionMgr;

public class GoodMgr {
	
	private DBConnectionMgr pool;
	
	
	public GoodMgr () {
		pool = DBConnectionMgr.getInstance();
	}	


// 댓긋 좋아요 개수
	public int getGoodCount(int commentsNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = pool.getConnection();
			
			sql = "select count(*) from good where commentsNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, commentsNum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return -1;
	}
	
	
// 인서트 댓글 좋아요
	public void insertGood(GoodBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = pool.getConnection();
			sql = "insert good values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getCommentsNum());
			pstmt.setString(2, bean.getUserName());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
// 딜리트 댓글 좋아요
	public void deleteGood(GoodBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		
		try {
			con = pool.getConnection();
			sql = "delete from good where commentsNum=? and userName=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getCommentsNum());
			pstmt.setString(2, bean.getUserName());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
// 좋아요 중복체크
	public int checkGood(int commentsNum,String userName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "select count(*) from good where commentsNum=? and userName=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, commentsNum);
			pstmt.setString(2, userName);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return -1;
	}
	
// 랭크 점수 (유저가 받은 좋아요 개수)
	public int rating(String userName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = pool.getConnection();
			sql = "select count(*) from good,comments where good.commentsNum = comments.num and comments.name=? and good.commentsNum";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userName);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return -1;
	}
	
	
	
	
	
	
	
	
}
