<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Мои записи | Парикмахерская "Элегант"</title>
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

        /* Стили для таблицы */
        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .appointments-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 0.95rem;
        }

        .appointments-table th {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 20px;
            text-align: left;
            font-weight: 500;
            position: sticky;
            top: 0;
        }

        .appointments-table th:first-child {
            border-top-left-radius: 10px;
        }

        .appointments-table th:last-child {
            border-top-right-radius: 10px;
        }

        .appointments-table td {
            padding: 15px 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            vertical-align: middle;
        }

        .appointments-table tr:last-child td {
            border-bottom: none;
        }

        .appointments-table tr:hover td {
            background-color: rgba(106, 76, 147, 0.05);
        }

        .appointments-table tr:nth-child(even) {
            background-color: rgba(249, 249, 249, 0.5);
        }

        /* Стили для кнопок */
        .btn {
            padding: 8px 15px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn i {
            margin-right: 5px;
        }

        .btn-edit {
            background-color: rgba(74, 144, 226, 0.1);
            color: #4a90e2;
        }

        .btn-edit:hover {
            background-color: rgba(74, 144, 226, 0.2);
        }

        .btn-cancel {
            background-color: rgba(226, 74, 74, 0.1);
            color: #e24a4a;
            margin-left: 8px;
        }

        .btn-cancel:hover {
            background-color: rgba(226, 74, 74, 0.2);
        }

        .btn-outline-purple {
            background-color: transparent;
            border: 1px solid var(--primary-color);
            color: var(--primary-color);
            padding: 8px 16px;
        }

        .btn-outline-purple:hover {
            background-color: rgba(106, 76, 147, 0.1);
        }

        .btn-outline-purple:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Пагинация */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            margin-top: 30px;
        }

        .page-info {
            font-size: 0.9rem;
            color: var(--dark-color);
            min-width: 120px;
            text-align: center;
        }

        /* Сообщение об отсутствии записей */
        .no-records {
            text-align: center;
            padding: 50px;
            color: #666;
            font-size: 1.1rem;
        }

        .no-records i {
            font-size: 2rem;
            color: #ddd;
            margin-bottom: 15px;
            display: block;
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

            .appointments-table {
                display: block;
                overflow-x: auto;
            }

            .appointments-table th,
            .appointments-table td {
                white-space: nowrap;
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
            <a href="${pageContext.request.contextPath}/userMaster" class="nav-link">
                <i class="fas fa-user-tie nav-icon"></i>
                <span class="nav-text">Мастера</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/booking" class="nav-link active">
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
        <h2 class="page-title">Мои записи</h2>
    </div>

    <div class="table-container">
        <table class="appointments-table">
            <thead>
            <tr>
                <th>Услуга</th>
                <th>Дата и время</th>
                <th>Мастер</th>
                <th>Цена</th>
                <th>Действия</th>
            </tr>
            </thead>
            <tbody id="appointmentsTableBody">
            <!-- Пример записи (будет заменено динамическим контентом) -->

            </tbody>
        </table>
    </div>

    <div class="pagination">
        <button id="prevPage" class="btn btn-outline-purple" disabled>
            <i class="fas fa-chevron-left"></i> Назад
        </button>
        <span id="pageInfo" class="page-info">Страница 1 из 1</span>
        <button id="nextPage" class="btn btn-outline-purple">
            Вперед <i class="fas fa-chevron-right"></i>
        </button>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/jwt-decode@3.1.2/build/jwt-decode.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function toggleSidebar() {
        document.querySelector('.sidebar').classList.toggle('collapsed');
    }

    $(document).ready(function () {
        const token = localStorage.getItem("jwtToken");

        if (!token) {
            console.error("Токен не найден. Пожалуйста, войдите в систему.");
            return;
        }

        try {
            // Декодируем токен, чтобы получить userId
            const decodedToken = jwt_decode(token);
            const userId = decodedToken.id; // Предполагается, что в токене есть поле `id`
            console.log("ID пользователя:", userId);

            // Выполняем запрос для получения записей пользователя
            fetch("/records/user/" + userId + "/records")
                .then(response => {
                    console.log("Ответ сервера:", response); // Логируем полный объект ответа
                    return response.json();
                })
                .then(data => {
                    console.log("Данные от сервера:", data);

                    const tableBody = $('#appointmentsTableBody');
                    tableBody.empty(); // Очистка таблицы

                    if (data.length === 0) {
                        tableBody.append(
                            '<tr><td colspan="5" class="no-records">' +
                            '<i class="far fa-calendar-times"></i>' +
                            '<p>У вас пока нет записей</p>' +
                            '</td></tr>'
                        );
                        return;
                    }

                    data.forEach(record => {
                        // Преобразуем дату и время
                        const rawDate = new Date(record.hairService.date); // Используем поле date из Record
                        const formattedDate = rawDate.toLocaleDateString('ru-RU', {
                            day: '2-digit',
                            month: '2-digit',
                            year: 'numeric',
                        });
                        const formattedTime = rawDate.toLocaleTimeString('ru-RU', {
                            hour: '2-digit',
                            minute: '2-digit',
                        });

                        const row =
                            "<tr>" +
                            "<td>" + record.hairService.service_name + "</td>" + // Используем поле name из HairService
                            "<td>" + formattedDate + " " + formattedTime + "</td>" +
                            "<td>" + (record.hairService.master ? record.hairService.master.fullName : "Не указан") + "</td>" + // Проверяем наличие мастера
                            "<td>" + record.hairService.price + " Byn</td>" +
                            "<td>" +
                            "<button class='btn btn-cancel' onclick='cancelAppointment(" + record.id + ")'><i class='fas fa-times'></i> Отменить</button>" +
                            "</td>" +
                            "</tr>";
                        tableBody.append(row);
                    });
                })
                .catch(error => console.error('Ошибка при загрузке записей:', error));
        } catch (err) {
            console.error("Ошибка при декодировании токена:", err);
        }
    });


    function cancelAppointment(id) {
        console.log("Тип ID:", typeof id);
        if (confirm("Вы действительно хотите отменить эту запись?")) {
            fetch('/records/' + id, {  // Используем правильный id записи
                method: 'DELETE', // Используем метод DELETE для удаления
                headers: {
                    'Content-Type': 'application/json',
                }
            })
                .then(response => {
                    if (response.ok) {
                        alert("Запись успешно удалена");
                        // Удаляем строку из таблицы
                        $('#appointmentsTableBody').find('button[onclick="cancelAppointment(' + id + ')"]').closest('tr').remove();
                    } else {
                        return response.json().then(err => {
                            throw new Error(err.message || 'Ошибка при удалении записи');
                        });
                    }
                })
                .catch(error => {
                    console.error('Ошибка:', error);
                    alert("Не удалось удалить запись: " + error.message);
                });
        }
    }




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