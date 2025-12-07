package org.example.tickets.service;

import org.example.tickets.model.Station;
import org.example.tickets.repository.StationRepository;
import org.example.tickets.request.StationRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StationService {

    private final StationRepository repository;

    @Autowired
    public StationService(StationRepository repository) {
        this.repository = repository;
    }

    public Station createStation(StationRequest request) {
        Station station = new Station();
        station.setName(request.getName());
        station.setCity(request.getCity());
        station.setRegion(request.getRegion());
        return repository.save(station);
    }

    public List<Station> getAllStations() {
        return repository.findAll();
    }

    public Station getStationById(Long id) {
        return repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Station not found"));
    }

    public Station updateStation(Long id, StationRequest request) {
        Station station = getStationById(id);
        station.setName(request.getName());
        station.setCity(request.getCity());
        station.setRegion(request.getRegion());
        return repository.save(station);
    }

    public void deleteStation(Long id) {
        Station station = getStationById(id);
        repository.delete(station);
    }

    public List<Station> getStationsByCity(String city) {
        return repository.findByCity(city);
    }

    public List<Station> searchStationsByName(String name) {
        return repository.findByNameContainingIgnoreCase(name);
    }
}
