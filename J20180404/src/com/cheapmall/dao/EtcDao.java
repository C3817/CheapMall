package com.cheapmall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class EtcDao {
	/*
	 * Version 1.0
	 * 최초작성자 : 허진무
	 * 내용 : 메뉴, 검색 등 관련 DAO
	 */
	
	/*
	 * 작성자 : 허진무
	 * 최초작성일 : 20180411
	 * 내용 :
	 * 	1. searchTagGet() -> 검색어를 가져옴(ajax)
	 *	2. searchKeyword() / getKeyword() -> 검색어를 검색
	 *	3. registKeyword() -> 검색어 등록
	 */
	
	private static EtcDao instance;
	private EtcDao() {}
	public static EtcDao getInstance() {
		if(instance == null) { instance = new EtcDao(); }
		return instance;
	}
	
	private Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		}catch(Exception e) { 
			// SYSO
			System.out.println("Connection Error");
			System.out.println(e.getMessage());	
		}
		return conn;
	}
	private void DisConnection(Connection conn, PreparedStatement ps, ResultSet rs) throws SQLException{
		if(rs != null) { rs.close(); }
		if(ps != null) { ps.close(); }
		if(conn != null) { conn.close(); }
	}
	
	// HJM - KeyWord Start!
	public JSONObject searchTagGet(String keyword) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT tag" + 
					" FROM search" + 
					" WHERE full_tag LIKE FN_GET_DIV_KO_CHAR(?) || '%' " + 
					" order by tag asc";
		JSONArray array = new JSONArray();
		JSONObject json = new JSONObject();
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, keyword);
			rs = ps.executeQuery();
			json.put("result", "no");
			if(rs.next()) {
				do {
					array.add(rs.getString(1));
				} while(rs.next());
				json.put("keywords", array);
				json.replace("result", "no", "yes");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("searchTagGet Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return json;
	}
	public int searchKeyword(String keyword) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM search where tag LIKE ?";
		int result = 0;
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, keyword);
			rs = ps.executeQuery();
			if(rs.next()) {
				result = 1;
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("searchKeyword Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return result;
	}
	public int registKeyword(String keyword, String transKeyword) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		
		String sql = "INSERT INTO search "
				+ "	VALUES(?,?,0)";
		int result = 0;
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, keyword);
			ps.setString(2, transKeyword);
			result = ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("registKeyword Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, null);
		}
		
		return result;
	}
	public JSONObject getKeyword(String keyword) throws SQLException{
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM search WHERE tag LIKE ?";
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonList = new JSONArray();
		
		try {
			conn = getConnection();
			ps = conn.prepareStatement(sql);
			ps.setString(1, keyword);
			rs = ps.executeQuery();
			if(rs.next()) {
				jsonObject.put("tag", rs.getString(1));
				jsonObject.put("tag2", rs.getString(2));
			}
		} catch (Exception e) {
			// TODO: handle exception
			// SYSO
			System.out.println("getKeyword Error");
			e.printStackTrace();
		} finally {
			DisConnection(conn, ps, rs);
		}
		
		return jsonObject;
	}
}
