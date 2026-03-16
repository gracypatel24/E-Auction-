<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    .user-footer {
        background: white;
        padding: 20px 30px;
        border-radius: 15px;
        margin-top: 30px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
    }
    
    .footer-content {
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: #6c757d;
        font-size: 14px;
    }
    
    .footer-links {
        display: flex;
        gap: 25px;
    }
    
    .footer-links a {
        color: #6c757d;
        text-decoration: none;
        transition: color 0.3s;
        font-size: 13px;
    }
    
    .footer-links a:hover {
        color: #667eea;
    }
    
    .footer-heart {
        color: #ff4757;
        margin: 0 3px;
        animation: heartbeat 1.5s ease infinite;
    }
    
    @keyframes heartbeat {
        0% { transform: scale(1); }
        50% { transform: scale(1.1); }
        100% { transform: scale(1); }
    }
    
    @media (max-width: 768px) {
        .footer-content {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }
    }
</style>

<footer class="user-footer">
    <div class="footer-content">
        <div>
            &copy; 2026 <span style="color: #667eea; font-weight: 600;">E-Auction</span>. All rights reserved.
        </div>
        
        <div class="footer-links">
            <a href="#">About</a>
            <a href="#">Terms</a>
            <a href="#">Privacy</a>
            <a href="#">Contact</a>
            <a href="#">Help</a>
        </div>
        
        <div>
            Made with <span class="footer-heart">❤️</span> by Skydash
        </div>
    </div>
</footer>