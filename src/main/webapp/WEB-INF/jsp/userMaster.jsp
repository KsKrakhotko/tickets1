<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Поезда | Железнодорожные перевозки</title>
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

        .info-card {
            background: #FFF;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            border-top: 4px solid var(--purple);
        }

        .info-card h3 {
            font-family: 'Playfair Display', serif;
            color: var(--charcoal);
            margin-bottom: 15px;
            font-size: 1.4rem;
        }

        .info-card p {
            color: var(--slate);
            line-height: 1.8;
            margin-bottom: 15px;
        }

        .data-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 30px;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .data-table th {
            background: var(--purple);
            color: #fff;
            padding: 15px 20px;
            text-align: left;
            font-weight: 500;
            font-family: 'Playfair Display', serif;
        }

        .data-table td {
            padding: 15px 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            font-size: 0.9rem;
        }

        .data-table tr:last-child td {
            border-bottom: none;
        }

        .data-table tr:hover td {
            background: rgba(138, 43, 226, 0.1);
            transition: background-color 0.3s ease;
        }

        .data-table tr:nth-child(even) td {
            background: #f9f9f9;
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
            <a href="${pageContext.request.contextPath}/serviceUser" class="nav-link">
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
            <h2 class="page-title">Поезда</h2>
    </div>

        <div class="info-card">
            <h3><i class="fas fa-train" style="color: var(--purple); margin-right: 10px;"></i>Наш парк поездов</h3>
            <p>
                Мы предлагаем современный и комфортабельный подвижной состав для ваших путешествий. 
                Наши поезда оснащены всеми необходимыми удобствами для комфортной поездки.
        </p>
            <p>
                Каждый поезд проходит регулярное техническое обслуживание и соответствует всем стандартам безопасности. 
                Выберите подходящий поезд для вашего маршрута!
        </p>
    </div>

    <table class="data-table">
        <thead>
        <tr>
                <th>Номер поезда</th>
                <th>Тип</th>
                <th>Количество мест</th>
        </tr>
        </thead>
            <tbody id="trainsTableBody">
        <!-- Данные будут загружены с помощью JavaScript -->
        </tbody>
    </table>
    </div>
</div>

<script>
    async function loadTrains() {
        try {
            const response = await fetch('/api/trains');
            if (!response.ok) throw new Error('Ошибка загрузки данных');
            const trains = await response.json();

            const tableBody = document.getElementById('trainsTableBody');
            tableBody.innerHTML = '';

            if (trains.length === 0) {
                tableBody.innerHTML = '<tr><td colspan="3" style="text-align: center; padding: 30px; color: var(--slate);">Поезда не найдены</td></tr>';
                return;
            }

            trains.forEach(train => {
            const row = document.createElement('tr');
            row.innerHTML =
                    '<td>' + (train.trainNumber || train.number || 'N/A') + '</td>' +
                    '<td>' + (train.type || 'Стандарт') + '</td>' +
                    '<td>' + (train.totalSeats || train.seats || 'N/A') + '</td>';
            tableBody.appendChild(row);
        });
        } catch (error) {
            console.error('Ошибка загрузки поездов:', error);
            document.getElementById('trainsTableBody').innerHTML = 
                '<tr><td colspan="3" style="text-align: center; padding: 30px; color: var(--danger);">Ошибка загрузки данных</td></tr>';
        }
    }

    document.addEventListener('DOMContentLoaded', loadTrains);

    function logout() {
        localStorage.removeItem("jwtToken");
        sessionStorage.removeItem("jwtToken");
        document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
        window.location.href = "/home";
    }
</script>
</body>
</html>
