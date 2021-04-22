package comments.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import database.DBConnectionMgr;

public class CommentsMgr {
	
	private DBConnectionMgr pool;
	
	
	public CommentsMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
//댓글 개수
	public int getCommentsCount(int board_num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		int count = 0;
		
		try {
			con = pool.getConnection();
			sql = "select count(*) from comments where board_num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			
			if(rs.next())
				count = rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		
		return count; 
	}
	
// 댓글 리스트	
	public ArrayList<CommentsBean> getCommentsList(int board_num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		ArrayList<CommentsBean> list = new ArrayList<CommentsBean>();
		
		try {
			con = pool.getConnection();
			sql = "select * from comments where board_num = ? order by num desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CommentsBean bean = new CommentsBean();
				bean.setNum(rs.getInt("num"));
				bean.setBoard_num(rs.getInt("board_num"));
				bean.setName(rs.getString("name"));
				bean.setContent(rs.getString("content"));
				bean.setRegist_day(rs.getString("regist_day"));
				list.add(bean);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return null;
	}
// 댓글 등록	
	public void insertComments(CommentsBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "insert comments values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, bean.getNum());
			pstmt.setInt(2, bean.getBoard_num());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getContent());
			pstmt.setString(5, bean.getRegist_day());
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}		
	}

//댓글 삭제
	public void deleteComments(CommentsBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "delete from comments where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

// 댓글 수정
	public void updateComments(CommentsBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "update comments set content=? where num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, bean.getContent());
			pstmt.setInt(2, bean.getNum());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

