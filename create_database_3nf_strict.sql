-- SQL скрипт создания базы данных для системы продажи билетов на поезда
-- СТРОГО соответствует 3 нормальной форме (3NF) - без нарушений
-- База данных: railway_tickets_db

-- Удаление базы данных, если существует (для пересоздания)
DROP DATABASE IF EXISTS railway_tickets_db;

-- Создание базы данных
CREATE DATABASE railway_tickets_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE railway_tickets_db;

-- Таблица: Пользователи
CREATE TABLE user (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role ENUM('ADMIN', 'USER') NOT NULL DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Таблица: Дополнительная информация о пользователях
-- Связь 1:1 с User (нормализовано для соответствия 3NF)
CREATE TABLE info (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Таблица: Поезда
CREATE TABLE train (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    train_number VARCHAR(20) NOT NULL UNIQUE,
    train_name VARCHAR(100) NOT NULL,
    train_type VARCHAR(50) NOT NULL,
    total_seats INT NOT NULL CHECK (total_seats > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_train_number (train_number),
    INDEX idx_train_type (train_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Таблица: Станции
CREATE TABLE station (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_station (name, city),
    INDEX idx_city (city),
    INDEX idx_region (region)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Таблица: Маршруты
-- Примечание: total_seats может отличаться от train.total_seats для разных маршрутов
-- одного поезда (например, разные конфигурации вагонов), поэтому это не нарушение 3NF
-- available_seats НЕ хранится - вычисляется динамически (строгая 3NF)
CREATE TABLE route (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    train_id BIGINT NOT NULL,
    departure_station_id BIGINT NOT NULL,
    arrival_station_id BIGINT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    total_seats INT NOT NULL CHECK (total_seats > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (train_id) REFERENCES train(id) ON DELETE RESTRICT,
    FOREIGN KEY (departure_station_id) REFERENCES station(id) ON DELETE RESTRICT,
    FOREIGN KEY (arrival_station_id) REFERENCES station(id) ON DELETE RESTRICT,
    CHECK (arrival_time > departure_time),
    CHECK (departure_station_id != arrival_station_id),
    INDEX idx_train_id (train_id),
    INDEX idx_departure_station (departure_station_id),
    INDEX idx_arrival_station (arrival_station_id),
    INDEX idx_departure_time (departure_time),
    INDEX idx_arrival_time (arrival_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Таблица: Билеты
-- Примечание: price НЕ хранится в Ticket (строгая 3NF)
-- Цена всегда берется из Route через JOIN или VIEW
CREATE TABLE ticket (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    route_id BIGINT NOT NULL,
    seat_number INT NOT NULL CHECK (seat_number > 0),
    carriage_type VARCHAR(50) NOT NULL,
    purchase_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'CANCELLED', 'USED', 'REFUNDED')),
    pnr_code VARCHAR(20) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE RESTRICT,
    FOREIGN KEY (route_id) REFERENCES route(id) ON DELETE RESTRICT,
    UNIQUE KEY unique_seat_per_route (route_id, seat_number, carriage_type),
    INDEX idx_user_id (user_id),
    INDEX idx_route_id (route_id),
    INDEX idx_pnr_code (pnr_code),
    INDEX idx_status (status),
    INDEX idx_purchase_time (purchase_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Таблица: Отзывы
CREATE TABLE review (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    review_text TEXT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_rating (rating),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- VIEW: Маршруты с вычисляемым available_seats (для удобства)
-- ============================================================================

CREATE VIEW route_with_available_seats AS
SELECT 
    r.id,
    r.train_id,
    r.departure_station_id,
    r.arrival_station_id,
    r.departure_time,
    r.arrival_time,
    r.price,
    r.total_seats,
    r.created_at,
    r.updated_at,
    -- Вычисляем available_seats как разницу между total_seats и количеством активных билетов
    (r.total_seats - COALESCE(
        (SELECT COUNT(*) 
         FROM ticket t 
         WHERE t.route_id = r.id 
         AND t.status = 'ACTIVE'), 
        0
    )) AS available_seats
FROM route r;

-- ============================================================================
-- VIEW: Билеты с ценами из маршрутов (для удобства)
-- ============================================================================

CREATE VIEW ticket_with_price AS
SELECT 
    t.id,
    t.user_id,
    t.route_id,
    t.seat_number,
    t.carriage_type,
    t.purchase_time,
    t.status,
    t.pnr_code,
    t.created_at,
    t.updated_at,
    -- Цена берется из маршрута (соответствие 3NF)
    r.price AS price
FROM ticket t
INNER JOIN route r ON t.route_id = r.id;

-- ============================================================================
-- ФУНКЦИЯ: Получение доступных мест для маршрута (альтернатива VIEW)
-- ============================================================================

DELIMITER $$

CREATE FUNCTION get_available_seats(route_id_param BIGINT)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE total_seats_val INT;
    DECLARE booked_seats INT;
    
    -- Получаем общее количество мест
    SELECT total_seats INTO total_seats_val
    FROM route
    WHERE id = route_id_param;
    
    -- Получаем количество забронированных мест
    SELECT COUNT(*) INTO booked_seats
    FROM ticket
    WHERE route_id = route_id_param
    AND status = 'ACTIVE';
    
    -- Возвращаем разницу
    RETURN COALESCE(total_seats_val, 0) - COALESCE(booked_seats, 0);
END$$

DELIMITER ;

-- ============================================================================
-- ПРИМЕРЫ ЗАПРОСОВ ДЛЯ РАБОТЫ С НОРМАЛИЗОВАННОЙ БД
-- ============================================================================

/*
-- Получение билета с ценой (через JOIN):
SELECT 
    t.*,
    r.price AS price
FROM ticket t
INNER JOIN route r ON t.route_id = r.id
WHERE t.id = ?;

-- Получение билета с ценой (через VIEW):
SELECT * FROM ticket_with_price WHERE id = ?;

-- Получение маршрута с доступными местами (через VIEW):
SELECT * FROM route_with_available_seats WHERE id = ?;

-- Получение маршрута с доступными местами (через функцию):
SELECT 
    r.*,
    get_available_seats(r.id) AS available_seats
FROM route r
WHERE r.id = ?;

-- Получение маршрута с доступными местами (через подзапрос):
SELECT 
    r.*,
    (r.total_seats - COALESCE(
        (SELECT COUNT(*) 
         FROM ticket t 
         WHERE t.route_id = r.id 
         AND t.status = 'ACTIVE'), 
        0
    )) AS available_seats
FROM route r
WHERE r.id = ?;
*/

-- Просмотр структуры таблиц
SHOW TABLES;

-- Просмотр созданных VIEW
SHOW FULL TABLES WHERE Table_type = 'VIEW';
