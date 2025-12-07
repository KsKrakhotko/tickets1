package org.example.tickets.controller;

import org.example.tickets.model.Info;
import org.example.tickets.model.User;
import org.example.tickets.repository.InfoRepository;
import org.example.tickets.repository.UserRepository;
import org.example.tickets.service.UserService;
import org.example.tickets.util.JwtCore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class ProfileController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository; // Репозиторий для User
    @Autowired
    private InfoRepository infoRepository; // Репозиторий для Info

    @Autowired
    private JwtCore jwtCore;

    @GetMapping("/profile")
    public ResponseEntity<?> getUserProfile(@RequestHeader("Authorization") String token) {
        if (token == null || !token.startsWith("Bearer ")) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Ошибка: Токен не передан или имеет неверный формат");
        }

        try {
            String jwt = token.substring(7);
            String username = jwtCore.extractUsername(jwt);
            String email = jwtCore.extractEmail(jwt);

            if (username == null || email == null) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Ошибка: Невозможно извлечь данные из токена");
            }

            User user = userService.findUserByUsername(username);
            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Ошибка: Пользователь не найден");
            }

            // Создаём ответ с данными из токена
            Map<String, Object> response = new HashMap<>();
            response.put("username", username);
            response.put("email", email);

            // Добавляем информацию из таблицы info, если она есть
            Info userInfo = infoRepository.findByUserId(user.getId());
            if (userInfo != null) {
                response.put("fullName", userInfo.getFullName());
                response.put("phoneNumber", userInfo.getPhoneNumber());
            } else {
                // Если информации нет - возвращаем null или пустые строки
                response.put("fullName", null);
                response.put("phoneNumber", null);
            }

            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Ошибка сервера: " + e.getMessage());
        }
    }

    @PostMapping("/profileUpdate")
    public ResponseEntity<?> updateUserInfo(@RequestHeader("Authorization") String token, @RequestBody Info updatedInfo) {
        try {
            String jwt = token.substring(7);
            String username = jwtCore.extractUsername(jwt);

            User user = userService.findUserByUsername(username);
            if (user == null) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Пользователь не найден");
            }

            Info info = infoRepository.findByUserId(user.getId());

            // Если информации нет - создаем новую запись
            if (info == null) {
                info = new Info();
                info.setUser(user); // Устанавливаем связь с пользователем
            }

            // Обновляем данные
            info.setFullName(updatedInfo.getFullName());
            info.setPhoneNumber(updatedInfo.getPhoneNumber());

            Info savedInfo = infoRepository.save(info);
            return ResponseEntity.ok(savedInfo);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Ошибка сервера: " + e.getMessage());
        }
    }

}

