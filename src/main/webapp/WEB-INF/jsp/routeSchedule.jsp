<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Расписание маршрута | Железнодорожные перевозки</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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

        .admin-layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            min-height: 100vh;
        }

        .admin-sidebar {
            background: linear-gradient(to bottom, #FFFFFF, #F8F8F8);
            box-shadow: 5px 0 15px rgba(0,0,0,0.05);
            border-right: 1px solid rgba(138, 43, 226, 0.3);
        }

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

        .admin-content {
            padding: 40px;
            background-color: #FFF;
        }

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

        .schedule-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 30px;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .schedule-table th {
            background: var(--purple);
            color: #fff;
            padding: 15px 20px;
            text-align: left;
            font-weight: 500;
            font-family: 'Playfair Display', serif;
        }

        .schedule-table td {
            padding: 15px 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            font-size: 0.9rem;
        }

        .schedule-table tr:last-child td {
            border-bottom: none;
        }

        .schedule-table tr:hover td {
            background: rgba(138, 43, 226, 0.1);
            transition: background-color 0.3s ease;
        }

        .schedule-table tr:nth-child(even) td {
            background: #f9f9f9;
        }

        .btn {
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-purple {
            background: var(--purple);
            color: white;
        }

        .btn-purple:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
        }

        .btn-purple:disabled {
            background: var(--slate);
            cursor: not-allowed;
            transform: none;
        }

        .route-info {
            background: #FFF;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            border-top: 4px solid var(--purple);
        }

        .route-info h3 {
            font-family: 'Playfair Display', serif;
            color: var(--charcoal);
            margin-bottom: 15px;
            font-size: 1.4rem;
        }

        .route-info p {
            color: var(--slate);
            line-height: 1.8;
            margin-bottom: 10px;
        }

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
                <h1>ЖД-Портал</h1>
            </div>
        </div>

        <ul class="nav-links">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/userHome" class="nav-link">
                    <i class="fas fa-user nav-icon"></i>
                    <span class="nav-text">Профиль</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/serviceUser" class="nav-link active">
                    <i class="fas fa-route nav-icon"></i>
                    <span class="nav-text">Маршруты</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/booking" class="nav-link">
                    <i class="fas fa-ticket-alt nav-icon"></i>
                    <span class="nav-text">Мои билеты</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/reviews" class="nav-link">
                    <i class="fas fa-star nav-icon"></i>
                    <span class="nav-text">Отзывы</span>
                </a>
            </li>
            <li class="nav-item" style="margin-top: 30px;">
                <a href="javascript:void(0);" class="nav-link" onclick="logout()">
                    <i class="fas fa-sign-out-alt nav-icon"></i>
                    <span class="nav-text">Выход</span>
                </a>
            </li>
        </ul>
    </div>

    <div class="admin-content">
        <div class="page-header">
            <h2 class="page-title">Расписание маршрута</h2>
        </div>

        <div class="route-info" id="routeInfo">
            <h3><i class="fas fa-route" style="color: var(--purple); margin-right: 10px;"></i><span id="routeName">Загрузка...</span></h3>
            <p id="routeDescription">Загрузка информации о маршруте...</p>
        </div>

        <table class="schedule-table">
            <thead>
            <tr>
                <th>Дата отправления</th>
                <th>Время отправления</th>
                <th>Время прибытия</th>
                <th>Цена</th>
                <th>Свободных мест</th>
                <th>Действия</th>
            </tr>
            </thead>
            <tbody id="scheduleTableBody">
            <tr>
                <td colspan="6" style="text-align: center; padding: 30px; color: var(--slate);">Загрузка расписания...</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // Получаем параметры из URL
        const urlParams = new URLSearchParams(window.location.search);
        const departure = urlParams.get('departure');
        const arrival = urlParams.get('arrival');

        if (!departure || !arrival) {
            $('#routeName').text('Ошибка');
            $('#routeDescription').text('Не указаны параметры маршрута');
            $('#scheduleTableBody').html('<tr><td colspan="6" style="text-align: center; padding: 30px; color: var(--danger);">Ошибка: не указаны станции отправления и прибытия</td></tr>');
            return;
        }

        const routeName = departure + ' → ' + arrival;
        $('#routeName').text(routeName);
        $('#routeDescription').text('Расписание рейсов по маршруту ' + routeName);

        // Загружаем расписание маршрута
        function loadSchedule() {
            $.ajax({
                url: '/routes',
                type: 'GET',
                dataType: 'json',
                success: function(routes) {
                    // Фильтруем маршруты по станциям и дате
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);

                    const filteredRoutes = routes.filter(function(route) {
                        if (!route.departureStation || !route.arrivalStation) return false;
                        if (!route.departureTime) return false;
                        
                        const departureDate = new Date(route.departureTime);
                        departureDate.setHours(0, 0, 0, 0);
                        
                        return route.departureStation.name === departure &&
                               route.arrivalStation.name === arrival &&
                               departureDate >= today &&
                               route.availableSeats > 0;
                    });

                    // Сортируем по дате отправления
                    filteredRoutes.sort(function(a, b) {
                        return new Date(a.departureTime) - new Date(b.departureTime);
                    });

                    const tableBody = $('#scheduleTableBody');
                    tableBody.empty();

                    if (filteredRoutes.length === 0) {
                        tableBody.html('<tr><td colspan="6" style="text-align: center; padding: 30px; color: var(--slate);">Нет доступных рейсов на ближайшие даты</td></tr>');
                        return;
                    }

                    filteredRoutes.forEach(function(route) {
                        const departureDate = new Date(route.departureTime);
                        const arrivalDate = new Date(route.arrivalTime);
                        
                        const formattedDate = departureDate.toLocaleDateString('ru-RU', {
                            day: '2-digit',
                            month: '2-digit',
                            year: 'numeric'
                        });
                        
                        const formattedDepartureTime = departureDate.toLocaleTimeString('ru-RU', {
                            hour: '2-digit',
                            minute: '2-digit'
                        });
                        
                        const formattedArrivalTime = arrivalDate.toLocaleTimeString('ru-RU', {
                            hour: '2-digit',
                            minute: '2-digit'
                        });

                        const row = $('<tr>');
                        row.html(
                            '<td>' + formattedDate + '</td>' +
                            '<td>' + formattedDepartureTime + '</td>' +
                            '<td>' + formattedArrivalTime + '</td>' +
                            '<td><strong>' + (route.price || 0) + ' BYN</strong></td>' +
                            '<td>' + (route.availableSeats || 0) + '</td>' +
                            '<td>' +
                            '<button class="btn btn-purple book-ticket" data-route-id="' + route.id + '">' +
                            '<i class="fas fa-ticket-alt"></i> Купить билет' +
                            '</button>' +
                            '</td>'
                        );
                        tableBody.append(row);
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Ошибка при загрузке расписания:', error);
                    $('#scheduleTableBody').html('<tr><td colspan="6" style="text-align: center; padding: 30px; color: var(--danger);">Ошибка загрузки расписания</td></tr>');
                }
            });
        }

        loadSchedule();

        // Обработчик для покупки билета
        $(document).on('click', '.book-ticket', function() {
            const routeId = $(this).data('route-id');
            const token = localStorage.getItem("jwtToken");

            if (!token) {
                alert("Пожалуйста, войдите в систему для покупки билета.");
                window.location.href = '/signin';
                return;
            }

            // Перенаправляем на страницу выбора места
            window.location.href = '/seatSelection?routeId=' + routeId;
        });
    });

    function logout() {
        localStorage.removeItem("jwtToken");
        sessionStorage.removeItem("jwtToken");
        document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
        window.location.href = "/home";
    }
</script>
</body>
</html>


