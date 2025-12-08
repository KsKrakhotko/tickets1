<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Маршруты | Железнодорожные перевозки</title>
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

        .route-filter {
            background: #FFF;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            border-top: 4px solid var(--purple);
        }

        .route-filter h3 {
            font-family: 'Playfair Display', serif;
            color: var(--charcoal);
            margin-bottom: 20px;
        }

        .route-filter .form-control {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s;
            background-color: white;
        }

        .route-filter .form-control:focus {
            outline: none;
            border-color: var(--purple);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.1);
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .service-card {
            background: #FFF;
            display: block;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border-top: 3px solid var(--purple);
            color: var(--charcoal) !important;
        }

        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }


        .service-image {
            height: 180px;
            background-color: #f6f6f6;
            display: flex;
            justify-content: center;
            align-items: center;
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
            flex-direction: column;
            gap: 8px;
            margin-bottom: 15px;
        }

        .service-meta span {
            display: block;
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
            background-color: var(--purple);
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 1rem;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-purple:hover {
            background-color: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
        }

        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        /* Адаптивность */
        @media (max-width: 992px) {
            .admin-layout {
                grid-template-columns: 1fr;
            }

            .admin-sidebar {
                display: none;
            }

            .route-filter > div {
                grid-template-columns: 1fr !important;
            }

            .route-filter #clearFilter {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            .admin-content {
                padding: 20px;
            }

            .services-grid {
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
            <a href="${pageContext.request.contextPath}/serviceUser" class="nav-link active">
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
            <h2 class="page-title">Маршруты</h2>
        </div>

        <!-- Фильтр маршрутов -->
        <div class="route-filter" style="background: #FFF; border-radius: 12px; padding: 30px; box-shadow: 0 5px 25px rgba(0,0,0,0.05); margin-bottom: 30px; border-top: 4px solid var(--purple);">
            <h3 style="font-family: 'Playfair Display', serif; color: var(--charcoal); margin-bottom: 20px;">
                <i class="fas fa-filter" style="color: var(--purple); margin-right: 10px;"></i>
                Поиск маршрутов
            </h3>
            <div style="display: grid; grid-template-columns: 1fr 1fr auto; gap: 20px; align-items: end;">
                <div class="form-group" style="margin-bottom: 0;">
                    <label for="departureStation" style="display: block; margin-bottom: 8px; font-weight: 500; color: var(--charcoal);">Станция отправления</label>
                    <select id="departureStation" class="form-control" style="width: 100%; padding: 12px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 1rem; transition: border-color 0.3s;">
                        <option value="">Все станции</option>
                    </select>
                </div>
                <div class="form-group" style="margin-bottom: 0;">
                    <label for="arrivalStation" style="display: block; margin-bottom: 8px; font-weight: 500; color: var(--charcoal);">Станция прибытия</label>
                    <select id="arrivalStation" class="form-control" style="width: 100%; padding: 12px; border: 2px solid #e0e0e0; border-radius: 8px; font-size: 1rem; transition: border-color 0.3s;">
                        <option value="">Все станции</option>
                    </select>
                </div>
                <button id="clearFilter" class="btn" style="background: var(--slate); color: white; padding: 12px 24px; border: none; border-radius: 8px; font-size: 1rem; font-weight: 600; cursor: pointer; transition: all 0.3s;">
                    <i class="fas fa-times"></i> Сбросить
        </button>
            </div>
    </div>

        <!-- Список маршрутов -->
    <h3 style="margin-bottom: 20px; font-family: 'Playfair Display', serif; color: var(--charcoal);">
            <i class="fas fa-route" style="color: var(--purple); margin-right: 10px;"></i>
            Доступные маршруты
    </h3>

        <div class="services-grid" id="routesGrid">
            <!-- Список маршрутов будет загружаться сюда динамически -->
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jwt-decode@3.1.2/build/jwt-decode.min.js"></script>

<script>
    let allRoutes = [];
    let allStations = [];

    $(document).ready(function() {
        // Загружаем список станций
        function loadStations() {
            $.ajax({
                url: '/api/stations',
                type: 'GET',
                dataType: 'json',
                success: function(stations) {
                    allStations = stations || [];
                    const departureSelect = $('#departureStation');
                    const arrivalSelect = $('#arrivalStation');
                    
                    // Очищаем и добавляем опцию "Все станции"
                    departureSelect.empty().append('<option value="">Все станции</option>');
                    arrivalSelect.empty().append('<option value="">Все станции</option>');
                    
                    if (Array.isArray(allStations) && allStations.length > 0) {
                        allStations.forEach(function(station) {
                            const optionText = station.city ? (station.city + ' - ' + station.name) : station.name;
                            departureSelect.append($('<option>').val(station.id).text(optionText));
                            arrivalSelect.append($('<option>').val(station.id).text(optionText));
                    });
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Ошибка при загрузке станций:', error);
                }
            });
        }

        // Функция для загрузки маршрутов с фильтрацией
        function loadRoutes() {
            console.log('Начинаем загрузку маршрутов...');
                $.ajax({
                url: '/routes',
                    type: 'GET',
                    dataType: 'json',
                success: function(routes) {
                    console.log('Полученные маршруты:', routes);
                    console.log('Количество маршрутов:', routes ? routes.length : 0);
                    allRoutes = routes || [];
                    if (allRoutes.length > 0) {
                        console.log('Первый маршрут для проверки:', allRoutes[0]);
                    }
                    filterAndDisplayRoutes();
                    },
                    error: function(xhr, status, error) {
                    console.error('Ошибка при загрузке маршрутов:', error);
                    console.error('Статус:', xhr.status);
                    console.error('Ответ сервера:', xhr.responseText);
                    $('#routesGrid').html('<p class="text-danger" style="text-align: center; padding: 30px;">Ошибка загрузки маршрутов. Проверьте консоль браузера для деталей.</p>');
                    }
                });
            }

        // Функция для фильтрации и отображения маршрутов
        function filterAndDisplayRoutes() {
            $('#routesGrid').empty();

            if (!allRoutes || allRoutes.length === 0) {
                console.log('Нет маршрутов для отображения');
                $('#routesGrid').html('<p style="text-align: center; padding: 30px; color: var(--slate);">Нет доступных маршрутов в базе данных</p>');
                    return;
                }

            console.log('Всего маршрутов для фильтрации:', allRoutes.length);

            // Получаем выбранные станции
            const selectedDepartureId = $('#departureStation').val();
            const selectedArrivalId = $('#arrivalStation').val();

            // Фильтруем маршруты: дата отправления должна быть не ранее сегодняшнего дня
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            
            let filteredRoutes = allRoutes.filter(function(route) {
                // Фильтр по дате
                if (!route.departureTime) {
                    console.log('Маршрут без departureTime пропущен:', route);
                    return false;
                }
                const departureDate = new Date(route.departureTime);
                departureDate.setHours(0, 0, 0, 0);
                
                if (departureDate < today) {
                    console.log('Маршрут с прошедшей датой пропущен:', route.departureTime);
                    return false;
                }
                
                if (route.availableSeats === null || route.availableSeats === undefined || route.availableSeats <= 0) {
                    console.log('Маршрут без доступных мест пропущен:', route);
                    return false;
                }

                // Фильтр по станции отправления
                if (selectedDepartureId) {
                    const departureId = route.departureStation ? String(route.departureStation.id) : null;
                    if (departureId !== String(selectedDepartureId)) {
                        return false;
                    }
            }

                // Фильтр по станции прибытия
                if (selectedArrivalId) {
                    const arrivalId = route.arrivalStation ? String(route.arrivalStation.id) : null;
                    if (arrivalId !== String(selectedArrivalId)) {
                        return false;
                    }
                }

                return true;
            });

            console.log('Отфильтровано маршрутов:', filteredRoutes.length);

            if (filteredRoutes.length === 0) {
                $('#routesGrid').html('<p style="text-align: center; padding: 30px; color: var(--slate);">Нет доступных маршрутов по выбранным критериям. Попробуйте изменить фильтры или проверьте, что в базе данных есть маршруты с датой отправления не ранее сегодняшнего дня.</p>');
                    return;
                }

            // Группируем маршруты по направлению (отправление → прибытие)
            const routeGroups = {};
            filteredRoutes.forEach(function(route) {
                const departureStation = route.departureStation ? route.departureStation.name : 'Не указано';
                const arrivalStation = route.arrivalStation ? route.arrivalStation.name : 'Не указано';
                const routeKey = departureStation + ' → ' + arrivalStation;
                
                if (!routeGroups[routeKey]) {
                    routeGroups[routeKey] = [];
                }
                routeGroups[routeKey].push(route);
            });

            // Отображаем сгруппированные маршруты
            Object.keys(routeGroups).forEach(function(routeName) {
                const routesInGroup = routeGroups[routeName];
                const firstRoute = routesInGroup[0];
                const minPrice = Math.min(...routesInGroup.map(r => r.price || 0));
                const totalAvailableSeats = routesInGroup.reduce((sum, r) => sum + (r.availableSeats || 0), 0);
                
                const routeCard =
                        '<div class="service-card">' +
                        '<div class="service-image">' +
                    '<i class="fas fa-route" style="font-size: 3rem; color: var(--purple);"></i>' +
                        '</div>' +
                        '<div class="service-body">' +
                    '<h3 class="service-title">' + routeName + '</h3>' +
                        '<div class="service-meta">' +
                    '<span class="service-price">От ' + minPrice + ' BYN</span>' +
                    '<span class="service-master">Доступно рейсов: ' + routesInGroup.length + '</span>' +
                    '<span class="service-master">Свободных мест: ' + totalAvailableSeats + '</span>' +
                        '</div>' +
                        '<div class="service-actions">' +
                    '<button class="btn btn-purple view-schedule" data-route-name="' + routeName + '" data-departure="' + (firstRoute.departureStation ? firstRoute.departureStation.name : '') + '" data-arrival="' + (firstRoute.arrivalStation ? firstRoute.arrivalStation.name : '') + '">' +
                    '<i class="fas fa-calendar-alt"></i> Посмотреть расписание' +
                        '</button>' +
                        '</div>' +
                        '</div>' +
                        '</div>';

                $('#routesGrid').append(routeCard);
                });
            }

        // Загружаем данные при загрузке страницы
        loadStations();
        loadRoutes();

        // Обработчики изменения фильтров
        $('#departureStation, #arrivalStation').on('change', function() {
            filterAndDisplayRoutes();
        });

        // Обработчик кнопки сброса фильтров
        $('#clearFilter').on('click', function() {
            $('#departureStation').val('');
            $('#arrivalStation').val('');
            filterAndDisplayRoutes();
        });

        // Обработчик для просмотра расписания
        $(document).on('click', '.view-schedule', function() {
            const routeName = $(this).data('route-name');
            const departure = $(this).data('departure');
            const arrival = $(this).data('arrival');

            // Сохраняем параметры в sessionStorage для использования на странице расписания
            sessionStorage.setItem('selectedRoute', JSON.stringify({
                routeName: routeName,
                departure: departure,
                arrival: arrival
            }));
            
            // Перенаправляем на страницу расписания
            window.location.href = '/routeSchedule?departure=' + encodeURIComponent(departure) + '&arrival=' + encodeURIComponent(arrival);
        });
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