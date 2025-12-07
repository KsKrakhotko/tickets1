package org.example.tickets.request;

import java.time.LocalDateTime;

public class RouteRequest {
    // ID поезда, на котором будет осуществляться маршрут (для связи ManyToOne)
    private Long trainId;

    // ID существующих станций отправления и прибытия (для связи ManyToOne)
    private Long departureStationId;
    private Long arrivalStationId;

    private LocalDateTime departureTime;
    private LocalDateTime arrivalTime;

    // Цена за билет (Double, согласно вашей сущности Route)
    private Double price;

    // Общее количество мест на маршруте (берется из запроса, устанавливается как availableSeats)
    private Integer totalSeats;

    // Геттеры и Сеттеры

    public Long getTrainId() {
        return trainId;
    }

    public void setTrainId(Long trainId) {
        this.trainId = trainId;
    }

    public Long getDepartureStationId() {
        return departureStationId;
    }

    public void setDepartureStationId(Long departureStationId) {
        this.departureStationId = departureStationId;
    }

    public Long getArrivalStationId() {
        return arrivalStationId;
    }

    public void setArrivalStationId(Long arrivalStationId) {
        this.arrivalStationId = arrivalStationId;
    }

    public LocalDateTime getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(LocalDateTime departureTime) {
        this.departureTime = departureTime;
    }

    public LocalDateTime getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(LocalDateTime arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Integer getTotalSeats() {
        return totalSeats;
    }

    public void setTotalSeats(Integer totalSeats) {
        this.totalSeats = totalSeats;
    }
}
