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
//            String q;
//            String c;
//            ResultSet result;
//            int maxCourse = 0;
//            q = "select count(*) as C from course";
//            result = s.executeQuery(q);
//            if (!result.next())
//                System.out.println("Unexpected empty result.");
//            else
//                maxCourse = Integer.parseInt(result.getString("C"));
//            int numCourse = 0, oldNumCourse = -1;
//            String[] prereqs = new String [maxCourse];
//            Scanner krb = new Scanner(System.in);
//            System.out.print("Input a course id (number): ");
//            String course = krb.next();
//            String courseString = "" + '\'' + course + '\'';
//            while (numCourse != oldNumCourse) {
//                for (int i = oldNumCourse + 1; i < numCourse; i++) {
//                    courseString += ", " + '\'' + prereqs[i] + '\'' ;
//                }
//                oldNumCourse = numCourse;
//                q = "select prereq_id from prereq where course_id in (" + courseString + ")";
//                    result = s.executeQuery(q);
//                    while (result.next()) {
//                        c = result.getString("prereq_id");
//                        boolean found = false;
//                        for (int i = 0; i < numCourse; i++)
//                            found |= prereqs[i].equals(c);
//                        if (!found) prereqs[numCourse++] = c;
//                    }
//                    courseString = "" + '\'' + prereqs[oldNumCourse] + '\'';
//                }
//                Arrays.sort(prereqs, 0, numCourse);
//                System.out.print("The courses that must be taken prior to "
//                        + course + " are: ");
//                for (int i = 0; i < numCourse; i++)
//                    System.out.print ((i==0?" ":", ") + prereqs[i]);
//                System.out.println();
            } catch(Exception e){e.printStackTrace();
            }
        }}