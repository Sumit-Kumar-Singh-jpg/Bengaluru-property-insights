package com.bengaluru.lands.servlet;

import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;
import java.sql.*;

@WebServlet("/report")
public class ReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        res.setContentType("text/csv");
        PrintWriter out = res.getWriter();
        out.println("ID,Name,Price,Roi");

        String url = "jdbc:mysql://127.0.0.1:3306/bengaluru_lands";
        String user = "root";
        String pass = "root123";

        try {
            Connection con = DriverManager.getConnection(url, user, pass);
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(
                "SELECT a.area_id, a.name, m.current_price, m.avg_roi_pct " +
                "FROM areas a LEFT JOIN area_metrics m ON a.area_id = m.area_id"
            );
            while (rs.next()) {
                out.println(rs.getInt(1) + "," + rs.getString(2) + "," + rs.getBigDecimal(3) + "," + rs.getBigDecimal(4));
            }
            con.close();

            // Java I/O: log to file
            FileWriter fw = new FileWriter("report_log.txt", true);
            fw.write("Report generated at " + new java.util.Date() + "\n");
            fw.close();

        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    }
}