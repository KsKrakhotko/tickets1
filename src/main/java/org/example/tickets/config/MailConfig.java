package org.example.tickets.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@Configuration
public class MailConfig {

    @Value("${spring.mail.host:smtp.gmail.com}")
    private String host;

    @Value("${spring.mail.port:587}")
    private int port;

    @Value("${spring.mail.username:}")
    private String username;

    @Value("${spring.mail.password:}")
    private String password;

    @Bean
    public JavaMailSender getJavaMailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost(host);
        mailSender.setPort(port);

        mailSender.setUsername(username);
        mailSender.setPassword(password);

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.smtp.starttls.enable", "true");  // Включаем поддержку STARTTLS
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2"); // Устанавливаем версии TLS для безопасности
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com"); // Доверяем сертификату Gmail
        props.put("mail.debug", "false"); // Отключить отладочный вывод (можно включить для диагностики)
        
        // Настройки таймаутов для подключения
        props.put("mail.smtp.connectiontimeout", "10000"); // 10 секунд на подключение
        props.put("mail.smtp.timeout", "10000"); // 10 секунд на операции чтения/записи
        props.put("mail.smtp.writetimeout", "10000"); // 10 секунд на запись
        
        // Альтернативные настройки для надежности
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.checkserveridentity", "true");

        return mailSender;
    }
}