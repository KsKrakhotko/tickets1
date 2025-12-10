-- SQL скрипт создания базы данных для системы продажи билетов на поезда
-- Соответствует 3 нормальной форме (3NF)
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
-- Примечание: total_seats и available_seats могут быть разными для разных маршрутов
-- одного поезда (например, разные конфигурации вагонов), поэтому это не нарушение 3NF
-- Если total_seats всегда равен train.total_seats, то это поле следует удалить
CREATE TABLE route (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    train_id BIGINT NOT NULL,
    departure_station_id BIGINT NOT NULL,
    arrival_station_id BIGINT NOT NULL,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    total_seats INT NOT NULL CHECK (total_seats > 0),
    -- available_seats можно вычислять как: total_seats - COUNT(tickets для этого route)
    -- Но для производительности оставлено как denormalized поле
    -- Для строгой 3NF это поле следует удалить и вычислять динамически
    available_seats INT NOT NULL DEFAULT 0 CHECK (available_seats >= 0),
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
-- Примечание: price в Ticket хранится для исторических данных (цена на момент покупки)
-- Это важно для финансовой отчетности, но технически это нарушение 3NF
-- Если цена всегда должна быть актуальной из Route, то поле price следует удалить
CREATE TABLE ticket (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    route_id BIGINT NOT NULL,
    seat_number INT NOT NULL CHECK (seat_number > 0),
    carriage_type VARCHAR(50) NOT NULL,
    purchase_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'CANCELLED', 'USED', 'REFUNDED')),
    pnr_code VARCHAR(20) NOT NULL UNIQUE,
    -- price хранится для исторических данных (цена на момент покупки)
    -- Для строгой 3NF это поле можно удалить и брать из route.price
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
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

-- Триггер для автоматического обновления available_seats при создании билета
-- Это обеспечивает целостность данных для denormalized поля
DELIMITER $$

CREATE TRIGGER after_ticket_insert
AFTER INSERT ON ticket
FOR EACH ROW
BEGIN
    IF NEW.status = 'ACTIVE' THEN
        UPDATE route 
        SET available_seats = available_seats - 1 
        WHERE id = NEW.route_id AND available_seats > 0;
    END IF;
END$$

CREATE TRIGGER after_ticket_update
AFTER UPDATE ON ticket
FOR EACH ROW
BEGIN
    -- Если статус изменился с ACTIVE на другой
    IF OLD.status = 'ACTIVE' AND NEW.status != 'ACTIVE' THEN
        UPDATE route 
        SET available_seats = available_seats + 1 
        WHERE id = NEW.route_id;
    -- Если статус изменился с не-ACTIVE на ACTIVE
    ELSEIF OLD.status != 'ACTIVE' AND NEW.status = 'ACTIVE' THEN
        UPDATE route 
        SET available_seats = available_seats - 1 
        WHERE id = NEW.route_id AND available_seats > 0;
    END IF;
END$$

CREATE TRIGGER after_ticket_delete
AFTER DELETE ON ticket
FOR EACH ROW
BEGIN
    IF OLD.status = 'ACTIVE' THEN
        UPDATE route 
        SET available_seats = available_seats + 1 
        WHERE id = OLD.route_id;
    END IF;
END$$

DELIMITER ;

-- Вставка тестовых данных (опционально)
-- Можно раскомментировать для тестирования

/*
-- Тестовые пользователи
INSERT INTO user (username, password, email, role) VALUES
('admin', '$2a$10$encrypted_password_hash', 'admin@example.com', 'ADMIN'),
('user1', '$2a$10$encrypted_password_hash', 'user1@example.com', 'USER');

-- Тестовые станции
INSERT INTO station (name, city, region) VALUES
('Москва Центральная', 'Москва', 'Московская область'),
('Гомель', 'Гомель', 'Гомельская область'),
('Витебск', 'Витебск', 'Витебская область');

-- Тестовые поезда
INSERT INTO train (train_number, train_name, train_type, total_seats) VALUES
('001', 'Столичный экспресс', 'ПАССАЖИРСКИЙ', 500),
('002', 'Белорусский экспресс', 'СКОРЫЙ', 400);
*/

-- Просмотр структуры таблиц
SHOW TABLES;

