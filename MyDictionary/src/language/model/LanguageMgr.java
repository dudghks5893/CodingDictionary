package language.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dictionary.model.DictionaryBean;
import language.database.DBConnectionMgr;

public class LanguageMgr {
	
	private DBConnectionMgr pool;
	
	public LanguageMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
//언어 추가
	public void insertLanguage(LanguageBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
			
		try {
			con = pool.getConnection();
			sql = "insert language values(?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getLanguage());
			pstmt.executeUpdate();
				
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

//언어 리스트
	public ArrayList<LanguageBean> getLanguageList(){
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "";
		ArrayList<LanguageBean> list = new ArrayList<LanguageBean>();
		try {
			con = pool.getConnection();
			stmt = con.createStatement();
			sql = "select * from language";
			rs = stmt.executeQuery(sql);
				
			while (rs.next()) {
				LanguageBean bean = new LanguageBean();
				bean.setLanguage(rs.getString(1));
				list.add(bean);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, stmt, rs);
		}
		return null;
	}
	
	
	
}
