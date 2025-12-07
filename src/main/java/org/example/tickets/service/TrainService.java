package org.example.tickets.service;


import org.example.tickets.model.Train;
import org.example.tickets.repository.TrainRepository;
import org.example.tickets.request.TrainRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TrainService {

    private final TrainRepository trainRepository;

    @Autowired
    public TrainService(TrainRepository trainRepository) {
        this.trainRepository = trainRepository;
    }

    /**
     * Создает новый поезд, проверяя, что поезд с таким номером еще не существует.
     */
    @Transactional
    public Train createTrain(TrainRequest request) {
        // 1. Проверка на дубликат по TrainNumber
        if (trainRepository.findByTrainNumber(request.getTrainNumber()).isPresent()) {
            throw new RuntimeException("Train with number " + request.getTrainNumber() + " already exists.");
        }

        // 2. Создание сущности Train
        Train train = new Train();
        train.setTrainNumber(request.getTrainNumber());
        train.setTrainName(request.getTrainName());
        train.setTrainType(request.getTrainType());
        train.setTotalSeats(request.getTotalSeats());

        // 3. Сохранение и возврат
        return trainRepository.save(train);
    }

    /**
     * Возвращает список всех поездов.
     */
    public List<Train> getAllTrains() {
        return trainRepository.findAll();
    }

    /**
     * Получает поезд по ID
     */
    public Train getTrainById(Long id) {
        return trainRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Train not found"));
    }

    /**
     * Обновляет существующий поезд
     */
    @Transactional
    public Train updateTrain(Long id, TrainRequest request) {
        Train train = getTrainById(id);
        
        // Проверяем, не занят ли новый номер другим поездом
        if (!train.getTrainNumber().equals(request.getTrainNumber())) {
            if (trainRepository.findByTrainNumber(request.getTrainNumber()).isPresent()) {
                throw new RuntimeException("Train with number " + request.getTrainNumber() + " already exists.");
            }
        }
        
        train.setTrainNumber(request.getTrainNumber());
        train.setTrainName(request.getTrainName());
        train.setTrainType(request.getTrainType());
        train.setTotalSeats(request.getTotalSeats());
        
        return trainRepository.save(train);
    }

    /**
     * Удаляет поезд по ID
     */
    @Transactional
    public void deleteTrain(Long id) {
        Train train = getTrainById(id);
        trainRepository.delete(train);
    }
}
