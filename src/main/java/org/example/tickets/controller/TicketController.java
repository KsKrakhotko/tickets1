package org.example.tickets.controller;


import org.example.tickets.model.Ticket;
import org.example.tickets.request.TicketRequest;
import org.example.tickets.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/tickets")
public class TicketController {

    private final TicketService ticketService;

    @Autowired
    public TicketController(TicketService ticketService) {
        this.ticketService = ticketService;
    }

    @PostMapping
    public Ticket createTicket(@RequestBody TicketRequest request) {
        return ticketService.createTicket(
                request.getUserId(),
                request.getRouteId(),
                request.getSeatNumber(),
                request.getCarriageType()
        );
    }

    @GetMapping
    public List<Ticket> getAllTickets() {
        return ticketService.getAllTickets();
    }

    @GetMapping("/user/{userId}")
    public List<Ticket> getUserTickets(@PathVariable Long userId) {
        return ticketService.getTicketsByUserId(userId);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteTicket(@PathVariable Long id) {
        try {
            ticketService.deleteTicket(id);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Ticket not found", e);
        }
    }

    @GetMapping("/today/count")
    public int getTodayTicketsCount() {
        return ticketService.getTodayTicketsCount();
    }

    @GetMapping("/revenue/today")
    public Double getTodayRevenue() {
        return ticketService.getTodayRevenue();
    }

    @GetMapping("/active/count")
    public int getActiveTicketsCount() {
        return ticketService.getActiveTicketsCount();
    }

    @PatchMapping("/{id}/status")
    public ResponseEntity<Ticket> updateTicketStatus(
            @PathVariable Long id,
            @RequestBody String newStatus) {
        try {
            // Убираем кавычки, если они есть (JSON строка может быть обернута в кавычки)
            String status = newStatus.replaceAll("^\"|\"$", "");
            Ticket updatedTicket = ticketService.updateTicketStatus(id, status);
            return ResponseEntity.ok(updatedTicket);
        } catch (IllegalArgumentException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, 
                "Ошибка при обновлении статуса билета: " + e.getMessage());
        }
    }
}