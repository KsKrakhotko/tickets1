package org.example.tickets.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;


@RestController
@RequestMapping("/contact")
public class ContactController {

    @Autowired
    private JavaMailSender javaMailSender;

    @PostMapping("/send")
    public ResponseEntity<String> sendEmail(@RequestParam String name,
                                            @RequestParam String email,
                                            @RequestParam String message) {
        System.out.println("Получен запрос: name=" + name + ", email=" + email + ", message=" + message);

        try {
            MimeMessage mimeMessage = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false);

            helper.setTo("kkrahotko@gmail.com");
            helper.setSubject("Новое сообщение от " + name);
            helper.setText("От: " + name + "\nEmail: " + email + "\nСообщение: " + message);

            javaMailSender.send(mimeMessage);
            return ResponseEntity.ok("Сообщение отправлено!");
        } catch (MessagingException e) {
            return ResponseEntity.badRequest().body("Ошибка: " + e.getMessage());
        }
    }


}

