package org.example.tickets.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.example.tickets.model.Ticket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.time.format.DateTimeFormatter;

@Service
public class EmailService {

    private final JavaMailSender mailSender;
    private final PdfService pdfService;
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");

    @Autowired
    public EmailService(JavaMailSender mailSender, PdfService pdfService) {
        this.mailSender = mailSender;
        this.pdfService = pdfService;
    }

    public void sendTicketEmail(Ticket ticket) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            String userEmail = ticket.getUser().getEmail();
            if (userEmail == null || userEmail.trim().isEmpty()) {
                throw new RuntimeException("Email пользователя не указан");
            }

            helper.setTo(userEmail);
            helper.setSubject("Ваш железнодорожный билет - PNR: " + ticket.getPnrCode());

            // Формируем текст письма
            String emailText = buildEmailText(ticket);
            helper.setText(emailText, true);

            // Прикрепляем PDF билета
            byte[] pdfBytes = pdfService.generateTicketPdf(ticket);
            helper.addAttachment("ticket_" + ticket.getPnrCode() + ".pdf", 
                    new ByteArrayResource(pdfBytes), 
                    "application/pdf");

            mailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("Ошибка при отправке билета на почту: " + e.getMessage(), e);
        }
    }

    private String buildEmailText(Ticket ticket) {
        StringBuilder text = new StringBuilder();
        text.append("<html><body style='font-family: Arial, sans-serif;'>");
        text.append("<div style='max-width: 600px; margin: 0 auto; padding: 20px;'>");
        
        text.append("<h2 style='color: #8A2BE2;'>Спасибо за покупку!</h2>");
        text.append("<p>Ваш билет успешно оформлен.</p>");
        
        text.append("<div style='background-color: #f8f8ff; padding: 15px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #8A2BE2;'>");
        text.append("<p><strong>PNR код:</strong> ").append(ticket.getPnrCode()).append("</p>");
        
        if (ticket.getRoute() != null && ticket.getRoute().getDepartureStation() != null && 
            ticket.getRoute().getArrivalStation() != null) {
            text.append("<p><strong>Маршрут:</strong> ")
                .append(ticket.getRoute().getDepartureStation().getName())
                .append(" → ")
                .append(ticket.getRoute().getArrivalStation().getName())
                .append("</p>");
        }
        
        if (ticket.getRoute() != null && ticket.getRoute().getDepartureTime() != null) {
            text.append("<p><strong>Отправление:</strong> ")
                .append(ticket.getRoute().getDepartureTime().format(DATE_TIME_FORMATTER))
                .append("</p>");
        }
        
        if (ticket.getSeatNumber() != null) {
            text.append("<p><strong>Место:</strong> ")
                .append(ticket.getCarriageType())
                .append(", №")
                .append(ticket.getSeatNumber())
                .append("</p>");
        }
        
        if (ticket.getPrice() != null) {
            text.append("<p><strong>Цена:</strong> ").append(ticket.getPrice()).append(" BYN</p>");
        }
        
        text.append("</div>");
        
        text.append("<p>Ваш билет прикреплен к этому письму в формате PDF.</p>");
        text.append("<p>При посадке предъявите данный билет и документ, удостоверяющий личность.</p>");
        
        text.append("<p style='margin-top: 30px; color: #666; font-size: 12px;'>С уважением,<br>ЖД-Портал</p>");
        text.append("</div></body></html>");
        
        return text.toString();
    }
}


