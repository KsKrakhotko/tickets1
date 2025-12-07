package org.example.tickets.repository;

import org.example.tickets.model.Info;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InfoRepository extends JpaRepository<Info, Integer> {
    Info findByUserId(long userId);
}

