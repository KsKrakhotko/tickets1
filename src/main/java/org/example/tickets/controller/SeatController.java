package org.example.tickets.controller;

import org.example.tickets.model.Route;
import org.example.tickets.service.RouteService;
import org.example.tickets.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/seats")
public class SeatController {

    private final RouteService routeService;
    private final TicketService ticketService;

    @Autowired
    public SeatController(RouteService routeService, TicketService ticketService) {
        this.routeService = routeService;
        this.ticketService = ticketService;
    }

    /**
     * Получение карты мест для маршрута
     * GET /api/seats/route/{routeId}
     */
    @GetMapping("/route/{routeId}")
    public ResponseEntity<Map<String, Object>> getSeatMap(@PathVariable Long routeId) {
        try {
            Route route = routeService.getRouteById(routeId);
            
            // Получаем список занятых мест
            List<Integer> occupiedSeats = ticketService.getOccupiedSeatsByRoute(routeId);
            
            // Создаем карту мест
            Map<String, Object> seatMap = new HashMap<>();
            seatMap.put("routeId", routeId);
            seatMap.put("totalSeats", route.getTotalSeats() != null ? route.getTotalSeats() : 0);
            seatMap.put("availableSeats", route.getAvailableSeats() != null ? route.getAvailableSeats() : 0);
            seatMap.put("occupiedSeats", occupiedSeats);
            
            // Генерируем список всех мест с их статусом
            List<Map<String, Object>> seats = new ArrayList<>();
            int totalSeats = route.getTotalSeats() != null ? route.getTotalSeats() : 0;
            
            for (int i = 1; i <= totalSeats; i++) {
                Map<String, Object> seat = new HashMap<>();
                seat.put("number", i);
                seat.put("occupied", occupiedSeats.contains(i));
                seat.put("available", !occupiedSeats.contains(i));
                seats.add(seat);
            }
            
            seatMap.put("seats", seats);
            
            return ResponseEntity.ok(seatMap);
        } catch (RuntimeException e) {
            throw new ResponseStatusException(
                org.springframework.http.HttpStatus.NOT_FOUND, 
                "Route not found with id: " + routeId
            );
        }
    }

    /**
     * Проверка доступности конкретного места
     * GET /api/seats/route/{routeId}/seat/{seatNumber}
     */
    @GetMapping("/route/{routeId}/seat/{seatNumber}")
    public ResponseEntity<Map<String, Object>> checkSeatAvailability(
            @PathVariable Long routeId,
            @PathVariable Integer seatNumber) {
        try {
            Route route = routeService.getRouteById(routeId);
            List<Integer> occupiedSeats = ticketService.getOccupiedSeatsByRoute(routeId);
            
            Map<String, Object> response = new HashMap<>();
            response.put("routeId", routeId);
            response.put("seatNumber", seatNumber);
            response.put("available", !occupiedSeats.contains(seatNumber));
            response.put("occupied", occupiedSeats.contains(seatNumber));
            
            if (seatNumber < 1 || (route.getTotalSeats() != null && seatNumber > route.getTotalSeats())) {
                response.put("valid", false);
                response.put("message", "Номер места вне допустимого диапазона");
            } else {
                response.put("valid", true);
            }
            
            return ResponseEntity.ok(response);
        } catch (RuntimeException e) {
            throw new ResponseStatusException(
                org.springframework.http.HttpStatus.NOT_FOUND, 
                "Route not found with id: " + routeId
            );
        }
    }
}


