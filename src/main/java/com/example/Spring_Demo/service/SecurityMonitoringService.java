package com.example.Spring_Demo.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Service
public class SecurityMonitoringService {

    private static final Logger logger = LoggerFactory.getLogger(SecurityMonitoringService.class);

    public void logLoginAttempt(String username, boolean successful, HttpServletRequest request) {
        Map<String, Object> event = new HashMap<>();
        event.put("timestamp", LocalDateTime.now());
        event.put("event", "LOGIN_ATTEMPT");
        event.put("username", username);
        event.put("successful", successful);
        event.put("ipAddress", getClientIP(request));
        event.put("userAgent", request.getHeader("User-Agent"));
        event.put("sessionId", request.getSession(false) != null ? request.getSession().getId() : "none");

        logger.info("SECURITY_EVENT: {}", event);
    }

    public void logSecurityEvent(String eventType, String details, HttpServletRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth != null ? auth.getName() : "anonymous";

        Map<String, Object> event = new HashMap<>();
        event.put("timestamp", LocalDateTime.now());
        event.put("event", eventType);
        event.put("username", username);
        event.put("details", details);
        event.put("ipAddress", getClientIP(request));
        event.put("userAgent", request.getHeader("User-Agent"));

        logger.warn("SECURITY_EVENT: {}", event);
    }

    public void logApiAccess(String endpoint, String method, int statusCode, HttpServletRequest request) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth != null ? auth.getName() : "anonymous";

        Map<String, Object> event = new HashMap<>();
        event.put("timestamp", LocalDateTime.now());
        event.put("event", "API_ACCESS");
        event.put("username", username);
        event.put("endpoint", endpoint);
        event.put("method", method);
        event.put("statusCode", statusCode);
        event.put("ipAddress", getClientIP(request));

        logger.info("API_ACCESS: {}", event);
    }

    private String getClientIP(HttpServletRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }
        return request.getRemoteAddr();
    }
}