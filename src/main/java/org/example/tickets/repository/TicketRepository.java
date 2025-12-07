package org.example.tickets.repository;

import org.example.tickets.model.Ticket;
import org.example.tickets.model.User;
import org.example.tickets.model.Route;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Long> {
    boolean existsByRouteAndSeatNumber(Route route, Integer seatNumber);
    List<Ticket> findByUserId(Long userId);
    List<Ticket> findByUserAndStatus(User user, String status);
    Optional<Ticket> findByPnrCode(String pnrCode);
    List<Ticket> findByPurchaseTimeBetween(LocalDateTime start, LocalDateTime end);

    @Query("SELECT COUNT(t) FROM Ticket t WHERE t.purchaseTime BETWEEN :start AND :end")
    int countByPurchaseTimeBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT SUM(t.price) FROM Ticket t WHERE t.purchaseTime BETWEEN :start AND :end AND t.status = 'active'")
    Double calculateRevenueByPeriod(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    @Query("SELECT COUNT(t) FROM Ticket t WHERE t.status = :status")
    int countByStatus(@Param("status") String status);

    @Query("SELECT t.seatNumber FROM Ticket t WHERE t.route = :route AND t.status = :status")
    List<Integer> findSeatNumbersByRouteAndStatus(@Param("route") Route route, @Param("status") String status);
}