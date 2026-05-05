package com.example.Spring_Demo.repository;

import com.example.Spring_Demo.model.UserAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<UserAccount, Integer> {
    Optional<UserAccount> findByUserIdAndPasswordAndRole(String userId, String password, String role);
    Optional<UserAccount> findByUserId(String userId);
}
