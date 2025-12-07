package org.example.tickets.service;

import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.borders.SolidBorder;
import com.itextpdf.layout.element.Div;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import com.itextpdf.layout.properties.VerticalAlignment;
import org.example.tickets.model.Ticket;
import org.example.tickets.model.Route;
import org.example.tickets.model.User;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;

@Service
public class PDFService {

    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm");
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd.MM.yyyy");
    private static final DeviceRgb PURPLE_COLOR = new DeviceRgb(138, 43, 226);
    private static final DeviceRgb DARK_GRAY = new DeviceRgb(64, 64, 64);
    private static final DeviceRgb LIGHT_GRAY = new DeviceRgb(240, 240, 240);

    public byte[] generateTicketPDF(Ticket ticket) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        
        try {
            PdfWriter writer = new PdfWriter(baos);
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf);
            document.setMargins(30, 30, 30, 30);

            User user = ticket.getUser();
            Route route = ticket.getRoute();

            // Основной контейнер билета
            Div ticketContainer = new Div()
                    .setBorder(new SolidBorder(DARK_GRAY, 2))
                    .setPadding(25)
                    .setMarginBottom(10);

            // Заголовок с логотипом и названием
            Div header = new Div()
                    .setMarginBottom(20)
                    .setTextAlignment(TextAlignment.CENTER);
            
            Paragraph companyName = new Paragraph("ЖД-ПОРТАЛ")
                    .setFontSize(22)
                    .setBold()
                    .setFontColor(PURPLE_COLOR)
                    .setMarginBottom(5);
            header.add(companyName);
            
            Paragraph ticketType = new Paragraph("ЖЕЛЕЗНОДОРОЖНЫЙ БИЛЕТ")
                    .setFontSize(16)
                    .setBold()
                    .setFontColor(DARK_GRAY)
                    .setMarginBottom(10);
            header.add(ticketType);
            
            Paragraph pnr = new Paragraph("PNR: " + ticket.getPnrCode())
                    .setFontSize(12)
                    .setBold()
                    .setFontColor(new DeviceRgb(100, 100, 100));
            header.add(pnr);
            
            ticketContainer.add(header);

            // Горизонтальная линия
            Div separator = new Div()
                    .setBorder(new SolidBorder(DARK_GRAY, 1))
                    .setMarginBottom(20);
            ticketContainer.add(separator);

            // Основная информация о маршруте
            Table mainInfoTable = new Table(UnitValue.createPercentArray(new float[]{1f, 0.1f, 1f}))
                    .setWidth(UnitValue.createPercentValue(100))
                    .setMarginBottom(20);

            // Левая колонка - Отправление
            Cell departureCell = createStationCell(
                    "ОТПРАВЛЕНИЕ",
                    route.getDepartureStation().getCity(),
                    route.getDepartureStation().getName(),
                    route.getDepartureTime(),
                    true
            );
            mainInfoTable.addCell(departureCell);

            // Стрелка
            Cell arrowCell = new Cell()
                    .add(new Paragraph("→")
                            .setFontSize(28)
                            .setBold()
                            .setFontColor(PURPLE_COLOR))
                    .setTextAlignment(TextAlignment.CENTER)
                    .setVerticalAlignment(VerticalAlignment.MIDDLE)
                    .setBorder(null)
                    .setPadding(5);
            mainInfoTable.addCell(arrowCell);

            // Правая колонка - Прибытие
            Cell arrivalCell = createStationCell(
                    "ПРИБЫТИЕ",
                    route.getArrivalStation().getCity(),
                    route.getArrivalStation().getName(),
                    route.getArrivalTime(),
                    false
            );
            mainInfoTable.addCell(arrivalCell);

            ticketContainer.add(mainInfoTable);

            // Детальная информация в таблице
            Table detailsTable = new Table(UnitValue.createPercentArray(new float[]{1f, 1f}))
                    .setWidth(UnitValue.createPercentValue(100))
                    .setMarginTop(15)
                    .setBorder(new SolidBorder(DARK_GRAY, 1));

            // Пассажир
            addDetailRow(detailsTable, "ПАССАЖИР", user.getUsername());
            
            // Поезд
            String trainNumber = route.getTrain().getTrainNumber() != null && !route.getTrain().getTrainNumber().isEmpty() ? 
                    route.getTrain().getTrainNumber() : "№" + route.getTrain().getId();
            String trainName = route.getTrain().getTrainName() != null && !route.getTrain().getTrainName().isEmpty() ? 
                    " - " + route.getTrain().getTrainName() : "";
            addDetailRow(detailsTable, "ПОЕЗД", trainNumber + trainName);
            
