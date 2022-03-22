package joljak;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AdressDAO {
	
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public AdressDAO( ) {

        String className = "com.mysql.jdbc.Driver";
        String url = "jdbc:mysql://127.0.0.1:3306/?user=root";
        String user = "root";
        String passwd = "0501";
        
        try {
            Class.forName(className);
            con = DriverManager.getConnection(url, user, passwd);
            System.out.println("Connect Success!");              
        } catch(Exception e) {
            System.out.println("Connect Failed!");
            e.printStackTrace();
        } /*finally {
                try {
                    if(con != null && !con.isClosed()) {
                        con.close();
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                }
        }*/
	}
	
	  public String[] select_dong(String sido_name, String sigungu_name) {
	        String SQL = "SELECT DISTINCT dong_name FROM joljak.address WHERE sido_name = ? AND sigungu_name = ?";
	        ArrayList<String> dong_list= new ArrayList<String>();
	        try {
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, sido_name);
				pstmt.setString(2, sigungu_name);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					dong_list.add(rs.getString("dong_name"));
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
	        String[] result = new String[dong_list.size()];
			result = dong_list.toArray(result);
			for(int i =0; i<result.length; i++){
			    System.out.println(result[i]);
			}
			return result;
	  }
	  
	  public String[] select_sigungu(String sido_name) {
	        String SQL = "SELECT DISTINCT sigungu_name FROM joljak.address WHERE sido_name = ?";
	        ArrayList<String> sigungu_list= new ArrayList<String>();
	        try {
				pstmt = con.prepareStatement(SQL);
				pstmt.setString(1, sido_name);
				rs = pstmt.executeQuery();
		        	while(rs.next()) {
		        		System.out.println(rs.getString("sigungu_name"));
		        	}
			} catch (SQLException e) {
				e.printStackTrace();
			}
	        String[] result = new String[sigungu_list.size()];
			result = sigungu_list.toArray(result);
			for(int i =0; i<result.length; i++){
			    System.out.println(result[i]);
			}
	        return result;
	  }
}
