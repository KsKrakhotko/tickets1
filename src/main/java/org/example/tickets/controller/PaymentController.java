package org.example.tickets.controller;

import org.example.tickets.model.Ticket;
import org.example.tickets.request.TicketRequest;
import org.example.tickets.service.PdfService;
import org.example.tickets.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import com.lowagie.text.DocumentException;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.core.io.ByteArrayResource;

@RestController
@RequestMapping("/api/payment")
public class PaymentController {

    private final TicketService ticketService;
    private final PdfService pdfService;
    private final JavaMailSender javaMailSender;

    @Autowired
    public PaymentController(TicketService ticketService, PdfService pdfService, JavaMailSender javaMailSender) {
        this.ticketService = ticketService;
        this.pdfService = pdfService;
        this.javaMailSender = javaMailSender;
    }

    @PostMapping("/process")
    public ResponseEntity<?> processPayment(@RequestBody PaymentRequest paymentRequest) {
        try {
            // Эмуляция оплаты - просто проверяем, что данные заполнены
            if (paymentRequest.getCardNumber() == null || paymentRequest.getCardNumber().trim().isEmpty()) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Номер карты обязателен");
            }
            
            if (paymentRequest.getCardHolder() == null || paymentRequest.getCardHolder().trim().isEmpty()) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Имя держателя карты обязательно");
            }
            
