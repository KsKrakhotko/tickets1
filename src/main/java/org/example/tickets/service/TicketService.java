package org.example.tickets.service;

import org.example.tickets.model.Ticket;
import org.example.tickets.model.User;
import org.example.tickets.model.Route;
import org.example.tickets.repository.TicketRepository;
import org.example.tickets.repository.UserRepository;
import org.example.tickets.repository.RouteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class TicketService {

    private final TicketRepository ticketRepository;
    private final UserRepository userRepository;
    private final RouteRepository routeRepository;

    @Autowired
    public TicketService(TicketRepository ticketRepository,
                         UserRepository userRepository,
                         RouteRepository routeRepository) {
        this.ticketRepository = ticketRepository;
        this.userRepository = userRepository;
        this.routeRepository = routeRepository;
    }

    @Transactional
    public Ticket createTicket(long userId, long routeId, int seatNumber, String carriageType) {
        // Получаем пользователя и маршрут
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));
        
        // Проверяем, что у пользователя есть email
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            System.out.println("ВНИМАНИЕ: У пользователя " + user.getUsername() + " (ID: " + userId + ") не указан email!");
        } else {
            System.out.println("Пользователь найден: " + user.getUsername() + ", Email: " + user.getEmail());
        }

        Route route = routeRepository.findById(routeId)
                .orElseThrow(() -> new RuntimeException("Route not found with id: " + routeId));

        // Проверяем доступность места
        if (ticketRepository.existsByRouteAndSeatNumber(route, seatNumber)) {
            throw new RuntimeException("Seat " + seatNumber + " is already occupied on this route");
        }

        // Проверяем доступные места
        int availableSeats = route.getAvailableSeats() != null ? route.getAvailableSeats() : 0;
        int totalSeats = route.getTotalSeats() != null ? route.getTotalSeats() : 0;
        
        if (availableSeats <= 0) {
            throw new RuntimeException("No available seats on this route");
        }
        
        // Валидация: убеждаемся, что availableSeats не превышает totalSeats
        if (availableSeats > totalSeats) {
            // Исправляем некорректные данные
            route.setAvailableSeats(totalSeats);
            routeRepository.save(route);
            if (totalSeats <= 0) {
                throw new RuntimeException("No available seats on this route");
            }
        }

        // Создаем новый билет
        Ticket ticket = new Ticket();
        ticket.setUser(user);
        ticket.setRoute(route);
        ticket.setSeatNumber(seatNumber);
        ticket.setCarriageType(carriageType);
        ticket.setPurchaseTime(LocalDateTime.now());
        ticket.setStatus("active");
        ticket.setPnrCode(generatePNRCode());
        ticket.setPrice(route.getPrice());

        // Уменьшаем количество доступных мест
        int currentAvailable = route.getAvailableSeats() != null ? route.getAvailableSeats() : 0;
        if (currentAvailable > 0) {
            route.setAvailableSeats(currentAvailable - 1);
            routeRepository.save(route);
        } else {
            throw new RuntimeException("No available seats on this route");
        }

        return ticketRepository.save(ticket);
    }

    public List<Ticket> getAllTickets() {
        return ticketRepository.findAll();
    }

    public List<Ticket> getTicketsByUserId(Long userId) {
        return ticketRepository.findByUserId(userId);
    }

    public List<Ticket> getTicketsByUserAndStatus(Long userId, String status) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));
        return ticketRepository.findByUserAndStatus(user, status);
    }

    public Ticket getTicketByPnrCode(String pnrCode) {
        return ticketRepository.findByPnrCode(pnrCode)
                .orElseThrow(() -> new RuntimeException("Ticket not found with PNR code: " + pnrCode));
    }

    @Transactional
    public void deleteTicket(Long id) {
        Ticket ticket = ticketRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Ticket with ID " + id + " not found"));

        Route route = ticket.getRoute();
        
        // Возвращаем место в доступные только если билет был активен
        // Если билет был отменен, место уже было возвращено ранее
        if ("active".equals(ticket.getStatus())) {
            int currentAvailable = route.getAvailableSeats() != null ? route.getAvailableSeats() : 0;
            int totalSeats = route.getTotalSeats() != null ? route.getTotalSeats() : 0;
            
            // Увеличиваем availableSeats, но не больше totalSeats
            route.setAvailableSeats(Math.min(currentAvailable + 1, totalSeats));
            routeRepository.save(route);
        }

        ticketRepository.delete(ticket);
    }

    @Transactional
    public Ticket updateTicketStatus(Long id, String newStatus) {
        Ticket ticket = ticketRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Ticket with ID " + id + " not found"));

        if (newStatus == null || newStatus.trim().isEmpty()) {
            throw new IllegalArgumentException("Invalid status");
        }

        String oldStatus = ticket.getStatus();
        Route route = ticket.getRoute();
        
        // Обновляем availableSeats в зависимости от изменения статуса
        if ("active".equals(oldStatus) && "cancelled".equals(newStatus)) {
            // Билет отменяется - возвращаем место
            int currentAvailable = route.getAvailableSeats() != null ? route.getAvailableSeats() : 0;
            int totalSeats = route.getTotalSeats() != null ? route.getTotalSeats() : 0;
            route.setAvailableSeats(Math.min(currentAvailable + 1, totalSeats));
            routeRepository.save(route);
        } else if ("cancelled".equals(oldStatus) && "active".equals(newStatus)) {
            // Билет активируется - забираем место
            int currentAvailable = route.getAvailableSeats() != null ? route.getAvailableSeats() : 0;
            if (currentAvailable > 0) {
                route.setAvailableSeats(currentAvailable - 1);
                routeRepository.save(route);
            } else {
                throw new RuntimeException("No available seats on this route");
            }
        }

        ticket.setStatus(newStatus);
        return ticketRepository.save(ticket);
    }

    public int getTodayTicketsCount() {
        LocalDateTime startOfDay = LocalDateTime.now().toLocalDate().atStartOfDay();
        LocalDateTime endOfDay = startOfDay.plusDays(1);
        return ticketRepository.countByPurchaseTimeBetween(startOfDay, endOfDay);
    }

    public Double getTodayRevenue() {
        LocalDateTime startOfDay = LocalDateTime.now().toLocalDate().atStartOfDay();
        LocalDateTime endOfDay = startOfDay.plusDays(1);
        Double revenue = ticketRepository.calculateRevenueByPeriod(startOfDay, endOfDay);
        return revenue != null ? revenue : 0.0;
    }

    public int getActiveTicketsCount() {
        return ticketRepository.countByStatus("active");
    }

    public List<Ticket> getTicketsByPeriod(LocalDateTime start, LocalDateTime end) {
        return ticketRepository.findByPurchaseTimeBetween(start, end);
    }

    public List<Integer> getOccupiedSeatsByRoute(Long routeId) {
        Route route = routeRepository.findById(routeId)
                .orElseThrow(() -> new RuntimeException("Route not found with id: " + routeId));
        return ticketRepository.findSeatNumbersByRouteAndStatus(route, "active");
    }

    public int getTicketsCountByMonth(int year, int month) {
        return ticketRepository.countByYearAndMonth(year, month);
    }

    public Double getRevenueByMonth(int year, int month) {
        Double revenue = ticketRepository.calculateRevenueByYearAndMonth(year, month);
        return revenue != null ? revenue : 0.0;
    }

    public List<Object[]> getPopularRoutes() {
        List<Object[]> routeIds = ticketRepository.findPopularRoutesIds();
        // Преобразуем ID в объекты Route с загрузкой связей
        return routeIds.stream()
            .map(result -> {
                try {
                    Long routeId = ((Number) result[0]).longValue();
                    Route route = routeRepository.findByIdWithRelations(routeId)
                        .orElse(null);
                    if (route != null && route.getDepartureStation() != null && route.getArrivalStation() != null) {
                        return new Object[]{route, result[1]};
                    }
                    return null;
                } catch (Exception e) {
                    System.err.println("Ошибка при загрузке маршрута: " + e.getMessage());
                    return null;
                }
            })
            .filter(result -> result != null && result[0] != null)
            .collect(Collectors.toList());
    }

    public long getTotalTicketsCount() {
        return ticketRepository.count();
    }

    public Double getTotalRevenue() {
        Double revenue = ticketRepository.calculateTotalRevenue();
        return revenue != null ? revenue : 0.0;
    }

    /**
     * Получает билет по ID
     */
    public Ticket getTicketById(Long id) {
        return ticketRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket not found with id: " + id));
    }

    private String generatePNRCode() {
        // Простая генерация PNR кода (в реальном приложении нужно сделать более сложную логику)
        return "PNR" + System.currentTimeMillis();
    }
}