<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Выбор места | ЖД Билеты</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #8A2BE2;
            --success-color: #4CAF50;
            --danger-color: #F44336;
            --warning-color: #FFC107;
            --light-gray: #f5f5f5;
            --dark-gray: #666;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f5f7fa;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            padding: 30px;
        }

        .header {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid var(--light-gray);
        }

        .header h1 {
            color: var(--primary-color);
            font-size: 1.8rem;
            margin-bottom: 10px;
        }

        .route-info {
            color: var(--dark-gray);
            font-size: 0.95rem;
        }

        .seat-map-container {
            margin: 30px 0;
        }

        .seat-map-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 20px;
            color: #333;
        }

        .seat-legend {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            padding: 15px;
            background: var(--light-gray);
            border-radius: 8px;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .legend-color {
            width: 20px;
            height: 20px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .seat-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(60px, 1fr));
            gap: 10px;
            padding: 20px;
            background: var(--light-gray);
            border-radius: 8px;
            max-width: 800px;
            margin: 0 auto;
        }

        .seat {
            width: 60px;
            height: 60px;
            border: 2px solid #ddd;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            position: relative;
        }

        .seat.available {
            background: var(--success-color);
            color: white;
            border-color: var(--success-color);
        }

        .seat.available:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 8px rgba(76, 175, 80, 0.3);
        }

        .seat.occupied {
            background: var(--danger-color);
            color: white;
            border-color: var(--danger-color);
            cursor: not-allowed;
            opacity: 0.7;
        }

        .seat.selected {
            background: var(--warning-color);
            color: #333;
            border-color: var(--warning-color);
            box-shadow: 0 0 0 3px rgba(255, 193, 7, 0.5);
        }

        .seat-info {
            margin-top: 30px;
            padding: 20px;
            background: var(--light-gray);
            border-radius: 8px;
        }

        .selected-seat-info {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 10px;
        }

        .actions {
            display: flex;
            gap: 15px;
            margin-top: 30px;
            justify-content: center;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background: #7A1BD2;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
        }

        .btn-primary:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .loading {
            text-align: center;
            padding: 40px;
            color: var(--dark-gray);
        }

        .error {
            background: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 6px;
            margin: 20px 0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-chair"></i> Выбор места</h1>
        <div class="route-info" id="routeInfo">
            Загрузка информации о маршруте...
        </div>
    </div>

    <div id="loading" class="loading">
        <i class="fas fa-spinner fa-spin fa-2x"></i>
        <p>Загрузка карты мест...</p>
    </div>

    <div id="error" class="error" style="display: none;"></div>

    <div id="seatMapContainer" style="display: none;">
        <div class="seat-map-container">
            <h3 class="seat-map-title">Выберите место</h3>
            
            <div class="seat-legend">
                <div class="legend-item">
                    <div class="legend-color" style="background: var(--success-color);"></div>
                    <span>Свободно</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color" style="background: var(--danger-color);"></div>
                    <span>Занято</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color" style="background: var(--warning-color);"></div>
                    <span>Выбрано</span>
                </div>
            </div>

            <div class="seat-grid" id="seatGrid">
                <!-- Места будут добавлены динамически -->
            </div>
        </div>

        <div class="seat-info">
            <div class="selected-seat-info" id="selectedSeatInfo">
                Место не выбрано
            </div>
            <div id="seatDetails"></div>
        </div>

        <div class="actions">
            <button class="btn btn-secondary" onclick="goBack()">
                <i class="fas fa-arrow-left"></i> Назад
            </button>
            <button class="btn btn-primary" id="confirmBtn" onclick="confirmSelection()" disabled>
                <i class="fas fa-check"></i> Подтвердить выбор
            </button>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    let selectedSeat = null;
    let routeId = null;
    let seatMap = null;

    $(document).ready(function() {
        // Получаем routeId из URL параметров
        const urlParams = new URLSearchParams(window.location.search);
        routeId = urlParams.get('routeId');
        
        if (!routeId) {
            showError('Не указан ID маршрута');
            return;
        }

        loadSeatMap(routeId);
    });

    function loadSeatMap(routeId) {
        $.ajax({
            url: '${pageContext.request.contextPath}/api/seats/route/' + routeId,
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                seatMap = data;
                $('#loading').hide();
                $('#seatMapContainer').show();
                displayRouteInfo(data);
                renderSeats(data.seats);
            },
            error: function(xhr, status, error) {
                $('#loading').hide();
                showError('Ошибка при загрузке карты мест: ' + (xhr.responseJSON?.message || error));
            }
        });
    }

    function displayRouteInfo(data) {
        // Здесь можно добавить информацию о маршруте, если она доступна
        $('#routeInfo').html(
            'Всего мест: ' + data.totalSeats + 
            ' | Доступно: ' + data.availableSeats + 
            ' | Занято: ' + data.occupiedSeats.length
        );
    }

    function renderSeats(seats) {
        const seatGrid = $('#seatGrid');
        seatGrid.empty();

        seats.forEach(function(seat) {
            const seatElement = $('<div>')
                .addClass('seat')
                .addClass(seat.occupied ? 'occupied' : 'available')
                .text(seat.number)
                .data('seat-number', seat.number)
                .data('occupied', seat.occupied);

            if (!seat.occupied) {
                seatElement.on('click', function() {
                    selectSeat(seat.number);
                });
            }

            seatGrid.append(seatElement);
        });
    }

    function selectSeat(seatNumber) {
        // Снимаем выделение с предыдущего места
        if (selectedSeat) {
            $('.seat[data-seat-number="' + selectedSeat + '"]')
                .removeClass('selected')
                .addClass('available');
        }

        // Выделяем новое место
        selectedSeat = seatNumber;
        $('.seat[data-seat-number="' + seatNumber + '"]')
            .removeClass('available')
            .addClass('selected');

        // Обновляем информацию
        $('#selectedSeatInfo').text('Выбрано место: №' + seatNumber);
        $('#confirmBtn').prop('disabled', false);
    }

    function confirmSelection() {
        if (!selectedSeat) {
            alert('Пожалуйста, выберите место');
            return;
        }

        if (!confirm('Подтвердить выбор места №' + selectedSeat + '?')) {
            return;
        }

        // Здесь можно перейти на страницу оформления билета или отправить данные
        // Например, передать selectedSeat и routeId в форму бронирования
        const userId = getUserIdFromToken(); // Получить из токена
        
        if (!userId) {
            alert('Необходимо войти в систему');
            window.location.href = '${pageContext.request.contextPath}/signin';
            return;
        }

        // Перенаправляем на страницу оплаты
        window.location.href = '${pageContext.request.contextPath}/payment?routeId=' + routeId + 
            '&seatNumber=' + selectedSeat + '&userId=' + userId;
    }

    function getUserIdFromToken() {
        try {
            const token = localStorage.getItem('jwtToken');
            if (!token) return null;
            
            // Простое декодирование JWT (в реальном приложении используйте библиотеку)
            const payload = JSON.parse(atob(token.split('.')[1]));
            return payload.id || payload.userId;
        } catch (e) {
            return null;
        }
    }

    function goBack() {
        window.history.back();
    }

    function showError(message) {
        $('#error').text(message).show();
    }
</script>
</body>
</html>


