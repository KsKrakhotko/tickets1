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
        .appointments-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .appointments-table th, .appointments-table td {
            padding: 15px;
            text-align: left;
            font-family: 'Montserrat', sans-serif;
        }

        .appointments-table th {
            background: linear-gradient(to right, var(--purple), var(--dark-purple));
            color: var(--ivory);
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: uppercase;
        }

        .appointments-table tr {
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .appointments-table tr:nth-child(even) {
            background-color: rgba(138, 43, 226, 0.05);
        }

        .appointments-table tr:hover {
            background-color: rgba(138, 43, 226, 0.15);
            transform: scale(1.01);
        }

        .appointments-table td {
            border-bottom: 1px solid rgba(138, 43, 226, 0.1);
            color: var(--charcoal);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .appointments-table td:last-child {
            text-align: center;
        }

        .appointments-table .status-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-align: center;
        }

        .status-badge.PENDING {
            background: rgba(255, 193, 7, 0.15);
            color: var(--warning);
        }

        .status-badge.CONFIRMED {
            background: rgba(70, 130, 180, 0.15);
            color: steelblue;
        }

        .status-badge.COMPLETED {
            background: rgba(76, 175, 80, 0.15);
            color: var(--success);
        }

        .status-badge.CANCELLED {
            background: rgba(244, 67, 54, 0.15);
            color: var(--danger);
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
<body data-context-path="${pageContext.request.contextPath}">
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
                <a href="${pageContext.request.contextPath}/adminHome" class="nav-link">
                    <i class="fas fa-tachometer-alt nav-icon"></i>
                    <span class="nav-text">Главная</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/recordAdmin" class="nav-link active">
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
            <h2 class="page-title">Управление записями</h2>
        </div>

        <!-- Форма фильтрации -->
        <div class="filter-form">
            <div class="form-group">
                <label for="sortBy" class="form-label">Сортировка</label>
                <select id="sortBy" class="form-control">
                    <option value="dateAsc">По дате (по возрастанию)</option>
                    <option value="dateDesc">По дате (по убыванию)</option>
                </select>
            </div>

        </div>

        <!-- Таблица записей -->
        <div class="table-responsive">
            <table class="appointments-table">
                <thead>
                <tr>
                    <th>Клиент</th>
                    <th>Услуга</th>
                    <th>Дата</th>
                    <th>Мастер</th>
                    <th>Статус</th>
                    <th>Действия</th>
                </tr>
                </thead>
                <tbody id="appointmentsTableBody">
                <!-- Записи будут загружаться сюда динамически -->
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

        <!-- Модальное окно для изменения статуса -->
        <div id="statusModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Изменение статуса записи</h3>
                </div>
                <div class="modal-body">
                    <p id="appointmentInfoText">Изменить статус для записи клиента <strong>Иван Иванов</strong></p>
                    <div class="form-group" style="margin-top: 15px;">
                        <label class="form-label">Выберите новый статус:</label>
                        <select id="newStatus" class="form-control">
                            <option value="ожидание">ожидание</option>
                            <option value="подтверждена">подтверждена</option>
                            <option value="отменена">отменена</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="cancelStatusChange" class="btn btn-outline-purple">Отмена</button>
                    <button id="confirmStatusChange" class="btn btn-purple">Сохранить изменения</button>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        let currentPage = 0;
        let totalPages = 1;
        let currentAppointmentId = null;

        function getFilters() {
            return {
                client: $('#searchClient').val(),
                service: $('#searchService').val()
            };
        }

        $('#sortBy').change(function() {
            loadAppointments(0);  // Перезагружаем записи при изменении сортировки
        });

        function loadAppointments(page = 0) {
            const filters = getFilters();
            const contextPath = document.body.getAttribute('data-context-path');

            $.ajax({
                url: contextPath + "/records",
                type: 'GET',
                data: {
                    page: page,
                    size: 5,
                    client: filters.client || '',
                    service: filters.service || ''
                },
                dataType: 'json',
                success: function(response) {
                    console.log('Ответ с сервера:', response);
                    $('#appointmentsTableBody').empty();

                    // Получаем выбранный критерий сортировки
                    const sortBy = $('#sortBy').val();

                    // Сортируем данные по дате
                    if (sortBy === 'dateAsc') {
                        response.sort(function(a, b) {
                            return new Date(a.hairService.date) - new Date(b.hairService.date);
                        });
                    } else if (sortBy === 'dateDesc') {
                        response.sort(function(a, b) {
                            return new Date(b.hairService.date) - new Date(a.hairService.date);
                        });
                    }

                    if (response.length > 0) {
                        response.forEach(function(appointment) {
                            const masterName = appointment.hairService && appointment.hairService.master ?
                                appointment.hairService.master.fullName : 'Не указан';

                            const serviceName = appointment.hairService ?
                                (appointment.hairService.service_name || appointment.hairService.name) :
                                'Не указана';

                            const formattedDate = appointment.hairService && appointment.hairService.date ?
                                formatDate(appointment.hairService.date) : 'Не указана';

                            const row = '<tr>' +
                                '<td>' + (appointment.user ? appointment.user.username : 'Не указан') + '</td>' +
                                '<td>' + serviceName + '</td>' +
                                '<td>' + formattedDate + '</td>' +
                                '<td>' + masterName + '</td>' +
                                '<td>' + (appointment.status || 'Не указан') + '</td>' +
                                '<td>' +
                                '<button class="btn btn-outline-purple btn-sm change-status-btn" ' +
                                'data-id="' + appointment.id + '" ' +
                                'data-client="' + (appointment.user ? appointment.user.username : '') + '" ' +
                                'data-status="' + (appointment.status || '') + '">' +
                                '<i class="fas fa-edit"></i> Изменить статус' +
                                '</button>' +
                                '</td>' +
                                '</tr>';

                            $('#appointmentsTableBody').append(row);
                        });
                    } else {
                        $('#appointmentsTableBody').html('<tr><td colspan="6" style="text-align: center;">Записи не найдены</td></tr>');
                        $('#prevPage').prop('disabled', true);
                        $('#nextPage').prop('disabled', true);
                        $('#pageInfo').text('Страница 0 из 0');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Ошибка при загрузке записей:', error);
                    $('#appointmentsTableBody').html('<tr><td colspan="6" style="text-align: center; color: var(--danger);">Ошибка загрузки данных</td></tr>');
                }
            });
        }

        function formatDate(dateString) {
            try {
                if (!dateString) return 'Не указана';
                const date = dateString instanceof Date ? dateString : new Date(dateString);

                if (isNaN(date.getTime())) {
                    console.error('Некорректная дата:', dateString);
                    return 'Не указана';
                }

                const options = {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    timeZone: 'Europe/Moscow'
                };

                return date.toLocaleString('ru-RU', options);
            } catch (e) {
                console.error('Ошибка форматирования даты:', e);
                return 'Не указана';
            }
        }

        // Инициализация
        loadAppointments();

        // Обработчики событий
        $('#applyFilter').click(function() {
            loadAppointments(0);
        });

        $('#prevPage').click(function() {
            if (currentPage > 0) {
                loadAppointments(currentPage - 1);
            }
        });

        $('#nextPage').click(function() {
            if (currentPage + 1 < totalPages) {
                loadAppointments(currentPage + 1);
            }
        });

        // Единственный обработчик для кнопки изменения статуса
        $(document).on('click', '.change-status-btn', function() {
            currentAppointmentId = $(this).data('id');
            const clientName = $(this).data('client');
            const currentStatus = $(this).data('status');

            $('#appointmentInfoText').html('Изменить статус для записи клиента <strong>' + clientName + '</strong>');
            $('#newStatus').val(currentStatus);
            $('#statusModal').css('display', 'flex');
        });

        // Обработчик для кнопки отмены
        $('#cancelStatusChange').click(function() {
            $('#statusModal').hide();
            currentAppointmentId = null;
        });

        // Обработчик для кнопки подтверждения
        $('#confirmStatusChange').click(function() {
            const newStatus = $('#newStatus').val();
            const contextPath = document.body.getAttribute('data-context-path');

            if (!currentAppointmentId || !newStatus) {
                alert('Пожалуйста, выберите статус.');
                return;
            }

            $.ajax({
                url: contextPath + '/records/' + currentAppointmentId + '/status',
                type: 'PATCH',
                contentType: 'application/json',
                data: JSON.stringify(newStatus), // Передаем просто новый статус, без обертки
                success: function() {
                    alert('Статус успешно изменен!');
                    $('#statusModal').hide();
                    loadAppointments(currentPage);
                    currentAppointmentId = null;
                },
                error: function(xhr, status, error) {
                    alert('Произошла ошибка при изменении статуса');
                    console.error('Ошибка:', error);
                }
            });

        });

        // Закрытие модального окна при клике вне его области
        $(window).click(function(event) {
            if ($(event.target).is('#statusModal')) {
                $('#statusModal').hide();
                currentAppointmentId = null;
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