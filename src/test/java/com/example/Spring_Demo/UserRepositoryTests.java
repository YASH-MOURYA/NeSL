package com.example.Spring_Demo;

import com.example.Spring_Demo.model.UserAccount;
import com.example.Spring_Demo.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.TestPropertySource;

import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@ActiveProfiles("test")
@TestPropertySource(locations = "classpath:application-test.properties")
class UserRepositoryTests {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private TestEntityManager entityManager;

    @Test
    void shouldLoadInitialUsersFromH2() {
        // Verify that initial data is loaded from test-data.sql
        long count = userRepository.count();
        assertThat(count).isGreaterThanOrEqualTo(6);

        // Test finding a specific user
        UserAccount user = userRepository.findByUserIdAndPasswordAndRole("entity1", "entity123", "ENTITY")
                .orElseThrow(() -> new IllegalStateException("Expected entity1 to exist"));
        assertThat(user.getEmail()).isEqualTo("entity1@example.com");
        assertThat(user.getName()).isEqualTo("Entity One");
    }

    @Test
    void shouldFindUserByUserIdOnly() {
        UserAccount user = userRepository.findByUserId("entity1")
                .orElseThrow(() -> new IllegalStateException("Expected entity1 to exist"));
        assertThat(user.getName()).isEqualTo("Entity One");
        assertThat(user.getRole()).isEqualTo("ENTITY");
    }

    @Test
    void shouldSaveAndRetrieveNewUser() {
        UserAccount created = new UserAccount();
        created.setName("Test User");
        created.setUserId("testuser");
        created.setEmail("testuser@example.com");
        created.setRole("INDIVIDUAL");
        created.setUin("ABCDE1234P");
        created.setPassword("test123");

        UserAccount saved = userRepository.save(created);
        entityManager.flush();

        assertThat(saved.getId()).isNotNull();

        UserAccount found = userRepository.findByUserIdAndPasswordAndRole("testuser", "test123", "INDIVIDUAL")
                .orElseThrow(() -> new IllegalStateException("Expected testuser to exist"));
        assertThat(found.getEmail()).isEqualTo("testuser@example.com");
    }

    @Test
    void shouldFindUserByUserIdAndRole() {
        UserAccount user = userRepository.findByUserIdAndPasswordAndRole("irp1", "irp123", "IRP")
                .orElseThrow(() -> new IllegalStateException("Expected irp1 to exist"));
        assertThat(user.getEmail()).isEqualTo("irp1@example.com");
    }

    @Test
    void shouldReturnEmptyWhenUserNotFound() {
        Optional<UserAccount> user = userRepository.findByUserIdAndPasswordAndRole("nonexistent", "wrong", "ENTITY");
        assertThat(user).isEmpty();
    }

    @Test
    void shouldUpdateUserDetails() {
        UserAccount userAccount = userRepository.findByUserId("entity1")
                .orElseThrow(() -> new IllegalStateException("Expected entity1 to exist"));
        userAccount.setEmail("newemail@example.com");
        userRepository.save(userAccount);
        entityManager.flush();

        Optional<UserAccount> updated = userRepository.findByUserId("entity1");
        assertThat(updated).isPresent();
        assertThat(updated.get().getEmail()).isEqualTo("newemail@example.com");
    }

    @Test
    void shouldDeleteUser() {
        Optional<UserAccount> user = userRepository.findByUserId("entity1");
        assertThat(user).isPresent();

        userRepository.delete(user.get());
        entityManager.flush();

        Optional<UserAccount> deleted = userRepository.findByUserId("entity1");
        assertThat(deleted).isEmpty();
    }
}
