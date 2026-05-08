package com.example.Spring_Demo;

import com.example.Spring_Demo.security.ApiAccessLoggingFilter;
import com.example.Spring_Demo.security.AuthEntryPointJwt;
import com.example.Spring_Demo.security.AuthTokenFilter;
import com.example.Spring_Demo.security.CustomAuthenticationFailureHandler;
import com.example.Spring_Demo.security.CustomAuthenticationSuccessHandler;
import com.example.Spring_Demo.security.SecurityFilter;
import com.example.Spring_Demo.service.UserDetailsServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;

import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

import org.springframework.security.config.http.SessionCreationPolicy;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig {

    @Autowired(required = false)
    private UserDetailsServiceImpl userDetailsService;

    @Autowired
    private AuthEntryPointJwt unauthorizedHandler;

    @Autowired
    private AuthTokenFilter authTokenFilter;

    @Autowired
    private CustomAuthenticationSuccessHandler authenticationSuccessHandler;

    @Autowired
    private CustomAuthenticationFailureHandler authenticationFailureHandler;

    @Autowired
    private ApiAccessLoggingFilter apiAccessLoggingFilter;

    // =========================================
    // Authentication Manager
    // =========================================

    @Bean
    public AuthenticationManager authenticationManager(
            AuthenticationConfiguration authConfig) throws Exception {

        return authConfig.getAuthenticationManager();
    }

    // =========================================
    // Password Encoder
    // =========================================

    @Bean
    public PasswordEncoder passwordEncoder() {

        return new BCryptPasswordEncoder();
    }

    // =========================================
    // Authentication Provider
    // =========================================

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {

        DaoAuthenticationProvider authProvider =
                new DaoAuthenticationProvider();

        if (userDetailsService != null) {

            authProvider.setUserDetailsService(userDetailsService);
            authProvider.setPasswordEncoder(passwordEncoder());
        }

        return authProvider;
    }

    // =========================================
    // Security Filter Chain
    // =========================================

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http, SecurityFilter securityFilter)
            throws Exception {

        http

            // =========================================
            // CORS
            // =========================================

            .cors()
            .and()

            // =========================================
            // CSRF
            // =========================================

            .csrf()
                .csrfTokenRepository(
                        CookieCsrfTokenRepository.withHttpOnlyFalse())
                .ignoringAntMatchers("/api/auth/**")
            .and()

            // =========================================
            // Exception Handling
            // =========================================

            .exceptionHandling()
                .authenticationEntryPoint(unauthorizedHandler)
            .and()

            // =========================================
            // Session Management
            // =========================================

            .sessionManagement()
                .sessionFixation().migrateSession()
                .maximumSessions(1)
                .maxSessionsPreventsLogin(false)
            .and()
                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                .invalidSessionUrl("/")
            .and()

            // =========================================
            // Authorization Rules
            // =========================================

            .authorizeRequests()

                .antMatchers(
                        "/",
                        "/home",
                        "/login",
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/h2-console/**",
                        "/oauth2/**",
                        "/login/oauth2/**"
                ).permitAll()

                .antMatchers("/api/auth/**").permitAll()

                .antMatchers("/api/**").authenticated()

                .antMatchers("/users/**")
                    .hasAnyRole("ADMIN", "MANAGER")

                .anyRequest().authenticated()

            .and()

            // =========================================
            // Form Login
            // =========================================

            .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/perform_login")
                .usernameParameter("userId")
                .passwordParameter("password")
                .successHandler(authenticationSuccessHandler)
                .failureHandler(authenticationFailureHandler)
                .permitAll()

            .and()

            // =========================================
            // OAuth2 Login
            // =========================================

            .oauth2Login()
                .loginPage("/login")
                .defaultSuccessUrl("/dashboard", true)

            .and()

            // =========================================
            // Logout
            // =========================================

            .logout()
                .logoutRequestMatcher(
                        new AntPathRequestMatcher("/logout"))
                .logoutSuccessUrl("/")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()

            .and()

            // =========================================
            // Headers
            // =========================================

            .headers()
                .frameOptions().disable();

        // =========================================
        // Authentication Provider
        // =========================================

        if (userDetailsService != null) {

            http.authenticationProvider(authenticationProvider());
        }

        // =========================================
        // Custom Filters
        // =========================================

        http.addFilterBefore(
                authTokenFilter,
                UsernamePasswordAuthenticationFilter.class
        );

        http.addFilterBefore(
                apiAccessLoggingFilter,
                AuthTokenFilter.class
        );

        http.addFilterBefore(
                securityFilter,
                org.springframework.security.web.session.ConcurrentSessionFilter.class
        );

        return http.build();
    }
}
