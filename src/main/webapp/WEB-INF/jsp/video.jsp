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

        /* Видео галерея */
        .videos-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
            margin-top: 20px;
        }

        .video-card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }

        .video-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }

        .video-thumbnail {
            position: relative;
            height: 200px;
            background-color: #000;
            cursor: pointer;
        }

        .video-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.9;
            transition: opacity 0.3s;
        }

        .video-thumbnail:hover img {
            opacity: 0.7;
        }

        .play-button {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 60px;
            height: 60px;
            background-color: rgba(255,255,255,0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
        }

        .play-button i {
            color: white;
            font-size: 1.8rem;
            margin-left: 5px;
        }

        .video-thumbnail:hover .play-button {
            background-color: rgba(255,255,255,0.3);
            transform: translate(-50%, -50%) scale(1.1);
        }

        .video-info {
            padding: 20px;
        }

        .video-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.2rem;
            margin-bottom: 10px;
            color: var(--dark-color);
        }

        .video-description {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 15px;
            line-height: 1.5;
        }

        .video-meta {
            display: flex;
            justify-content: space-between;
            color: #888;
            font-size: 0.85rem;
        }

        /* Модальное окно для видео */
        .video-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.9);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }

        .video-modal-content {
            width: 80%;
            max-width: 900px;
            position: relative;
        }

        .close-video {
            position: absolute;
            top: -40px;
            right: 0;
            color: white;
            font-size: 1.8rem;
            cursor: pointer;
        }

        .video-wrapper {
            position: relative;
            padding-bottom: 56.25%; /* 16:9 Aspect Ratio */
            height: 0;
            overflow: hidden;
        }

        .video-wrapper iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: none;
        }

        /* Категории видео */
        .video-categories {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .category-btn {
            padding: 8px 16px;
            border-radius: 20px;
            background: white;
            border: 1px solid #ddd;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 0.9rem;
        }

        .category-btn.active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }

        .category-btn:hover {
            border-color: var(--primary-color);
        }

        /* Поиск видео */
        .video-search {
            margin-bottom: 25px;
            position: relative;
            max-width: 400px;
        }

        .video-search input {
            width: 100%;
            padding: 12px 20px;
            border-radius: 30px;
            border: 1px solid #ddd;
            font-family: 'Montserrat', sans-serif;
            padding-left: 45px;
        }

        .video-search i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #888;
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

            .videos-container {
                grid-template-columns: 1fr;
            }

            .video-modal-content {
                width: 95%;
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
            <a href="${pageContext.request.contextPath}/booking" class="nav-link">
                <i class="fas fa-calendar-check nav-icon"></i>
                <span class="nav-text">Запись</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/haircare" class="nav-link active">
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
        <h2 class="page-title">Видео по уходу за волосами</h2>
    </div>

    <!-- Поиск и фильтры -->
    <div class="video-search">
        <i class="fas fa-search"></i>
        <input type="text" placeholder="Поиск видео..." id="search-videos">
    </div>

    <div class="video-categories">
        <button class="category-btn active" data-category="all">Все</button>
        <button class="category-btn" data-category="styling">Укладка</button>
        <button class="category-btn" data-category="treatment">Лечение</button>
        <button class="category-btn" data-category="coloring">Окрашивание</button>
        <button class="category-btn" data-category="tools">Инструменты</button>
    </div>

    <!-- Видео галерея -->
    <div class="videos-container">
        <!-- Видео 1 -->
        <div class="video-card" data-category="styling">
            <div class="video-thumbnail" data-video-id="M_nGPqYqJsA">
                <img src="https://i.ytimg.com/vi/M_nGPqYqJsA/hqdefault.jpg" alt="Уход за волосами">
                <div class="play-button">
                    <i class="fas fa-play"></i>
                </div>
            </div>
            <div class="video-info">
                <h3 class="video-title">5 способов укладки волос без термического воздействия</h3>
                <p class="video-description">Узнайте, как создать красивые прически без вреда для волос с помощью простых техник укладки.</p>
                <div class="video-meta">
                    <span><i class="fas fa-clock"></i> 12:34</span>
                    <span><i class="fas fa-eye"></i> 245K просмотров</span>
                </div>
            </div>
        </div>


        <!-- Видео 2 -->
        <div class="video-card" data-category="treatment">
            <div class="video-thumbnail" data-video-id="7KLNbdQerEA">
                <img src="https://i.ytimg.com/vi/7KLNbdQerEA/hqdefault.jpg" alt="Лечение волос">
                <div class="play-button">
                    <i class="fas fa-play"></i>
                </div>
            </div>
            <div class="video-info">
                <h3 class="video-title">Домашние маски для восстановления волос</h3>
                <p class="video-description">Рецепты натуральных масок для поврежденных волос, которые можно легко приготовить дома.</p>
                <div class="video-meta">
                    <span><i class="fas fa-clock"></i> 8:45</span>
                    <span><i class="fas fa-eye"></i> 189K просмотров</span>
                </div>
            </div>
        </div>

        <!-- Видео 3 -->
        <div class="video-card" data-category="coloring">
            <div class="video-thumbnail" data-video-id="-_0ivZlAiQM">
                <img src="https://i.ytimg.com/vi/-_0ivZlAiQM/hqdefault.jpg" alt="Окрашивание волос">
                <div class="play-button">
                    <i class="fas fa-play"></i>
                </div>
            </div>
            <div class="video-info">
                <h3 class="video-title">Как сохранить цвет волос после окрашивания</h3>
                <p class="video-description">Советы профессионалов по уходу за окрашенными волосами и продлению стойкости цвета.</p>
                <div class="video-meta">
                    <span><i class="fas fa-clock"></i> 15:20</span>
                    <span><i class="fas fa-eye"></i> 320K просмотров</span>
                </div>
            </div>
        </div>

        <!-- Видео 4 -->
        <div class="video-card" data-category="tools">
            <div class="video-thumbnail" data-video-id="wW7bZjFqm_c">
                <img src="https://i.ytimg.com/vi/wW7bZjFqm_c/hqdefault.jpg" alt="Инструменты для волос">
                <div class="play-button">
                    <i class="fas fa-play"></i>
                </div>
            </div>
            <div class="video-info">
                <h3 class="video-title">Как правильно выбрать фен и щетку для волос</h3>
                <p class="video-description">Руководство по выбору инструментов для укладки, которые не повредят ваши волосы.</p>
                <div class="video-meta">
                    <span><i class="fas fa-clock"></i> 10:15</span>
                    <span><i class="fas fa-eye"></i> 156K просмотров</span>
                </div>
            </div>
        </div>

        <!-- Видео 5 -->
        <div class="video-card" data-category="treatment">
            <div class="video-thumbnail" data-video-id="gwfBZs-d7Lc">
                <img src="https://i.ytimg.com/vi/gwfBZs-d7Lc/hqdefault.jpg" alt="Лечение волос">
                <div class="play-button">
                    <i class="fas fa-play"></i>
                </div>
            </div>
            <div class="video-info">
                <h3 class="video-title">Секреты ухода за сухими и ломкими волосами</h3>
                <p class="video-description">Эффективные методы восстановления сухих и поврежденных волос в домашних условиях.</p>
                <div class="video-meta">
                    <span><i class="fas fa-clock"></i> 14:30</span>
                    <span><i class="fas fa-eye"></i> 278K просмотров</span>
                </div>
            </div>
        </div>

        <!-- Видео 6 -->
        <div class="video-card" data-category="styling">
            <div class="video-thumbnail" data-video-id="BNbmDNxb7Dw">
                <img src="https://i.ytimg.com/vi/BNbmDNxb7Dw/hqdefault.jpg" alt="Укладка волос">
                <div class="play-button">
                    <i class="fas fa-play"></i>
                </div>
            </div>
            <div class="video-info">
                <h3 class="video-title">Вечерние прически за 5 минут</h3>
                <p class="video-description">Быстрые и элегантные прически для особых случаев, которые можно сделать самостоятельно.</p>
                <div class="video-meta">
                    <span><i class="fas fa-clock"></i> 7:52</span>
                    <span><i class="fas fa-eye"></i> 412K просмотров</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Модальное окно для видео -->
    <div class="video-modal" id="video-modal">
        <div class="video-modal-content">
            <span class="close-video">&times;</span>
            <div class="video-wrapper">
                <iframe id="video-frame" src="" frameborder="0" allowfullscreen></iframe>
            </div>
        </div>
    </div>
</div>

<script src="https://www.youtube.com/iframe_api"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // Открытие видео в модальном окне
        $('.video-thumbnail').click(function() {
            const videoId = $(this).data('video-id');
            const videoUrl = `https://www.youtube.com/embed/${videoId}?autoplay=1&rel=0`;

            $('#video-frame').attr('src', videoUrl);
            $('#video-modal').show();
            $('body').css('overflow', 'hidden');
        });

        // Закрытие модального окна
        $('.close-video').click(function() {
            $('#video-frame').attr('src', '');
            $('#video-modal').hide();
            $('body').css('overflow', 'auto');
        });

        // Фильтрация видео по категориям
        $('.category-btn').click(function() {
            $('.category-btn').removeClass('active');
            $(this).addClass('active');

            const category = $(this).data('category');

            if (category === 'all') {
                $('.video-card').show();
            } else {
                $('.video-card').hide();
                $(`.video-card[data-category="${category}"]`).show();
            }
        });

        // Поиск видео
        $('#search-videos').on('input', function() {
            const searchTerm = $(this).val().toLowerCase();

            $('.video-card').each(function() {
                const title = $(this).find('.video-title').text().toLowerCase();
                const description = $(this).find('.video-description').text().toLowerCase();

                if (title.includes(searchTerm) || description.includes(searchTerm)) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        });

        // Закрытие модального окна при клике вне его
        $(window).click(function(event) {
            if (event.target.id === 'video-modal') {
                $('#video-frame').attr('src', '');
                $('#video-modal').hide();
                $('body').css('overflow', 'auto');
            }
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
    });
</script>
</body>
</html>