            // Вагон и место
            addDetailRow(detailsTable, "ВАГОН", ticket.getCarriageType());
            addDetailRow(detailsTable, "МЕСТО", "№" + ticket.getSeatNumber());
            
            // Цена
            addDetailRow(detailsTable, "ЦЕНА", ticket.getPrice() + " BYN");
            
            // Дата покупки
            addDetailRow(detailsTable, "ДАТА ПОКУПКИ", ticket.getPurchaseTime().format(DATE_TIME_FORMATTER));
            
            // Статус
            String statusText = ticket.getStatus().equals("active") ? "АКТИВЕН" : ticket.getStatus().toUpperCase();
            addDetailRow(detailsTable, "СТАТУС", statusText);

            ticketContainer.add(detailsTable);

            // Примечание внизу
            Div footer = new Div()
                    .setMarginTop(20)
                    .setPadding(10)
                    .setBackgroundColor(LIGHT_GRAY)
                    .setBorder(new SolidBorder(DARK_GRAY, 0.5f));
            
            Paragraph note = new Paragraph("При посадке предъявите данный билет и документ, удостоверяющий личность.")
                    .setFontSize(9)
                    .setTextAlignment(TextAlignment.CENTER)
                    .setFontColor(DARK_GRAY);
            footer.add(note);
            
            ticketContainer.add(footer);

            document.add(ticketContainer);
            document.close();
            
            return baos.toByteArray();
        } catch (Exception e) {
            throw new RuntimeException("Ошибка при генерации PDF билета", e);
        }
    }

    private Cell createStationCell(String label, String city, String stationName, 
                                   java.time.LocalDateTime dateTime, boolean isDeparture) {
        Cell cell = new Cell()
                .setPadding(15)
                .setTextAlignment(TextAlignment.CENTER)
                .setVerticalAlignment(VerticalAlignment.MIDDLE);
        
        if (isDeparture) {
            cell.setBorderRight(new SolidBorder(DARK_GRAY, 1));
        }
        
        // Метка (ОТПРАВЛЕНИЕ/ПРИБЫТИЕ)
        Paragraph labelPara = new Paragraph(label)
                .setFontSize(9)
                .setBold()
                .setFontColor(new DeviceRgb(100, 100, 100))
                .setMarginBottom(8);
        cell.add(labelPara);
        
        // Город
        if (city != null && !city.isEmpty()) {
            Paragraph cityPara = new Paragraph(city.toUpperCase())
                    .setFontSize(14)
                    .setBold()
                    .setFontColor(DARK_GRAY)
                    .setMarginBottom(5);
            cell.add(cityPara);
        }
        
        // Название станции
        Paragraph stationPara = new Paragraph(stationName)
                .setFontSize(11)
                .setFontColor(new DeviceRgb(80, 80, 80))
                .setMarginBottom(10);
        cell.add(stationPara);
        
        // Дата
        Paragraph datePara = new Paragraph(dateTime.format(DATE_FORMATTER))
                .setFontSize(10)
                .setFontColor(new DeviceRgb(100, 100, 100))
                .setMarginBottom(5);
        cell.add(datePara);
        
        // Время
        Paragraph timePara = new Paragraph(dateTime.format(TIME_FORMATTER))
                .setFontSize(20)
                .setBold()
                .setFontColor(PURPLE_COLOR);
        cell.add(timePara);
        
        return cell;
    }

    private void addDetailRow(Table table, String label, String value) {
        Cell labelCell = new Cell()
                .add(new Paragraph(label)
                        .setFontSize(10)
                        .setBold()
                        .setFontColor(DARK_GRAY))
                .setPadding(10)
                .setBorder(new SolidBorder(DARK_GRAY, 0.5f))
                .setBackgroundColor(LIGHT_GRAY)
                .setTextAlignment(TextAlignment.LEFT);
        
        Cell valueCell = new Cell()
                .add(new Paragraph(value != null ? value : "")
                        .setFontSize(11)
                        .setFontColor(DARK_GRAY))
                .setPadding(10)
                .setBorder(new SolidBorder(DARK_GRAY, 0.5f))
                .setTextAlignment(TextAlignment.LEFT);
        
        table.addCell(labelCell);
        table.addCell(valueCell);
    }
}
