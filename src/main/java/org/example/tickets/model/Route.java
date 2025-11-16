package org.example.tickets.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Route {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Train train;

    @ManyToOne
    private Station departureStation;

    @ManyToOne
    private Station arrivalStation;

    private java.time.LocalDateTime departureTime;
    private java.time.LocalDateTime arrivalTime;
    private Double price;
    private Integer availableSeats;
}
