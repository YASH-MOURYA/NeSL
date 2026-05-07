# Spring Demo - Production Deployment Guide

## Overview
This guide provides instructions for deploying the Spring Demo application in a production environment with enhanced security features.

## Security Features Implemented

### 🔐 Authentication & Authorization
- **Form-based Authentication**: Traditional web login
- **JWT Token Authentication**: For API access
- **OAuth2 Resource Server**: Support for external OAuth2 providers
- **Role-based Access Control**: ADMIN and MANAGER roles

### 🛡️ Security Measures
- **SSL/TLS Encryption**: HTTPS enforcement
- **CSRF Protection**: Cookie-based tokens
- **Security Headers**: XSS protection, content type options, frame options
- **Rate Limiting**: 10 requests per minute per IP
- **Session Management**: Secure session handling with fixation protection

### 📊 Monitoring & Logging
- **Security Event Logging**: Login attempts, API access, security violations
- **Audit Events**: Spring Boot Actuator audit events
- **Structured Logging**: JSON format for log analysis

## Prerequisites

### System Requirements
- Java 8 or higher
- Maven 3.6+
- PostgreSQL (recommended for production)
- SSL Certificate (from CA or self-signed for testing)

### Environment Variables
Set the following environment variables for production:

```bash
# Database
export DB_USERNAME=your_db_username
export DB_PASSWORD=your_db_password

# SSL Configuration
export SSL_KEYSTORE_PASSWORD=your_keystore_password
export SSL_KEY_ALIAS=your_key_alias

# JWT Configuration
export JWT_SECRET_KEY=your_256_bit_secret_key_here

# OAuth2 (if using external provider)
export OAUTH2_ISSUER_URI=https://your-auth-server.com
export OAUTH2_JWK_SET_URI=https://your-auth-server.com/.well-known/jwks.json
```

## SSL/TLS Certificate Setup

### Option 1: Self-Signed Certificate (Development/Testing)
```bash
keytool -genkeypair -alias tomcat -keyalg RSA -keysize 2048 \
  -storetype PKCS12 -keystore keystore.p12 -validity 365 \
  -dname "CN=yourdomain.com, OU=IT, O=YourCompany, L=City, ST=State, C=US" \
  -storepass your_password -keypass your_password
```

### Option 2: CA-Signed Certificate (Production)
1. Generate CSR:
```bash
keytool -certreq -alias tomcat -keystore keystore.p12 \
  -file certificate.csr -storepass your_password
```

2. Submit CSR to CA and import the signed certificate:
```bash
keytool -import -trustcacerts -alias tomcat -file certificate.crt \
  -keystore keystore.p12 -storepass your_password
```

## Database Setup

### PostgreSQL Setup
```sql
CREATE DATABASE nesl_prod;
CREATE USER nesl_user WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE nesl_prod TO nesl_user;
```

### Flyway Migration (if using)
```bash
mvn flyway:migrate -Dflyway.configFiles=src/main/resources/application-production.properties
```

## Deployment Steps

### 1. Build the Application
```bash
mvn clean package -DskipTests
```

### 2. Create Production Keystore
Place your production keystore at `/path/to/production/keystore.p12`

### 3. Set Environment Variables
```bash
export SPRING_PROFILES_ACTIVE=production
export DB_USERNAME=nesl_user
export DB_PASSWORD=your_db_password
export SSL_KEYSTORE_PASSWORD=your_keystore_password
export SSL_KEY_ALIAS=tomcat
export JWT_SECRET_KEY=your_256_bit_secret_key_here
```

### 4. Run the Application
```bash
java -jar target/Spring_Demo-0.0.1-SNAPSHOT.jar
```

### 5. Verify Deployment
```bash
# Check health endpoint
curl -k https://localhost:8443/actuator/health

# Check application logs
tail -f /var/log/spring-demo/application.log
```

## API Usage Examples

### JWT Authentication
```bash
# Login and get JWT token
curl -k -X POST https://localhost:8443/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password"}'

# Use JWT token for API access
curl -k -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  https://localhost:8443/api/me
```

### Web Authentication
- Access `https://yourdomain.com/login` for web login
- Use form-based authentication with CSRF protection

## Monitoring

### Health Checks
```bash
# Application health
curl -k https://localhost:8443/actuator/health

# Metrics
curl -k https://localhost:8443/actuator/metrics

# Audit events
curl -k https://localhost:8443/actuator/auditevents
```

### Log Analysis
```bash
# View security events
grep "SECURITY_EVENT" /var/log/spring-demo/application.log

# View API access logs
grep "API_ACCESS" /var/log/spring-demo/application.log
```

## Security Best Practices

### 1. Certificate Management
- Rotate certificates annually
- Use strong cipher suites
- Keep private keys secure

### 2. Secret Management
- Use environment variables for secrets
- Consider using Spring Cloud Config or HashiCorp Vault
- Rotate JWT secrets regularly

### 3. Network Security
- Use firewall rules to restrict access
- Implement rate limiting at network level
- Use HTTPS termination at load balancer if applicable

### 4. Monitoring
- Set up alerts for security events
- Monitor failed login attempts
- Regular log analysis for anomalies

## Troubleshooting

### Common Issues

1. **SSL Handshake Errors**
   - Verify keystore path and password
   - Check certificate validity
   - Ensure correct cipher suites

2. **JWT Token Issues**
   - Verify JWT secret key length (256 bits minimum)
   - Check token expiration time
   - Validate token format

3. **Database Connection Issues**
   - Verify database credentials
   - Check connection pool settings
   - Ensure database is accessible

### Debug Mode
For troubleshooting, temporarily enable debug logging:
```bash
export JAVA_OPTS="-Dlogging.level.com.example=DEBUG -Dlogging.level.org.springframework.security=DEBUG"
```

## Performance Tuning

### JVM Settings
```bash
java -Xmx2g -Xms1g -XX:+UseG1GC -jar target/Spring_Demo-0.0.1-SNAPSHOT.jar
```

### Connection Pool Tuning
Adjust HikariCP settings in `application-production.properties` based on load testing results.

## Backup and Recovery

### Database Backup
```bash
pg_dump nesl_prod > nesl_prod_backup.sql
```

### Application Logs
- Logs are automatically rotated
- Archive old logs for compliance
- Monitor disk space usage

## Support

For issues or questions:
1. Check application logs
2. Review actuator endpoints
3. Consult Spring Boot documentation
4. Review security best practices

---

**Note**: This configuration provides a solid foundation for production deployment. Adjust settings based on your specific requirements and security policies.