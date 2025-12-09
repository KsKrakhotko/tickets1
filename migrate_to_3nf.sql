-- SQL скрипт миграции существующей БД к строгой 3 нормальной форме (3NF)
-- Устраняет нарушения: удаляет Ticket.price и Route.available_seats
-- База данных: railway_tickets_db

USE railway_tickets_db;

-- ============================================================================
-- ШАГ 1: Удаление триггеров, которые обновляли available_seats
-- ============================================================================

DROP TRIGGER IF EXISTS after_ticket_insert;
DROP TRIGGER IF EXISTS after_ticket_update;
DROP TRIGGER IF EXISTS after_ticket_delete;

-- ============================================================================
-- ШАГ 2: Удаление поля price из таблицы ticket (нарушение 3NF)
-- ============================================================================

-- Проверка существования поля перед удалением
SET @column_exists = (
    SELECT COUNT(*) 
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_SCHEMA = 'railway_tickets_db' 
    AND TABLE_NAME = 'ticket' 
    AND COLUMN_NAME = 'price'
);

SET @sql = IF(@column_exists > 0,
    'ALTER TABLE ticket DROP COLUMN price',
    'SELECT "Column price does not exist in ticket table" AS message'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ============================================================================
-- ШАГ 3: Удаление поля available_seats из таблицы route (денормализация)
-- ============================================================================

-- Проверка существования поля перед удалением
SET @column_exists = (
    SELECT COUNT(*) 
    FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_SCHEMA = 'railway_tickets_db' 
    AND TABLE_NAME = 'route' 
    AND COLUMN_NAME = 'available_seats'
);

SET @sql = IF(@column_exists > 0,
    'ALTER TABLE route DROP COLUMN available_seats',
    'SELECT "Column available_seats does not exist in route table" AS message'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ============================================================================
-- ШАГ 4: Создание VIEW для вычисления available_seats (для удобства)
-- ============================================================================

DROP VIEW IF EXISTS route_with_available_seats;

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
         AND t.status = 'active'), 
        0
    )) AS available_seats
FROM route r;

-- ============================================================================
-- ШАГ 5: Создание VIEW для получения билетов с ценами из маршрутов
-- ============================================================================

DROP VIEW IF EXISTS ticket_with_price;

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
-- ШАГ 6: Проверка результата миграции
-- ============================================================================

-- Показать структуру таблиц после миграции
SELECT '=== Структура таблицы ticket ===' AS info;
DESCRIBE ticket;

SELECT '=== Структура таблицы route ===' AS info;
DESCRIBE route;

SELECT '=== Созданные VIEW ===' AS info;
SHOW FULL TABLES WHERE Table_type = 'VIEW';

-- Проверка целостности данных
SELECT 
    'Проверка: количество билетов' AS check_name,
    COUNT(*) AS count
FROM ticket
UNION ALL
SELECT 
    'Проверка: количество маршрутов' AS check_name,
    COUNT(*) AS count
FROM route
UNION ALL
SELECT 
    'Проверка: доступные места (через VIEW)' AS check_name,
    SUM(available_seats) AS count
FROM route_with_available_seats;

-- ============================================================================
-- ИНСТРУКЦИИ ПО ОБНОВЛЕНИЮ ПРИЛОЖЕНИЯ
-- ============================================================================

/*
После выполнения миграции необходимо обновить Java-код:

1. В модели Ticket.java:
   - Удалить поле: private Double price;
   - При получении цены использовать JOIN с Route или VIEW ticket_with_price

2. В модели Route.java:
   - Удалить поле: private Integer availableSeats;
   - При получении availableSeats использовать:
     * VIEW route_with_available_seats
     * Или вычислять: totalSeats - COUNT(активных билетов)

3. В TicketService.java:
   - Удалить строку: ticket.setPrice(route.getPrice());
   - При получении цены билета использовать JOIN: ticket.getRoute().getPrice()

4. В RouteService.java:
   - Удалить все операции с availableSeats
   - Использовать вычисление через COUNT или VIEW

5. В TicketRepository.java:
   - Обновить запросы, которые используют t.price
   - Использовать JOIN с route или VIEW ticket_with_price

Пример запроса для получения цены билета:
   SELECT t.*, r.price 
   FROM ticket t 
   INNER JOIN route r ON t.route_id = r.id 
   WHERE t.id = ?

Или использовать VIEW:
   SELECT * FROM ticket_with_price WHERE id = ?
*/

SELECT 'Миграция завершена успешно!' AS status;
