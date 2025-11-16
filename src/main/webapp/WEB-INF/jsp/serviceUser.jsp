<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Личный кабинет | Парикмахерская "Элегант"</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            font-size: 2rem;
            color: var(--primary-color);
        }

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

        .btn-purple {
            background-color: var(--primary-color);
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 8px;
            cursor: pointer;
            transition: all var(--transition-speed) ease;
        }

        .btn-purple:hover {
            background-color: #5a3d7d; /* Более тёмный оттенок фиолетового */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
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

            .mobile-menu-btn {
                display: block;
                position: fixed;
                top: 20px;
                left: 20px;
                z-index: 1100;
                background: var(--primary-color);
                color: white;
                border: none;
                border-radius: 50%;
                width: 50px;
                height: 50px;
                font-size: 1.5rem;
                cursor: pointer;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            }

        }

        /* Анимации */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .profile-card, .info-card, .appointments-table {
            animation: fadeIn 0.6s ease-out;
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
            <a href="/serviceUser" class="nav-link active">
                <i class="fas fa-cut nav-icon"></i>
                <span class="nav-text">Услуги</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="/userMaster" class="nav-link">
                <i class="fas fa-user-tie nav-icon"></i>
                <span class="nav-text">Мастера</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="/booking" class="nav-link">
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
            <a href="/reviews" class="nav-link">
                <i class="fas fa-star nav-icon"></i>
                <span class="nav-text">Отзывы</span>
            </a>
        </li>
        <li class="nav-item" style="margin-top: 30px;">
            <a href="/userHome" class="nav-link">
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
        <h1 class="page-title">Услуги парикмахерской</h1>
        <button class="mobile-menu-btn" onclick="toggleMobileMenu()">
            <i class="fas fa-bars"></i>
        </button>
    </div>

    <!-- Список услуг -->
    <h3 style="margin-bottom: 20px; font-family: 'Playfair Display', serif; color: var(--charcoal);">
        <i class="fas fa-list" style="color: var(--purple); margin-right: 10px;"></i>
        Список услуг
    </h3>

    <div class="services-grid">
        <!-- Список услуг будет загружаться сюда динамически -->
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jwt-decode@3.1.2/build/jwt-decode.min.js"></script>

<script>

    $(document).ready(function() {
        // Функция для отображения всех услуг
        function loadServices() {
            $.ajax({
                url: '/services',
                type: 'GET',
                dataType: 'json',
                success: function(response) {
                    console.log('Полученные данные с сервера:', response);
                    $('.services-grid').empty();

                    const services = Array.isArray(response) ? response : [];

                    if (!services || services.length === 0) {
                        $('.services-grid').html('<p>Нет доступных услуг</p>');
                        return;
                    }

                    services.forEach(function(service) {
                        const name = service.service_name ? service.service_name.trim() : 'Не указано';
                        const price = service.price ? service.price + ' Br' : 'Не указана';
                        const formattedDate = service.date
                            ? new Date(service.date).toLocaleString('ru-RU', {
                                day: '2-digit',
                                month: '2-digit',
                                year: 'numeric',
                                hour: '2-digit',
                                minute: '2-digit'
                            })
                            : 'Не указана';

                        const masterName = service.master && service.master.fullName ? service.master.fullName : 'Не указан';
                        const serviceCard =
                            '<div class="service-card">' +
                            '<div class="service-image">' +
                            '<img src="/images/elegant.jpg" alt="Изображение услуги" class="service-img">' +
                            '</div>' +
                            '<div class="service-body">' +
                            '<h3 class="service-title">' + name + '</h3>' +
                            '<div class="service-meta">' +
                            '<span class="service-price">Цена: ' + price + '</span>' +
                            '<span class="service-date">Дата: ' + formattedDate + '</span>' +
                            '<span class="service-master">Мастер: ' + masterName + '</span>' +
                            '</div>' +
                            '<div class="service-actions">' +
                            '<button class="btn btn-purple book-service" data-id="' + service.service_id + '">' +
                            '<i class="fas fa-calendar-plus"></i> Записаться' +
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
        $(document).ready(function() {
            let services = [];
            let records = [];

            // Функция для загрузки услуг и записей
            function loadServices() {
                // Загрузка услуг
                $.ajax({
                    url: '/services',
                    type: 'GET',
                    dataType: 'json',
                    success: function(response) {
                        services = Array.isArray(response) ? response : [];
                        filterAndRenderServices();
                    },
                    error: function(xhr, status, error) {
                        console.error('Ошибка при загрузке услуг:', error);
                    }
                });

                // Загрузка записей
                $.ajax({
                    url: '/records',
                    type: 'GET',
                    dataType: 'json',
                    success: function(response) {
                        records = Array.isArray(response) ? response : [];
                        filterAndRenderServices();
                    },
                    error: function(xhr, status, error) {
                        console.error('Ошибка при загрузке записей:', error);
                    }
                });
            }

            // Функция для фильтрации и отображения услуг
            function filterAndRenderServices() {
                if (services.length === 0 || records.length === 0) {
                    return;
                }

                const bookedServiceIds = records.map(record => record.hairService ? record.hairService.service_id : undefined);
                console.log("ID забронированных услуг:", bookedServiceIds);

                const availableServices = services.filter(service => !bookedServiceIds.includes(service.service_id));
                console.log("Доступные услуги:", availableServices);

                renderServices(availableServices);
            }

            // Функция для отображения услуг
            function renderServices(services) {
                $('.services-grid').empty();

                if (!services || services.length === 0) {
                    $('.services-grid').html('<p>Нет доступных услуг</p>');
                    return;
                }

                services.forEach(function(service) {
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

                    const masterName = service.master && service.master.fullName ? service.master.fullName : 'Не указан';
                    const serviceCard =
                        '<div class="service-card">' +
                        '<div class="service-image">' +
                        '<img src="/images/elegant.jpg" alt="Изображение услуги" class="service-img">' +
                        '</div>' +
                        '<div class="service-body">' +
                        '<h3 class="service-title">' + name + '</h3>' +
                        '<div class="service-meta">' +
                        '<span class="service-price">Цена: ' + price + '</span>' +
                        '<span class="service-date">Дата: ' + formattedDate + '</span>' +
                        '<span class="service-master">Мастер: ' + masterName + '</span>' +
                        '</div>' +
                        '<div class="service-actions">' +
                        '<button class="btn btn-purple book-service" data-id="' + service.service_id + '">' +
                        '<i class="fas fa-calendar-plus"></i> Записаться' +
                        '</button>' +
                        '</div>' +
                        '</div>' +
                        '</div>';

                    $('.services-grid').append(serviceCard);
                });
            }

            // Загружаем услуги и записи при загрузке страницы
            loadServices();

            // Обработчик для записи на услугу
            $(document).on('click', '.book-service', function() {
                const serviceId = $(this).data('id');
                const token = localStorage.getItem("jwtToken");

                if (!token) {
                    alert("Пожалуйста, войдите в систему для записи на услугу.");
                    return;
                }

                try {
                    // Декодируем токен и получаем ID пользователя
                    const decodedToken = jwt_decode(token);
                    const userId = decodedToken.id;
                    console.log("ID пользователя:", userId);

                    // Отправка запроса на сервер для записи на услугу
                    $.ajax({
                        url: '/records',
                        type: 'POST',
                        contentType: 'application/json',
                        headers: {
                            "Authorization": "Bearer " + token
                        },
                        data: JSON.stringify({
                            userId: userId,
                            serviceId: serviceId
                        }),
                        success: function(response) {
                            alert('Вы успешно записались на услугу!');
                            loadServices();  // Перезагружаем услуги и фильтруем заново
                        },
                        error: function(xhr, status, error) {
                            console.error('Ошибка при записи на услугу:', error);
                            alert('Не удалось записаться на услугу. Попробуйте позже.');
                        }
                    });
                } catch (error) {
                    console.error('Ошибка декодирования токена:', error);
                    alert('Ошибка аутентификации. Пожалуйста, войдите снова.');
                }
            });
        });
    });

</script>
</body>
</html>