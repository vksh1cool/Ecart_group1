package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {
//public static void main(String[] args) {
//	DBUtil.createConnection();
//}
public static Connection createConnection() {
	Connection cn = null;
	try {
		String databaseURL = "jdbc:derby:C:\\Users\\2733134\\git\\Aug29_Java_Ninja_Group4\\Java Project Group 4\\Ecart;create=true;";
		DriverManager.registerDriver(new org.apache.derby.jdbc.EmbeddedDriver());
		cn = DriverManager.getConnection(databaseURL);
	}
	catch(SQLException e){
		System.out.println(e.getMessage());
	}
	return cn;
}

public static void closeAllConnection(Connection cn, PreparedStatement ps, ResultSet rs) {
	try {
		if(rs!=null) {
			rs.close();
		}
		if(ps!=null) {
			ps.close();
		}
		if(cn!=null) {
			cn.close();
		}
	}
	catch(Exception e) {
		System.out.println(e.getMessage());
	}
}
}
