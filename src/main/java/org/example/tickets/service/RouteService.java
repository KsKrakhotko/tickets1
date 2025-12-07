package org.example.tickets.service;


import org.example.tickets.model.Route;
import org.example.tickets.model.Station;
import org.example.tickets.model.Train;
import org.example.tickets.repository.RouteRepository;
import org.example.tickets.repository.StationRepository;
import org.example.tickets.repository.TrainRepository;
import org.example.tickets.request.RouteRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class RouteService {

    private final RouteRepository routeRepository;
    private final StationRepository stationRepository;
    private final TrainRepository trainRepository;

    // Конструкторная инъекция всех необходимых репозиториев
    @Autowired
    public RouteService(RouteRepository routeRepository,
                        StationRepository stationRepository,
                        TrainRepository trainRepository) {
        this.routeRepository = routeRepository;
        this.stationRepository = stationRepository;
        this.trainRepository = trainRepository;
    }

    // ✅ Метод для создания нового маршрута (для администратора)
    @Transactional
    public Route createRoute(RouteRequest request) {

        // 1. Проверка существования связанных сущностей

        // Поиск Поезда
        Train train = trainRepository.findById(request.getTrainId())
                .orElseThrow(() -> new RuntimeException("Train not found with id: " + request.getTrainId()));

        // Поиск Станции отправления
        Station departureStation = stationRepository.findById(request.getDepartureStationId())
                .orElseThrow(() -> new RuntimeException("Departure Station not found with id: " + request.getDepartureStationId()));

        // Поиск Станции прибытия
        Station arrivalStation = stationRepository.findById(request.getArrivalStationId())
                .orElseThrow(() -> new RuntimeException("Arrival Station not found with id: " + request.getArrivalStationId()));

        // 2. Создание и настройка сущности Route
        Route route = new Route();

        route.setTrain(train);
        route.setDepartureStation(departureStation);
        route.setArrivalStation(arrivalStation);
        route.setDepartureTime(request.getDepartureTime());
        route.setArrivalTime(request.getArrivalTime());
        route.setPrice(request.getPrice());

        // Получаем количество мест в поезде
        int trainSeats = train.getTotalSeats() != null && train.getTotalSeats() > 0 ? train.getTotalSeats() : 0;
        
        if (trainSeats == 0) {
            throw new RuntimeException("Поезд не имеет указанного количества мест (totalSeats = 0 или null)");
        }
        
        // При создании маршрута, все места считаются доступными (availableSeats = totalSeats)
        if (request.getTotalSeats() != null && request.getTotalSeats() > 0) {
            // Валидация: totalSeats не может превышать количество мест в поезде
            if (request.getTotalSeats() > trainSeats) {
                throw new RuntimeException("Количество мест в маршруте (" + request.getTotalSeats() + 
                    ") не может превышать количество мест в поезде (" + trainSeats + ")");
            }
            route.setTotalSeats(request.getTotalSeats());
            route.setAvailableSeats(request.getTotalSeats());
        } else {
            // Если totalSeats не указан, используем количество мест из поезда
            route.setTotalSeats(trainSeats);
            route.setAvailableSeats(trainSeats);
        }
        
        // Валидация: убеждаемся, что availableSeats не превышает totalSeats
        int totalSeats = route.getTotalSeats() != null ? route.getTotalSeats() : 0;
        int availableSeats = route.getAvailableSeats() != null ? route.getAvailableSeats() : 0;
        route.setAvailableSeats(Math.min(availableSeats, totalSeats));

        // 3. Сохранение в базе данных
        return routeRepository.save(route);
    }

    // 💡 Пример дополнительного метода: Поиск маршрутов по городам (используя логику из RouteRepository)
    public List<Route> findRoutesByCities(String departureCity, String arrivalCity) {
        return routeRepository.findByDepartureStationCityAndArrivalStationCity(departureCity, arrivalCity);
    }

    // 💡 Пример дополнительного метода: Получение всех маршрутов
    @Transactional(readOnly = true)
    public List<Route> getAllRoutes() {
        // Используем оптимизированный запрос с JOIN FETCH для избежания проблем с ленивой загрузкой
        List<Route> routes = routeRepository.findAllWithRelations();
        
        // Валидация и автоматическое исправление некорректных данных
        for (Route route : routes) {
            validateAndFixRouteSeats(route);
        }
        
        return routes;
    }
    
    /**
     * Валидирует и исправляет некорректные значения availableSeats и totalSeats
     * ВНИМАНИЕ: Этот метод только для чтения, не сохраняет изменения в БД
     * Для сохранения исправлений используйте updateRoute()
     */
    private void validateAndFixRouteSeats(Route route) {
        int totalSeats = route.getTotalSeats() != null ? route.getTotalSeats() : 0;
        int availableSeats = route.getAvailableSeats() != null ? route.getAvailableSeats() : 0;
        
        // Если totalSeats = 0 или null, но availableSeats > 0, устанавливаем totalSeats = availableSeats
        if (totalSeats == 0 && availableSeats > 0) {
            route.setTotalSeats(availableSeats);
        }
        
        // Если availableSeats > totalSeats, исправляем на totalSeats
        if (availableSeats > totalSeats && totalSeats > 0) {
            route.setAvailableSeats(totalSeats);
        }
        
        // Если availableSeats < 0, устанавливаем в 0
        if (availableSeats < 0) {
            route.setAvailableSeats(0);
        }
    }
    
    /**
     * Исправляет некорректные данные в БД для всех маршрутов
     * Используйте этот метод для исправления существующих некорректных данных
     */
    @Transactional
    public void fixAllRoutesSeats() {
        List<Route> routes = routeRepository.findAll();
        for (Route route : routes) {
            int totalSeats = route.getTotalSeats() != null ? route.getTotalSeats() : 0;
            int availableSeats = route.getAvailableSeats() != null ? route.getAvailableSeats() : 0;
            boolean needsUpdate = false;
            
            // Если totalSeats = 0 или null, но availableSeats > 0
            if (totalSeats == 0 && availableSeats > 0) {
                route.setTotalSeats(availableSeats);
                needsUpdate = true;
            }
            
            // Если availableSeats > totalSeats
            if (availableSeats > totalSeats && totalSeats > 0) {
                route.setAvailableSeats(totalSeats);
                needsUpdate = true;
            }
            
            // Если availableSeats < 0
            if (availableSeats < 0) {
                route.setAvailableSeats(0);
                needsUpdate = true;
            }
            
            if (needsUpdate) {
                routeRepository.save(route);
            }
        }
    }

    /**
     * Получает маршрут по ID
     */
    @Transactional(readOnly = true)
    public Route getRouteById(Long id) {
        Route route = routeRepository.findByIdWithRelations(id)
                .orElseThrow(() -> new RuntimeException("Route not found with id: " + id));
        
        // Валидация и автоматическое исправление некорректных данных
        validateAndFixRouteSeats(route);
        
        return route;
    }

    /**
     * Обновляет существующий маршрут
     */
    @Transactional
    public Route updateRoute(Long id, RouteRequest request) {
        // 1. Получаем существующий маршрут
        Route route = getRouteById(id);

        // 2. Проверка существования связанных сущностей
        Train train = trainRepository.findById(request.getTrainId())
                .orElseThrow(() -> new RuntimeException("Train not found with id: " + request.getTrainId()));

        Station departureStation = stationRepository.findById(request.getDepartureStationId())
                .orElseThrow(() -> new RuntimeException("Departure Station not found with id: " + request.getDepartureStationId()));

        Station arrivalStation = stationRepository.findById(request.getArrivalStationId())
                .orElseThrow(() -> new RuntimeException("Arrival Station not found with id: " + request.getArrivalStationId()));

        // 3. Обновление полей маршрута
        route.setTrain(train);
        route.setDepartureStation(departureStation);
        route.setArrivalStation(arrivalStation);
        route.setDepartureTime(request.getDepartureTime());
        route.setArrivalTime(request.getArrivalTime());
        route.setPrice(request.getPrice());

        // Получаем количество мест в поезде
        int trainSeats = train.getTotalSeats() != null && train.getTotalSeats() > 0 ? train.getTotalSeats() : 0;
        
        if (trainSeats == 0) {
            throw new RuntimeException("Поезд не имеет указанного количества мест (totalSeats = 0 или null)");
        }

        // Обновляем totalSeats и availableSeats
        if (request.getTotalSeats() != null) {
            int currentTotal = route.getTotalSeats() != null ? route.getTotalSeats() : 0;
            int newTotal = request.getTotalSeats();
            
            // Валидация: totalSeats не может превышать количество мест в поезде
            if (newTotal > trainSeats) {
                throw new RuntimeException("Количество мест в маршруте (" + newTotal + 
                    ") не может превышать количество мест в поезде (" + trainSeats + ")");
            }
            
            int currentAvailable = route.getAvailableSeats() != null ? route.getAvailableSeats() : 0;
            
            // Устанавливаем новое значение totalSeats
            route.setTotalSeats(newTotal);
            
            // Вычисляем разницу и обновляем availableSeats
            // Если totalSeats увеличивается, availableSeats увеличивается на разницу
            // Если totalSeats уменьшается, availableSeats уменьшается, но не может быть больше нового totalSeats
            int difference = newTotal - currentTotal;
            int newAvailable = currentAvailable + difference;
            
            // Валидация: availableSeats должно быть в пределах [0, totalSeats]
            route.setAvailableSeats(Math.max(0, Math.min(newAvailable, newTotal)));
        }

        // 4. Сохранение обновленного маршрута
        return routeRepository.save(route);
    }

    /**
     * Удаляет маршрут по ID
     */
    @Transactional
    public void deleteRoute(Long id) {
        Route route = getRouteById(id);
        routeRepository.delete(route);
    }

    /**
     * Получает количество активных маршрутов (с доступными местами)
     */
    @Transactional(readOnly = true)
    public int getActiveRoutesCount() {
        return routeRepository.countByAvailableSeatsGreaterThanZero();
    }

    /**
     * Получает количество поездов в пути (отправились, но еще не прибыли)
     */
    @Transactional(readOnly = true)
    public int getTrainsInTransitCount() {
        java.time.LocalDateTime now = java.time.LocalDateTime.now();
        List<Route> routesInTransit = routeRepository.findByDepartureTimeBetween(
            now.minusDays(7), // Поезда, отправившиеся за последние 7 дней
            now
        );
        
        // Фильтруем только те, которые отправились, но еще не прибыли
        int count = 0;
        for (Route route : routesInTransit) {
            if (route.getDepartureTime() != null && route.getArrivalTime() != null) {
                if (route.getDepartureTime().isBefore(now) && route.getArrivalTime().isAfter(now)) {
                    count++;
                }
            }
        }
        return count;
    }

    /**
     * Получает маршруты с отправлениями в указанном месяце
     */
    @Transactional(readOnly = true)
    public List<Route> getRoutesByMonth(int year, int month) {
        java.time.LocalDateTime startOfMonth = java.time.LocalDateTime.of(year, month, 1, 0, 0);
        java.time.LocalDateTime endOfMonth = startOfMonth.plusMonths(1);
        return routeRepository.findByDepartureTimeBetween(startOfMonth, endOfMonth);
    }

    /**
     * Получает общее количество маршрутов
     */
    @Transactional(readOnly = true)
    public long getTotalRoutesCount() {
        return routeRepository.count();
    }
}
