<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Управление маршрутами | Железнодорожный Администратор</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Стили CSS остаются прежними, так как они универсальны */
        :root {
            --purple: #8A2BE2;
            --dark-purple: #6A1B9A;
            --light-purple: #E6E6FA;
            --ivory: #FFFFF0;
            --charcoal: #36454F;
            --slate: #708090;
            --success: #4CAF50;
            --warning: #FFC107;
            --danger: #F44336;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: var(--ivory);
            color: var(--charcoal);
            line-height: 1.6;
        }

        /* Основной лейаут */
        .admin-layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            min-height: 100vh;
        }

        /* Боковая панель - фиолетовый акцент */
        .admin-sidebar {
            background: linear-gradient(to bottom, #FFFFFF, #F8F8F8);
            box-shadow: 5px 0 15px rgba(0,0,0,0.05);
            border-right: 1px solid rgba(138, 43, 226, 0.3);
        }

        /* Логотип и заголовок */
        .admin-header {
            padding: 30px 25px;
            border-bottom: 1px solid rgba(138, 43, 226, 0.2);
            margin-bottom: 20px;
        }

        .admin-title {
            display: flex;
            align-items: center;
            font-family: 'Playfair Display', serif;
        }

        .admin-title i {
            font-size: 2rem;
            margin-right: 15px;
            color: var(--purple);
        }

        .admin-title h1 {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--charcoal);
            position: relative;
        }

        .admin-title h1::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 40px;
            height: 2px;
            background: var(--purple);
        }

        /* Навигация */
        .admin-nav {
            padding: 0 15px;
        }

        .nav-item {
            margin-bottom: 5px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 14px 20px;
            color: var(--slate);
            text-decoration: none;
            border-radius: 4px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .nav-link:hover {
            background: rgba(138, 43, 226, 0.1);
            color: var(--charcoal);
            transform: translateX(5px);
        }

        .nav-link.active {
            background: rgba(138, 43, 226, 0.15);
            color: var(--charcoal);
            border-left: 3px solid var(--purple);
            font-weight: 600;
        }

        .nav-link i {
            width: 24px;
            margin-right: 12px;
            color: var(--purple);
            text-align: center;
        }

        /* Основное содержимое */
        .admin-content {
            padding: 40px;
            background-color: #FFF;
        }

        /* Заголовок страницы */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(138, 43, 226, 0.2);
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--charcoal);
            position: relative;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 2px;
            background: var(--purple);
        }

        /* Карточки маршрутов (используем старые стили grid/card) */
        .routes-grid { /* Переименовано с services-grid */
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); /* Увеличен мин. размер для маршрутов */
            gap: 25px;
            margin-bottom: 40px;
        }

        .route-card{ /* Переименовано с service-card */
            background: #FFF;
            display: block;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border-top: 3px solid var(--purple);
            color: black !important;
        }


        .route-image { /* Переименовано с service-image */
            height: 180px;
            background-color: #f6f6f6;
            display: flex;
            justify-content: center;
            align-items: center;
            color: var(--purple);
            font-size: 3rem;
            object-fit: cover;
        }

        .route-body { /* Переименовано с service-body */
            padding: 20px;
        }

        .route-title { /* Переименовано с service-title */
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            margin-bottom: 10px;
            color: var(--charcoal);
        }

        /* Дополнительный класс для мета-информации маршрута */
        .route-details {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 15px;
            font-size: 0.95rem;
        }

        .route-detail-item {
            display: flex;
            justify-content: space-between;
            padding-bottom: 5px;
            border-bottom: 1px dotted var(--light-purple);
        }

        .route-meta-label {
            font-weight: 500;
            color: var(--slate);
        }

        .route-meta-value {
            font-weight: 600;
            color: var(--charcoal);
        }

        .route-price-seats {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .route-price {
            font-weight: 700;
            color: var(--purple);
            font-size: 1.4rem;
        }

        .route-seats {
            font-weight: 600;
            color: var(--success);
            font-size: 1.1rem;
        }

        .route-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }


        /* Кнопки */
        .btn {
            padding: 8px 16px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            font-weight: 500;
        }

        .btn i {
            margin-right: 6px;
        }

        .btn-purple {
            background: var(--purple);
            color: white;
        }

        .btn-purple:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.3);
        }

        .btn-outline-purple {
            background: transparent;
            color: var(--purple);
            border: 1px solid var(--purple);
        }

        .btn-outline-purple:hover {
            background: rgba(138, 43, 226, 0.1);
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background: #d32f2f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(244, 67, 54, 0.3);
        }

        /* Форма добавления/редактирования */
        .route-form { /* Переименовано с service-form */
            background: #FFF;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 40px;
            border-top: 3px solid var(--purple);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--charcoal);
        }

        .form-control {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-family: 'Montserrat', sans-serif;
            transition: border 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--purple);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.1);
        }

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }

        /* Модальное окно */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: #FFF;
            width: 500px;
            max-width: 90%;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 30px rgba(0,0,0,0.2);
            animation: modalFadeIn 0.3s ease;
        }

        .modal-header {
            padding: 20px;
            background: var(--purple);
            color: white;
            font-family: 'Playfair Display', serif;
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            background: #f9f9f9;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        @keyframes modalFadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Адаптивность */
        @media (max-width: 992px) {
            .admin-layout {
                grid-template-columns: 1fr;
            }

            .admin-sidebar {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="admin-layout">
    <div class="admin-sidebar">
        <div class="admin-header">
            <div class="admin-title">
                <i class="fas fa-train"></i>
                <h1>ЖД Админ</h1>
            </div>
        </div>

        <ul class="nav-links">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminHome" class="nav-link">
                    <i class="fas fa-tachometer-alt nav-icon"></i>
                    <span class="nav-text">Главная</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/recordAdmin" class="nav-link active">
                    <i class="fas fa-route nav-icon"></i>
                    <span class="nav-text">Маршруты</span>
                    <span class="badge" id="activeRoutesBadge">...</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminStations" class="nav-link">
                    <i class="fas fa-building nav-icon"></i>
                    <span class="nav-text">Станции</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminTrains" class="nav-link">
                    <i class="fas fa-train-subway nav-icon"></i>
                    <span class="nav-text">Поезда</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminTickets" class="nav-link">
                    <i class="fas fa-ticket-alt nav-icon"></i>
                    <span class="nav-text">Билеты</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminClients" class="nav-link">
                    <i class="fas fa-users nav-icon"></i>
                    <span class="nav-text">Клиенты/Пассажиры</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/statistic" class="nav-link">
                    <i class="fas fa-chart-bar nav-icon"></i>
                    <span class="nav-text">Отчеты/Статистика</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="javascript:void(0);" class="nav-link" onclick="logout()">
                    <i class="fas fa-sign-out-alt nav-icon"></i>
                    <span class="nav-text">Выход</span>
                </a>
            </li>
        </ul>
    </div>

    <div class="admin-content">
        <div class="page-header">
            <h2 class="page-title">Управление маршрутами</h2>
            <div class="admin-actions">
                <button id="addRouteBtn" class="btn btn-purple">
                    <i class="fas fa-plus"></i> Добавить маршрут
                </button>
                <button id="exportExcelBtn" class="btn btn-purple">
                    <i class="fas fa-file-excel"></i> Экспорт в Excel
                </button>
            </div>
        </div>

        <div id="routeForm" class="route-form" style="display: none;">
            <h3 style="margin-bottom: 20px; font-family: 'Playfair Display', serif;" id="formTitle">Добавить новый маршрут</h3>
            <form id="routeFormElement">
                <input type="hidden" id="routeId">

                <div class="form-row" style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="trainSelect" class="form-label">Поезд</label>
                        <select id="trainSelect" class="form-control" required>
                            <option value="">Выберите поезд</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="totalSeats" class="form-label">Общее количество мест</label>
                        <input type="number" id="totalSeats" class="form-control" required min="1" step="1">
                        <small class="text-muted" id="totalSeatsHint">Кол-во доступных мест будет равно этому значению. Выберите поезд для установки максимального значения.</small>
                    </div>
                </div>

                <div class="form-row" style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="departureStationSelect" class="form-label">Станция отправления</label>
                        <select id="departureStationSelect" class="form-control" required>
                            <option value="">Выберите станцию</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="arrivalStationSelect" class="form-label">Станция прибытия</label>
                        <select id="arrivalStationSelect" class="form-control" required>
                            <option value="">Выберите станцию</option>
                        </select>
                    </div>
                </div>

                <div class="form-row" style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="departureTime" class="form-label">Дата и время отправления</label>
                        <input type="datetime-local" id="departureTime" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="arrivalTime" class="form-label">Дата и время прибытия</label>
                        <input type="datetime-local" id="arrivalTime" class="form-control" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="routePrice" class="form-label">Цена билета (Br)</label>
                    <input type="number" id="routePrice" class="form-control" required min="0" step="0.01">
                </div>

                <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px;">
                    <button type="button" id="cancelFormBtn" class="btn btn-outline-purple">Отмена</button>
                    <button type="submit" class="btn btn-purple">
                        <i class="fas fa-save"></i> Сохранить маршрут
                    </button>
                </div>
            </form>
        </div>

        <h3 style="margin-bottom: 20px; font-family: 'Playfair Display', serif; color: var(--charcoal);">
            <i class="fas fa-list" style="color: var(--purple); margin-right: 10px;"></i>
            Список маршрутов
        </h3>

        <div class="routes-grid">
        </div>

        <div id="deleteModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Подтверждение удаления</h3>
                </div>
                <div class="modal-body">
                    <p>Вы уверены, что хотите удалить этот маршрут? Это действие нельзя отменить.</p>
                </div>
                <div class="modal-footer">
                    <button id="cancelDeleteBtn" class="btn btn-outline-purple">Отмена</button>
                    <button id="confirmDeleteBtn" class="btn btn-danger">Удалить</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // Глобальная переменная для хранения данных маршрутов для экспорта
    let routesData = [];

    // Вспомогательная функция для форматирования даты
    function formatDateTime(dateTimeStr) {
        if (!dateTimeStr) return 'Не указано';
        try {
            return new Date(dateTimeStr).toLocaleString('ru-RU', {
                day: '2-digit',
                month: '2-digit',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit'
            });
        } catch (e) {
            return 'Ошибка даты';
        }
    }

    $(document).ready(function() {

        // --- Загрузка зависимых данных (Поезда и Станции) ---

        // Храним информацию о поездах для валидации
        let trainsData = {};

        function loadTrains() {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/trains', // Путь к API для получения всех поездов
                type: 'GET',
                dataType: 'json',
                success: function(trains) {
                    $('#trainSelect').empty().append('<option value="">Выберите поезд</option>');
                    trainsData = {}; // Очищаем предыдущие данные
                    if (Array.isArray(trains)) {
                        trains.forEach(function(train) {
                            trainsData[train.id] = train; // Сохраняем данные о поезде
                            $('#trainSelect').append($('<option>')
                                .val(train.id)
                                .attr('data-total-seats', train.totalSeats || 0)
                                .text(train.trainNumber + ' (' + train.trainName + ') - ' + (train.totalSeats || 0) + ' мест'));
                        });
                    }
                },
                error: function() {
                    alert('Не удалось загрузить список поездов.');
                }
            });
        }
        
        // Обработчик изменения выбранного поезда
        $(document).on('change', '#trainSelect', function() {
            const trainId = $(this).val();
            const totalSeatsInput = $('#totalSeats');
            
            if (trainId && trainsData[trainId]) {
                const train = trainsData[trainId];
                const maxSeats = train.totalSeats || 0;
                
                // Устанавливаем максимальное значение для totalSeats
                totalSeatsInput.attr('max', maxSeats);
                
                // Если поле пустое или значение превышает максимум, устанавливаем значение по умолчанию
                const currentValue = parseInt(totalSeatsInput.val()) || 0;
                if (currentValue === 0 || currentValue > maxSeats) {
                    totalSeatsInput.val(maxSeats);
                }
                
                // Обновляем подсказку
                totalSeatsInput.next('small').text(
                    'Кол-во доступных мест будет равно этому значению. Максимум: ' + maxSeats + ' мест (количество мест в поезде)'
                );
            } else {
                // Сбрасываем ограничения, если поезд не выбран
                totalSeatsInput.removeAttr('max');
                totalSeatsInput.next('small').text('Кол-во доступных мест будет равно этому значению.');
            }
        });
        
        // Валидация при изменении количества мест
        $(document).on('input change', '#totalSeats', function() {
            const trainId = $('#trainSelect').val();
            const totalSeatsValue = parseInt($(this).val()) || 0;
            
            if (trainId && trainsData[trainId]) {
                const train = trainsData[trainId];
                const maxSeats = train.totalSeats || 0;
                
                if (totalSeatsValue > maxSeats) {
                    alert('Количество мест в маршруте (' + totalSeatsValue + 
                        ') не может превышать количество мест в поезде (' + maxSeats + ')');
                    $(this).val(maxSeats);
                }
            }
        });

        function loadStations() {
            $.ajax({
                url: '${pageContext.request.contextPath}/api/stations', // Путь к API для получения всех станций
                type: 'GET',
                dataType: 'json',
                success: function(stations) {
                    $('#departureStationSelect').empty().append('<option value="">Выберите станцию отправления</option>');
                    $('#arrivalStationSelect').empty().append('<option value="">Выберите станцию прибытия</option>');
                    if (Array.isArray(stations)) {
                        stations.forEach(function(station) {
                            const optionText = station.city + ' - ' + station.name;
                            $('#departureStationSelect').append($('<option>').val(station.id).text(optionText));
                            $('#arrivalStationSelect').append($('<option>').val(station.id).text(optionText));
                        });
                    }
                },
                error: function() {
                    alert('Не удалось загрузить список станций.');
                }
            });
        }

        // --- Обработчики формы ---

        // Показать форму добавления маршрута
        $('#addRouteBtn').click(function() {
            // Загрузка списков перед показом формы
            loadTrains();
            loadStations();

            $('#formTitle').text('Добавить новый маршрут');
            $('#routeForm').show();
            $('#routeFormElement')[0].reset();
            $('#routeId').val('');
            // Сбрасываем валидацию
            $('#totalSeats').removeAttr('max');
            $('#totalSeatsHint').text('Кол-во доступных мест будет равно этому значению. Выберите поезд для установки максимального значения.');
            $('html, body').animate({
                scrollTop: $('#routeForm').offset().top - 20
            }, 300);
        });

        // Скрыть форму
        $('#cancelFormBtn').click(function() {
            $('#routeForm').hide();
            // Сбрасываем валидацию при закрытии формы
            $('#totalSeats').removeAttr('max');
            $('#totalSeatsHint').text('Кол-во доступных мест будет равно этому значению. Выберите поезд для установки максимального значения.');
        });

        // Обработка отправки формы (Добавление/Редактирование)
        $('#routeFormElement').submit(function(e) {
            e.preventDefault();

            const isNew = !$('#routeId').val(); // Если routeId пуст, то это новый маршрут

            // Преобразование дат из формата datetime-local в ISO формат
            function formatDateTimeForBackend(localDateTime) {
                if (!localDateTime) return null;
                // datetime-local формат: YYYY-MM-DDTHH:MM
                // ISO формат для Spring Boot: YYYY-MM-DDTHH:MM:SS
                // Если секунды не указаны, добавляем :00
                if (localDateTime.length === 16) {
                    return localDateTime + ':00';
                }
                return localDateTime;
            }

            const formData = {
                trainId: parseInt($('#trainSelect').val()),
                departureStationId: parseInt($('#departureStationSelect').val()),
                arrivalStationId: parseInt($('#arrivalStationSelect').val()),
                departureTime: formatDateTimeForBackend($('#departureTime').val()),
                arrivalTime: formatDateTimeForBackend($('#arrivalTime').val()),
                price: parseFloat($('#routePrice').val()),
                totalSeats: parseInt($('#totalSeats').val())
            };

            // Валидация
            if (!formData.trainId || !formData.departureStationId || !formData.arrivalStationId) {
                alert('Пожалуйста, заполните все обязательные поля');
                return;
            }

            if (formData.departureStationId === formData.arrivalStationId) {
                alert('Станция отправления и прибытия не могут совпадать');
                return;
            }
            
            // Валидация количества мест
            if (trainsData[formData.trainId]) {
                const train = trainsData[formData.trainId];
                const maxSeats = train.totalSeats || 0;
                
                if (maxSeats === 0) {
                    alert('Выбранный поезд не имеет указанного количества мест. Пожалуйста, выберите другой поезд.');
                    return;
                }
                
                if (formData.totalSeats > maxSeats) {
                    alert('Количество мест в маршруте (' + formData.totalSeats + 
                        ') не может превышать количество мест в поезде (' + maxSeats + ')');
                    $('#totalSeats').focus();
                    return;
                }
            }

            const url = isNew ? '${pageContext.request.contextPath}/routes' : '${pageContext.request.contextPath}/routes/' + $('#routeId').val();
            const type = isNew ? 'POST' : 'PUT';

            console.log('Данные для отправки:', formData, 'URL:', url, 'Type:', type);

            $.ajax({
                url: url,
                type: type,
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function(response) {
                    console.log('Маршрут сохранен:', response);
                    alert('Маршрут успешно сохранен!');
                    $('#routeForm').hide();
                    loadRoutes();
                },
                error: function(xhr, status, error) {
                    console.error('Ошибка при сохранении маршрута:', xhr, status, error);
                    let errorMsg = 'Произошла ошибка на сервере.';
                    
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        errorMsg = xhr.responseJSON.message;
                    } else if (xhr.responseText) {
                        try {
                            const error = JSON.parse(xhr.responseText);
                            if (error.message) {
                                errorMsg = error.message;
                            } else {
                                errorMsg = xhr.responseText;
                            }
                        } catch (e) {
                            errorMsg = xhr.responseText || 'Неизвестная ошибка';
                        }
                    } else if (xhr.status === 0) {
                        errorMsg = 'Не удалось подключиться к серверу. Проверьте подключение.';
                    } else if (xhr.status === 400) {
                        errorMsg = 'Ошибка валидации данных. Проверьте правильность заполнения полей.';
                    } else if (xhr.status === 404) {
                        errorMsg = 'Ресурс не найден.';
                    } else if (xhr.status === 500) {
                        errorMsg = 'Внутренняя ошибка сервера.';
                    }
                    
                    alert('Ошибка при сохранении маршрута: ' + errorMsg);
                }
            });
        });

        // --- Редактирование ---

        $(document).on('click', '.edit-route', function() {
            const routeIdStr = $(this).attr('data-id');
            if (!routeIdStr || routeIdStr === '') {
                alert('Ошибка: не удалось получить ID маршрута');
                return;
            }
            const routeId = parseInt(routeIdStr, 10);
            if (isNaN(routeId) || routeId <= 0) {
                alert('Ошибка: неверный ID маршрута');
                return;
            }

            // 1. Загрузка списков (нужно, чтобы заполнить SELECT)
            loadTrains();
            loadStations();

            // 2. Получение данных маршрута с сервера
            $.ajax({
                url: '${pageContext.request.contextPath}/routes/' + routeId, // Путь к API для получения маршрута по ID
                type: 'GET',
                success: function(route) {
                    $('#formTitle').text('Редактировать маршрут');
                    $('#routeId').val(route.id);

                    // Заполнение полей
                    const trainId = route.train ? route.train.id : '';
                    $('#trainSelect').val(trainId);
                    
                    // Устанавливаем максимальное значение для totalSeats при редактировании
                    if (trainId && trainsData[trainId]) {
                        const train = trainsData[trainId];
                        const maxSeats = train.totalSeats || 0;
                        $('#totalSeats').attr('max', maxSeats);
                        $('#totalSeats').next('small').text(
                            'Кол-во доступных мест будет равно этому значению. Максимум: ' + maxSeats + ' мест (количество мест в поезде)'
                        );
                    }
                    
                    $('#departureStationSelect').val(route.departureStation ? route.departureStation.id : '');
                    $('#arrivalStationSelect').val(route.arrivalStation ? route.arrivalStation.id : '');

                    // Преобразование времени в формат datetime-local (YYYY-MM-DDTHH:MM)
                    $('#departureTime').val(route.departureTime ? route.departureTime.substring(0, 16) : '');
                    $('#arrivalTime').val(route.arrivalTime ? route.arrivalTime.substring(0, 16) : '');

                    $('#routePrice').val(route.price);
                    $('#totalSeats').val(route.totalSeats); // Используем totalSeats

                    // Показать форму редактирования
                    $('#routeForm').show();
                    $('html, body').animate({
                        scrollTop: $('#routeForm').offset().top - 20
                    }, 300);
                },
                error: function(xhr, status, error) {
                    alert('Ошибка при загрузке данных маршрута');
                    console.error('Ошибка:', error);
                }
            });
        });

        // --- Удаление ---

        let routeToDelete = null;
        $(document).on('click', '.delete-route', function() {
            const idStr = $(this).attr('data-id');
            if (!idStr || idStr === '') {
                alert('Ошибка: не удалось получить ID маршрута');
                return;
            }
            const id = parseInt(idStr, 10);
            if (isNaN(id) || id <= 0) {
                alert('Ошибка: неверный ID маршрута');
                return;
            }
            routeToDelete = id;
            $('#deleteModal').css('display', 'flex');
        });

        $('#cancelDeleteBtn').click(function() {
            $('#deleteModal').hide();
            routeToDelete = null;
        });

        $('#confirmDeleteBtn').click(function() {
            if (routeToDelete) {
                // Логика удаления маршрута через AJAX запрос
                $.ajax({
                    url: '${pageContext.request.contextPath}/routes/' + routeToDelete,
                    type: 'DELETE',
                    success: function() {
                        alert('Маршрут успешно удален!');
                        $('#deleteModal').css('display', 'none');
                        routeToDelete = null;
                        loadRoutes();
                    },
                    error: function(xhr, status, error) {
                        console.error('Ошибка при удалении маршрута:', xhr, status, error);
                        let errorMsg = 'Произошла ошибка при удалении маршрута.';
                        
                        if (xhr.status === 404) {
                            errorMsg = 'Маршрут не найден.';
                        } else if (xhr.responseText) {
                            try {
                                const error = JSON.parse(xhr.responseText);
                                if (error.message) {
                                    errorMsg = 'Ошибка: ' + error.message;
                                }
                            } catch (e) {
                                errorMsg = 'Ошибка: ' + xhr.responseText;
                            }
                        }
                        
                        alert(errorMsg);
                        $('#deleteModal').css('display', 'none');
                        routeToDelete = null;
                    }
                });
            }
        });

        // --- Загрузка списка маршрутов ---

        function loadRoutes() {
            $.ajax({
                url: '${pageContext.request.contextPath}/routes',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    console.log('Полученные данные маршрутов:', response);
                    $('.routes-grid').empty();

                    routesData = Array.isArray(response) ? response : [];
                    const routes = routesData;

                    if (!routes || routes.length === 0) {
                        $('.routes-grid').html('<p>Нет доступных маршрутов</p>');
                        return;
                    }

                    routes.forEach(function(route) {
                        const id = route.id ? route.id : null;
                        if (!id) {
                            console.warn('Маршрут без ID пропущен:', route);
                            return;
                        }

                        // Извлечение информации
                        const departureCity = route.departureStation && route.departureStation.city ? route.departureStation.city : 'Н/Д';
                        const arrivalCity = route.arrivalStation && route.arrivalStation.city ? route.arrivalStation.city : 'Н/Д';
                        const departureTime = formatDateTime(route.departureTime);
                        const arrivalTime = formatDateTime(route.arrivalTime);
                        const trainNumber = route.train && route.train.trainNumber ? route.train.trainNumber : 'Н/Д';
                        const price = route.price ? route.price.toFixed(2) + ' Br' : 'Н/Д';
                        // Получаем доступные места
                        let availableSeats = route.availableSeats !== null && route.availableSeats !== undefined ? route.availableSeats : 0;
                        
                        // Получаем общее количество мест (приоритет: route.totalSeats > train.totalSeats)
                        let totalSeats = 0;
                        if (route.totalSeats !== null && route.totalSeats !== undefined && route.totalSeats > 0) {
                            totalSeats = route.totalSeats;
                        } else if (route.train && route.train.totalSeats !== null && route.train.totalSeats !== undefined && route.train.totalSeats > 0) {
                            totalSeats = route.train.totalSeats;
                        } else {
                            // Если totalSeats не указан, используем availableSeats как максимальное значение
                            totalSeats = availableSeats > 0 ? availableSeats : 0;
                        }
                        
                        // Исправляем: availableSeats не может быть больше totalSeats
                        const finalAvailableSeats = availableSeats > totalSeats ? totalSeats : availableSeats;
                        const finalTotalSeats = totalSeats;

                        const routeCard =
                            '<div class="route-card">' +
                            '<div class="route-image">' +
                            '<i class="fas fa-route"></i>' +
                            '</div>' +
                            '<div class="route-body">' +
                            '<h3 class="route-title">' + departureCity + ' → ' + arrivalCity + '</h3>' +
                            '<div class="route-details">' +
                            '<div class="route-detail-item"><span class="route-meta-label"><i class="fas fa-train"></i> Поезд №:</span> <span class="route-meta-value">' + trainNumber + '</span></div>' +
                            '<div class="route-detail-item"><span class="route-meta-label"><i class="far fa-clock"></i> Отправление:</span> <span class="route-meta-value">' + departureTime + '</span></div>' +
                            '<div class="route-detail-item"><span class="route-meta-label"><i class="fas fa-clock"></i> Прибытие:</span> <span class="route-meta-value">' + arrivalTime + '</span></div>' +
                            '</div>' +
                            '<div class="route-price-seats">' +
                            '<span class="route-price">' + price + '</span>' +
                            '<span class="route-seats">Мест: ' + finalAvailableSeats + ' / ' + finalTotalSeats + '</span>' +
                            '</div>' +
                            '<div class="route-actions">' +
                            '<button class="btn btn-outline-purple edit-route" data-id="' + id + '">' +
                            '<i class="fas fa-edit"></i> Редактировать' +
                            '</button>' +
                            '<button class="btn btn-danger delete-route" data-id="' + id + '">' +
                            '<i class="fas fa-trash"></i> Удалить' +
                            '</button>' +
                            '</div>' +
                            '</div>' +
                            '</div>';

                        $('.routes-grid').append(routeCard);
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Ошибка при загрузке маршрутов:', xhr, status, error);
                    let errorMsg = 'Ошибка загрузки маршрутов';
                    
                    if (xhr.status === 0) {
                        errorMsg = 'Не удалось подключиться к серверу. Проверьте подключение.';
                    } else if (xhr.status === 404) {
                        errorMsg = 'API маршрутов не найден.';
                    } else if (xhr.status === 500) {
                        errorMsg = 'Внутренняя ошибка сервера при загрузке маршрутов.';
                    } else if (xhr.responseText) {
                        try {
                            const error = JSON.parse(xhr.responseText);
                            if (error.message) {
                                errorMsg = error.message;
                            }
                        } catch (e) {
                            errorMsg = xhr.responseText;
                        }
                    }
                    
                    $('.routes-grid').html('<p class="text-danger" style="padding: 20px; text-align: center;">' + errorMsg + '</p>');
                }
            });
        }

        // --- Экспорт в Excel ---
        document.getElementById('exportExcelBtn').addEventListener('click', function () {
            if (!routesData || routesData.length === 0) {
                alert('Нет данных для экспорта.');
                return;
            }

            const worksheetData = routesData.map(route => ({
                ID: route.id,
                Поезд: route.train && route.train.trainNumber ? route.train.trainNumber : 'Н/Д',
                Отправление: route.departureStation && route.departureStation.city ? route.departureStation.city : 'Н/Д',
                Прибытие: route.arrivalStation && route.arrivalStation.city ? route.arrivalStation.city : 'Н/Д',
                'Время отправления': formatDateTime(route.departureTime),
                'Время прибытия': formatDateTime(route.arrivalTime),
                Цена: route.price,
                'Доступные места': route.availableSeats,
            }));

            const workbook = XLSX.utils.book_new();
            const worksheet = XLSX.utils.json_to_sheet(worksheetData);
            XLSX.utils.book_append_sheet(workbook, worksheet, 'Маршруты');
            XLSX.writeFile(workbook, 'routes.xlsx');
        });

        // Загружаем все маршруты при загрузке страницы
        loadRoutes();

        // --- Выход ---
        function logout() {
            localStorage.removeItem("jwtToken");
            sessionStorage.removeItem("jwtToken");
            document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
            window.location.href = "/home";
        }
        window.logout = logout; // Делаем функцию доступной глобально для onclick
    });
</script>
</body>
</html>