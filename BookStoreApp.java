import java.sql.*;
import java.util.Scanner;
import java.util.Arrays;
public class BookStoreApp {
    public static void main(String[] args) {
        try (
                Connection con = DriverManager.getConnection(
                        "jdbc:postgresql://localhost:5432/project","postgres","new_password");
                Statement s = con.createStatement();
        ){
            String q;
            ResultSet result;
            q = "SELECT isbn, title, num_pages, price, pub_id, percentage, stock FROM bookstore.a_book;";
            result = s.executeQuery(q);
            System.out.println("Browser all books:");
            System.out.println("ISBN  Title  Num Pages  Price  Publisher  Stock");
            while (result.next()) {
                String isbn = result.getString(1);
                String title = result.getString(2);
                String num_pages = result.getString(3);
                String price = result.getString(4);
                String pub_id = result.getString(5);
                String percentage = result.getString(6);
                String stock = result.getString(7);
                System.out.println(isbn + ", " + title + ", " + num_pages + ", " + price + ", " + pub_id + ", " + percentage + ", " + stock);
            }
        } catch(Exception e){e.printStackTrace();}
    }
}