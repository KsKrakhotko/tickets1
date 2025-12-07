package org.example.tickets.controller;


import org.example.tickets.model.Route;
import org.example.tickets.request.RouteRequest;
import org.example.tickets.service.RouteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@RestController
@RequestMapping("/routes")
public class RouteController {

    private final RouteService routeService;

    @Autowired
    public RouteController(RouteService routeService) {
        this.routeService = routeService;
    }

    // ✅ POST /routes - Добавление нового маршрута
    @PostMapping
    public ResponseEntity<Route> createRoute(@RequestBody RouteRequest request) {
        try {
            // Валидация входных данных
            if (request.getTrainId() == null) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Train ID is required");
            }
            if (request.getDepartureStationId() == null) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Departure Station ID is required");
            }
            if (request.getArrivalStationId() == null) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Arrival Station ID is required");
            }
            if (request.getDepartureTime() == null) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Departure time is required");
            }
            if (request.getArrivalTime() == null) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Arrival time is required");
            }
            if (request.getPrice() == null || request.getPrice() <= 0) {
                throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Valid price is required");
            }
            
            Route newRoute = routeService.createRoute(request);
            // Возвращаем статус 201 Created
            return new ResponseEntity<>(newRoute, HttpStatus.CREATED);
        } catch (ResponseStatusException e) {
            throw e;
        } catch (RuntimeException e) {
            // Если Train или Station не найдены, возвращаем 400 Bad Request с сообщением об ошибке
            e.printStackTrace();
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, 
                "Ошибка при создании маршрута: " + e.getMessage());
        }
    }

    // GET /routes - Получение всех маршрутов
    @GetMapping
    public ResponseEntity<List<Route>> getAllRoutes() {
        try {
            List<Route> routes = routeService.getAllRoutes();
            return ResponseEntity.ok(routes);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, 
                "Ошибка при загрузке маршрутов: " + e.getMessage());
        }
    }

    // GET /routes/search - Поиск маршрутов по городам
    @GetMapping("/search")
    public List<Route> searchRoutes(
            @RequestParam String departureCity,
            @RequestParam String arrivalCity) {

        return routeService.findRoutesByCities(departureCity, arrivalCity);
    }

    // GET /routes/{id} - Получение маршрута по ID
    @GetMapping("/{id}")
    public ResponseEntity<Route> getRouteById(@PathVariable Long id) {
        try {
            Route route = routeService.getRouteById(id);
            return ResponseEntity.ok(route);
        } catch (RuntimeException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }

    // PUT /routes/{id} - Обновление маршрута
    @PutMapping("/{id}")
    public ResponseEntity<Route> updateRoute(@PathVariable Long id, @RequestBody RouteRequest request) {
        try {
            Route updatedRoute = routeService.updateRoute(id, request);
            return ResponseEntity.ok(updatedRoute);
        } catch (RuntimeException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, e.getMessage());
        }
    }

    // DELETE /routes/{id} - Удаление маршрута
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteRoute(@PathVariable Long id) {
        try {
            routeService.deleteRoute(id);
            return ResponseEntity.ok().build();
        } catch (RuntimeException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        }
    }
    
    // POST /routes/fix-seats - Исправление некорректных данных о местах во всех маршрутах
    @PostMapping("/fix-seats")
    public ResponseEntity<String> fixAllRoutesSeats() {
        try {
            routeService.fixAllRoutesSeats();
            return ResponseEntity.ok("Все маршруты успешно исправлены");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, 
                "Ошибка при исправлении маршрутов: " + e.getMessage());
        }
    }
}
