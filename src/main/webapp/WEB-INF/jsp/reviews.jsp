<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Отзывы | Железнодорожные перевозки</title>
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

        .action-btn {
            background: var(--purple);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .action-btn:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
        }

        .action-btn i {
            margin-right: 5px;
        }

        /* Стили для отзывов */
        .reviews-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .review-card {
            background: #FFF;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            transition: transform 0.3s, box-shadow 0.3s;
            border-top: 4px solid var(--purple);
        }

        .review-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .review-author {
            font-weight: 600;
            color: var(--charcoal);
            font-size: 1.1rem;
        }

        .review-date {
            color: var(--slate);
            font-size: 0.9rem;
        }

        .review-rating {
            color: #FFD700;
            margin-bottom: 15px;
            font-size: 1.2rem;
        }

        .review-text {
            line-height: 1.8;
            color: var(--charcoal);
            font-size: 1rem;
        }

        /* Форма добавления отзыва */
        .add-review-form {
            background: #FFF;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 5px 25px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            border-top: 4px solid var(--purple);
        }

        .form-title {
            font-family: 'Playfair Display', serif;
            color: var(--charcoal);
            margin-bottom: 25px;
            font-size: 1.5rem;
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

        .form-input, .form-textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-family: 'Montserrat', sans-serif;
            transition: border-color 0.3s;
            font-size: 1rem;
        }

        .form-input:focus, .form-textarea:focus {
            outline: none;
            border-color: var(--purple);
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.1);
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
            transition: color 0.2s, transform 0.2s;
        }

        .star:hover {
            transform: scale(1.1);
        }

        .star.active {
            color: #FFD700;
        }

        .submit-btn {
            background: var(--purple);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .submit-btn:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(138, 43, 226, 0.3);
        }

        @media (max-width: 992px) {
            .admin-layout {
                grid-template-columns: 1fr;
            }

            .admin-sidebar {
                display: none;
            }
        }

        @media (max-width: 768px) {
            .admin-content {
                padding: 20px;
            }

            .review-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }

            .add-review-form {
                padding: 20px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
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
                <a href="${pageContext.request.contextPath}/serviceUser" class="nav-link">
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
                <a href="${pageContext.request.contextPath}/reviews" class="nav-link active">
                    <i class="fas fa-star nav-icon"></i>
                    <span class="nav-text">Отзывы</span>
                </a>
            </li>
            <li class="nav-item" style="margin-top: 30px;">
                <a href="javascript:void(0);" class="nav-link" onclick="logout()">
                    <i class="fas fa-sign-out-alt nav-icon"></i>
                    <span class="nav-text">Выход</span>
                </a>
            </li>
        </ul>
    </div>

    <div class="admin-content">
        <div class="page-header">
            <h2 class="page-title">Отзывы о ЖД-Портале</h2>
            <button class="action-btn" id="showFormBtn">
                <i class="fas fa-plus"></i> Добавить отзыв
            </button>
        </div>

        <div class="add-review-form" id="reviewForm" style="display: none;">
            <h3 class="form-title">Оставить отзыв</h3>
            <form id="reviewFormElement">
                <div class="form-group">
                    <label class="form-label">Оценка</label>
                    <div class="rating-stars" id="ratingStars">
                        <i class="far fa-star star" data-value="1"></i>
                        <i class="far fa-star star" data-value="2"></i>
                        <i class="far fa-star star" data-value="3"></i>
                        <i class="far fa-star star" data-value="4"></i>
                        <i class="far fa-star star" data-value="5"></i>
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

        <div class="reviews-container" id="reviewsContainer">
            <!-- Отзывы будут загружены динамически -->
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/jwt-decode@3.1.2/build/jwt-decode.min.js"></script>
<script>
    // Функция для выхода
    function logout() {
        localStorage.removeItem("jwtToken");
        sessionStorage.removeItem("jwtToken");
        document.cookie = "jwtToken=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
        window.location.href = "/home";
    }

    // ИСПРАВЛЕНО: Правильная логика подсветки звезд
    function highlightStars(count) {
        const stars = document.querySelectorAll('#ratingStars .star');
        stars.forEach((star, index) => {
            if (index < count) {
                // Выбранная: сплошная (fas) и активный цвет
                star.classList.add('fas', 'active');
                star.classList.remove('far');
            } else {
                // Невыбранная: контурная (far) и неактивный цвет
                star.classList.add('far');
                star.classList.remove('fas', 'active');
            }
        });
    }

    function initRatingStars() {
        const starsContainer = document.getElementById('ratingStars');
        const ratingInput = document.getElementById('ratingValue');

        const stars = starsContainer.querySelectorAll('.star');

        stars.forEach(star => {
            // При наведении
            star.addEventListener('mouseover', function() {
                const value = parseInt(this.getAttribute('data-value'));
                highlightStars(value);
            });

            // При уходе курсора, восстанавливаем текущий рейтинг
            star.addEventListener('mouseout', function() {
                const currentRating = parseInt(ratingInput.value);
                highlightStars(currentRating);
            });

            // При клике - устанавливаем рейтинг
            star.addEventListener('click', function() {
                const value = parseInt(this.getAttribute('data-value'));
                ratingInput.value = value;
                highlightStars(value);
            });
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
                
                if (reviews && reviews.length > 0) {
                    reviews.forEach(review => {
                        try {
                            const reviewCard = createReviewCard(review);
                            reviewsContainer.appendChild(reviewCard);
                        } catch (error) {
                            console.error("Ошибка при создании карточки отзыва:", error, review);
                        }
                    });
                } else {
                    reviewsContainer.innerHTML = '<div class="review-card"><p class="review-text">Пока нет отзывов. Будьте первым!</p></div>';
                }
            } else {
                console.error("Ошибка загрузки отзывов:", response.status, response.statusText);
                const reviewsContainer = document.getElementById('reviewsContainer');
                reviewsContainer.innerHTML = '<div class="review-card"><p class="review-text" style="color: red;">Ошибка при загрузке отзывов. Попробуйте обновить страницу.</p></div>';
            }
        } catch (error) {
            console.error("Ошибка при запросе", error);
            const reviewsContainer = document.getElementById('reviewsContainer');
            reviewsContainer.innerHTML = '<div class="review-card"><p class="review-text" style="color: red;">Ошибка при загрузке отзывов. Проверьте подключение к интернету.</p></div>';
        }
    }

    // Создание HTML для отзыва
    function createReviewCard(review) {
        const reviewCard = document.createElement('div');
        reviewCard.className = 'review-card';

        // Проверка на наличие данных
        if (!review) {
            throw new Error("Review is null or undefined");
        }

        // Обработка даты
        let formattedDate = 'Дата не указана';
        if (review.createdAt) {
            try {
                const currentDate = new Date(review.createdAt);
                if (!isNaN(currentDate.getTime())) {
                    formattedDate = currentDate.toLocaleDateString('ru-RU', {
                        day: 'numeric',
                        month: 'long',
                        year: 'numeric'
                    });
                }
            } catch (e) {
                console.error("Ошибка форматирования даты:", e);
            }
        }

        // Обработка имени пользователя
        const username = (review.user && review.user.username) ? review.user.username : 'Анонимный пользователь';

        // Генерация звезд для рейтинга
        let starsHTML = '';
        const rating = review.rating || 0;
        for (let i = 0; i < 5; i++) {
            // Используем fas для закрашенных, far для незакрашенных
            starsHTML += i < rating
                ? '<i class="fas fa-star" style="color: #FFD700;"></i>'
                : '<i class="far fa-star" style="color: #FFD700;"></i>';
        }

        // Обработка текста отзыва
        const reviewText = review.reviewText || 'Текст отзыва отсутствует';

        reviewCard.innerHTML =
            '<div class="review-header">' +
            '<span class="review-author">' + escapeHtml(username) + '</span>' +
            '<span class="review-date">' + formattedDate + '</span>' +
            '</div>' +
            '<div class="review-rating">' +
            starsHTML +
            '</div>' +
            '<p class="review-text">' + escapeHtml(reviewText) + '</p>';

        return reviewCard;
    }

    // Функция для экранирования HTML
    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // Загружаем отзывы и инициализируем звезды при загрузке страницы
    window.addEventListener('DOMContentLoaded', function() {
        loadReviews();
        initRatingStars();
    });

    document.getElementById('reviewFormElement').addEventListener('submit', function(e) {
        e.preventDefault();

        const rating = document.getElementById('ratingValue').value;
        const text = document.getElementById('reviewText').value.trim();
        const token = localStorage.getItem("jwtToken") || sessionStorage.getItem("jwtToken");

        if (rating === '0') {
            alert('Пожалуйста, поставьте оценку');
            return;
        }

        if (!text) {
            alert('Пожалуйста, введите текст отзыва');
            return;
        }

        if (!token) {
            alert('Ошибка аутентификации. Пожалуйста, войдите снова.');
            window.location.href = '/signin';
            return;
        }

        let xhr = new XMLHttpRequest();
        try {
            // Декодируем токен и получаем ID пользователя
            const decodedToken = jwt_decode(token);
            const userId = decodedToken.id;
            
            if (!userId) {
                alert('Ошибка: не удалось получить ID пользователя. Пожалуйста, войдите снова.');
                window.location.href = '/signin';
                return;
            }
            
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
                    try {
                        const response = JSON.parse(xhr.responseText);
                        alert('Спасибо за ваш отзыв!');
                        loadReviews(); // Перезагружаем список отзывов
                        document.getElementById('reviewFormElement').reset();  // Очищаем форму
                        document.getElementById('ratingValue').value = '0'; // Сбрасываем рейтинг
                        highlightStars(0); // Сбрасываем подсветку звезд
                        document.getElementById('reviewForm').style.display = 'none';
                        document.getElementById('showFormBtn').innerHTML = '<i class="fas fa-plus"></i> Добавить отзыв';
                    } catch (e) {
                        console.error('Ошибка парсинга ответа:', e);
                        alert('Отзыв добавлен, но произошла ошибка при обновлении страницы');
                        loadReviews();
                    }
                } else {
                    let errorMessage = 'Ошибка при добавлении отзыва';
                    try {
                        const errorResponse = JSON.parse(xhr.responseText);
                        if (errorResponse) {
                            errorMessage = errorResponse.toString();
                        }
                    } catch (e) {
                        // Игнорируем ошибку парсинга
                    }
                    alert(errorMessage);
                }
            };

            // Устанавливаем обработчик для ошибок запроса
            xhr.onerror = function() {
                alert('Ошибка при отправке отзыва. Проверьте подключение к интернету.');
            };
            
            // Устанавливаем обработчик для таймаута
            xhr.ontimeout = function() {
                alert('Превышено время ожидания ответа. Попробуйте еще раз.');
            };
            xhr.timeout = 10000; // 10 секунд
            
            // Отправляем запрос
            xhr.send(JSON.stringify(newReview));
        } catch (error) {
            console.error('Ошибка декодирования токена:', error);
            alert('Ошибка аутентификации. Пожалуйста, войдите снова.');
            window.location.href = '/signin';
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
