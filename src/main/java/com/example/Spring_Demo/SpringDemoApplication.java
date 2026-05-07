package com.example.Spring_Demo;

import com.example.Spring_Demo.repository.UserRepository;
import com.example.Spring_Demo.security.JwtProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootApplication
@EnableConfigurationProperties(JwtProperties.class)
public class SpringDemoApplication implements CommandLineRunner {

	@Autowired
	private UserRepository userRepository;

	@Autowired(required = false)
	private PasswordEncoder passwordEncoder;

	public static void main(String[] args) {
		SpringApplication.run(SpringDemoApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		// Only encode passwords if PasswordEncoder is available (i.e., not in @DataJpaTest context)
		if (passwordEncoder != null) {
			userRepository.findAll().forEach(user -> {
				if (!user.getPassword().startsWith("$2a$")) { // Check if not already encoded
					user.setPassword(passwordEncoder.encode(user.getPassword()));
					userRepository.save(user);
				}
			});
		}
	}
}
