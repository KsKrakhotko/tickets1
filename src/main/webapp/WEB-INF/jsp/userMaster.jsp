<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Видео по уходу за волосами | Парикмахерская "Элегант"</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Montserrat:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #6a4c93;
            --secondary-color: #8a5a44;
            --accent-color: #f8bbd0;
            --light-color: #f9f9f9;
            --dark-color: #333;
            --sidebar-width: 280px;
            --sidebar-collapsed-width: 80px;
            --transition-speed: 0.3s;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f5f7fa;
            color: var(--dark-color);
            overflow-x: hidden;
            transition: all var(--transition-speed) ease;
        }

        /* Сайдбар */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: var(--sidebar-width);
            background: linear-gradient(180deg, var(--primary-color) 0%, #5a3d7d 100%);
            box-shadow: 5px 0 15px rgba(0, 0, 0, 0.1);
            transition: width var(--transition-speed) ease;
            z-index: 1000;
            overflow: hidden;
        }

        .sidebar.collapsed {
            width: var(--sidebar-collapsed-width);
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px;
            height: 80px;
            background-color: rgba(0, 0, 0, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            color: white;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: 600;
            white-space: nowrap;
        }

        .logo-icon {
            font-size: 2rem;
            margin-right: 15px;
            color: var(--accent-color);
        }

        .logo-text {
            opacity: 1;
            transition: opacity var(--transition-speed);
        }

        .sidebar.collapsed .logo-text {
            opacity: 0;
        }

        .toggle-btn {
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
            transition: transform var(--transition-speed);
        }

        .sidebar.collapsed .toggle-btn {
            transform: rotate(180deg);
        }

        .nav-links {
            padding: 20px 0;
            height: calc(100vh - 80px);
            overflow-y: auto;
        }

        .nav-item {
            list-style: none;
            margin-bottom: 5px;
            padding: 0 15px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s;
            white-space: nowrap;
        }

        .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }

        .nav-link.active {
            background-color: var(--accent-color);
            color: var(--primary-color);
            font-weight: 500;
        }

        .nav-icon {
            font-size: 1.3rem;
            margin-right: 20px;
            min-width: 24px;
            text-align: center;
        }

        .nav-text {
            opacity: 1;
            transition: opacity var(--transition-speed);
        }

        .sidebar.collapsed .nav-text {
            opacity: 0;
        }

        /* Основное содержимое */
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 30px;
            min-height: 100vh;
            transition: margin-left var(--transition-speed);
        }

        .sidebar.collapsed ~ .main-content {
            margin-left: var(--sidebar-collapsed-width);
        }

        /* Заголовок */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }

        .page-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--primary-color);
            position: relative;
        }

        .page-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 2px;
            background: var(--primary-color);
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
            background: var(--primary-color);
            color: #fff;
            padding: 15px 20px;
            text-align: left;
            font-weight: 500;
            font-family: 'Playfair Display', serif;
            text-transform: uppercase;
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
            background: rgba(106, 76, 147, 0.1);
            transition: background-color 0.3s ease;
        }

        .data-table tr:nth-child(even) td {
            background: #f9f9f9;
        }

        .data-table td:first-child,
        .data-table th:first-child {
            border-radius: 8px 0 0 8px;
        }

        .data-table td:last-child,
        .data-table th:last-child {
            border-radius: 0 8px 8px 0;
        }

        .action-btn {
            background-color: var(--accent-color);
            color: var(--primary-color);
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .action-btn:hover {
            background-color: var(--secondary-color);
            color: #fff;
        }




        .action-btn i {
            margin-right: 5px;
        }

        /* Адаптивность */
        @media (max-width: 992px) {
            .sidebar {
                width: var(--sidebar-collapsed-width);
            }

            .sidebar .logo-text,
            .sidebar .nav-text {
                opacity: 0;
            }

            .main-content {
                margin-left: var(--sidebar-collapsed-width);
            }

            .sidebar:hover {
                width: var(--sidebar-width);
            }

            .sidebar:hover .logo-text,
            .sidebar:hover .nav-text {
                opacity: 1;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 0;
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
<!-- Боковая панель -->
<div class="sidebar">
    <div class="sidebar-header">
        <a href="/" class="logo">
            <i class="fas fa-scissors logo-icon"></i>
            <span class="logo-text">Элегант</span>
        </a>
        <button class="toggle-btn" onclick="toggleSidebar()">
            <i class="fas fa-angle-left"></i>
        </button>
    </div>

    <ul class="nav-links">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/serviceUser" class="nav-link">
                <i class="fas fa-cut nav-icon"></i>
                <span class="nav-text">Услуги</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/userMaster" class="nav-link active">
                <i class="fas fa-user-tie nav-icon"></i>
                <span class="nav-text">Мастера</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/booking" class="nav-link">
                <i class="fas fa-calendar-check nav-icon"></i>
                <span class="nav-text">Запись</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/video" class="nav-link">
                <i class="fas fa-spa nav-icon"></i>
                <span class="nav-text">Уход за волосами</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/reviews" class="nav-link">
                <i class="fas fa-star nav-icon"></i>
                <span class="nav-text">Отзывы</span>
            </a>
        </li>

        <li class="nav-item" style="margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/userHome" class="nav-link">
                <i class="fas fa-user nav-icon"></i>
                <span class="nav-text">Профиль</span>
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
<div class="main-content">
    <div class="header">
        <h2 class="page-title">Мастера "Элегант"</h2>
    </div>

    <div class="about-section" style="background-color: var(--light-color); padding: 20px; border-radius: 8px; margin-bottom: 20px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);">
        <h3 style="font-family: 'Playfair Display', serif; color: var(--primary-color); margin-bottom: 10px;">Лучшие мастера</h3>
        <p style="font-size: 1rem; line-height: 1.6; color: var(--dark-color);">
            Добро пожаловать в наш салон красоты! Наши мастера — это профессионалы с многолетним опытом,
            которые знают все тонкости своего дела. Мы предлагаем высококачественные услуги по уходу за волосами,
            используя только проверенные материалы и современные техники.
        </p>
        <p style="font-size: 1rem; line-height: 1.6; color: var(--dark-color);">
            Мы гарантируем индивидуальный подход к каждому клиенту, чтобы вы остались довольны результатом.
            Доверьтесь нам — и ваш стиль станет воплощением элегантности!
        </p>
    </div>

    <table class="data-table">
        <thead>
        <tr>
            <th>Имя</th>
            <th>Специализация</th>
            <th>Стаж</th>
        </tr>
        </thead>
        <tbody id="mastersTableBody">
        <!-- Данные будут загружены с помощью JavaScript -->
        </tbody>
    </table>
</div>

<script>
    async function loadMasters() {
        const response = await fetch('/api/masters');
        const masters = await response.json();

        const tableBody = document.getElementById('mastersTableBody');
        tableBody.innerHTML = ''; // Очищаем таблицу

        masters.forEach(master => {
            const row = document.createElement('tr');
            row.innerHTML =
                '<td>' + master.fullName + '</td>' +
                '<td>' + master.specialization + '</td>' +
                '<td>' + master.experience + '</td>';
            tableBody.appendChild(row);
        });
    }

    document.addEventListener('DOMContentLoaded', loadMasters);

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