            if (paymentRequest.getExpiryDate() == null || paymentRequest.getExpiryDate().trim().isEmpty()) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Срок действия карты обязателен");
            }
            
            if (paymentRequest.getCvv() == null || paymentRequest.getCvv().trim().isEmpty()) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "CVV код обязателен");
            }

            // Валидация номера карты (простая проверка формата)
            String cardNumber = paymentRequest.getCardNumber().replaceAll("\\s", "");
            if (cardNumber.length() < 13 || cardNumber.length() > 19 || !cardNumber.matches("\\d+")) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Неверный формат номера карты");
            }

            // Валидация CVV
            String cvv = paymentRequest.getCvv().trim();
            if (cvv.length() != 3 || !cvv.matches("\\d+")) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "CVV должен содержать 3 цифры");
            }

            // Эмуляция обработки платежа (всегда успешно, данные не сохраняются)
            // В реальном приложении здесь был бы вызов платежного шлюза
            
            // Создаем билет после успешной оплаты
            TicketRequest ticketRequest = new TicketRequest();
            ticketRequest.setUserId(paymentRequest.getUserId());
            ticketRequest.setRouteId(paymentRequest.getRouteId());
            ticketRequest.setSeatNumber(paymentRequest.getSeatNumber());
            ticketRequest.setCarriageType(paymentRequest.getCarriageType() != null ? 
                paymentRequest.getCarriageType() : "Стандарт");

            Ticket ticket;
            try {
                ticket = ticketService.createTicket(
                    ticketRequest.getUserId(),
                    ticketRequest.getRouteId(),
                    ticketRequest.getSeatNumber(),
                    ticketRequest.getCarriageType()
                );
            } catch (RuntimeException e) {
                // Обрабатываем ошибки создания билета (место занято, нет доступных мест и т.д.)
                String errorMessage = e.getMessage();
                if (errorMessage != null && errorMessage.contains("already occupied")) {
                    throw new ResponseStatusException(HttpStatus.CONFLICT, 
                        "Место " + paymentRequest.getSeatNumber() + " уже занято. Пожалуйста, выберите другое место.");
                } else if (errorMessage != null && errorMessage.contains("No available seats")) {
                    throw new ResponseStatusException(HttpStatus.CONFLICT, 
                        "На данном маршруте нет доступных мест.");
                } else if (errorMessage != null && errorMessage.contains("not found")) {
                    throw new ResponseStatusException(HttpStatus.NOT_FOUND, 
                        "Маршрут не найден.");
                } else {
                    throw new ResponseStatusException(HttpStatus.BAD_REQUEST, 
                        "Ошибка при создании билета: " + (errorMessage != null ? errorMessage : "Неизвестная ошибка"));
                }
            }
            
            System.out.println("Билет создан с ID: " + ticket.getId());
            System.out.println("Пользователь в билете: " + (ticket.getUser() != null ? ticket.getUser().getUsername() : "NULL"));
            
            // Перезагружаем билет с пользователем, чтобы убедиться, что все связи загружены
            // Это необходимо, так как после сохранения связи могут быть не загружены из-за lazy loading
            if (ticket.getId() != null) {
                ticket = ticketService.getTicketById(ticket.getId());
                System.out.println("Билет перезагружен. Пользователь: " + (ticket.getUser() != null ? ticket.getUser().getUsername() : "NULL"));
            }

            // Генерируем PDF билет
            byte[] pdfBytes;
            try {
                pdfBytes = pdfService.generateTicketPdf(ticket);
            } catch (DocumentException e) {
                throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, 
                    "Ошибка при генерации PDF: " + e.getMessage());
            }

            // Отправляем билет на email пользователя
            String userEmail = null;
            if (ticket.getUser() != null) {
                userEmail = ticket.getUser().getEmail();
                System.out.println("Пользователь найден: " + ticket.getUser().getUsername() + ", Email: " + userEmail);
            } else {
                System.out.println("ВНИМАНИЕ: Пользователь не найден в билете!");
            }
            
            boolean emailSent = false;
            String emailError = null;
            
            if (userEmail != null && !userEmail.trim().isEmpty()) {
                try {
                    System.out.println("Начинаем отправку email на адрес: " + userEmail);
                    sendTicketByEmail(ticket, pdfBytes, userEmail);
                    System.out.println("Email успешно отправлен на адрес: " + userEmail);
                    emailSent = true;
                } catch (org.springframework.mail.MailAuthenticationException e) {
                    // Ошибка аутентификации - проблема с настройками почты
                    emailError = "Ошибка аутентификации почтового сервера. Проверьте настройки SMTP в конфигурации.";
                    System.err.println("ОШИБКА АУТЕНТИФИКАЦИИ при отправке email на " + userEmail + ": " + e.getMessage());
                    e.printStackTrace();
                } catch (jakarta.mail.AuthenticationFailedException e) {
                    // Ошибка аутентификации Gmail
                    emailError = "Ошибка аутентификации Gmail. Проверьте пароль приложения в настройках.";
                    System.err.println("ОШИБКА АУТЕНТИФИКАЦИИ GMAIL при отправке email на " + userEmail + ": " + e.getMessage());
                    e.printStackTrace();
                } catch (jakarta.mail.MessagingException e) {
                    // Ошибка подключения к почтовому серверу
                    String errorMsg = e.getMessage();
                    Throwable cause = e.getCause();
                    
                    // Проверяем причину исключения
                    if (cause instanceof java.net.ConnectException || 
                        (errorMsg != null && errorMsg.contains("Connection timed out"))) {
                        emailError = "Не удалось подключиться к почтовому серверу. Проверьте интернет-соединение и настройки SMTP.";
                    } else if (errorMsg != null && errorMsg.contains("Couldn't connect to host")) {
                        emailError = "Не удалось подключиться к почтовому серверу. Возможно, порт заблокирован или сервер недоступен.";
                    } else {
                        emailError = "Ошибка подключения к почтовому серверу: " + (errorMsg != null ? errorMsg.split("\n")[0] : "Неизвестная ошибка");
                    }
                    System.err.println("ОШИБКА ПОДКЛЮЧЕНИЯ при отправке email на " + userEmail + ": " + e.getMessage());
                    e.printStackTrace();
                } catch (Exception e) {
                    // Другие ошибки
                    String errorMsg = e.getMessage();
                    if (errorMsg != null && errorMsg.contains("\n")) {
                        // Берем только первую строку, чтобы избежать переносов строк в заголовке
                        errorMsg = errorMsg.split("\n")[0];
                    }
                    emailError = "Ошибка при отправке email: " + (errorMsg != null ? errorMsg : "Неизвестная ошибка");
                    System.err.println("ОШИБКА при отправке email на " + userEmail + ": " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                System.out.println("ВНИМАНИЕ: Email пользователя не указан или пуст. Билет не будет отправлен по email.");
            }
            
            // Возвращаем PDF в ответе
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData("attachment", 
                "ticket_" + ticket.getPnrCode() + ".pdf");
            headers.setContentLength(pdfBytes.length);
            
            // Добавляем информацию об отправке email в заголовки
            if (emailSent) {
                headers.add("X-Email-Status", "sent");
                headers.add("X-Email-Address", userEmail);
            } else if (emailError != null) {
                headers.add("X-Email-Status", "failed");
                // Очищаем сообщение об ошибке от переносов строк и специальных символов для HTTP заголовка
                String cleanError = emailError.replaceAll("[\\r\\n]", " ").replaceAll("\\s+", " ").trim();
                // Ограничиваем длину, чтобы избежать проблем с заголовками
                if (cleanError.length() > 200) {
                    cleanError = cleanError.substring(0, 197) + "...";
                }
                headers.add("X-Email-Error", cleanError);
            } else {
                headers.add("X-Email-Status", "skipped");
            }

            return new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);

        } catch (ResponseStatusException e) {
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, 
                "Ошибка при обработке платежа: " + e.getMessage());
        }
    }

    // Внутренний класс для запроса оплаты
    public static class PaymentRequest {
        private Long userId;
        private Long routeId;
        private Integer seatNumber;
        private String carriageType;
        private String cardNumber;
        private String cardHolder;
        private String expiryDate;
        private String cvv;

        // Getters and Setters
        public Long getUserId() { return userId; }
        public void setUserId(Long userId) { this.userId = userId; }

        public Long getRouteId() { return routeId; }
        public void setRouteId(Long routeId) { this.routeId = routeId; }

        public Integer getSeatNumber() { return seatNumber; }
        public void setSeatNumber(Integer seatNumber) { this.seatNumber = seatNumber; }

        public String getCarriageType() { return carriageType; }
        public void setCarriageType(String carriageType) { this.carriageType = carriageType; }

        public String getCardNumber() { return cardNumber; }
        public void setCardNumber(String cardNumber) { this.cardNumber = cardNumber; }

        public String getCardHolder() { return cardHolder; }
        public void setCardHolder(String cardHolder) { this.cardHolder = cardHolder; }

        public String getExpiryDate() { return expiryDate; }
        public void setExpiryDate(String expiryDate) { this.expiryDate = expiryDate; }

        public String getCvv() { return cvv; }
        public void setCvv(String cvv) { this.cvv = cvv; }
    }

    /**
     * Отправляет билет на email пользователя
     */
    private void sendTicketByEmail(Ticket ticket, byte[] pdfBytes, String email) throws MessagingException {
        System.out.println("Создание MimeMessage для отправки на: " + email);
        MimeMessage message = javaMailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

        // Настройка письма
        helper.setTo(email);
        helper.setFrom("kkrahotko@gmail.com"); // Устанавливаем отправителя
        helper.setSubject("Ваш железнодорожный билет - PNR: " + ticket.getPnrCode());
        System.out.println("Тема письма установлена: Ваш железнодорожный билет - PNR: " + ticket.getPnrCode());
        
        // Формируем текст письма
        String routeInfo = ticket.getRoute().getDepartureStation().getName() + " → " + 
                          ticket.getRoute().getArrivalStation().getName();
        String departureTime = ticket.getRoute().getDepartureTime().format(
            java.time.format.DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm"));
        
        String emailText = "<html><body style='font-family: Arial, sans-serif;'>" +
            "<h2 style='color: #8A2BE2;'>Спасибо за покупку!</h2>" +
            "<p>Ваш билет успешно оформлен.</p>" +
            "<div style='background-color: #f5f5f5; padding: 15px; border-radius: 5px; margin: 20px 0;'>" +
            "<p><strong>PNR код:</strong> " + ticket.getPnrCode() + "</p>" +
            "<p><strong>Маршрут:</strong> " + routeInfo + "</p>" +
            "<p><strong>Дата и время отправления:</strong> " + departureTime + "</p>" +
            "<p><strong>Место:</strong> " + (ticket.getSeatNumber() != null ? ticket.getSeatNumber() : "Не указано") + "</p>" +
            "<p><strong>Цена:</strong> " + (ticket.getPrice() != null ? ticket.getPrice() + " BYN" : "0 BYN") + "</p>" +
            "</div>" +
            "<p>Ваш билет в формате PDF прикреплен к этому письму.</p>" +
            "<p>При посадке предъявите данный билет и документ, удостоверяющий личность.</p>" +
            "<p style='color: #666; font-size: 12px; margin-top: 30px;'>С уважением,<br>Служба железнодорожных перевозок</p>" +
            "</body></html>";

        helper.setText(emailText, true); // true означает HTML

        // Прикрепляем PDF файл
        System.out.println("Прикрепление PDF файла размером: " + pdfBytes.length + " байт");
        helper.addAttachment("ticket_" + ticket.getPnrCode() + ".pdf", 
            new ByteArrayResource(pdfBytes),
            "application/pdf");

        // Отправляем письмо
        System.out.println("Отправка письма через JavaMailSender...");
        javaMailSender.send(message);
        System.out.println("Письмо успешно отправлено на адрес: " + email);
    }
}

