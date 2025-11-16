package org.example.tickets.service;

import org.example.tickets.impl.UserdetailsImpl;
import org.example.tickets.model.Role;
import org.example.tickets.model.User;
import org.example.tickets.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService implements UserDetailsService {

    private UserRepository userRepository;

    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findUserByUsername(username).orElseThrow(() -> new UsernameNotFoundException(
                String.format("User %s not found", username)
        ));
        return UserdetailsImpl.build(user);
    }

    public Optional<String> getEmailById(Long id) {
        return userRepository.findEmailById(id);
    }

    public User findUserByUsername(String username) {
        return userRepository.findUserByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));
    }
    public Page<User> getUsersWithFilters(String username, String email, String roleStr, Pageable pageable) {
        if (roleStr != null && !roleStr.isEmpty()) {
            Role role = Role.valueOf(roleStr);
            return userRepository.findByUsernameContainingIgnoreCaseAndEmailContainingIgnoreCaseAndRole(username, email, role, pageable);
        } else {
            return userRepository.findByUsernameContainingIgnoreCaseAndEmailContainingIgnoreCase(username, email, pageable);
        }
    }

    public void updateUserRole(Long userId, Role newRole) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + userId));
        user.setRole(newRole);
        userRepository.save(user);
    }

    public long getTotalUsers() {
        return userRepository.count(); // Предположим, что у вас есть репозиторий userRepository
    }

    public User getUserById(Long id) {
        return userRepository.findById(id)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with id: " + id));
    }
}

