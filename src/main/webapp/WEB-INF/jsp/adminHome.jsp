<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Админ-центр | Система управления ЖД</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* CSS ОСТАВЛЕН БЕЗ ИЗМЕНЕНИЙ (ФИОЛЕТОВАЯ ТЕМА) ДЛЯ СОХРАНЕНИЯ СТИЛЕЙ */
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: #FFF;
            border-radius: 6px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-top: 3px solid var(--purple);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 15px;
            background: rgba(138, 43, 226, 0.1);
            color: var(--purple);
            font-size: 1.3rem;
        }

        .stat-value {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 5px;
            color: var(--charcoal);
        }

        .stat-label {
            color: var(--slate);
            font-size: 0.9rem;
        }

        .interactive-calendar {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            margin-top: 30px;
            border: 1px solid rgba(138, 43, 226, 0.1);
        }

        .calendar-day {
            position: relative;
            cursor: pointer;
        }

        .calendar-day.has-event::after {
            content: '';
            position: absolute;
            bottom: 3px;
            left: 50%;
            transform: translateX(-50%);
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--purple);
        }

        .calendar-day.has-event:hover {
            background: rgba(138, 43, 226, 0.1);
        }

        .calendar-day.today {
            background: var(--purple) !important;
            color: white !important;
            font-weight: 600;
            box-shadow: 0 3px 10px rgba(138, 43, 226, 0.3);
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .calendar-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.2rem;
            color: var(--charcoal);
            font-weight: 600;
        }

        .nav-button {
            background: rgba(138, 43, 226, 0.1);
            border: none;
            border-radius: 50%;
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: var(--purple);
            transition: all 0.3s ease;
        }

        .nav-button:hover {
            background: rgba(138, 43, 226, 0.2);
            transform: scale(1.1);
        }

        .calendar-weekdays {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 5px;
            margin-bottom: 10px;
            font-weight: 600;
            color: var(--slate);
            text-align: center;
        }

        .calendar-days {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 5px;
        }

        .calendar-day {
            padding: 10px;
            text-align: center;
            border-radius: 4px;
            transition: all 0.3s ease;
            min-height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .calendar-day.other-month {
            color: #ccc;
        }

        .calendar-day.weekend {
            background: rgba(138, 43, 226, 0.05);
        }

        .calendar-footer {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid rgba(138, 43, 226, 0.1);
        }

        .legend {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.85rem;
            color: var(--slate);
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
                <a href="${pageContext.request.contextPath}/adminHome" class="nav-link active">
                    <i class="fas fa-tachometer-alt nav-icon"></i>
                    <span class="nav-text">Главная</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/recordAdmin" class="nav-link">
                    <i class="fas fa-route nav-icon"></i>
                    <span class="nav-text">Маршруты</span>
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
                    <span class="nav-text">Отчёты</span>
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
            <h2 class="page-title">Панель управления ЖД</h2>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-ticket-alt"></i>
                </div>
                <div class="stat-value" id="tickets-sold">...</div>
                <div class="stat-label">Билетов продано сегодня</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-route"></i>
                </div>
                <div class="stat-value" id="active-routes">...</div>
                <div class="stat-label">Активных маршрутов</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-money-bill-wave"></i>
                </div>
                <div class="stat-value" id="today-revenue">... BYN</div>
                <div class="stat-label">Выручка сегодня</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-value" id="departures-today">...</div>
                <div class="stat-label">Поездов в пути (сейчас)</div>
            </div>
        </div>

        <h3 style="margin-bottom: 20px; font-family: 'Playfair Display', serif; color: var(--charcoal);">
            <i class="fas fa-calendar-alt" style="color: var(--purple); margin-right: 10px;"></i>
            Предстоящие отправления (Календарь)
        </h3>
        <div class="interactive-calendar">
            <div class="calendar-header">
                <button class="nav-button prev-month"><i class="fas fa-chevron-left"></i></button>
                <h3 class="calendar-title">Месяц 2024</h3>
                <button class="nav-button next-month"><i class="fas fa-chevron-right"></i></button>
            </div>

            <div class="calendar-weekdays">
                <div>Пн</div>
                <div>Вт</div>
                <div>Ср</div>
                <div>Чт</div>
                <div>Пт</div>
                <div>Сб</div>
                <div>Вс</div>
            </div>

            <div class="calendar-days"></div>

            <div class="calendar-footer">
                <div class="legend">
                    <span class="legend-item"><i class="fas fa-circle" style="color: var(--purple)"></i> Сегодня</span>
                    <span class="legend-item"><i class="fas fa-circle" style="color: var(--purple); opacity: 0.3;"></i> Выходные</span>
                    <span class="legend-item"><i class="fas fa-dot-circle" style="color: var(--purple)"></i> Есть отправления</span>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // --- Логика Календаря с реальными данными ---
    document.addEventListener('DOMContentLoaded', function() {
        const calendarDays = document.querySelector('.calendar-days');
        const calendarTitle = document.querySelector('.calendar-title');
        const prevMonthBtn = document.querySelector('.prev-month');
        const nextMonthBtn = document.querySelector('.next-month');

        let currentDate = new Date();
        let routesByDay = {}; // Хранит маршруты по дням месяца

        const monthNames = [
            'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
            'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'
        ];

        // Загружает маршруты для указанного месяца
        function loadRoutesForMonth(year, month) {
            $.ajax({
                url: '/api/routes/by-month',
                method: 'GET',
                data: {
                    year: year,
                    month: month + 1 // Java месяцы начинаются с 1
                },
                success: function(response) {
                    routesByDay = {};
                    if (response.routes && Array.isArray(response.routes)) {
                        response.routes.forEach(function(route) {
                            if (route.departureTime) {
                                // Парсим дату отправления
                                const departureDate = new Date(route.departureTime);
                                const day = departureDate.getDate();
                                
                                if (!routesByDay[day]) {
                                    routesByDay[day] = [];
                                }
                                routesByDay[day].push(route);
                            }
                        });
                    }
                    // Перерисовываем календарь с новыми данными
                    renderCalendar(currentDate);
                },
                error: function(xhr, status, error) {
                    console.error('Ошибка при загрузке маршрутов:', error);
                    routesByDay = {};
                    renderCalendar(currentDate);
                }
            });
        }

        function renderCalendar(date) {
            const year = date.getFullYear();
            const month = date.getMonth();
            calendarTitle.textContent = monthNames[month] + ' ' + year;
            calendarDays.innerHTML = '';
            const firstDay = new Date(year, month, 1);
            const lastDay = new Date(year, month + 1, 0);
            const firstDayWeekday = firstDay.getDay() === 0 ? 6 : firstDay.getDay() - 1;
            const lastDate = lastDay.getDate();

            const prevMonthLastDay = new Date(year, month, 0).getDate();
            for (let i = firstDayWeekday - 1; i >= 0; i--) {
                const day = document.createElement('div');
                day.className = 'calendar-day other-month';
                day.textContent = prevMonthLastDay - i;
                calendarDays.appendChild(day);
            }

            const today = new Date();
            for (let i = 1; i <= lastDate; i++) {
                const day = document.createElement('div');
                day.className = 'calendar-day';
                day.textContent = i;
                const currentDay = new Date(year, month, i);
                if (currentDay.getDay() === 0 || currentDay.getDay() === 6) {
                    day.classList.add('weekend');
                }
                if (i === today.getDate() && month === today.getMonth() && year === today.getFullYear()) {
                    day.classList.add('today');
                }
                // Проверяем, есть ли отправления в этот день
                if (routesByDay[i] && routesByDay[i].length > 0) {
                    day.classList.add('has-event');
                    // Добавляем подсказку с количеством отправлений
                    day.title = routesByDay[i].length + ' отправлений';
                }
                calendarDays.appendChild(day);
            }

            const daysFromNextMonth = 42 - (firstDayWeekday + lastDate);
            for (let i = 1; i <= daysFromNextMonth; i++) {
                const day = document.createElement('div');
                day.className = 'calendar-day other-month';
                day.textContent = i;
                calendarDays.appendChild(day);
            }
        }

        // Загружаем маршруты для текущего месяца при загрузке страницы
        loadRoutesForMonth(currentDate.getFullYear(), currentDate.getMonth());
        renderCalendar(currentDate);

        prevMonthBtn.addEventListener('click', function() {
            currentDate.setMonth(currentDate.getMonth() - 1);
            loadRoutesForMonth(currentDate.getFullYear(), currentDate.getMonth());
            animateButton(this);
        });

        nextMonthBtn.addEventListener('click', function() {
            currentDate.setMonth(currentDate.getMonth() + 1);
            loadRoutesForMonth(currentDate.getFullYear(), currentDate.getMonth());
            animateButton(this);
        });

        function animateButton(button) {
            button.style.transform = 'scale(0.9)';
            setTimeout(() => {
                button.style.transform = 'scale(1)';
            }, 200);
        }
    });

    // --- AJAX логика (ЖД) ---
    $(document).ready(function() {
        // 1. Билетов продано сегодня
        $.ajax({
            url: '/api/tickets/sold/today',
            method: 'GET',
            success: function(response) {
                $('#tickets-sold').text(response.ticketsSoldToday || 0);
            },
            error: function() {
                $('#tickets-sold').text('N/A');
            }
        });

        // 2. Активные маршруты (Для панели и для badge в навигации)
        $.ajax({
            url: '/api/routes/active',
            method: 'GET',
            success: function(response) {
                const count = response.activeRoutesCount || 0;
                $('#active-routes').text(count);
            },
            error: function() {
                $('#active-routes').text('N/A');
            }
        });

        // 3. Выручка сегодня
        $.ajax({
            url: '/api/revenue/today',
            method: 'GET',
            success: function(response) {
                $('#today-revenue').text((response.todayRevenue || 0) + ' BYN');
            },
            error: function() {
                $('#today-revenue').text('N/A');
            }
        });

        // 4. Поездов в пути (сейчас)
        $.ajax({
            url: '/api/trains/in-transit',
            method: 'GET',
            success: function(response) {
                $('#departures-today').text(response.trainsInTransitCount || 0);
            },
            error: function() {
                $('#departures-today').text('N/A');
            }
        });
    });

    // --- Логика выхода ---
    function logout() {
        localStorage.removeItem("jwtToken");
        sessionStorage.removeItem("jwtToken");
        document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
        window.location.href = "/home";
    }
</script>
</body>
</html>