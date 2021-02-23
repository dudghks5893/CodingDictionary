package bookmark;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BookmarkMgr {

	private DBConnectionMgr pool;
	
	
	public BookmarkMgr () {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	
	
	
	
	//인서트 즐겨찾기
	public void insertBookmark(String userid, BookmarkBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		String sql = null;
		String sql2 = null;
		
		try {
			con = pool.getConnection();
			
			sql = "select name from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setUsername(rs.getString(1));
			}
			sql2 = "insert into bookmark value(?,?)";
			pstmt2 = con.prepareStatement(sql2);
			pstmt2.setString(1, bean.getUsername());
			pstmt2.setInt(2, bean.getCdnum());
			pstmt2.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt);
		}
	}
	
	
	
	
	
	
}
