<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Админ-центр | Парикмахерская "Элегант"</title>
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

        /* Карточки статистики */
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

        /* Таблицы */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: #FFF;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .data-table th {
            background: var(--charcoal);
            color: #FFF;
            padding: 15px 20px;
            text-align: left;
            font-weight: 500;
            font-family: 'Playfair Display', serif;
        }

        .data-table td {
            padding: 12px 20px;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .data-table tr:last-child td {
            border-bottom: none;
        }

        .data-table tr:hover {
            background: rgba(138, 43, 226, 0.03);
        }

        /* Кнопки */
        .btn {
            padding: 10px 20px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            font-weight: 500;
        }

        .btn i {
            margin-right: 8px;
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

        /* Бейджи статусов */
        .status-badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-confirmed {
            background: rgba(76, 175, 80, 0.1);
            color: var(--success);
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.1);
            color: var(--warning);
        }

        .status-cancelled {
            background: rgba(244, 67, 54, 0.1);
            color: var(--danger);
        }

        .interactive-calendar {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            margin-top: 30px;
            border: 1px solid rgba(138, 43, 226, 0.1);
        }

        .calendar-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .calendar-title {
            font-family: 'Playfair Display', serif;
            color: var(--charcoal);
            font-size: 1.2rem;
            margin: 0 15px;
            min-width: 180px;
            text-align: center;
        }

        .nav-button {
            background: none;
            border: none;
            color: var(--purple);
            cursor: pointer;
            font-size: 1rem;
            padding: 5px 10px;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
        }

        .nav-button:hover {
            background: rgba(138, 43, 226, 0.1);
        }

        .calendar-weekdays {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            text-align: center;
            margin-bottom: 15px;
            font-weight: 500;
            color: var(--slate);
            font-size: 0.85rem;
        }

        .calendar-days {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            gap: 8px;
            min-height: 200px;
        }

        .calendar-day {
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            position: relative;
        }

        .calendar-day:hover {
            background: rgba(138, 43, 226, 0.1);
            color: var(--purple);
        }

        .calendar-day.weekend {
            color: var(--slate);
        }

        .calendar-day.today {
            background: var(--purple);
            color: white !important;
            font-weight: 600;
            box-shadow: 0 3px 10px rgba(138, 43, 226, 0.3);
        }

        .calendar-day.other-month {
            color: #ccc;
            opacity: 0.6;
        }

        .calendar-footer {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid rgba(138, 43, 226, 0.1);
        }

        .legend {
            display: flex;
            gap: 15px;
            font-size: 0.8rem;
            color: var(--slate);
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* Дополнительные стили для эффектов */
        .calendar-day.has-event::after {
            content: '';
            position: absolute;
            bottom: 3px;
            left: 50%;
            transform: translateX(-50%);
            width: 4px;
            height: 4px;
            border-radius: 50%;
            background: var(--purple);
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
    <!-- Боковая панель -->
    <div class="admin-sidebar">
        <div class="admin-header">
            <div class="admin-title">
                <i class="fas fa-crown"></i>
                <h1>Элегант Админ</h1>
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
                    <i class="fas fa-calendar-check nav-icon"></i>
                    <span class="nav-text">Записи</span>
                    <span class="badge">${pendingAppointments}</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/adminClients" class="nav-link">
                    <i class="fas fa-users nav-icon"></i>
                    <span class="nav-text">Клиенты</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/master" class="nav-link">
                    <i class="fas fa-user-tie nav-icon"></i>
                    <span class="nav-text">Персонал</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/serviceAdmin" class="nav-link">
                    <i class="fas fa-cut nav-icon"></i>
                    <span class="nav-text">Услуги</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/statistic" class="nav-link">
                    <i class="fas fa-chart-bar nav-icon"></i>
                    <span class="nav-text">Отчеты</span>
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


        <!-- Основное содержимое -->
    <div class="admin-content">
        <div class="page-header">
            <h2 class="page-title">Панель управления</h2>
        </div>

        <!-- Статистика -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-calendar-day"></i>
                </div>
                <div class="stat-value">${stats.todayAppointments}</div>
                <div class="stat-label">Записи на сегодня</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-value" id="total-users">Загружается...</div>
                <div class="stat-label">Клиенты в системе</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-ruble-sign"></i>
                </div>
                <div class="stat-value">${stats.todayRevenue} Byn</div>
                <div class="stat-label">Доход сегодня</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-value">${stats.pendingAppointments}</div>
                <div class="stat-label">Ожидают подтверждения</div>
            </div>
        </div>

        <!-- Последние записи -->
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
                    <span class="legend-item"><i class="fas fa-circle" style="color: var(--slate)"></i> Выходные</span>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

    document.addEventListener('DOMContentLoaded', function() {
        const calendarDays = document.querySelector('.calendar-days');
        const calendarTitle = document.querySelector('.calendar-title');
        const prevMonthBtn = document.querySelector('.prev-month');
        const nextMonthBtn = document.querySelector('.next-month');

        let currentDate = new Date();

        // Русские названия месяцев
        const monthNames = [
            'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
            'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'
        ];

        function renderCalendar(date) {
            const year = date.getFullYear();
            const month = date.getMonth();

            // Установка заголовка
            calendarTitle.textContent = monthNames[month] + ' ' + year;


            // Очистка календаря
            calendarDays.innerHTML = '';

            // Первый день месяца
            const firstDay = new Date(year, month, 1);
            // Последний день месяца
            const lastDay = new Date(year, month + 1, 0);
            // День недели первого дня месяца (0-6)
            const firstDayWeekday = firstDay.getDay() === 0 ? 6 : firstDay.getDay() - 1;
            // Последнее число месяца
            const lastDate = lastDay.getDate();

            // Дни предыдущего месяца
            const prevMonthLastDay = new Date(year, month, 0).getDate();
            for (let i = firstDayWeekday - 1; i >= 0; i--) {
                const day = document.createElement('div');
                day.className = 'calendar-day other-month';
                day.textContent = prevMonthLastDay - i;
                calendarDays.appendChild(day);
            }

            // Дни текущего месяца
            const today = new Date();
            for (let i = 1; i <= lastDate; i++) {
                const day = document.createElement('div');
                day.className = 'calendar-day';
                day.textContent = i;

                // Проверка на выходные (суббота или воскресенье)
                const currentDay = new Date(year, month, i);
                if (currentDay.getDay() === 0 || currentDay.getDay() === 6) {
                    day.classList.add('weekend');
                }

                // Проверка на сегодняшний день
                if (i === today.getDate() && month === today.getMonth() && year === today.getFullYear()) {
                    day.classList.add('today');
                }

                // Случайные "события" для визуализации (каждый 3-5 день)
                if (i % Math.floor(Math.random() * 3 + 3) === 0) {
                    day.classList.add('has-event');
                }

                calendarDays.appendChild(day);
            }

            // Дни следующего месяца
            const daysFromNextMonth = 42 - (firstDayWeekday + lastDate);
            for (let i = 1; i <= daysFromNextMonth; i++) {
                const day = document.createElement('div');
                day.className = 'calendar-day other-month';
                day.textContent = i;
                calendarDays.appendChild(day);
            }
        }

        // Инициализация календаря
        renderCalendar(currentDate);

        // Обработчики кнопок
        prevMonthBtn.addEventListener('click', function() {
            currentDate.setMonth(currentDate.getMonth() - 1);
            renderCalendar(currentDate);
            animateButton(this);
        });

        nextMonthBtn.addEventListener('click', function() {
            currentDate.setMonth(currentDate.getMonth() + 1);
            renderCalendar(currentDate);
            animateButton(this);
        });

        // Анимация кнопок
        function animateButton(button) {
            button.style.transform = 'scale(0.9)';
            setTimeout(() => {
                button.style.transform = 'scale(1)';
            }, 200);
        }

        // Анимация дней при клике
        calendarDays.addEventListener('click', function(e) {
            if (e.target.classList.contains('calendar-day')) {
                e.target.style.transform = 'scale(0.95)';
                setTimeout(() => {
                    e.target.style.transform = 'scale(1)';
                }, 200);
            }
        });
    });

    // Инициализация админ-панели
    $(document).ready(function() {
        // AJAX-запрос на получение общего количества пользователей
        $.ajax({
            url: '/admin/clients/dashboard',  // URL вашего метода getDashboard
            method: 'GET',
            success: function(response) {
                // Получаем данные (например, totalUsers)
                var totalUsers = response.totalUsers;
                // Отображаем на странице (например, в элемент с id="total-users")
                $('#total-users').text(totalUsers);
            },
            error: function(xhr, status, error) {
                console.error('Ошибка при получении данных пользователей:', error);
            }
        });

        // AJAX-запрос на получение количества записей на сегодня
        $.ajax({
            url: '/records/today', // Эндпоинт для получения количества записей на сегодня
            method: 'GET',
            success: function(response) {
                // Отображаем данные в блоке статистики
                $('.stat-card .stat-value').first().text(response); // Предполагается, что первый блок для "Записей на сегодня"
            },
            error: function(xhr, status, error) {
                console.error('Ошибка при получении данных записей на сегодня:', error);
            }
        });

        $.ajax({
            url: '/records/revenue/today', // Эндпоинт для получения дохода за сегодня
            method: 'GET',
            success: function(response) {
                // Отображаем данные в блоке "Доход сегодня"
                $('.stat-card .stat-value').eq(2).text(response + ' Br'); // Предполагается, что третий блок — для дохода
            },
            error: function(xhr, status, error) {
                console.error('Ошибка при получении данных дохода за сегодня:', error);
            }
        });

        $.ajax({
            url: '/records/pending/count', // Эндпоинт для получения количества записей со статусом "ожидание"
            method: 'GET',
            success: function(response) {
                // Отображаем данные в блоке "Ожидают подтверждения"
                $('.stat-card .stat-value').eq(3).text(response); // Четвертый блок для "Ожидают подтверждения"
            },
            error: function(xhr, status, error) {
                console.error('Ошибка при получении данных ожиданий:', error);
            }
        });
    });
    function logout() {
        // Удаляем токен из localStorage (или sessionStorage, cookies)
        localStorage.removeItem("jwtToken");  // Для localStorage
        sessionStorage.removeItem("jwtToken");  // Для sessionStorage

        // Также можно удалить cookie (если хранится в cookies)
        document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";

        // Перенаправляем пользователя на страницу входа
        window.location.href = "/home";  // Замените "/login" на нужный URL
    }
</script>
</body>
</html>