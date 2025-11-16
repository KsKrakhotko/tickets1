<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Главная | Парикмахерская "Элегант"</title>
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

        /* Навигация */
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

        /* Приветственный блок */
        .welcome-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            background: linear-gradient(135deg, #ffffff 0%, #f9f9f9 100%);
            border-left: 5px solid var(--primary-color);
        }

        .welcome-title {
            font-size: 1.8rem;
            margin-bottom: 15px;
            color: var(--primary-color);
        }

        .welcome-text {
            font-size: 1.1rem;
            line-height: 1.6;
            color: #555;
            margin-bottom: 20px;
        }

        /* Карточки услуг */
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .service-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .service-image {
            height: 180px;
            background-size: cover;
            background-position: center;
        }

        .service-content {
            padding: 20px;
        }

        .service-title {
            font-size: 1.3rem;
            margin-bottom: 10px;
            color: var(--primary-color);
        }

        .service-description {
            color: #666;
            margin-bottom: 15px;
            line-height: 1.5;
        }

        .service-price {
            font-weight: 600;
            color: var(--secondary-color);
            font-size: 1.2rem;
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

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .welcome-card, .service-card {
            animation: fadeIn 0.6s ease-out;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-header">
        <a href="#" class="logo">
            <i class="fas fa-scissors logo-icon"></i>
            <span class="logo-text">Элегант</span>
        </a>
        <button class="toggle-btn" onclick="toggleSidebar()">
            <i class="fas fa-angle-left"></i>
        </button>
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
                <i class="fas fa-sign-out-alt nav-icon"></i>
                <span class="nav-text">Вход</span>
            </a>
        </li>
    </ul>

</div>

<div class="main-content">
    <div class="header">
        <h1 class="page-title">Главная</h1>
        <button class="mobile-menu-btn" onclick="toggleMobileMenu()">
            <i class="fas fa-bars"></i>
        </button>
    </div>

    <div class="welcome-card">
        <h2 class="welcome-title">Добро пожаловать в парикмахерскую "Элегант"</h2>
        <p class="welcome-text">
            Мы предлагаем профессиональные услуги парикмахеров, стилистов и визажистов.
            Наши мастера с многолетним опытом помогут вам создать идеальный образ.
        </p>
        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
        <a href="/booking" class="btn" id="bookingBtn" style="display: inline-block; background: var(--primary-color); color: white; padding: 12px 25px; border-radius: 8px; text-decoration: none;">
            Записаться онлайн
        </a>

        <div id="registrationModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); z-index: 1000; justify-content: center; align-items: center;">
            <div style="background: white; padding: 30px; border-radius: 10px; max-width: 400px; text-align: center;">
                <h3 style="margin-top: 0;">Для записи необходимо зарегистрироваться</h3>
                <p>Пожалуйста, зарегистрируйтесь или войдите в свой аккаунт, чтобы продолжить.</p>
                <div style="margin-top: 20px;">
                    <a href="<%= request.getContextPath() %>/signup" style="display: inline-block; background: var(--primary-color); color: white; padding: 10px 20px; border-radius: 5px; text-decoration: none; margin-right: 10px;">
                        Зарегистрироваться
                    </a>
                    <a href="<%= request.getContextPath() %>/signin" style="display: inline-block; padding: 10px 20px; border-radius: 5px; text-decoration: none; border: 1px solid #ccc;">
                        Войти
                    </a>
                </div>
                <button id="closeModal" style="margin-top: 20px; background: none; border: none; color: #666; cursor: pointer;">
                    Закрыть
                </button>
            </div>
        </div>

        <script>
            document.getElementById('bookingBtn').addEventListener('click', function(e) {
                e.preventDefault();
                document.getElementById('registrationModal').style.display = 'flex';
            });

            document.getElementById('closeModal').addEventListener('click', function() {
                document.getElementById('registrationModal').style.display = 'none';
            });

            window.addEventListener('click', function(e) {
                if (e.target === document.getElementById('registrationModal')) {
                    document.getElementById('registrationModal').style.display = 'none';
                }
            });
        </script>
    </div>

    <h2 style="margin-bottom: 20px; color: var(--primary-color);">Популярные услуги</h2>

    <div class="services-grid">
        <div class="service-card">
            <div class="service-image" style="background-image: url('https://i.pinimg.com/originals/fd/35/e6/fd35e625f85ed8689b0034e4decb0bab.jpg');"></div>
            <div class="service-content">
                <h3 class="service-title">Женская стрижка</h3>
                <p class="service-description">Профессиональная стрижка с учетом особенностей вашего типа лица и волос.</p>
                <div class="service-price">от 50 Byn</div>
            </div>
        </div>

        <div class="service-card">
            <div class="service-image" style="background-image: url('https://avatars.mds.yandex.net/i?id=80061dd96a56860d9a8c67c4073bf946_l-5236580-images-thumbs&n=13');"></div>
            <div class="service-content">
                <h3 class="service-title">Мужская стрижка</h3>
                <p class="service-description">Стрижка с оформлением бороды и усов по последним тенденциям.</p>
                <div class="service-price">от 40 Byn</div>
            </div>
        </div>

        <div class="service-card">
            <div class="service-image" style="background-image: url('https://i.pinimg.com/736x/39/68/c7/3968c73343fa0de140554d4fa36ee7af.jpg');"></div>
            <div class="service-content">
                <h3 class="service-title">Окрашивание</h3>
                <p class="service-description">Качественное окрашивание с использованием профессиональных материалов.</p>
                <div class="service-price">от 70 Byn</div>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleSidebar() {
        document.querySelector('.sidebar').classList.toggle('collapsed');
    }
    document.addEventListener('click', function(event) {
        const sidebar = document.querySelector('.sidebar');
        const mobileBtn = document.querySelector('.mobile-menu-btn');

        if (window.innerWidth <= 768 &&
            !sidebar.contains(event.target) &&
            event.target !== mobileBtn &&
            !mobileBtn.contains(event.target)) {
            sidebar.style.width = '0';
        }
    });
</script>
</body>
</html>