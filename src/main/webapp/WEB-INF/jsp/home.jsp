<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Главная | Железнодорожные перевозки</title>
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

        .welcome-card {
            background: #FFF;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            margin-bottom: 40px;
            border-top: 4px solid var(--purple);
        }

        .welcome-title {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            margin-bottom: 20px;
            color: var(--charcoal);
            position: relative;
        }

        .welcome-title::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 60px;
            height: 2px;
            background: var(--purple);
        }

        .welcome-text {
            font-size: 1.1rem;
            line-height: 1.8;
            color: var(--slate);
            margin-bottom: 30px;
        }

        .btn {
            padding: 12px 30px;
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

        .routes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .route-card {
            background: #FFF;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border-top: 3px solid var(--purple);
        }

        .route-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .route-image {
            height: 180px;
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .route-image::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to bottom, transparent, rgba(138, 43, 226, 0.1));
        }

        .route-content {
            padding: 25px;
        }

        .route-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.4rem;
            margin-bottom: 12px;
            color: var(--charcoal);
        }

        .route-description {
            color: var(--slate);
            margin-bottom: 15px;
            line-height: 1.6;
            font-size: 0.95rem;
        }

        .route-price {
            font-weight: 700;
            color: var(--purple);
            font-size: 1.3rem;
        }

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
            background: white;
            padding: 40px;
            border-radius: 12px;
            max-width: 500px;
            text-align: center;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            }

        .modal-content h3 {
            font-family: 'Playfair Display', serif;
            color: var(--charcoal);
            margin-bottom: 15px;
            }

        .modal-content p {
            color: var(--slate);
            margin-bottom: 25px;
            }

        .modal-actions {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .btn-secondary {
            background: var(--slate);
                color: white;
        }

        .btn-secondary:hover {
            background: var(--charcoal);
        }

        .btn-outline {
            background: transparent;
            border: 1px solid var(--slate);
            color: var(--slate);
        }

        .btn-outline:hover {
            background: rgba(112, 128, 144, 0.1);
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
            <a href="${pageContext.request.contextPath}/" class="nav-link active">
                <i class="fas fa-home nav-icon"></i>
                <span class="nav-text">Главная</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/contact" class="nav-link">
                <i class="fas fa-map-marker-alt nav-icon"></i>
                <span class="nav-text">Контакты</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/signin" class="nav-link">
                <i class="fas fa-sign-in-alt nav-icon"></i>
                <span class="nav-text">Вход</span>
            </a>
        </li>
    </ul>
</div>

    <div class="admin-content">
        <div class="page-header">
            <h2 class="page-title">Главная</h2>
    </div>

    <div class="welcome-card">
        <h2 class="welcome-title">Добро пожаловать в систему бронирования ЖД билетов</h2>
        <p class="welcome-text">
                Мы предоставляем вам систему для удобного бронирования билетов на железнодорожные перевозки не выходя из дома. 
                Выберите маршрут, удобное место и оформите билет за несколько кликов.
            </p>
            <a href="/booking" class="btn btn-primary" id="bookingBtn">
                <i class="fas fa-ticket-alt"></i> Забронировать онлайн
            </a>
        </div>

        <h3 style="margin-bottom: 25px; font-family: 'Playfair Display', serif; color: var(--charcoal);">
            <i class="fas fa-route" style="color: var(--purple); margin-right: 10px;"></i>
            Популярные направления
        </h3>

        <div class="routes-grid">
            <div class="route-card">
                <div class="route-image" style="background-image: url('<%= request.getContextPath() %>/images/Moscow.png');">
                    <i class="fas fa-train" style="font-size: 3rem; color: var(--purple); z-index: 1; position: relative;"></i>
    </div>
                <div class="route-content">
                    <h3 class="route-title">Минск → Москва</h3>
                    <p class="route-description">Незабываемая поездка в комфортных условиях. Прямое сообщение между столицами.</p>
                    <div class="route-price">от 160 BYN</div>
            </div>
        </div>

            <div class="route-card">
                <div class="route-image" style="background-image: url('<%= request.getContextPath() %>/images/Gomel.png');">
                    <i class="fas fa-train" style="font-size: 3rem; color: var(--purple); z-index: 1; position: relative;"></i>
                </div>
                <div class="route-content">
                    <h3 class="route-title">Минск → Гомель</h3>
                    <p class="route-description">Южное гостеприимство на рельсах. Быстрое и комфортное путешествие.</p>
                    <div class="route-price">от 20 BYN</div>
            </div>
        </div>

            <div class="route-card">
                <div class="route-image" style="background-image: url('<%= request.getContextPath() %>/images/Vitebsk.png');">
                    <i class="fas fa-train" style="font-size: 3rem; color: var(--purple); z-index: 1; position: relative;"></i>
                </div>
                <div class="route-content">
                    <h3 class="route-title">Минск → Витебск</h3>
                    <p class="route-description">Путешествие на родину гения. Удобное расписание и комфортные вагоны.</p>
                    <div class="route-price">от 20 BYN</div>
            </div>
        </div>
        </div>
    </div>
</div>

<div id="registrationModal" class="modal">
    <div class="modal-content">
        <h3>Для покупки билета необходимо зарегистрироваться</h3>
        <p>Пожалуйста, зарегистрируйтесь или войдите в свой аккаунт, чтобы продолжить.</p>
        <div class="modal-actions">
            <a href="<%= request.getContextPath() %>/signup" class="btn btn-primary">
                <i class="fas fa-user-plus"></i> Зарегистрироваться
            </a>
            <a href="<%= request.getContextPath() %>/signin" class="btn btn-outline">
                <i class="fas fa-sign-in-alt"></i> Войти
            </a>
        </div>
        <button id="closeModal" class="btn btn-secondary" style="margin-top: 20px;">
            <i class="fas fa-times"></i> Закрыть
        </button>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $('#bookingBtn').on('click', function(e) {
            e.preventDefault();
            $('#registrationModal').css('display', 'flex');
        });

        $('#closeModal').on('click', function() {
            $('#registrationModal').css('display', 'none');
        });

        $(window).on('click', function(e) {
            if ($(e.target).is('#registrationModal')) {
                $('#registrationModal').css('display', 'none');
        }
        });
    });
</script>
</body>
</html>