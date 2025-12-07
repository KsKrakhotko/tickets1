package org.example.tickets.repository;

import org.example.tickets.model.Route;
import org.example.tickets.model.Station;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface RouteRepository extends JpaRepository<Route, Long> {
    List<Route> findByDepartureStationAndArrivalStation(Station departure, Station arrival);

    @Query("SELECT r FROM Route r WHERE r.departureStation.city = :departureCity AND r.arrivalStation.city = :arrivalCity")
    List<Route> findByDepartureStationCityAndArrivalStationCity(
            @Param("departureCity") String departureCity,
            @Param("arrivalCity") String arrivalCity);

    List<Route> findByDepartureTimeBetween(LocalDateTime start, LocalDateTime end);
    List<Route> findByAvailableSeatsGreaterThan(Integer seats);

    @Query("SELECT COUNT(r) FROM Route r WHERE r.availableSeats > 0")
    int countByAvailableSeatsGreaterThanZero();

    @Query("SELECT DISTINCT r FROM Route r LEFT JOIN FETCH r.train LEFT JOIN FETCH r.departureStation LEFT JOIN FETCH r.arrivalStation")
    List<Route> findAllWithRelations();

    @Query("SELECT DISTINCT r FROM Route r LEFT JOIN FETCH r.train LEFT JOIN FETCH r.departureStation LEFT JOIN FETCH r.arrivalStation WHERE r.id = :id")
    java.util.Optional<Route> findByIdWithRelations(@Param("id") Long id);
}