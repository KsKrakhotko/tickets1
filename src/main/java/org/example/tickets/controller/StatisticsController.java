package org.example.tickets.controller;

import org.example.tickets.service.RouteService;
import org.example.tickets.service.TicketService;
import org.example.tickets.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
public class StatisticsController {

    private final TicketService ticketService;
    private final RouteService routeService;
    private final UserService userService;

    @Autowired
    public StatisticsController(TicketService ticketService, RouteService routeService, UserService userService) {
        this.ticketService = ticketService;
        this.routeService = routeService;
        this.userService = userService;
    }

    /**
     * GET /api/tickets/sold/today
     * Возвращает количество билетов, проданных сегодня
     */
    @GetMapping("/tickets/sold/today")
    public ResponseEntity<Map<String, Integer>> getTicketsSoldToday() {
        int count = ticketService.getTodayTicketsCount();
        Map<String, Integer> response = new HashMap<>();
        response.put("ticketsSoldToday", count);
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/tickets/total
     * Возвращает общее количество билетов за всё время
     */
    @GetMapping("/tickets/total")
    public ResponseEntity<Map<String, Long>> getTotalTickets() {
        long count = ticketService.getTotalTicketsCount();
        Map<String, Long> response = new HashMap<>();
        response.put("totalTickets", count);
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/routes/active
     * Возвращает количество активных маршрутов (с доступными местами)
     */
    @GetMapping("/routes/active")
    public ResponseEntity<Map<String, Integer>> getActiveRoutes() {
        int count = routeService.getActiveRoutesCount();
        Map<String, Integer> response = new HashMap<>();
        response.put("activeRoutesCount", count);
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/routes/total
     * Возвращает общее количество маршрутов за всё время
     */
    @GetMapping("/routes/total")
    public ResponseEntity<Map<String, Long>> getTotalRoutes() {
        long count = routeService.getTotalRoutesCount();
        Map<String, Long> response = new HashMap<>();
        response.put("totalRoutes", count);
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/revenue/today
     * Возвращает выручку за сегодня
     */
    @GetMapping("/revenue/today")
    public ResponseEntity<Map<String, Double>> getTodayRevenue() {
        Double revenue = ticketService.getTodayRevenue();
        Map<String, Double> response = new HashMap<>();
        response.put("todayRevenue", revenue != null ? revenue : 0.0);
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/revenue/total
     * Возвращает общую выручку за всё время
     */
    @GetMapping("/revenue/total")
    public ResponseEntity<Map<String, Double>> getTotalRevenue() {
        Double revenue = ticketService.getTotalRevenue();
        Map<String, Double> response = new HashMap<>();
        response.put("totalRevenue", revenue != null ? revenue : 0.0);
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/trains/in-transit
     * Возвращает количество поездов в пути (отправились, но еще не прибыли)
     */
    @GetMapping("/trains/in-transit")
    public ResponseEntity<Map<String, Integer>> getTrainsInTransit() {
        int count = routeService.getTrainsInTransitCount();
        Map<String, Integer> response = new HashMap<>();
        response.put("trainsInTransitCount", count);
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/routes/by-month
     * Возвращает маршруты с отправлениями в указанном месяце
     */
    @GetMapping("/routes/by-month")
    public ResponseEntity<Map<String, Object>> getRoutesByMonth(
            @RequestParam int year,
            @RequestParam int month) {
        var routes = routeService.getRoutesByMonth(year, month);
        Map<String, Object> response = new HashMap<>();
        response.put("routes", routes);
        response.put("count", routes.size());
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/users/count
     * Возвращает общее количество пользователей
     */
    @GetMapping("/users/count")
    public ResponseEntity<Map<String, Long>> getTotalUsers() {
        long count = userService.getTotalUsers();
        Map<String, Long> response = new HashMap<>();
        response.put("totalUsers", count);
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/tickets/by-month
     * Возвращает количество проданных билетов по месяцам за последние 12 месяцев
     */
    @GetMapping("/tickets/by-month")
    public ResponseEntity<Map<String, Object>> getTicketsByMonth() {
        Map<String, Integer> data = new HashMap<>();
        java.time.LocalDate now = java.time.LocalDate.now();
        
        for (int i = 11; i >= 0; i--) {
            java.time.LocalDate date = now.minusMonths(i);
            int year = date.getYear();
            int month = date.getMonthValue();
            int count = ticketService.getTicketsCountByMonth(year, month);
            String key = String.format("%02d.%d", month, year);
            data.put(key, count);
        }
        
        Map<String, Object> response = new HashMap<>();
        response.put("ticketsByMonth", data);
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/revenue/by-month
     * Возвращает выручку по месяцам за последние 12 месяцев
     */
    @GetMapping("/revenue/by-month")
    public ResponseEntity<Map<String, Object>> getRevenueByMonth() {
        Map<String, Double> data = new HashMap<>();
        java.time.LocalDate now = java.time.LocalDate.now();
        
        for (int i = 11; i >= 0; i--) {
            java.time.LocalDate date = now.minusMonths(i);
            int year = date.getYear();
            int month = date.getMonthValue();
            Double revenue = ticketService.getRevenueByMonth(year, month);
            String key = String.format("%02d.%d", month, year);
            data.put(key, revenue != null ? revenue : 0.0);
        }
        
        Map<String, Object> response = new HashMap<>();
        response.put("revenueByMonth", data);
        return ResponseEntity.ok(response);
    }

    /**
     * GET /api/routes/popular
     * Возвращает популярные маршруты (по количеству проданных билетов)
     */
    @GetMapping("/routes/popular")
    public ResponseEntity<Map<String, Object>> getPopularRoutes() {
        try {
            List<Object[]> popularRoutes = ticketService.getPopularRoutes();
            
            List<Map<String, Object>> routesData = popularRoutes.stream()
                .limit(4) // Топ-4 маршрута
                .filter(result -> result[0] != null && result[1] != null) // Фильтруем null значения
                .map(result -> {
                    try {
                        Map<String, Object> routeInfo = new HashMap<>();
                        org.example.tickets.model.Route route = (org.example.tickets.model.Route) result[0];
                        Long count = ((Number) result[1]).longValue();
                        
                        if (route != null && route.getDepartureStation() != null && route.getArrivalStation() != null) {
                            routeInfo.put("route", route.getDepartureStation().getName() + " → " + route.getArrivalStation().getName());
                            routeInfo.put("count", count);
                            return routeInfo;
                        }
                        return null;
                    } catch (Exception e) {
                        System.err.println("Ошибка при обработке маршрута: " + e.getMessage());
                        return null;
                    }
                })
                .filter(routeInfo -> routeInfo != null) // Убираем null значения
                .collect(Collectors.toList());
            
            Map<String, Object> response = new HashMap<>();
            response.put("popularRoutes", routesData);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.err.println("Ошибка при получении популярных маршрутов: " + e.getMessage());
            e.printStackTrace();
            Map<String, Object> response = new HashMap<>();
            response.put("popularRoutes", new java.util.ArrayList<>());
            return ResponseEntity.ok(response);
        }
    }
}

