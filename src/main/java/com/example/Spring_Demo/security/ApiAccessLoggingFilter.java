package com.example.Spring_Demo.security;

import com.example.Spring_Demo.service.SecurityMonitoringService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import java.io.IOException;

@Component
public class ApiAccessLoggingFilter implements Filter {

    @Autowired
    private SecurityMonitoringService securityMonitoringService;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Log API access for /api/* endpoints
        if (httpRequest.getRequestURI().startsWith("/api/")) {
            // Wrap response to capture status code
            StatusExposingServletResponse wrappedResponse = new StatusExposingServletResponse(httpResponse);

            try {
                chain.doFilter(request, wrappedResponse);
            } finally {
                securityMonitoringService.logApiAccess(
                    httpRequest.getRequestURI(),
                    httpRequest.getMethod(),
                    wrappedResponse.getStatus(),
                    httpRequest
                );
            }
        } else {
            chain.doFilter(request, response);
        }
    }

    // Helper class to capture response status
    private static class StatusExposingServletResponse extends HttpServletResponseWrapper {
        private int status;

        public StatusExposingServletResponse(HttpServletResponse response) {
            super(response);
        }

        @Override
        public void setStatus(int sc) {
            this.status = sc;
            super.setStatus(sc);
        }

        @Override
        public void setStatus(int sc, String sm) {
            this.status = sc;
            super.setStatus(sc, sm);
        }

        @Override
        public void sendError(int sc) throws IOException {
            this.status = sc;
            super.sendError(sc);
        }

        @Override
        public void sendError(int sc, String msg) throws IOException {
            this.status = sc;
            super.sendError(sc, msg);
        }

        public int getStatus() {
            return status;
        }
    }
}