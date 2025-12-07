<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Управление клиентами | Парикмахерская "Элегант"</title>
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

        /* Таблица клиентов */
        .clients-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }

        .clients-table th {
            background-color: var(--purple);
            color: white;
            font-weight: 500;
            text-align: left;
            padding: 15px;
            font-family: 'Playfair Display', serif;
        }

        .clients-table td {
            padding: 12px 15px;
            border-bottom: 1px solid rgba(138, 43, 226, 0.1);
            vertical-align: middle;
        }

        .clients-table tr:hover {
            background-color: rgba(138, 43, 226, 0.05);
        }

        .client-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
            border: 2px solid var(--light-purple);
        }

        .client-name {
            display: flex;
            align-items: center;
        }

        .role-badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .role-client {
            background-color: rgba(70, 130, 180, 0.1);
            color: steelblue;
        }

        .role-admin {
            background-color: rgba(138, 43, 226, 0.1);
            color: var(--purple);
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

        .btn-sm {
            padding: 5px 10px;
            font-size: 0.75rem;
        }

        /* Форма фильтрации */
        .filter-form {
            background: #FFF;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            border-top: 3px solid var(--purple);
            display: flex;
            gap: 15px;
            align-items: flex-end;
        }

        .form-group {
            margin-bottom: 0;
            flex: 1;
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

        /* Модальное окно изменения роли */
        .modal {
            display: none; /* Скрыто по умолчанию */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5); /* Прозрачный черный фон */
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background: #FFF;
            width: 500px;
            max-width: 90%;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.2);
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

        .role-option {
            display: block;
            margin-bottom: 10px;
        }

        .role-option input {
            margin-right: 10px;
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

            .filter-form {
                flex-direction: column;
                align-items: stretch;
            }
        }

        @media (max-width: 768px) {
            .clients-table {
                display: block;
                overflow-x: auto;
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
                <a href="${pageContext.request.contextPath}/adminClients" class="nav-link active">
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

    <!-- Основное содержимое -->
    <div class="admin-content">
        <div class="page-header">
            <h2 class="page-title">Управление клиентами</h2>
        </div>

        <!-- Форма фильтрации -->
        <div class="filter-form">
            <div class="form-group">
                <label for="searchName" class="form-label">Поиск по имени</label>
                <input type="text" id="searchName" class="form-control" placeholder="Введите имя клиента">
            </div>
            <div class="form-group">
                <label for="searchEmail" class="form-label">Поиск по email</label>
                <input type="text" id="searchEmail" class="form-control" placeholder="Введите email">
            </div>
            <div class="form-group">
                <label for="filterRole" class="form-label">Роль</label>
                <select id="filterRole" class="form-control">
                    <option value="">Все роли</option>
                    <option value="USER">Клиент</option>
                    <option value="ADMIN">Администратор</option>
                </select>
            </div>
            <button id="applyFilter" class="btn btn-purple">
                <i class="fas fa-filter"></i> Применить
            </button>
        </div>

        <!-- Таблица клиентов -->
        <div class="table-responsive">
            <table class="clients-table">
                <thead>
                <tr>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Роль</th>
                    <th>Действия</th>
                </tr>
                </thead>
                <tbody id="clientsTableBody">
                <!-- Клиенты будут загружаться сюда динамически -->
                </tbody>
            </table>
        </div>

        <!-- Пагинация -->
        <div class="pagination" style="display: flex; justify-content: center; gap: 10px; margin-top: 20px;">
            <button id="prevPage" class="btn btn-outline-purple" disabled>
                <i class="fas fa-chevron-left"></i> Назад
            </button>
            <span id="pageInfo" style="display: flex; align-items: center;">Страница 1 из 1</span>
            <button id="nextPage" class="btn btn-outline-purple" disabled>
                Вперед <i class="fas fa-chevron-right"></i>
            </button>
        </div>

        <!-- Модальное окно для изменения роли -->
        <div id="roleModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Изменение роли клиента</h3>
                </div>
                <div class="modal-body">
                    <p id="clientNameText">Изменить роль для <strong>Иван Иванов</strong></p>
                    <div class="form-group" style="margin-top: 15px;">
                        <label class="form-label">Выберите новую роль:</label>
                        <div style="margin-top: 10px;">
                            <label class="role-option">
                                <input type="radio" name="newRole" value="USER" checked>
                                <span class="role-badge role-client">Клиент</span> - стандартные права доступа
                            </label>
                            <label class="role-option">
                                <input type="radio" name="newRole" value="ADMIN">
                                <span class="role-badge role-admin">Администратор</span> - полный доступ к системе
                            </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="cancelRoleChange" class="btn btn-outline-purple">Отмена</button>
                    <button id="confirmRoleChange" class="btn btn-purple">Сохранить изменения</button>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        let currentPage = 0;
        let totalPages = 1;
        let currentClientId = null;

        function getFilters() {
            return {
                name: $('#searchName').val(),
                email: $('#searchEmail').val(),
                role: $('#filterRole').val()
            };
        }

        function loadClients(page = 0) {
            const filters = getFilters();

            $.ajax({
                url: `${pageContext.request.contextPath}/admin/clients/list`,
                type: 'GET',
                data: {
                    page: page,
                    size: 5, // сколько на страницу
                    name: filters.name || '',
                    email: filters.email || '',
                    role: filters.role || ''
                },
                dataType: 'json',
                success: function(response) {
                    $('#clientsTableBody').empty();

                    if (response.content && response.content.length > 0) {
                        currentPage = response.number;
                        totalPages = response.totalPages;

                        $('#pageInfo').text('Страница ' + (currentPage + 1) + ' из ' + totalPages);
                        $('#prevPage').prop('disabled', currentPage === 0);
                        $('#nextPage').prop('disabled', currentPage + 1 >= totalPages);

                        response.content.forEach(function(client) {
                            let roleBadgeClass = 'role-client';
                            let roleText = 'Клиент';
                            if (client.role === 'ADMIN') {
                                roleBadgeClass = 'role-admin';
                                roleText = 'Админ';
                            }

                            const avatarUrl = client.avatarUrl
                                ? client.avatarUrl
                                : 'https://ui-avatars.com/api/?name=' + encodeURIComponent(client.username) + '&background=8A2BE2&color=fff';

                            const row = '<tr>' +
                                '<td>' +
                                '<div class="client-name">' +
                                '<img src="' + avatarUrl + '" alt="Аватар" class="client-avatar">' +
                                client.username +
                                '</div>' +
                                '</td>' +
                                '<td>' + client.email + '</td>' +
                                '<td><span class="role-badge ' + roleBadgeClass + '">' + roleText + '</span></td>' +
                                '<td>' +
                                '<button class="btn btn-outline-purple btn-sm change-role-btn" data-id="' + client.id + '" data-name="' + client.username + '" data-role="' + client.role + '">' +
                                '<i class="fas fa-user-cog"></i> Изменить роль' +
                                '</button>' +
                                '</td>' +
                                '</tr>';

                            $('#clientsTableBody').append(row);
                        });
                    } else {
                        $('#clientsTableBody').html('<tr><td colspan="6" style="text-align: center;">Клиенты не найдены</td></tr>');
                        $('#prevPage').prop('disabled', true);
                        $('#nextPage').prop('disabled', true);
                        $('#pageInfo').text('Страница 0 из 0');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Ошибка при загрузке клиентов:', error);
                    $('#clientsTableBody').html('<tr><td colspan="6" style="text-align: center; color: var(--danger);">Ошибка загрузки данных</td></tr>');
                }
            });
        }

        loadClients();

        $('#applyFilter').click(function() {
            loadClients(0);
        });

        $('#prevPage').click(function() {
            if (currentPage > 0) {
                loadClients(currentPage - 1);
            }
        });

        $('#nextPage').click(function() {
            if (currentPage + 1 < totalPages) {
                loadClients(currentPage + 1);
            }
        });

        $('#refreshBtn').click(function() {
            loadClients(currentPage);
        });

        $(document).on('click', '.change-role-btn', function() {
            currentClientId = $(this).data('id');
            const clientName = $(this).data('name');
            const currentRole = $(this).data('role');

            $('#clientNameText').html('Изменить роль для <strong>' + clientName + '</strong>');
            $('input[name="newRole"][value="' + currentRole + '"]').prop('checked', true);
            $('#roleModal').css('display', 'flex');
        });

        $('#cancelRoleChange').click(function() {
            $('#roleModal').hide();
            currentClientId = null;
        });

        $('#confirmRoleChange').click(function() {
            if (currentClientId) {
                const newRole = $('input[name="newRole"]:checked').val();

                $.ajax({
                    url: `${pageContext.request.contextPath}/admin/clients/change-role`,
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        clientId: currentClientId,
                        newRole: newRole
                    }),
                    success: function() {
                        alert('Роль успешно изменена!');
                        $('#roleModal').hide();
                        loadClients(currentPage);
                        currentClientId = null;
                    },
                    error: function(xhr, status, error) {
                        alert('Произошла ошибка при изменении роли');
                        console.error('Ошибка:', error);
                    }
                });
            }
        });

        $(window).click(function(e) {
            if (e.target === $('#roleModal')[0]) {
                $('#roleModal').hide();
                currentClientId = null;
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