package badgudu.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

//JDBC 1/2 단계 진행

public class ConnectionDAO {

	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver"); //1단계
			String url= "jdbc:oracle:thin:@masternull.iptime.org:1521:orcl";
			String user = "team03";
			String pass = "team";
			conn = DriverManager.getConnection(url, user, pass); //2단계
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void close(Connection conn , PreparedStatement pstmt , ResultSet rs) {
		if(rs != null) { try {rs.close();}catch(SQLException s) {}}
		if(pstmt != null) { try {pstmt.close();}catch(SQLException s) {}}
		if(conn != null) { try {conn.close();}catch(SQLException s) {}}
	}
}
