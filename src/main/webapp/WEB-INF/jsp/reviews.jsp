<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Отзывы | ЖД-Портал</title>
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

        .btn {
            padding: 12px 24px;
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

        .add-review-form {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-top: 3px solid var(--purple);
            margin-bottom: 30px;
        }

        .form-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: var(--charcoal);
            margin-bottom: 20px;
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

        .rating-stars {
            display: flex;
            gap: 5px;
            margin-bottom: 15px;
        }

        .rating-stars .star {
            font-size: 1.8rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
        }

        .rating-stars .star:hover,
        .rating-stars .star.active {
            color: #FFD700;
        }

        .rating-stars .star.fas {
            color: #FFD700;
        }

        .form-textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 4px;
            font-size: 16px;
            font-family: 'Montserrat', sans-serif;
            min-height: 120px;
            resize: vertical;
            transition: all 0.3s;
        }

        .form-textarea:focus {
            border-color: var(--purple);
            outline: none;
            box-shadow: 0 0 0 3px rgba(138, 43, 226, 0.1);
        }

        .submit-btn {
            background: var(--purple);
            color: white;
            border: none;
            border-radius: 4px;
            padding: 14px 30px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            background: var(--dark-purple);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(138, 43, 226, 0.3);
        }

        .reviews-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .review-card {
            background: white;
            border-radius: 8px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            border-top: 3px solid var(--purple);
            transition: transform 0.3s ease;
        }

        .review-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
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
            margin-bottom: 15px;
        }

        .review-rating i {
            color: #FFD700;
            margin-right: 3px;
        }

        .review-text {
            color: var(--charcoal);
            line-height: 1.8;
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
            <h2 class="page-title">Отзывы о ЖД-Портале</h2>
            <button class="btn btn-primary" id="showFormBtn">
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
                    <textarea class="form-textarea" id="reviewText" placeholder="Напишите ваш отзыв..." required></textarea>
                </div>
                <button type="submit" class="submit-btn">Отправить отзыв</button>
            </form>
        </div>

        <div class="reviews-container" id="reviewsContainer">
            <!-- Отзывы будут загружаться динамически -->
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jwt-decode@3.1.2/build/jwt-decode.min.js"></script>
<script>
    let selectedRating = 0;

    // Показать/скрыть форму отзыва
    $('#showFormBtn').on('click', function() {
        $('#reviewForm').slideToggle();
    });

    // Логика звезд
    $('.star').on('click', function() {
        const value = parseInt($(this).data('value'));
        selectedRating = value;
        $('#ratingValue').val(value);
        
        $('.star').each(function(index) {
            if (index < value) {
                $(this).removeClass('far').addClass('fas active');
            } else {
                $(this).removeClass('fas active').addClass('far');
            }
        });
    });

    // Подсветка при наведении
    $('.star').on('mouseenter', function() {
        const value = parseInt($(this).data('value'));
        $('.star').each(function(index) {
            if (index < value) {
                $(this).addClass('active');
            } else {
                $(this).removeClass('active');
            }
        });
    });

    $('.rating-stars').on('mouseleave', function() {
        $('.star').each(function(index) {
            if (index < selectedRating) {
                $(this).addClass('active');
            } else {
                $(this).removeClass('active');
            }
        });
    });

    // Загрузка отзывов
    function loadReviews() {
        $.ajax({
            url: '/review',
            method: 'GET',
            success: function(reviews) {
                const container = $('#reviewsContainer');
                container.empty();
                
                if (!reviews || reviews.length === 0) {
                    container.html('<p style="text-align: center; padding: 40px; color: var(--slate);">Пока нет отзывов. Будьте первым!</p>');
                    return;
                }
                
                reviews.forEach(function(review) {
                    let starsHtml = '';
                    for (let i = 1; i <= 5; i++) {
                        if (i <= (review.rating || 0)) {
                            starsHtml += '<i class="fas fa-star"></i>';
                        } else {
                            starsHtml += '<i class="far fa-star"></i>';
                        }
                    }
                    
                    const reviewCard = '<div class="review-card">' +
                        '<div class="review-header">' +
                        '<span class="review-author">' + (review.user ? (review.user.username || 'Анонимный пользователь') : 'Анонимный пользователь') + '</span>' +
                        '<span class="review-date">' + (review.createdAt ? new Date(review.createdAt).toLocaleDateString('ru-RU') : '') + '</span>' +
                        '</div>' +
                        '<div class="review-rating">' + starsHtml + '</div>' +
                        '<p class="review-text">' + (review.reviewText || review.text || review.comment || '') + '</p>' +
                        '</div>';
                    container.append(reviewCard);
                });
            },
            error: function() {
                $('#reviewsContainer').html('<p style="text-align: center; padding: 40px; color: var(--slate);">Ошибка при загрузке отзывов</p>');
            }
        });
    }

    // Отправка отзыва
    $('#reviewFormElement').on('submit', function(e) {
        e.preventDefault();
        
        const rating = $('#ratingValue').val();
        const text = $('#reviewText').val();
        
        if (rating == 0) {
            alert('Пожалуйста, выберите оценку');
            return;
        }
        
        const token = localStorage.getItem('jwtToken') || sessionStorage.getItem('jwtToken');
        if (!token) {
            alert('Необходимо войти в систему');
            window.location.href = '/signin';
            return;
        }
        
        let userId = null;
        try {
            const decoded = jwt_decode(token);
            userId = decoded.sub || decoded.userId || decoded.id;
        } catch (e) {
            console.error('Ошибка декодирования токена:', e);
        }
        
        $.ajax({
            url: '/review',
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + token,
                'Content-Type': 'application/json'
            },
            data: JSON.stringify({
                user: {
                    id: userId
                },
                rating: parseInt(rating),
                reviewText: text
            }),
            success: function() {
                alert('Отзыв успешно добавлен!');
                $('#reviewFormElement')[0].reset();
                $('#reviewForm').slideUp();
                selectedRating = 0;
                $('.star').removeClass('fas active').addClass('far');
                loadReviews();
            },
            error: function(xhr) {
                const errorMsg = xhr.responseJSON?.message || xhr.responseText || 'Неизвестная ошибка';
                alert('Ошибка при добавлении отзыва: ' + errorMsg);
            }
        });
    });

    // Загружаем отзывы при загрузке страницы
    $(document).ready(function() {
        loadReviews();
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
