package bookmark.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import database.DBConnectionMgr;
import dictionary.model.DictionaryBean;

public class BookmarkMgr {

	private DBConnectionMgr pool;
	
	
	public BookmarkMgr () {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	// 즐겨찾기 개수
			public int getBookmarkCount(String search, String userName) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "";
					
				try {
					con = pool.getConnection();
						
					if(search != null)
						sql = "select count(*) from codingdictionary, bookmark where bookmark.CDnum = codingdictionary.Num and UserName = ? and concat(Language,Code,Abbreviation,Meaning,Type,Explanation,Ex) like '%"+search+"%'";
					else 
						sql = "select count(*) from codingdictionary, bookmark where bookmark.CDnum = codingdictionary.Num and UserName = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, userName);
					rs = pstmt.executeQuery();
						
					if(rs.next()) {
						return rs.getInt(1);
					}
						
				} catch (Exception e) {
					System.out.println("getAllCount() 에러: "+e);
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return -1;
			}
			
	
	// 즐겨찾기 리스트	
		public ArrayList<DictionaryBean> getBookmarkDictionary(int pageNum,String search,int start , int listCout, String userName) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			start = (pageNum*listCout)-listCout; // 리스트 출력할 시작 위치
			
			ArrayList<DictionaryBean> list = new ArrayList<DictionaryBean>();
			
			try {
				con = pool.getConnection();
				if(search != null) 
					sql = "select * from codingdictionary, bookmark where bookmark.CDnum = codingdictionary.Num and UserName = ? and concat(Language,Code,Abbreviation,Meaning,Type,Explanation,Ex) like '%"+search+"%' order by Num desc limit ?,?";
				else 
					sql = "select * from codingdictionary, bookmark where bookmark.CDnum = codingdictionary.Num and UserName = ? order by Num desc limit ?,?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, userName);
				pstmt.setInt(2, start);
				pstmt.setInt(3, listCout);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					DictionaryBean bean = new DictionaryBean();
					bean.setNum(rs.getInt(1));
					bean.setLanguage(rs.getString(2));
					bean.setCode(rs.getString(3));
					bean.setAbbreviation(rs.getString(4));
					bean.setMeaning(rs.getString(5));
					bean.setType(rs.getString(6));
					bean.setExplanation(rs.getString(7));
					bean.setEx(rs.getString(8));
					list.add(bean);
				}
				return list;
			} catch (Exception e) {
				System.out.println("getAllDictionary() 에러: "+e);
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return null;
		}
		
	
		// 즐겨찾기 되어있을때 (중복확인)
		public int checkBookmark(String userName, String cdNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			try {
				con = pool.getConnection();
				sql = "select count(*) from bookmark where UserName=? and CDnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, userName);
				pstmt.setString(2, cdNum);
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
	
	
	//인서트 즐겨찾기
	public void insertBookmark(BookmarkBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into bookmark values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsername());
			pstmt.setInt(2, bean.getCdnum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con,pstmt);
		}
	}
	
	//즐겨찾기 삭제
	public void deleteBookmark(BookmarkBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "";
		try {
			con = pool.getConnection();
			sql = "delete from bookmark where UserName=? and CDnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getUsername());
			pstmt.setInt(2, bean.getCdnum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("deleteBookmark() 에러 : "+e);
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	
	
	
	
}
