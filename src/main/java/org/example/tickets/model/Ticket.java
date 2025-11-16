package org.example.tickets.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private User user;

    @ManyToOne
    private Route route;

    private Integer seatNumber;
    private String carriageType;
    private java.time.LocalDateTime purchaseTime;
    private String status;
    private String pnrCode;
    private Double price;
}