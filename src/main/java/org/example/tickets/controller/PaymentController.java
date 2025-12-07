package org.example.tickets.controller;

import org.example.tickets.model.Ticket;
import org.example.tickets.request.PaymentRequest;
import org.example.tickets.request.TicketRequest;
import org.example.tickets.service.EmailService;
import org.example.tickets.service.PDFService;
import org.example.tickets.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/payment")
public class PaymentController {

    private final TicketService ticketService;
    private final PDFService pdfService;
    private final EmailService emailService;

    @Autowired
    public PaymentController(TicketService ticketService, PDFService pdfService, EmailService emailService) {
        this.ticketService = ticketService;
        this.pdfService = pdfService;
        this.emailService = emailService;
    }

    @PostMapping("/process")
    public ResponseEntity<?> processPayment(@RequestBody PaymentRequest paymentRequest) {
        try {
            // Валидация платежных данных (без сохранения)
            if (!validatePaymentData(paymentRequest)) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                        .body("Неверные платежные данные");
            }

            // Создаем билет
            TicketRequest ticketRequest = paymentRequest.getTicketRequest();
            Ticket ticket = ticketService.createTicket(
                    ticketRequest.getUserId(),
                    ticketRequest.getRouteId(),
                    ticketRequest.getSeatNumber(),
                    ticketRequest.getCarriageType()
            );

            // Отправляем билет на почту
            try {
                emailService.sendTicketEmail(ticket);
            } catch (Exception e) {
                // Логируем ошибку, но не прерываем процесс
                System.err.println("Ошибка при отправке билета на почту: " + e.getMessage());
            }

            // Возвращаем информацию о билете
            return ResponseEntity.ok(ticket);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Ошибка при обработке оплаты: " + e.getMessage());
        }
    }

    @GetMapping("/ticket/{ticketId}/pdf")
    public ResponseEntity<byte[]> downloadTicketPDF(@PathVariable Long ticketId) {
        try {
            Ticket ticket = ticketService.getTicketById(ticketId);
            byte[] pdfBytes = pdfService.generateTicketPDF(ticket);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData("attachment", "ticket_" + ticket.getPnrCode() + ".pdf");

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(pdfBytes);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    private boolean validatePaymentData(PaymentRequest request) {
        // Простая валидация (в реальном приложении здесь была бы проверка через платежный шлюз)
        if (request.getCardNumber() == null || request.getCardNumber().trim().isEmpty()) {
            return false;
        }
        if (request.getCardHolder() == null || request.getCardHolder().trim().isEmpty()) {
            return false;
        }
        if (request.getExpiryDate() == null || request.getExpiryDate().trim().isEmpty()) {
            return false;
        }
        if (request.getCvv() == null || request.getCvv().trim().isEmpty()) {
            return false;
        }
        
        // Базовая проверка формата номера карты (16 цифр)
        String cardNumber = request.getCardNumber().replaceAll("\\s", "");
        if (cardNumber.length() < 13 || cardNumber.length() > 19 || !cardNumber.matches("\\d+")) {
            return false;
        }
        
        // Проверка CVV (3-4 цифры)
        String cvv = request.getCvv().trim();
        if (cvv.length() < 3 || cvv.length() > 4 || !cvv.matches("\\d+")) {
            return false;
        }
        
        return true;
    }
}
