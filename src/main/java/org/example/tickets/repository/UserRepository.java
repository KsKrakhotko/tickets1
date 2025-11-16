package org.example.tickets.repository;

import org.example.tickets.model.Role;
import org.example.tickets.model.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findUserByUsername(String username);
    Boolean existsByUsername(String username);
    Boolean existsByEmail(String email);
    Optional<String> findEmailById(Long id);
    Page<User> findByUsernameContainingIgnoreCaseAndEmailContainingIgnoreCaseAndRole(String username, String email, Role role, Pageable pageable);
    Page<User> findByUsernameContainingIgnoreCaseAndEmailContainingIgnoreCase(String username, String email, Pageable pageable);
    Optional<User> findById(Long id);
}

