<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Отчёты и статистика | ЖД-Портал</title>
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-top: 3px solid var(--purple);
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .stat-card h3 {
            font-size: 0.9rem;
            color: var(--slate);
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-card .value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--charcoal);
            margin-bottom: 5px;
        }

        .stat-card .icon {
            font-size: 2.5rem;
            color: var(--purple);
            opacity: 0.3;
            float: right;
            margin-top: -40px;
        }

        .charts-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 40px;
        }

        .chart-card {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-top: 3px solid var(--purple);
        }

        .chart-card h3 {
            font-size: 1.2rem;
            margin-bottom: 20px;
            color: var(--charcoal);
            display: flex;
            align-items: center;
        }

        .chart-card h3 i {
            margin-right: 10px;
            color: var(--purple);
        }

        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }

        .popular-routes {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-top: 3px solid var(--purple);
        }

        .popular-routes h3 {
            font-size: 1.2rem;
            margin-bottom: 20px;
            color: var(--charcoal);
            display: flex;
            align-items: center;
        }

        .popular-routes h3 i {
            margin-right: 10px;
            color: var(--purple);
        }

        .route-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            margin-bottom: 10px;
            background: var(--light-purple);
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .route-item:hover {
            background: rgba(138, 43, 226, 0.1);
            transform: translateX(5px);
        }

        .route-name {
            font-weight: 600;
            color: var(--charcoal);
        }

        .route-count {
            color: var(--purple);
            font-weight: 700;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-primary {
            background: var(--purple);
            color: white;
        }

        .btn-primary:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
        }

        @media (max-width: 992px) {
            .admin-layout {
                grid-template-columns: 1fr;
            }
            .admin-sidebar {
                display: none;
            }
            .charts-container {
                grid-template-columns: 1fr;
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
                <a href="${pageContext.request.contextPath}/statistic" class="nav-link active">
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
            <h2 class="page-title">Отчёты и статистика</h2>
            <button class="btn btn-primary" onclick="exportToExcel()">
                <i class="fas fa-file-excel"></i> Экспорт в Excel
            </button>
        </div>

        <div class="stats-grid" id="statsGrid">
            <div class="stat-card">
                <h3>Всего билетов</h3>
                <div class="value" id="totalTickets">-</div>
                <i class="fas fa-ticket-alt icon"></i>
            </div>
            <div class="stat-card">
                <h3>Всего маршрутов</h3>
                <div class="value" id="totalRoutes">-</div>
                <i class="fas fa-route icon"></i>
            </div>
            <div class="stat-card">
                <h3>Общая выручка</h3>
                <div class="value" id="totalRevenue">-</div>
                <i class="fas fa-ruble-sign icon"></i>
            </div>
            <div class="stat-card">
                <h3>Всего пользователей</h3>
                <div class="value" id="totalUsers">-</div>
                <i class="fas fa-users icon"></i>
            </div>
        </div>

        <div class="charts-container">
            <div class="chart-card">
                <h3><i class="fas fa-chart-bar"></i> Продажи билетов по месяцам</h3>
                <div class="chart-container">
                    <canvas id="ticketsChart"></canvas>
                </div>
            </div>
            <div class="chart-card">
                <h3><i class="fas fa-chart-line"></i> Выручка по месяцам</h3>
                <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>

        <div class="popular-routes">
            <h3><i class="fas fa-star"></i> Топ-4 популярных маршрута</h3>
            <div id="popularRoutesList">
                <p style="text-align: center; color: var(--slate); padding: 20px;">Загрузка данных...</p>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script>
    let ticketsChart, revenueChart;

    // Загрузка общей статистики
    async function loadGeneralStats() {
        try {
            // Всего билетов (за всё время)
            const ticketsRes = await fetch('/api/tickets/total');
            const ticketsData = await ticketsRes.json();
            document.getElementById('totalTickets').textContent = ticketsData.totalTickets || 0;

            // Всего маршрутов (за всё время)
            const routesRes = await fetch('/api/routes/total');
            const routesData = await routesRes.json();
            document.getElementById('totalRoutes').textContent = routesData.totalRoutes || 0;

            // Общая выручка (за всё время)
            const revenueRes = await fetch('/api/revenue/total');
            const revenueData = await revenueRes.json();
            document.getElementById('totalRevenue').textContent = (revenueData.totalRevenue || 0).toFixed(2) + ' BYN';

            // Всего пользователей
            const usersRes = await fetch('/api/users/count');
            const usersData = await usersRes.json();
            document.getElementById('totalUsers').textContent = usersData.totalUsers || 0;
        } catch (error) {
            console.error('Ошибка загрузки общей статистики:', error);
        }
    }

    // Загрузка данных для графика продаж билетов
    async function loadTicketsChart() {
        try {
            const response = await fetch('/api/tickets/by-month');
            const data = await response.json();
            const ticketsData = data.ticketsByMonth || {};

            const labels = Object.keys(ticketsData);
            const values = Object.values(ticketsData);

            const ctx = document.getElementById('ticketsChart').getContext('2d');
            if (ticketsChart) {
                ticketsChart.destroy();
            }

            ticketsChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Проданные билеты',
                        data: values,
                        backgroundColor: 'rgba(138, 43, 226, 0.6)',
                        borderColor: 'rgba(138, 43, 226, 1)',
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        } catch (error) {
            console.error('Ошибка загрузки графика продаж:', error);
        }
    }

    // Загрузка данных для графика выручки
    async function loadRevenueChart() {
        try {
            const response = await fetch('/api/revenue/by-month');
            const data = await response.json();
            const revenueData = data.revenueByMonth || {};

            const labels = Object.keys(revenueData);
            const values = Object.values(revenueData);

            const ctx = document.getElementById('revenueChart').getContext('2d');
            if (revenueChart) {
                revenueChart.destroy();
            }

            revenueChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Выручка (BYN)',
                        data: values,
                        backgroundColor: 'rgba(138, 43, 226, 0.1)',
                        borderColor: 'rgba(138, 43, 226, 1)',
                        borderWidth: 2,
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: 'rgba(138, 43, 226, 1)',
                        pointRadius: 4,
                        pointHoverRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return value.toLocaleString('ru-RU') + ' BYN';
                                }
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    return context.parsed.y.toLocaleString('ru-RU') + ' BYN';
                                }
                            }
                        }
                    }
                }
            });
        } catch (error) {
            console.error('Ошибка загрузки графика выручки:', error);
        }
    }

    // Загрузка популярных маршрутов
    async function loadPopularRoutes() {
        try {
            const response = await fetch('/api/routes/popular');
            if (!response.ok) {
                throw new Error('HTTP error! status: ' + response.status);
            }
            const data = await response.json();
            console.log('Полученные данные популярных маршрутов:', data);
            const routes = data.popularRoutes || [];

            const container = document.getElementById('popularRoutesList');
            if (!container) {
                console.error('Элемент popularRoutesList не найден');
                return;
            }

            if (routes.length === 0) {
                container.innerHTML = '<p style="text-align: center; color: var(--slate); padding: 20px;">Нет данных о популярных маршрутах</p>';
                return;
            }

            console.log('Отображаем маршруты:', routes);
            let html = '';
            routes.forEach((route, index) => {
                html += '<div class="route-item">';
                html += '<span class="route-name">' + (index + 1) + '. ' + (route.route || 'Неизвестный маршрут') + '</span>';
                html += '<span class="route-count">' + (route.count || 0) + ' билетов</span>';
                html += '</div>';
            });
            container.innerHTML = html;
        } catch (error) {
            console.error('Ошибка загрузки популярных маршрутов:', error);
            const container = document.getElementById('popularRoutesList');
            if (container) {
                container.innerHTML = '<p style="text-align: center; color: var(--danger); padding: 20px;">Ошибка загрузки данных: ' + error.message + '</p>';
            }
        }
    }

    // Экспорт в Excel
    async function exportToExcel() {
        try {
            const [ticketsData, revenueData, routesData, statsData] = await Promise.all([
                fetch('/api/tickets/by-month').then(r => r.json()),
                fetch('/api/revenue/by-month').then(r => r.json()),
                fetch('/api/routes/popular').then(r => r.json()),
                Promise.all([
                    fetch('/api/tickets/total').then(r => r.json()),
                    fetch('/api/routes/total').then(r => r.json()),
                    fetch('/api/revenue/total').then(r => r.json()),
                    fetch('/api/users/count').then(r => r.json())
                ])
            ]);

            const wb = XLSX.utils.book_new();

            // Общая статистика
            const statsSheet = [
                ['Показатель', 'Значение'],
                ['Всего билетов (за всё время)', statsData[0].totalTickets || 0],
                ['Всего маршрутов (за всё время)', statsData[1].totalRoutes || 0],
                ['Общая выручка (за всё время, BYN)', (statsData[2].totalRevenue || 0).toFixed(2)],
                ['Всего пользователей', statsData[3].totalUsers || 0]
            ];
            const ws1 = XLSX.utils.aoa_to_sheet(statsSheet);
            ws1['!cols'] = [{ wch: 35 }, { wch: 20 }];
            XLSX.utils.book_append_sheet(wb, ws1, 'Общая статистика');

            // Продажи по месяцам
            const ticketsSheet = [
                ['Месяц', 'Количество билетов'],
                ...Object.entries(ticketsData.ticketsByMonth || {}).map(([month, count]) => [month, count])
            ];
            const ws2 = XLSX.utils.aoa_to_sheet(ticketsSheet);
            ws2['!cols'] = [{ wch: 15 }, { wch: 20 }];
            XLSX.utils.book_append_sheet(wb, ws2, 'Продажи по месяцам');

            // Выручка по месяцам
            const revenueSheet = [
                ['Месяц', 'Выручка (BYN)'],
                ...Object.entries(revenueData.revenueByMonth || {}).map(([month, revenue]) => [month, revenue])
            ];
            const ws3 = XLSX.utils.aoa_to_sheet(revenueSheet);
            ws3['!cols'] = [{ wch: 15 }, { wch: 20 }];
            XLSX.utils.book_append_sheet(wb, ws3, 'Выручка по месяцам');

            // Популярные маршруты
            const routesSheet = [
                ['Маршрут', 'Количество проданных билетов'],
                ...(routesData.popularRoutes || []).map(route => [route.route, route.count])
            ];
            const ws4 = XLSX.utils.aoa_to_sheet(routesSheet);
            ws4['!cols'] = [{ wch: 40 }, { wch: 30 }];
            XLSX.utils.book_append_sheet(wb, ws4, 'Популярные маршруты');

            XLSX.writeFile(wb, 'statistics_report.xlsx');
            alert('Отчёт успешно экспортирован!');
        } catch (error) {
            console.error('Ошибка экспорта:', error);
            alert('Ошибка при экспорте отчёта');
        }
    }

    // Инициализация при загрузке страницы
    document.addEventListener('DOMContentLoaded', function() {
        loadGeneralStats();
        loadTicketsChart();
        loadRevenueChart();
        loadPopularRoutes();
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
