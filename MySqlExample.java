import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Locale;

public class MySqlExample {
    public static void main(String[] args) throws ClassNotFoundException {
        String host, port, databaseName, userName, password;
        host = port = databaseName = userName = password = null;
        
        for (int i = 0; i < args.length - 1; i++) {
            switch (args[i].toLowerCase(Locale.ROOT)) {
                case "-host": host = args[++i]; break;
                case "-username": userName = args[++i]; break;
                case "-password": password = args[++i]; break;
                case "-database": databaseName = args[++i]; break;
                case "-port": port = args[++i]; break;
            }
        }
        
        if (host == null || port == null || databaseName == null) {
            System.out.println("❌ Host, port, database information is required");
            System.out.println("Usage: java MySqlExample -host <host> -port <port> -database <db> -username <user> -password <pass>");
            return;
        }
        
        System.out.println("🔍 Connecting to database...");
        System.out.println("   Host: " + host);
        System.out.println("   Port: " + port);
        System.out.println("   Database: " + databaseName);
        System.out.println("   Username: " + userName);
        
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        try (final Connection connection = DriverManager.getConnection(
                "jdbc:mysql://" + host + ":" + port + "/" + databaseName + "?useSSL=true&serverTimezone=UTC",
                userName, password);
             final Statement statement = connection.createStatement();
             final ResultSet resultSet = statement.executeQuery("SELECT version() AS version")) {
            
            System.out.println("✅ Connected successfully!");
            
            while (resultSet.next()) {
                System.out.println("   MySQL Version: " + resultSet.getString("version"));
            }
            
            // Check monuments count
            try (ResultSet rs2 = statement.executeQuery("SELECT COUNT(*) FROM monument")) {
                if (rs2.next()) {
                    System.out.println("   Total Monuments: " + rs2.getInt(1));
                }
            }
            
        } catch (SQLException e) {
            System.out.println("❌ Connection failure.");
            System.out.println("   Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}