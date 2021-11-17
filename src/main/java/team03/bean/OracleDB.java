package team03.bean;

import java.sql.Connection;
import java.sql.DriverManager;

public class OracleDB {
	public static Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver"); 
		String url = "jdbc:oracle:thin:@masternull.iptime.org:1521:orcl";
		String user ="team03";
		String pw = "team03";
		Connection conn = DriverManager.getConnection(url,user,pw);  
		return conn;
	}
}
