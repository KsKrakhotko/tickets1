package org.example.tickets.model;

import jakarta.persistence.*;
import lombok.*;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "station")
public class Station {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String city;
    private String region;

    // Связь с маршрутами как станция отправления
    @OneToMany(mappedBy = "departureStation")
    @JsonIgnore
    private List<Route> departureRoutes;

    // Связь с маршрутами как станция прибытия
    @OneToMany(mappedBy = "arrivalStation")
    @JsonIgnore
    private List<Route> arrivalRoutes;
}
