<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Отзывы | Парикмахерская "Элегант"</title>
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

        .action-btn {
            background-color: var(--accent-color);
            color: var(--primary-color);
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
            display: flex;
            align-items: center;
        }

        .action-btn:hover {
            background-color: var(--secondary-color);
            color: #fff;
        }

        .action-btn i {
            margin-right: 5px;
        }

        /* Стили для отзывов */
        .reviews-container {
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        .review-card {
            background-color: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .review-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .review-author {
            font-weight: 600;
            color: var(--primary-color);
        }

        .review-date {
            color: #777;
            font-size: 0.9rem;
        }

        .review-rating {
            color: #FFD700;
            margin-bottom: 10px;
        }

        .review-text {
            line-height: 1.6;
            color: #555;
        }

        /* Форма добавления отзыва */
        .add-review-form {
            background-color: white;
            border-radius: 10px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .form-title {
            font-family: 'Playfair Display', serif;
            color: var(--primary-color);
            margin-bottom: 20px;
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark-color);
        }

        .form-input, .form-textarea {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-family: 'Montserrat', sans-serif;
            transition: border-color 0.3s;
        }

        .form-input:focus, .form-textarea:focus {
            border-color: var(--primary-color);
            outline: none;
        }

        .form-textarea {
            min-height: 120px;
            resize: vertical;
        }

        .rating-stars {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }

        .star {
            font-size: 1.8rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
        }

        .star.active {
            color: #FFD700;
        }

        .submit-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .submit-btn:hover {
            background-color: #5a3d7d;
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

            .review-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }

            .add-review-form {
                padding: 15px;
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
            <a href="${pageContext.request.contextPath}/video" class="nav-link">
                <i class="fas fa-spa nav-icon"></i>
                <span class="nav-text">Уход за волосами</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/reviews" class="nav-link active">
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
        <h2 class="page-title">Отзывы</h2>
        <button class="action-btn" id="showFormBtn">
            <i class="fas fa-plus"></i> Добавить отзыв
        </button>
    </div>

    <!-- Форма добавления отзыва (изначально скрыта) -->
    <div class="add-review-form" id="reviewForm" style="display: none;">
        <h3 class="form-title">Оставить отзыв</h3>
        <form id="reviewFormElement">
            <div class="form-group">
                <label class="form-label">Оценка</label>
                <div class="rating-stars" id="ratingStars">
                    <i class="fas fa-star star" data-value="1"></i>
                    <i class="fas fa-star star" data-value="2"></i>
                    <i class="fas fa-star star" data-value="3"></i>
                    <i class="fas fa-star star" data-value="4"></i>
                    <i class="fas fa-star star" data-value="5"></i>
                </div>
                <input type="hidden" id="ratingValue" value="0">
            </div>
            <div class="form-group">
                <label class="form-label">Ваш отзыв</label>
                <textarea class="form-textarea" id="reviewText" required></textarea>
            </div>
            <button type="submit" class="submit-btn">Отправить отзыв</button>
        </form>
    </div>

    <!-- Контейнер с отзывами -->
    <div class="reviews-container" id="reviewsContainer">
        <!-- Пример отзыва -->
        <div class="review-card">
            <div class="review-header">
                <span class="review-author">Анна Иванова</span>
                <span class="review-date">15 мая 2023</span>
            </div>
            <div class="review-rating">
                <i class="fas fa-star" style="color: #FFD700;"></i>
                <i class="fas fa-star" style="color: #FFD700;"></i>
                <i class="fas fa-star" style="color: #FFD700;"></i>
                <i class="fas fa-star" style="color: #FFD700;"></i>
                <i class="fas fa-star" style="color: #FFD700;"></i>
            </div>
            <p class="review-text">
                Очень довольна посещением парикмахерской "Элегант"! Мастер Мария - профессионал своего дела.
                Сделала именно ту стрижку, которую я хотела, дала ценные советы по уходу за волосами.
                Атмосфера в салоне приятная, уютная. Обязательно вернусь снова!
            </p>
        </div>

        <!-- Еще один пример отзыва -->
        <div class="review-card">
            <div class="review-header">
                <span class="review-author">Сергей Петров</span>
                <span class="review-date">3 апреля 2023</span>
            </div>
            <div class="review-rating">
                <i class="fas fa-star" style="color: #FFD700;"></i>
                <i class="fas fa-star" style="color: #FFD700;"></i>
                <i class="fas fa-star" style="color: #FFD700;"></i>
                <i class="fas fa-star" style="color: #FFD700;"></i>
                <i class="far fa-star" style="color: #FFD700;"></i>
            </div>
            <p class="review-text">
                Хороший салон, качественные услуги. Единственное - пришлось немного подождать,
                хотя у меня была запись. Но результат того стоил, стрижка выполнена аккуратно.
                Рекомендую этого мастера.
            </p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jwt-decode@3.1.2/build/jwt-decode.min.js"></script>
<script>
    // Функция для переключения сайдбара
    function toggleSidebar() {
        document.querySelector('.sidebar').classList.toggle('collapsed');
    }

    // Функция для выхода
    function logout() {
        localStorage.removeItem("jwtToken");
        sessionStorage.removeItem("jwtToken");
        document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
        window.location.href = "/home";
    }

    function initRatingStars() {
        const stars = document.querySelectorAll('.star');
        const ratingInput = document.getElementById('ratingValue');

        stars.forEach(star => {
            // При наведении
            star.addEventListener('mouseover', function() {
                const value = parseInt(this.getAttribute('data-value'));
                highlightStars(value);
            });

            // При уходе курсора
            star.addEventListener('mouseout', function() {
                const currentRating = parseInt(ratingInput.value);
                highlightStars(currentRating);
            });

            // При клике
            star.addEventListener('click', function() {
                const value = parseInt(this.getAttribute('data-value'));
                ratingInput.value = value;
                highlightStars(value);
            });
        });
    }

    // Подсветка звезд
    function highlightStars(count) {
        const stars = document.querySelectorAll('.star');
        stars.forEach((star, index) => {
            if (index < count) {
                star.classList.add('fas');
                star.classList.remove('far');
            } else {
                star.classList.add('far');
                star.classList.remove('fas');
            }
        });
    }
    // Функция для получения всех отзывов с сервера
    async function loadReviews() {
        try {
            const response = await fetch("/review");
            if (response.ok) {
                const reviews = await response.json();
                console.log("Отзывы успешно получены:", reviews);
                const reviewsContainer = document.getElementById('reviewsContainer');
                reviewsContainer.innerHTML = ''; // Очищаем контейнер перед загрузкой новых отзывов
                reviews.forEach(review => {
                    const reviewCard = createReviewCard(review);
                    reviewsContainer.appendChild(reviewCard);
                });
            } else {
                console.error("Ошибка загрузки отзывов");
            }
        } catch (error) {
            console.error("Ошибка при запросе", error);
        }
    }

    // Создание HTML для отзыва
    function createReviewCard(review) {
        const reviewCard = document.createElement('div');
        reviewCard.className = 'review-card';

        const currentDate = new Date(review.createdAt);
        const formattedDate = currentDate.toLocaleDateString('ru-RU', {
            day: 'numeric',
            month: 'long',
            year: 'numeric'
        });

        // Генерация звезд для рейтинга
        let starsHTML = '';
        for (let i = 0; i < 5; i++) {
            starsHTML += i < review.rating
                ? '<i class="fas fa-star" style="color: #FFD700;"></i>'
                : '<i class="far fa-star" style="color: #FFD700;"></i>';
        }

        reviewCard.innerHTML =
            '<div class="review-header">' +
            '<span class="review-author">' + review.user.username + '</span>' +
            '<span class="review-date">' + formattedDate + '</span>' +
            '</div>' +
            '<div class="review-rating">' +
            starsHTML +
            '</div>' +
            '<p class="review-text">' + review.reviewText + '</p>';

        return reviewCard;
    }

    // Загружаем отзывы при загрузке страницы
    window.addEventListener('DOMContentLoaded', function() {
        loadReviews();
        initRatingStars(); // Добавляем инициализацию звёзд
    });

    document.getElementById('reviewFormElement').addEventListener('submit', function(e) {
        e.preventDefault();

        const rating = document.getElementById('ratingValue').value;
        const text = document.getElementById('reviewText').value;
        const token = localStorage.getItem("jwtToken");

        if (rating === '0') {
            alert('Пожалуйста, поставьте оценку');
            return;
        }

        let xhr = new XMLHttpRequest();
        try {
            // Декодируем токен и получаем ID пользователя
            const decodedToken = jwt_decode(token);
            const userId = decodedToken.id;
            console.log("ID пользователя:", userId);

        // Отправляем новый отзыв на сервер
            const newReview = {
                user: { id: userId }, // Передаем объект user с id
                reviewText: text,
                rating: parseInt(rating),
                createdAt: new Date().toISOString(),
            };

            console.log("Отправляемый объект на сервер:", JSON.stringify(newReview)); // Отладочный вывод


            // Создаем новый XMLHttpRequest
        xhr.open('POST', '/review', true);
        xhr.setRequestHeader('Content-Type', 'application/json');

        // Устанавливаем обработчик для успешного ответа
        xhr.onload = function() {
            if (xhr.status === 200) {
                alert('Спасибо за ваш отзыв!');
                loadReviews(); // Перезагружаем список отзывов
                document.getElementById('reviewFormElement').reset();  // Очищаем форму
                document.getElementById('ratingValue').value = '0'; // Сбрасываем рейтинг
            } else {
                alert('Ошибка при добавлении отзыва');
            }
        };

        // Устанавливаем обработчик для ошибок запроса
        xhr.onerror = function() {
            alert('Ошибка при отправке отзыва');
        };
            // Отправляем запрос
            xhr.send(JSON.stringify(newReview));
        } catch (error) {
            console.error('Ошибка декодирования токена:', error);
            alert('Ошибка аутентификации. Пожалуйста, войдите снова.');
        }

    });

    document.getElementById('showFormBtn').addEventListener('click', function() {
        const form = document.getElementById('reviewForm');
        if (form.style.display === 'none') {
            form.style.display = 'block';
            this.innerHTML = '<i class="fas fa-times"></i> Отменить';
        } else {
            form.style.display = 'none';
            this.innerHTML = '<i class="fas fa-plus"></i> Добавить отзыв';
        }
    });
</script>
</body>
</html>