package org.example.tickets.service;

import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import org.example.tickets.model.Ticket;
import org.springframework.stereotype.Service;

import java.awt.Color;
import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;

@Service
public class PdfService {

    private static final Font TITLE_FONT = new Font(Font.HELVETICA, 18, Font.BOLD);
    private static final Font HEADER_FONT = new Font(Font.HELVETICA, 12, Font.BOLD);
    private static final Font NORMAL_FONT = new Font(Font.HELVETICA, 10, Font.NORMAL);
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd.MM.yyyy");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");

    public byte[] generateTicketPdf(Ticket ticket) throws DocumentException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, baos);
        document.open();

        // Заголовок
        Paragraph title = new Paragraph("ЖЕЛЕЗНОДОРОЖНЫЙ БИЛЕТ", TITLE_FONT);
        title.setAlignment(Element.ALIGN_CENTER);
        title.setSpacingAfter(20);
        document.add(title);

        // PNR код
        Paragraph pnr = new Paragraph("PNR: " + ticket.getPnrCode(), HEADER_FONT);
        pnr.setAlignment(Element.ALIGN_CENTER);
        pnr.setSpacingAfter(15);
        document.add(pnr);

        // Информация о маршруте
        PdfPTable routeTable = new PdfPTable(2);
        routeTable.setWidthPercentage(100);
        routeTable.setSpacingBefore(10);
        routeTable.setSpacingAfter(10);

        addTableRow(routeTable, "Маршрут:", 
            ticket.getRoute().getDepartureStation().getName() + " → " + 
            ticket.getRoute().getArrivalStation().getName());
        
        addTableRow(routeTable, "Поезд:", 
            ticket.getRoute().getTrain().getTrainNumber() + " (" + 
            ticket.getRoute().getTrain().getTrainName() + ")");
        
        addTableRow(routeTable, "Дата отправления:", 
            ticket.getRoute().getDepartureTime().format(DATE_FORMATTER));
        
        addTableRow(routeTable, "Время отправления:", 
            ticket.getRoute().getDepartureTime().format(TIME_FORMATTER));
        
        addTableRow(routeTable, "Время прибытия:", 
            ticket.getRoute().getArrivalTime().format(TIME_FORMATTER));
        
        addTableRow(routeTable, "Место:", 
            ticket.getSeatNumber() != null ? ticket.getSeatNumber().toString() : "Не указано");
        
        addTableRow(routeTable, "Тип вагона:", 
            ticket.getCarriageType() != null ? ticket.getCarriageType() : "Стандарт");
        
        addTableRow(routeTable, "Цена:", 
            ticket.getPrice() != null ? ticket.getPrice() + " BYN" : "0 BYN");

        document.add(routeTable);

        // Информация о пассажире
        if (ticket.getUser() != null) {
            Paragraph passengerTitle = new Paragraph("Информация о пассажире", HEADER_FONT);
            passengerTitle.setSpacingBefore(15);
            passengerTitle.setSpacingAfter(10);
            document.add(passengerTitle);

            PdfPTable passengerTable = new PdfPTable(2);
            passengerTable.setWidthPercentage(100);
            passengerTable.setSpacingAfter(10);

            addTableRow(passengerTable, "Имя пользователя:", 
                ticket.getUser().getUsername() != null ? ticket.getUser().getUsername() : "Не указано");
            
            if (ticket.getUser().getEmail() != null) {
                addTableRow(passengerTable, "Email:", ticket.getUser().getEmail());
            }

            document.add(passengerTable);
        }

        // Дата покупки
        Paragraph purchaseDate = new Paragraph(
            "Дата покупки: " + ticket.getPurchaseTime().format(DATE_FORMATTER) + " " + 
            ticket.getPurchaseTime().format(TIME_FORMATTER), 
            NORMAL_FONT);
        purchaseDate.setSpacingBefore(15);
        purchaseDate.setAlignment(Element.ALIGN_CENTER);
        document.add(purchaseDate);

        // Статус
        Paragraph status = new Paragraph(
            "Статус: " + (ticket.getStatus() != null ? ticket.getStatus() : "Активен"), 
            NORMAL_FONT);
        status.setAlignment(Element.ALIGN_CENTER);
        status.setSpacingAfter(20);
        document.add(status);

        // Примечание
        Paragraph note = new Paragraph(
            "При посадке предъявите данный билет и документ, удостоверяющий личность.", 
            new Font(Font.HELVETICA, 9, Font.ITALIC));
        note.setAlignment(Element.ALIGN_CENTER);
        note.setSpacingBefore(20);
        document.add(note);

        document.close();
        return baos.toByteArray();
    }

    private void addTableRow(PdfPTable table, String label, String value) {
        PdfPCell labelCell = new PdfPCell(new Phrase(label, HEADER_FONT));
        labelCell.setPadding(8);
        labelCell.setBackgroundColor(new Color(230, 230, 230));
        
        PdfPCell valueCell = new PdfPCell(new Phrase(value != null ? value : "Не указано", NORMAL_FONT));
        valueCell.setPadding(8);
        
        table.addCell(labelCell);
        table.addCell(valueCell);
    }
}
