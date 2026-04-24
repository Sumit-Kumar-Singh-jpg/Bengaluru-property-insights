package com.bengaluru.lands.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;
import java.io.*;

@WebFilter("/*")
public class LoggingFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        String log = new java.util.Date() + " - " + request.getMethod() + " " + request.getRequestURI() + "\n";
        
        FileWriter fw = new FileWriter("api_log.txt", true);
        fw.write(log);
        fw.close();
        
        chain.doFilter(req, res);
    }
}