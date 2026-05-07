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
    private SecurityFilter securityFilter;

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

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }

    // ✅ Password encoder
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    // ✅ Security filter
    @Bean
    public SecurityFilter securityFilter() {
        return new SecurityFilter();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        if (userDetailsService != null) {
            authProvider.setUserDetailsService(userDetailsService);
            authProvider.setPasswordEncoder(passwordEncoder());
        }
        return authProvider;
    }

    // ✅ Security rules
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .cors().and()
            .csrf()
                .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
                .ignoringAntMatchers("/api/auth/**")
            .and()
            .exceptionHandling().authenticationEntryPoint(unauthorizedHandler)
            .and()
            .sessionManagement()
                .sessionFixation().migrateSession()
                .maximumSessions(1)
                .maxSessionsPreventsLogin(false)
                .and()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .invalidSessionUrl("/login?invalid-session=true")
            .and()
            .authorizeRequests()
                // Public endpoints
                .antMatchers("/", "/login", "/css/**", "/js/**", "/images/**", "/h2-console/**", "/oauth2/**", "/login/oauth2/**").permitAll()
                // API endpoints - JWT protected
                .antMatchers("/api/auth/**").permitAll()
                .antMatchers("/api/**").authenticated()
                // Web endpoints - form login protected
                .antMatchers("/users/**").hasAnyRole("ADMIN", "MANAGER")
                .anyRequest().authenticated()
            .and()
            .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/perform_login")
                .usernameParameter("userId")
                .passwordParameter("password")
                .successHandler(authenticationSuccessHandler)
                .failureHandler(authenticationFailureHandler)
                .permitAll()
            .and()
            .oauth2Login()
                .loginPage("/login")
                .defaultSuccessUrl("/dashboard", true)
            .and()
            .oauth2ResourceServer()
                .jwt()
            .and()
            .and()
            .logout()
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                .logoutSuccessUrl("/login?logout=true")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
            .and()
            .headers()
                .frameOptions().deny()
            .and()
            .requiresChannel()
                .anyRequest().requiresSecure();

        if (userDetailsService != null) {
            http.authenticationProvider(authenticationProvider());
        }

        http.addFilterBefore(authTokenFilter, UsernamePasswordAuthenticationFilter.class);
        http.addFilterBefore(apiAccessLoggingFilter, AuthTokenFilter.class);
        http.addFilterBefore(securityFilter, org.springframework.security.web.session.ConcurrentSessionFilter.class);

        return http.build();
    }
}