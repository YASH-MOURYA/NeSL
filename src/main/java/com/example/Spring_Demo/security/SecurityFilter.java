package com.example.Spring_Demo.security;

import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

@Component
public class SecurityFilter implements Filter {

    private final ConcurrentHashMap<String, AtomicInteger> requestCounts = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<String, Long> lastRequestTimes = new ConcurrentHashMap<>();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String clientIP = getClientIP(httpRequest);

        // Rate limiting: max 10 requests per minute per IP
        if (isRateLimited(clientIP)) {
            httpResponse.setStatus(429);
            httpResponse.getWriter().write("Too many requests. Please try again later.");
            return;
        }

        // Security headers
        httpResponse.setHeader("X-Content-Type-Options", "nosniff");
        httpResponse.setHeader("X-Frame-Options", "DENY");
        httpResponse.setHeader("X-XSS-Protection", "1; mode=block");
        httpResponse.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubdomains");
        httpResponse.setHeader("Content-Security-Policy", "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data:; font-src 'self'");
        httpResponse.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");

        // Only allow HTTPS in production
        if ("https".equals(httpRequest.getScheme())) {
            httpResponse.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubdomains; preload");
        }

        chain.doFilter(request, response);
    }

    private String getClientIP(HttpServletRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }
        return request.getRemoteAddr();
    }

    private boolean isRateLimited(String clientIP) {
        long currentTime = System.currentTimeMillis();
        long windowStart = currentTime - 60000; // 1 minute window

        // Clean up old entries
        lastRequestTimes.entrySet().removeIf(entry -> entry.getValue() < windowStart);

        AtomicInteger count = requestCounts.computeIfAbsent(clientIP, k -> new AtomicInteger(0));
        Long lastTime = lastRequestTimes.get(clientIP);

        if (lastTime == null || lastTime < windowStart) {
            // Reset count for new window
            count.set(1);
            lastRequestTimes.put(clientIP, currentTime);
            return false;
        } else {
            // Increment count
            int currentCount = count.incrementAndGet();
            lastRequestTimes.put(clientIP, currentTime);
            return currentCount > 10; // Max 10 requests per minute
        }
    }
}