<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Управление услугами | Парикмахерская "Элегант"</title>
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

        /* Карточки услуг */
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .service-card{
            background: #FFF;
            display: block;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border-top: 3px solid var(--purple);
            color: black !important;
        }


        .service-image {
            height: 180px;
            background-color: #f6f6f6;
            display: flex;
            justify-content: center;
            color: var(--purple);
            font-size: 3rem;
            object-fit: cover;
        }

        .service-body {
            padding: 20px;
        }

        .service-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            margin-bottom: 10px;
            color: var(--charcoal);
        }

        .service-description {
            color: var(--slate);
            margin-bottom: 15px;
            font-size: 0.9rem;
        }

        .service-meta {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
        }

        .service-price {
            font-weight: 600;
            color: var(--purple);
            font-size: 1.2rem;
        }

        .service-date {
            color: var(--slate);
            font-size: 0.9rem;
        }

        .service-actions {
            display: flex;
            gap: 10px;
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

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background: #d32f2f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(244, 67, 54, 0.3);
        }

        /* Форма добавления/редактирования */
        .service-form {
            background: #FFF;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            margin-bottom: 40px;
            border-top: 3px solid var(--purple);
        }

        .form-group {
            margin-bottom: 20px;
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

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }

        /* Модальное окно */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-content {
            background: #FFF;
            width: 500px;
            max-width: 90%;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 30px rgba(0,0,0,0.2);
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
                <a href="${pageContext.request.contextPath}/adminHome" class="nav-link">
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
                <a href="${pageContext.request.contextPath}/serviceAdmin" class="nav-link active">
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
            <h2 class="page-title">Управление услугами</h2>
            <div class="admin-actions">
                <button id="addServiceBtn" class="btn btn-purple">
                    <i class="fas fa-plus"></i> Добавить услугу
                </button>
                <button id="exportExcelBtn" class="btn btn-purple">
                    <i class="fas fa-file-excel"></i> Экспорт в Excel
                </button>
            </div>
        </div>

        <!-- Форма добавления/редактирования (скрыта по умолчанию) -->
        <div id="serviceForm" class="service-form" style="display: none;">
            <h3 style="margin-bottom: 20px; font-family: 'Playfair Display', serif;" id="formTitle">Добавить новую услугу</h3>
            <form id="serviceFormElement">
                <input type="hidden" id="serviceId">
                <div class="form-group">
                    <label for="serviceName" class="form-label">Название услуги</label>
                    <input type="text" id="serviceName" class="form-control" required>
                </div>
                <div class="form-row" style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label for="servicePrice" class="form-label">Цена (Br)</label>
                        <input type="number" id="servicePrice" class="form-control" required min="0" step="1">
                    </div>
                </div>
                <div class="form-group">
                    <label for="serviceDate" class="form-label">Дата и время</label>
                    <input type="datetime-local" id="serviceDate" class="form-control" required>
                </div>
                <!-- Новый элемент для выбора мастера -->
                <div class="form-group">
                    <label for="masterSelect" class="form-label">Мастер</label>
                    <select id="masterSelect" class="form-control" required>
                        <option value="">Выберите мастера</option>
                        <!-- Список мастеров будет загружен сюда динамически -->
                    </select>
                </div>
                <div style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px;">
                    <button type="button" id="cancelFormBtn" class="btn btn-outline-purple">Отмена</button>
                    <button type="submit" class="btn btn-purple">
                        <i class="fas fa-save"></i> Сохранить
                    </button>
                </div>
            </form>
        </div>

        <!-- Список услуг -->
        <h3 style="margin-bottom: 20px; font-family: 'Playfair Display', serif; color: var(--charcoal);">
            <i class="fas fa-list" style="color: var(--purple); margin-right: 10px;"></i>
            Список услуг
        </h3>

        <div class="services-grid">
            <!-- Список услуг будет загружаться сюда динамически -->
        </div>

        <!-- Модальное окно подтверждения удаления -->
        <div id="deleteModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Подтверждение удаления</h3>
                </div>
                <div class="modal-body">
                    <p>Вы уверены, что хотите удалить эту услугу? Это действие нельзя отменить.</p>
                </div>
                <div class="modal-footer">
                    <button id="cancelDeleteBtn" class="btn btn-outline-purple">Отмена</button>
                    <button id="confirmDeleteBtn" class="btn btn-danger">Удалить</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // Показать форму добавления услуги
        $('#addServiceBtn').click(function() {
            $('#formTitle').text('Добавить новую услугу');
            $('#serviceForm').show();
            $('#serviceFormElement')[0].reset();
            $('#serviceId').val('');
            $('html, body').animate({
                scrollTop: $('#serviceForm').offset().top - 20
            }, 300);
        });

        // Скрыть форму
        $('#cancelFormBtn').click(function() {
            $('#serviceForm').hide();
        });

        $(document).on('click', '.edit-service', function() {
            const serviceId = $(this).data('id');

            // Получение данных услуги с сервера
            $.ajax({
                url: '/services/' + serviceId,  // Путь к API для получения услуги по ID
                type: 'GET',
                success: function(service) {
                    // Заполнение формы данными услуги
                    loadMasters();
                    $('#formTitle').text('Редактировать услугу');
                    $('#serviceId').val(service.id);  // ID услуги
                    $('#serviceName').val(service.name);  // Название услуги
                    $('#servicePrice').val(service.price);  // Цена услуги
                    $('#serviceDate').val(service.date);  // Дата услуги (предположим, что это дата предоставления услуги)

                    $('#masterSelect').val(service.master.id);

                    // Показать форму редактирования
                    $('#serviceForm').show();
                    $('html, body').animate({
                        scrollTop: $('#serviceForm').offset().top - 20
                    }, 300);
                },
                error: function(xhr, status, error) {
                    alert('Ошибка при загрузке данных услуги');
                    console.error('Ошибка:', error);
                }
            });
        });

// Обработка сохранения изменений
        $('#saveServiceBtn').click(function() {
            const serviceData = {
                id: $('#serviceId').val(),
                name: $('#serviceName').val(),
                price: $('#servicePrice').val(),
                date: $('#serviceDate').val(),
                master: {
                    id: $('#masterSelect').val()  // Объект мастера, передаем только ID мастера
                }
            };

            // Отправка обновленных данных на сервер
            $.ajax({
                url: '/services/' + serviceData.id,  // Путь к API для редактирования услуги
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(serviceData),
                success: function() {
                    alert('Услуга успешно обновлена!');
                    $('#serviceForm').hide();
                    loadServices();  // Обновить список услуг
                },
                error: function(xhr, status, error) {
                    alert('Ошибка при сохранении данных');
                    console.error('Ошибка:', error);
                }
            });
        });
        $(document).on('click', '.edit-service', function() {
            const serviceId = $(this).data('id');

            // Получение данных услуги с сервера
            $.ajax({
                url: '/services/' + serviceId,  // Путь к API для получения услуги по ID
                type: 'GET',
                success: function(service) {
                    console.log(service);
                    // Заполнение формы данными услуги
                    $('#formTitle').text('Редактировать услугу');
                    $('#serviceId').val(service.service_id);  // ID услуги
                    $('#serviceName').val(service.service_name);  // Название услуги
                    $('#servicePrice').val(service.price);  // Цена услуги
                    $('#serviceDate').val(service.date);  // Дата услуги (предположим, что это дата предоставления услуги)
                    if (service.master && service.master.fullName) {
                        // Заполнение поля с именем мастера (если оно есть)
                        $('#masterName').text(service.master.fullName);  // Если у вас есть элемент с id masterName
                    } else {
                        $('#masterName').text('Не указан');  // Если мастер не указан
                    }

                    // Показать форму редактирования
                    $('#serviceForm').show();
                    $('html, body').animate({
                        scrollTop: $('#serviceForm').offset().top - 20
                    }, 300);
                },
                error: function(xhr, status, error) {
                    alert('Ошибка при загрузке данных услуги');
                    console.error('Ошибка:', error);
                }
            });
        });

// Обработка сохранения изменений
        $('#saveServiceBtn').click(function() {
            const serviceData = {
                id: $('#serviceId').val(),
                name: $('#serviceName').val(),
                price: $('#servicePrice').val(),
                date: $('#serviceDate').val(),
                master: $('#masterSelect').val()
            };

            // Отправка обновленных данных на сервер
            $.ajax({
                url: '/services/' + serviceData.id,  // Путь к API для редактирования услуги
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(serviceData),
                success: function() {
                    alert('Услуга успешно обновлена!');
                    $('#serviceForm').hide();
                    loadServices();  // Обновить список услуг
                },
                error: function(xhr, status, error) {
                    alert('Ошибка при сохранении данных');
                    console.error('Ошибка:', error);
                }
            });
        });


        // Обработка удаления услуги
        let serviceToDelete = null;
        $(document).on('click', '.delete-service', function() {
            serviceToDelete = $(this).data('id');
            $('#deleteModal').css('display', 'flex');
        });

        $('#cancelDeleteBtn').click(function() {
            $('#deleteModal').hide();
            serviceToDelete = null;
        });

        $('#confirmDeleteBtn').click(function() {
            if (serviceToDelete) {
                // Логика удаления услуги через AJAX запрос
                $.ajax({
                    url: '/services/' + serviceToDelete,  // Убедитесь, что путь правильный для вашего API
                    type: 'DELETE',
                    success: function() {
                        alert('Услуга успешно удалена!');
                        $('#deleteModal').hide();
                        serviceToDelete = null;
                        loadServices(); // Обновить список услуг после удаления
                    },
                    error: function(xhr, status, error) {
                        alert('Произошла ошибка при удалении услуги');
                        console.error('Ошибка:', error);
                    }
                });
            }
        });

        // Обработка отправки формы
        $('#serviceFormElement').submit(function(e) {
            e.preventDefault();

            const formData = {
                service_id: $('#serviceId').val(),
                service_name: $('#serviceName').val(),
                date: $('#serviceDate').val(),
                price: parseFloat($('#servicePrice').val()),
                master: {
                    id: $('#masterSelect').val()  // Передаем объект мастера
                }
            };

            console.log('Данные для отправки:', formData);

            $.ajax({
                url: '/services',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function(response) {
                    console.log('Услуга сохранена:', response);
                    alert('Услуга успешно сохранена!');
                    $('#serviceForm').hide();
                    loadServices();
                },
                error: function(xhr, status, error) {
                    console.error('Ошибка при сохранении услуги:', error);
                    alert('Ошибка при сохранении услуги!');
                }
            });
        });

        // Закрытие модального окна при клике вне его
        $(window).click(function(e) {
            if (e.target === $('#deleteModal')[0]) {
                $('#deleteModal').hide();
                serviceToDelete = null;
            }
        });

        document.getElementById('exportExcelBtn').addEventListener('click', function () {
            if (!servicesData || servicesData.length === 0) {
                alert('Нет данных для экспорта.');
                return;
            }

            // Преобразование данных в формат таблицы
            const worksheetData = servicesData.map(service => ({
                ID: service.service_id || 'Не указан',
                Название: service.service_name ? service.service_name.trim() : 'Не указано',
                Цена: service.price ? service.price + ' Br' : 'Не указана',
                Дата: service.date
                    ? new Date(service.date).toLocaleString('ru-RU', {
                        day: '2-digit',
                        month: '2-digit',
                        year: 'numeric',
                        hour: '2-digit',
                        minute: '2-digit'
                    })
                    : 'Не указана',
            }));

            // Создание книги Excel
            const workbook = XLSX.utils.book_new();
            const worksheet = XLSX.utils.json_to_sheet(worksheetData);

            // Добавление листа в книгу
            XLSX.utils.book_append_sheet(workbook, worksheet, 'Услуги');

            // Генерация и загрузка файла
            XLSX.writeFile(workbook, 'services.xlsx');
        });

        function loadMasters() {
            $.ajax({
                url: '/api/masters',  // Путь к вашему API для получения всех мастеров
                type: 'GET',
                dataType: 'json',
                success: function(masters) {
                    $('#masterSelect').empty().append('<option value="">Выберите мастера</option>');

                    if (Array.isArray(masters) && masters.length > 0) {
                        masters.forEach(function(master) {
                            const option = $('<option>')
                                .val(master.id) // ID мастера
                                .text(master.fullName); // Имя мастера
                            $('#masterSelect').append(option);
                        });
                    } else {
                        $('#masterSelect').append('<option value="">Нет доступных мастеров</option>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Ошибка при загрузке мастеров:', error);
                    alert('Не удалось загрузить список мастеров.');
                }
            });
        }

// Вызов функции загрузки мастеров при загрузке страницы или отображении формы
        $('#addServiceBtn').click(function() {
            loadMasters();
            $('#serviceForm').show();
            $('#serviceFormElement')[0].reset();
            $('#serviceId').val('');
        });

        // Функция для отображения всех услуг
        let servicesData = [];
        function loadServices() {
            $.ajax({
                url: '/services',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    console.log('Полученные данные с сервера:', response);
                    $('.services-grid').empty();

                    servicesData = Array.isArray(response) ? response : [];
                    const services = Array.isArray(response) ? response : [];

                    if (!services || services.length === 0) {
                        $('.services-grid').html('<p>Нет доступных услуг</p>');
                        return;
                    }

                    services.forEach(function(service) {
                        console.log('Сервис:', service);

                        const name = service.service_name ? service.service_name.trim() : 'Не указано';
                        const price = service.price ? service.price + ' Byn' : 'Не указана';
                        const formattedDate = service.date
                            ? new Date(service.date).toLocaleString('ru-RU', {
                                day: '2-digit',
                                month: '2-digit',
                                year: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit'
                            })
                            : 'Не указана';

                        const id = service.service_id || '';

                        const masterName = service.master && service.master.fullName ? service.master.fullName : 'Не указан';
                        const serviceCard =
                            '<div class="service-card">' +
                            '<div class="service-image">' +
                            '<img src="/images/elegant.jpg" alt="Изображение услуги" class="service-img">' +
                            '</div>' +
                            '<div class="service-body">' +
                            '<h3 class="service-title">Название: ' + name + '</h3>' +
                            '<div class="service-meta">' +
                            '<span class="service-price">Цена: ' + price + '</span>' +
                            '<span class="service-date">Дата: ' + formattedDate + '</span>' +
                            '<span class="service-master">Мастер: ' + masterName + '</span>' +
                            '</div>' +
                            '<div class="service-actions">' +
                            '<button class="btn btn-outline-purple edit-service" data-id="' + id + '">' +
                            '<i class="fas fa-edit"></i> Редактировать' +
                            '</button>' +
                            '<button class="btn btn-danger delete-service" data-id="' + id + '">' +
                            '<i class="fas fa-trash"></i> Удалить' +
                            '</button>' +
                            '</div>' +
                            '</div>' +
                            '</div>';

                        $('.services-grid').append(serviceCard);
                    });
                },
                error: function(xhr, status, error) {
                    console.error('Ошибка при загрузке услуг:', error);
                    $('.services-grid').html('<p class="text-danger">Ошибка загрузки услуг</p>');
                }
            });
        }

        // Загружаем все услуги при загрузке страницы
        loadServices();
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
