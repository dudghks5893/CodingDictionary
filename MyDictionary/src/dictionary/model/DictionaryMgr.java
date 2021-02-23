package dictionary.model;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dictionary.database.DBConnectionMgr;

public class DictionaryMgr {


	private DBConnectionMgr pool;
	
	
	public DictionaryMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
//코딩사전 전체 개수
		public int getAllCount(String search) {
			Connection con = null;
			Statement stmt = null;
			ResultSet rs = null;
			String sql = "";
			
			try {
				con = pool.getConnection();
				stmt = con.createStatement();
				
				if(search != null)
					sql = "SELECT count(*) FROM CodingDictionary where concat(Language,Code,Abbreviation,Meaning,Type,Explanation,Ex) like '%"+search+"%'";
				else 
					sql = "SELECT count(*) FROM CodingDictionary";
				
				rs = stmt.executeQuery(sql);
				
				if(rs.next()) {
					return rs.getInt(1);
				}
				
			} catch (Exception e) {
				System.out.println("getAllCount() 에러: "+e);
			} finally {
				pool.freeConnection(con, stmt, rs);
			}
			return -1;
		}
	
// 코딩사전 페이징 개수
	public int getAllPaging(String search, int cnt) {
		int total = 0;
		int paging = 0;
		
		total = getAllCount(search); // 코딩사전 전체 개수
			
			if(total%cnt==0) { // 나머지가 0일때
				paging = total/cnt;
				Math.floor(paging);// 소수점 버리기
			} else { // 아닐때 페이지1개 추가
				paging = total/cnt+1;
				Math.floor(paging);// 소수점 버리기
			}
			
				return paging;
	}
	

	
//	// 다음 페이지 구현 중 불린 방법 다음 페이지가 있을 시 
//	public boolean getNextPage2(String search) { //매개변수에 카페 아이디 추가
//		int count = 15;
//		int start = (1 -1)*5;
//		int index = start + 1;
//		ArrayList<Integer> list = new ArrayList<Integer>();
//		for(int a=0; a<=getAllPaging(search); a++){
//			if(a%5==0){
//				list.add(a+1);
//			}
//		}
//		
//			for(int i = 0; i<=list.size(); i++) {
//				
//				if (index < (start + 5) && index <= count) {
//					index++;
//				} else {
//					break;
//				}
//				
//				return true;
//		}
//		return false; //결과가 없으면 false
//	}	
//	
//// 다음페이지 구현 중 
//	public int getAllPaging2(String search) {
//		Connection con = null;
//		Statement stmt = null;
//		ResultSet rs = null;
//		String sql = "";
//		int total = 0;
//		int remainder = 0;
//		
//		try {
//			con = pool.getConnection();
//			stmt = con.createStatement();
//			
//			if(search != null)
//				sql = "SELECT count(*) FROM CodingDictionary where concat(Language,Code,Abbreviation,Meaning,Type,Explanation,Ex) like '%"+search+"%'";
//			else 
//				sql = "SELECT count(*) FROM CodingDictionary";
//			
//			rs = stmt.executeQuery(sql);
//			
//			if(rs.next()) {
//				total = rs.getInt(1)/5;
//				remainder = rs.getInt(1)%5;
//				if(remainder!=0) {
//					total = rs.getInt(1)/5+1;
//				}
//				for(int i=0; i<total; i++) {
//					
//				}
//				return total;
//			}
//			
//		} catch (Exception e) {
//			System.out.println("getAllCount() 에러: "+e);
//		} finally {
//			pool.freeConnection(con, stmt, rs);
//		}
//		return -1;
//	}
//	
//// 다음페이지 구현 중	
//	public ArrayList<Integer> getNextPage(int next,String search){
//		int count = getAllPaging2(search);
//		int start = (next -1)*5;
//		int index = start +1;
//		
//		ArrayList<Integer> list = new ArrayList<Integer>();
//		for(int i=0; i<getAllPaging2(search); i++) {
//			list.add(i);
//			
//			if(index < (start + 5) && index <= count)
//				index++;
//			else
//				break;
//		}
//		
//		return list;
//	}

	
// 코딩사전 전체 리스트	
	public ArrayList<DictionaryBean> getAllDictionary(int pageNum,String search,int start , int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		start = (pageNum*cnt)-cnt; // 리스트 출력할 시작 위치
		
		ArrayList<DictionaryBean> list = new ArrayList<DictionaryBean>();
		
		try {
			con = pool.getConnection();
			if(search != null) 
				sql = "SELECT * FROM CodingDictionary where concat(Language,Code,Abbreviation,Meaning,Type,Explanation,Ex) like '%"+search+"%' order by Num desc limit ?,?";
			else 
				sql = "SELECT * FROM CodingDictionary order by Num desc limit ?,?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, cnt);
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
	
// 코딩사전 언어별 개수
		public int getLanguageCount(String search, String language) {
			Connection con = null;
			Statement stmt = null;
			ResultSet rs = null;
			String sql = "";
				
			try {
				con = pool.getConnection();
				stmt = con.createStatement();
					
				if(search != null)
					sql = "SELECT count(*) FROM CodingDictionary where concat(Language,Code,Abbreviation,Meaning,Type,Explanation,Ex) like '%"+search+"%'and Language like '"+language+"'";
				else 
					sql = "SELECT count(*) FROM CodingDictionary where Language like '"+language+"'";
					
				rs = stmt.executeQuery(sql);
					
				if(rs.next()) {
					return rs.getInt(1);
				}
					
			} catch (Exception e) {
				System.out.println("getAllCount() 에러: "+e);
			} finally {
				pool.freeConnection(con, stmt, rs);
			}
			return -1;
		}
			
// 코딩사전 언어별 페이징 개수
		public int getLanguagePaging(String search, String language ,int cnt) {
			int total = 0;
			int paging = 0;
			total = getLanguageCount(search,language); // 코딩사전 언어별 개수
				
				if(total%cnt==0) {
					paging = total/cnt;
					Math.floor(paging);
				} else {
					paging = total/cnt+1;
					Math.floor(paging);
				}
				
					return paging;
		}
// 코딩사전 언어별 리스트	
		public ArrayList<DictionaryBean> getLanguageDictionary(int pageNum,String search, String language, int start , int cnt) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			start = (pageNum*cnt)-cnt; // 리스트 출력할 시작 위치

			ArrayList<DictionaryBean> list = new ArrayList<DictionaryBean>();
			
			try {
				con = pool.getConnection();
				if(search != null)
					sql = "SELECT * FROM CodingDictionary where concat(Language,Code,Abbreviation,Meaning,Type,Explanation,Ex) like '%"+search+"%'and Language like '"+language+"' order by Num desc limit ?,?";
				else
					sql = "SELECT * FROM CodingDictionary where Language like '"+language+"' order by Num desc limit ?,?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
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
		
// 선택된 코딩사전 사용예제	
		public DictionaryBean getEx(String num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			DictionaryBean bean = new DictionaryBean();
			
			try {
				con = pool.getConnection();
				
				sql = "SELECT * FROM CodingDictionary where Num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setNum(rs.getInt(1));
					bean.setLanguage(rs.getString(2));
					bean.setCode(rs.getString(3));
					bean.setAbbreviation(rs.getString(4));
					bean.setMeaning(rs.getString(5));
					bean.setType(rs.getString(6));
					bean.setExplanation(rs.getString(7));
					bean.setEx(rs.getString(8));
				}
				return bean;
			} catch (Exception e) {
				System.out.println("getAllDictionary() 에러: "+e);
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return null;
		}
		
// 코딩사전 등록
		public void insertDictionary(DictionaryBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			try {
				con = pool.getConnection();
				for(int i=0; i<10; i++) {
				sql = "insert CodingDictionary(Language,Code,Abbreviation,Meaning,Type,Explanation,Ex) values(?,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getLanguage());
				pstmt.setString(2, bean.getCode());
				pstmt.setString(3, bean.getAbbreviation());
				pstmt.setString(4, bean.getMeaning());
				pstmt.setString(5, bean.getType());
				pstmt.setString(6, bean.getExplanation());
				pstmt.setString(7, bean.getEx());
				pstmt.executeUpdate();
				}
			} catch (Exception e) {
				System.out.println("insertDictionary() 에러: "+e);
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
		
		
// 코딩사전 수정
		public void updateDictionary(DictionaryBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			try {
				con = pool.getConnection();
				sql = "UPDATE CodingDictionary SET language=?,code=?, abbreviation=?, meaning=?, type=?, explanation=?, ex=? where Num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getLanguage());
				pstmt.setString(2, bean.getCode());
				pstmt.setString(3, bean.getAbbreviation());
				pstmt.setString(4, bean.getMeaning());
				pstmt.setString(5, bean.getType());
				pstmt.setString(6, bean.getExplanation());
				pstmt.setString(7, bean.getEx());
				pstmt.setInt(8, bean.getNum());
				pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("updateDictionary() 에러 : "+e);
			} finally {
				pool.freeConnection(con, pstmt);
			}
			
		}

// 코딩사전 삭제
		public void deleteDictionary(DictionaryBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = "";
			try {
				con = pool.getConnection();
				sql = "delete from CodingDictionary where Num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, bean.getNum());
				pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("deleteDictionary() 에러 : "+e);
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
// 코딩사전 삭제 자기 호출방식 (현재 view 페이지에서 바로 삭제)
//		public void deleteDictionary2(String num) {
//			Connection con = null;
//			PreparedStatement pstmt = null;
//			String sql = "";
//			try {
//				con = pool.getConnection();
//				sql = "delete from CodingDictionary where Num = ?";
//				pstmt = con.prepareStatement(sql);
//				pstmt.setString(1, num);
//				pstmt.executeUpdate();
//			} catch (Exception e) {
//				System.out.println("deleteDictionary() 에러 : "+e);
//			} finally {
//				pool.freeConnection(con, pstmt);
//			}
//		}
		
		
		
		
		
		
		
		
}
