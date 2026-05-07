package com.example.Spring_Demo.security;

import com.example.Spring_Demo.service.SecurityMonitoringService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Autowired
    private SecurityMonitoringService securityMonitoringService;

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        org.springframework.security.core.AuthenticationException exception)
            throws IOException, ServletException {
        String username = request.getParameter("userId");
        securityMonitoringService.logLoginAttempt(username != null ? username : "unknown", false, request);
        response.sendRedirect("/login?error=true");
    }
}
