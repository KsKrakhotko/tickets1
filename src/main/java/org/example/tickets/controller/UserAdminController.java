package org.example.tickets.controller;

import org.example.tickets.service.UserService;
import org.example.tickets.model.Role;
import org.example.tickets.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/admin/clients")
public class UserAdminController {

    @Autowired
    private UserService userService;

    @GetMapping("/list")
    public Page<User> getClientList(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size,
            @RequestParam(defaultValue = "") String name,
            @RequestParam(defaultValue = "") String email,
            @RequestParam(required = false) String role
    ) {
        Pageable pageable = PageRequest.of(page, size, Sort.by("id").descending());
        return userService.getUsersWithFilters(name, email, role, pageable);
    }

    @PostMapping("/change-role")
    public ResponseEntity<?> changeRole(@RequestBody Map<String, String> payload) {
        try {
            Long clientId = Long.valueOf(payload.get("clientId"));
            Role newRole = Role.valueOf(payload.get("newRole"));
            userService.updateUserRole(clientId, newRole);
            return ResponseEntity.ok("Роль обновлена");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Ошибка: " + e.getMessage());
        }
    }

    @GetMapping("/dashboard")
    public ResponseEntity<Map<String, Long>> getDashboard() {
        long totalUsers = userService.getTotalUsers(); // Получаем общее количество пользователей
        Map<String, Long> response = Map.of("totalUsers", totalUsers); // Строим карту с данными
        return ResponseEntity.ok(response); // Возвращаем ответ в формате JSON
    }
}

