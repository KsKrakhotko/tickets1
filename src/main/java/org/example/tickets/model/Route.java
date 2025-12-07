package org.example.tickets.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Route {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
    private Train train;

    @ManyToOne
    @JsonIgnoreProperties({"departureRoutes", "arrivalRoutes", "hibernateLazyInitializer", "handler"})
    private Station departureStation;

    @ManyToOne
    @JsonIgnoreProperties({"departureRoutes", "arrivalRoutes", "hibernateLazyInitializer", "handler"})
    private Station arrivalStation;

    private java.time.LocalDateTime departureTime;
    private java.time.LocalDateTime arrivalTime;
    private Double price;
    private Integer availableSeats;
    private Integer totalSeats;
}
