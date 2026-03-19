package com.grownited.eauction.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import com.grownited.eauction.entity.UserEntity;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AuthFilter implements Filter {
    
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/login", "/signup", "/register", "/authenticate",
        "/forgot-password", "/reset-password", "/generate-password",
        "/test-password", "/fix-passwords", "/hash-password", 
        "/debug-session", "/check-session", "/test-login", 
        "/simple-login", "/logout", "/css/", "/js/", "/images/"
    );
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String path = req.getRequestURI().substring(req.getContextPath().length());
        
        System.out.println("AuthFilter - processing: " + path);
        
        // Allow public paths (including logout)
        for (String publicPath : PUBLIC_PATHS) {
            if (path.startsWith(publicPath)) {
                System.out.println("AuthFilter - public path, allowing: " + path);
                chain.doFilter(request, response);
                return;
            }
        }
        
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            System.out.println("AuthFilter - user authenticated, allowing: " + path);
            chain.doFilter(request, response);
            return;
        }
        
        System.out.println("AuthFilter - no user, redirecting to login from: " + path);
        res.sendRedirect(req.getContextPath() + "/login");
    }
}