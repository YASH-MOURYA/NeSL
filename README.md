# NeSL Spring Demo

A Spring Boot web application demonstrating JSP views, JDBC/H2 persistence, Spring Security, OAuth2 login, and JWT support.

## Project Structure

- `src/main/java` - application source code
- `src/main/resources` - Spring Boot configuration and templates
- `src/main/webapp/WEB-INF/jsp` - JSP views
- `src/test/java` - unit and integration tests

## Requirements

- Java 8
- Maven

## Build and Run

```bash
./mvnw clean package
./mvnw spring-boot:run
```

If you are on Windows:

```powershell
./mvnw.cmd clean package
./mvnw.cmd spring-boot:run
```

## Configuration

The base configuration is in `src/main/resources/application.properties`.

- H2 in-memory database for development
- `server.ssl.enabled=false` for local development
- `spring.profiles.active` is commented out to avoid forcing production mode

Production-specific configuration is in `src/main/resources/application-production.properties`.

## Notes

- `application-production.properties` contains production database, SSL, and logging settings.
- `logs/` and `.p12` files are excluded from Git in `.gitignore`.

## GitHub Publish

The project is committed locally. If you need to publish it to GitHub from this environment, ensure Git credentials are configured before pushing.
