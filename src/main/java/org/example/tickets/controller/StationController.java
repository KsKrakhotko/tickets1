package org.example.tickets.controller;

import org.example.tickets.model.Station;
import org.example.tickets.request.StationRequest;
import org.example.tickets.service.StationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/stations")
public class StationController {

    private final StationService stationService;

    @Autowired
    public StationController(StationService stationService) {
        this.stationService = stationService;
    }

    @GetMapping
    public ResponseEntity<List<Station>> getAllStations() {
        return ResponseEntity.ok(stationService.getAllStations());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Station> getStationById(@PathVariable Long id) {
        return ResponseEntity.ok(stationService.getStationById(id));
    }

    @PostMapping
    public ResponseEntity<Station> createStation(@RequestBody StationRequest request) {
        return ResponseEntity.ok(stationService.createStation(request));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Station> updateStation(@PathVariable Long id,
                                                 @RequestBody StationRequest request) {
        Station updatedStation = stationService.updateStation(id, request);
        return ResponseEntity.ok(updatedStation);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteStation(@PathVariable Long id) {
        stationService.deleteStation(id);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/city/{city}")
    public ResponseEntity<List<Station>> getStationsByCity(@PathVariable String city) {
        return ResponseEntity.ok(stationService.getStationsByCity(city));
    }

    @GetMapping("/search")
    public ResponseEntity<List<Station>> searchStationsByName(@RequestParam String name) {
        return ResponseEntity.ok(stationService.searchStationsByName(name));
    }
}
